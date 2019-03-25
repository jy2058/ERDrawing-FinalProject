package kr.or.ddit.post.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.post.model.PostVo;
import kr.or.ddit.post.service.IBoardService;
import kr.or.ddit.post.service.IPostService;
import kr.or.ddit.util.model.PageVo;

@RequestMapping("/post")
@Controller
public class PostController {
	
	private Logger logger = LoggerFactory.getLogger(PostController.class);
	
	@Resource(name="boardService")
	private IBoardService boardService;
	
	@Resource(name="postService")
	private IPostService postService;
	
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
	public String postInsert(PostVo postVo, HttpSession session, Model model) {
	    Object memId = session.getAttribute("SESSION_MEMBERVO");
		model.addAttribute("boardNo", postVo.getPostNo());

		int insertCnt = postService.insertPost(postVo);

		// 정상 입력(성공)
		if (insertCnt == 1) {
			int postNo = postVo.getPostNo();

			model.addAttribute("msg", "게시글이 정상 등록 되었습니다");
			return "redirect:/post/postList"; //리스트 되면 수정필요
			// 정상 입력(실패)
		} else {
			model.addAttribute("msg", "게시글 등록이 실패 되었습니다");
			return "post/postInsert";
		}
	}
	
}
