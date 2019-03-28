package kr.or.ddit.post.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
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

import kr.or.ddit.post.model.BoardVo;
import kr.or.ddit.post.model.CommentsVo;
import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.post.model.UploadFileVo;
import kr.or.ddit.post.service.IBoardService;
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

		return "post/postList";
	}
	
	// 게시글 등록 화면
	@RequestMapping(path = "/postInsert", method = RequestMethod.GET)
	public String postInsertForm(HttpSession session, Model model, String boardNo) {

		model.addAttribute("boardNo", boardNo);

		return "post/postInsert";
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
	
	/*해야됨*/
	/*// 게시글 등록
	@RequestMapping(path = "/postInsert", method = RequestMethod.POST)
	public String postInsert(PostVo postVo, HttpSession session, Model model) {
	    Object memId = session.getAttribute("SESSION_MEMBERVO");
	    logger.debug("===postVo{}",postVo);
		model.addAttribute("boardNo", postVo.getBoardNo());

		int insertCnt = postService.insertPost(postVo);

		// 정상 입력(성공)
		if (insertCnt == 1) {
			int postNo = postVo.getPostNo();

			model.addAttribute("msg", "게시글이 정상 등록 되었습니다.");
			return "redirect:/post/postList"; //리스트 되면 수정필요
			// 정상 입력(실패)
		} else {
			model.addAttribute("msg", "게시글 등록이 실패 되었습니다.");
			return "post/postInsert";
		}
	}*/

	/* 해야됨 */
	// 게시글 상세 화면
	@RequestMapping(path = "/postDetail", method = RequestMethod.GET)
	public String postDetailForm(Model model, String postNo) {

		model.addAttribute("postNo", postNo);
		
		
		// 업로드 파일 조회
		List<UploadFileVo> fileList = uploadFileService.getAllFile(postNo);
		model.addAttribute("fileList", fileList);
		
		// 댓글 조회
		List<CommentsVo> cmtList = commentsService.getAllComments(postNo);
		model.addAttribute("cmtList", cmtList);

		PostVo postList = postService.getSelectPost(postNo);
		model.addAttribute("postList", postList);

		return "post/postDetail";
	}
	
	// 게시글 수정
	@RequestMapping(path = "/postUpdate", method = RequestMethod.GET)
	public String postUpdateForm(@RequestParam("postNo") String postNo, Model model) {
		
		PostVo postVo = postService.getSelectPost(postNo);
		
		List<UploadFileVo> fileList = uploadFileService.getAllFile(postNo);
		List<BoardVo> boardList = boardService.getAllBoard();
		
		model.addAttribute("postVo", postVo);
		model.addAttribute("fileList", fileList);
		model.addAttribute("boardList", boardList);
		
		return "post/postUpdate";
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
	
	
	
}
