package kr.or.ddit.post.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.post.model.BoardVo;
import kr.or.ddit.post.model.CommentLikeVo;
import kr.or.ddit.post.model.CommentsVo;
import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.post.model.UploadFileVo;
import kr.or.ddit.post.service.IBoardService;
import kr.or.ddit.post.service.ICommentLikeService;
import kr.or.ddit.post.service.ICommentsService;
import kr.or.ddit.post.service.IPostService;
import kr.or.ddit.post.service.IUploadFileService;
import kr.or.ddit.post.service.UploadFileServiceImpl;
import kr.or.ddit.util.model.PageVo;

@RequestMapping("/post")
@Controller
public class PostController {
	
	private Logger logger = LoggerFactory.getLogger(PostController.class);
	
	@Resource(name="boardService")
	private IBoardService boardService;
	
	@Resource(name="postService")
	private IPostService postService;
	
	@Resource(name="uploadFileService")
	private IUploadFileService uploadFileService;
	
	@Resource(name="commentsService")
	private ICommentsService commentsService;
	
	@Resource(name="commentLikeService")
	private ICommentLikeService commentLikeService;
	
	// 게시판 페이징 리스트
	@RequestMapping(path = "/postList")
	public String postList(@RequestParam(name="boardNo") int boardNo,
			               @RequestParam(name="page", defaultValue="1") int page, Model model) {

		String boardNm = postService.getSelectBoardNm(boardNo+"");

		PageVo paging = new PageVo(); // 페이징 처리를 위해 페이징 객체 생성 Paging 이라는 VO가 존재함
		paging.setPageNo(page);
		paging.setPageSize(10);

		paging.setBoardNo(boardNo); // 파라미터로 받은 게시판 번호를 넘김
		List<PostVo> postList = postService.selectPostPagingList(paging);

		model.addAttribute("postList", postList);
		model.addAttribute("boardNm", boardNm);
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("paging", paging);

		return "postList";
	}
	
	// 게시글 등록 화면
	@RequestMapping(path = "/postInsert", method = RequestMethod.GET)
	public String postInsertForm(HttpSession session, Model model, String boardNo) {

		model.addAttribute("boardNo", boardNo);

		return "postInsert";
	}

	// 게시글 등록
	@RequestMapping(path = "/postInsert", method = RequestMethod.POST)
	public String postInsert(PostVo postVo, @RequestPart("file") List<MultipartFile> files, Model model,
			               HttpSession session, RedirectAttributes ra) throws IllegalStateException, IOException {
		Object memId = session.getAttribute("SESSION_MEMBERVO");
		model.addAttribute("boardNo", postVo.getBoardNo());

		List<String> filenames = new ArrayList<>();
		List<String> realFilenames = new ArrayList<>();

		for (int i = 0; i < files.size(); i++) {
			if (!files.get(i).isEmpty() && files.get(i).getSize() > 0) {
				MultipartFile file = files.get(i);

				String filename = file.getOriginalFilename();
				String realFilename = "d:\\uploadFile\\" + UUID.randomUUID().toString();
				file.transferTo(new File(realFilename));

				filenames.add(filename);
				realFilenames.add(realFilename);
			}
		}

		int insertCnt = postService.insertPost(postVo);

		// 게시글 등록 성공
		if (insertCnt > 0) {
			// post : insert 실행 후 적용된 postNo
			int postNo = postVo.getPostNo();
			// uploadFile : 정상 실행된 행 개수
			int fileCnt = 0;

			for (int i = 0; i < filenames.size(); i++) {
				UploadFileVo uploadFileVo = new UploadFileVo();
				uploadFileVo.setUploadFileNm(filenames.get(i));
				uploadFileVo.setUploadRealFilePath(realFilenames.get(i));
				uploadFileVo.setPostNo(postNo);

				fileCnt += uploadFileService.insertFile(uploadFileVo);
			}

			if (fileCnt == filenames.size()) {
				ra.addAttribute("postNo", postNo);
				return "redirect:/post/postDetail";
			} else {
				System.out.println("첨부파일 등록 오류");
			}
		}
		// 게시글 등록 실패
		ra.addAttribute("boardNo", postVo.getBoardNo());
		return "redirect:/post/postInsert";
	}

