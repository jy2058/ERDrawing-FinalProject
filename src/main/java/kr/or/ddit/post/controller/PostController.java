package kr.or.ddit.post.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
	
	@Resource(name="boardService")
	private IBoardService boardService;
	
	@Resource(name="postService")
	private IPostService postService;
	
	// 게시판 페이징 리스트
	@RequestMapping(path = "/postList")
	public String postList(@RequestParam(name="boardNo") int boardNo,
			               @RequestParam(name="page", defaultValue="1") int page, Model model) {

		String boardNm = postService.getSelectBoardNm(boardNo + "");

		PageVo paging = new PageVo();
		paging.setPageNo(page);
		paging.setPageSize(10);

		paging.setBoardNo(boardNo);
		List<PostVo> postList = postService.selectPostPagingList(paging);

		model.addAttribute("postList", postList);
		model.addAttribute("boardNm", boardNm);
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("paging", paging);

		return "post/freeBoardList";
	}
	
}