	// 게시글 상세 화면
	@RequestMapping(path = "/postDetail", method = RequestMethod.GET)
	public String postDetailForm(Model model, String postNo, String boardNo, CommentLikeVo commentLikeVo) {
		model.addAttribute("postNo", postNo);
		model.addAttribute("boardNo", boardNo);
		logger.debug("============={}", commentLikeVo);
		// 업로드 파일 조회
		List<UploadFileVo> fileList = uploadFileService.getAllFile(postNo);
		model.addAttribute("fileList", fileList);
		
		// 댓글 조회
		List<CommentsVo> cmtList = commentsService.getAllComments(postNo);
		model.addAttribute("cmtList", cmtList);
		
		if(commentLikeVo.getMemId() != null){
			// 댓글 좋아요 조회
			List<CommentLikeVo> cmtLikeList = commentLikeService.getSelectCmtLike(commentLikeVo.getMemId());
			model.addAttribute("cmtLikeList", cmtLikeList);
		}
		
		PostVo postList = postService.getSelectPost(postNo);
		model.addAttribute("postList", postList);

		return "postDetail";
	}
	
	// 게시글 수정 화면
	@RequestMapping(path = "/postUpdate", method = RequestMethod.GET)
	public String postUpdateForm(@RequestParam("postNo") String postNo, Model model) {
		
		PostVo postVo = postService.getSelectPost(postNo);
		
		List<UploadFileVo> fileList = uploadFileService.getAllFile(postNo);
		List<BoardVo> boardList = boardService.getAllBoard();
		
		model.addAttribute("postVo", postVo);
		model.addAttribute("fileList", fileList);
		model.addAttribute("boardList", boardList);
		
		return "postUpdate";
	}
	
	// 게시글 수정
	@RequestMapping(path = "/postUpdate", method = RequestMethod.POST)
	public String postUpdate(RedirectAttributes ra,
			                 @RequestParam("postNo") int postNo,
			                 @RequestParam("postTitle") String postTitle,
			                 @RequestParam("postContent") String postContent,
							 @RequestParam(name="delFile", defaultValue="")String[] arrDelFile,
							 @RequestPart("file") List<MultipartFile> files) throws IllegalStateException, IOException {
		
		List<String> filenames = new ArrayList<>();
		List<String> realFilenames = new ArrayList<>();
		
		for (int i = 0; i < files.size(); i++) {
			if (!files.get(i).isEmpty() && files.get(i).getSize() > 0) {
				MultipartFile file = files.get(i);
				
				String filename = file.getOriginalFilename();
				String realFilename = "d:\\uploadFile\\" + UUID.randomUUID().toString();
				file.transferTo(new File(realFilename));
				
				filenames.add(filename);
				realFilenames.add(realFilename);
			}
		}
		
		PostVo postVo = new PostVo();
		postVo.setPostNo(postNo);
		postVo.setPostTitle(postTitle);
		postVo.setPostContent(postContent);
		
		int updateCnt = postService.updatePost(postVo);
		
		if (updateCnt > 0) {
			int insFileCnt = 0;
			int delFileCnt = 0;
			
			if (arrDelFile != null) {
				for (int i = 0; i < arrDelFile.length; i++)	{
					delFileCnt += uploadFileService.deleteFile(arrDelFile[i]);
				}
			}
			
			for (int i = 0; i < filenames.size(); i++) {
				UploadFileVo uploadFileVo = new UploadFileVo();
				uploadFileVo.setUploadFileNm(filenames.get(i));
				uploadFileVo.setUploadRealFilePath(realFilenames.get(i));
				uploadFileVo.setPostNo(postNo);
				
				insFileCnt += uploadFileService.insertFile(uploadFileVo);
			}
			
			if (insFileCnt == filenames.size() && delFileCnt == (arrDelFile == null ? 0 : arrDelFile.length)) {
				ra.addAttribute("postNo", postNo);
				return "redirect:/post/postDetail";
			} else {
				System.out.println("첨부파일 등록 오류");
			}
		} 
		
		ra.addAttribute("postNo", postNo);
		return "redirect:/post/postDetail";
	}
	
	// 게시글 삭제
	@RequestMapping(path = "/postDel", method = RequestMethod.GET)
	public String postDel(Model model, String boardNo, String postNo) {

		model.addAttribute("boardNo", boardNo);
		model.addAttribute("postNo", postNo);

		int deleteCnt = postService.deletePost(postNo);

		if (deleteCnt == 1) {
			model.addAttribute("msg", "게시글이 삭제 되었습니다.");
		} else {
			model.addAttribute("msg", "게시글 삭제에 실패했습니다.");
		}
		return "redirect:/post/postList";
	}
	
	// 댓글 등록
	@RequestMapping(path = "/insertCmt", method = RequestMethod.GET)
	public String insertCmt(CommentsVo commentsVo, Model model, String memId, String postNo) {
		model.addAttribute("postNo", postNo);
		model.addAttribute("memId", memId);

		int insertCnt = commentsService.insertComments(commentsVo);

		if (insertCnt > 0) {
			model.addAttribute("msg", "댓글을 정상 등록되었습니다.");
		}
		return "redirect:/post/postDetail";
	}
	
	// 댓글 삭제
	@RequestMapping(path = "/deleteCmt", method = RequestMethod.GET)
	public String deleteCmt(Model model, String postNo, String cmtNo) {
		model.addAttribute("postNo", postNo);
		model.addAttribute("cmtNo", cmtNo);

		int deleteCnt = commentsService.deleteComments(cmtNo);

		if (deleteCnt == 1) {
			model.addAttribute("msg", "댓글이 삭제 되었습니다.");	
		} else {
			model.addAttribute("msg", "댓글 삭제에 실패했습니다.");
		}
		return "redirect:/post/postDetail";
	}
	
	// 댓글 좋아요
	@RequestMapping(path = "/likeCmt", method = RequestMethod.POST)
	public String likeCmt(int cmtNo, String memId, String postNo, Model model, RedirectAttributes ra) {
	
		model.addAttribute("cmtNo", cmtNo);
		model.addAttribute("memId", memId);
		model.addAttribute("postNo", postNo);
		
		CommentLikeVo commentLikeVo = new CommentLikeVo();
		commentLikeVo.setCmtNo(cmtNo);
		commentLikeVo.setMemId(memId);

		int insertCnt = commentLikeService.insertCmtLike(commentLikeVo);

		if (insertCnt > 0) {
			model.addAttribute("msg", "좋아요?");
		}
		ra.addAttribute("postNo", postNo);
		return "redirect:/post/postDetail";
		
	}
	
	// 첨부파일 다운로드
	@RequestMapping(path = "/fileDownload", method = RequestMethod.GET)
	public String fileDownload(@RequestParam("uploadFileNo") String uploadFileNo,
							   HttpSession session, HttpServletResponse response) throws Exception {
	    UploadFileVo uploadFileVo = uploadFileService.selectFile(uploadFileNo);
	    String filename = uploadFileVo.getUploadFileNm();
	    String realfilename = uploadFileVo.getUploadRealFilePath();

	    File outputFile = new File(realfilename);
	    
	    // 파일을 읽어와 저장할 버퍼를 임시로 만들고 버퍼의 용량은 업로드할 수 있는 파일 크기로 지정함
	    byte[] temp = new byte[1024 * 1024 * 5];

	    FileInputStream fis = new FileInputStream(outputFile);
	    
	    // 유형 확인 : 읽어올 경로의 파일 유형 -> 페이지 생성할 때 타입을 설정해야 함
	    String mimeType = session.getServletContext().getMimeType(realfilename);

	    // 지정되지 않은 유형 예외처리
	    if (mimeType == null){
	    	mimeType = "application.octec-stream"; // 일련된 8bit 스트림 형식
	    }
	    
	    // 파일 다운로드 시작
	    response.setContentType(mimeType); // 유형 지정
	    
	    String encoding = new String(filename.getBytes("euc-kr"),"8859_1");
	  
	    String AA = "Content-Disposition";
	    String BB = "attachment;filename="+ encoding;
	    response.setHeader(AA,BB);
	     
	    // 브라우저에 쓰기
	    ServletOutputStream sos = response.getOutputStream();
	     
	    int numRead = 0;
	    while((numRead = fis.read(temp,0,temp.length)) != -1){
	    	// 브라우저에 출력
	    	sos.write(temp,0,numRead);
	    }
	    
	    // 자원 해제
	    sos.flush();
	    sos.close();
	    fis.close();
		
		return "";
	}
	
	// 답글 등록 화면
	@RequestMapping(path={"/postReply"}, method={RequestMethod.GET})
	public String postReplyForm(@RequestParam("postNo")String postNo,
								@RequestParam("boardNo")String boardNo,
								Model model) {
		List<BoardVo> boardList = boardService.getAllBoard();
		PostVo postVo = postService.getSelectPost(postNo);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("postVo", postVo);
		
		return "postReply";
	}
	
	// 답글 등록
	@RequestMapping(path={"/postReply"}, method={RequestMethod.POST})
	public String postReply(@RequestParam("postTitle") String postTitle,
							@RequestParam("postContent") String postContent,
							@RequestParam("postNo") int postNo,
						    @RequestParam("boardNo") int boardNo,
							@RequestPart("file") List<MultipartFile> files,
							HttpSession session, RedirectAttributes ra) throws IllegalStateException, IOException {
		MemberVo memId = (MemberVo)session.getAttribute("SESSION_MEMBERVO");
		PostVo parentVo = postService.getSelectPost("" + postNo);
		int gn = parentVo.getPostGn();
			
		List<String> filenames = new ArrayList<>();
		List<String> realFilenames = new ArrayList<>();
		
		for (int i = 0; i < files.size(); i++) {
			if (!files.get(i).isEmpty() && files.get(i).getSize() > 0) {
				MultipartFile file = files.get(i);

				String filename = file.getOriginalFilename();
				String realFilename = "d:\\uploadFile\\" + UUID.randomUUID().toString();
				file.transferTo(new File(realFilename));
				
				filenames.add(filename);
				realFilenames.add(realFilename);
			}
		}
		
		PostVo postVo = new PostVo();
		postVo.setPostTitle(postTitle);
		postVo.setPostContent(postContent);
		postVo.setWriterId(memId.getMemId());
		postVo.setPostGn(parentVo.getPostGn());
		postVo.setParentPostNo(parentVo.getPostNo());
		postVo.setBoardNo(parentVo.getBoardNo());
		
		int cnt = postService.insertReply(postVo);
		
		// 게시글 등록 성공
		if(cnt > 0) {
			// post : insert 실행 후 적용된 postNo
			int postCnt = postVo.getPostNo();
			// ploadFile : 정상 실행된 행 개수
			int fileCnt = 0;
			
			for (int i = 0; i < filenames.size(); i++) {
				UploadFileVo uploadFileVo = new UploadFileVo();
				uploadFileVo.setUploadFileNm(filenames.get(i));
				uploadFileVo.setUploadRealFilePath(realFilenames.get(i));
				uploadFileVo.setPostNo(postCnt);
				
				fileCnt += uploadFileService.insertFile(uploadFileVo);
			}
			
			if (fileCnt == filenames.size()) {
				ra.addAttribute("postNo", postVo.getPostNo());
				return "redirect:/post/postDetail";
			} else {
				System.out.println("첨부파일 등록 오류");
			}
		}
		// 게시글 등록 실패
		ra.addAttribute("boardNo", postVo.getBoardNo());
		return "redirect:/post/postInsert";
	}
	
	
	
}
