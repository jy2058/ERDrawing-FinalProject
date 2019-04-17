package kr.or.ddit.erd.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.service.ITeamService;
import kr.or.ddit.util.model.PageVo;

@RequestMapping("/erd")
@Controller
public class ErdController {
	private Logger logger = LoggerFactory.getLogger(ErdController.class);
	
	@Resource(name="erdService")
	private IErdService erdService;
	
	@Resource(name="teamService")
	private ITeamService teamService;
	
	@RequestMapping(path = { "/erdAdd" }, method = { RequestMethod.POST })
	public String makeErd(ErdVo erdVo, @RequestParam("tag")String tag, HttpSession session){
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		logger.debug("======erdTitle : {}  ", erdVo.getErdTitle());
		
		// 1. 공개설정이 팀일 때와 아닐 때 insert 값이 달라야 한다. --> xml에서 nullif문 이용
		// 1.1 팀일 때는 memId가 null이어야 한다.
		// 1.2 개인일 때는 teamNo가 null이어야 한다.
		// 2. erd 생성과 태그 생성은 동시에 이뤄져야 한다.
		// 3. 생성 된 erd의 번호로 등록한 tag들과 맵핑이 돼야 한다.(tagHist)
		
		// 공개설정이 팀일 때
		if(erdVo.getErdScope().equals("team")){
			logger.debug("======selectTeam : {}  ", erdVo.getTeamNo());
			erdVo.setTeamNo(erdVo.getTeamNo());
		}
		// 공개설정이 개인일 때
		else{
			erdVo.setMemId(memberVo.getMemId());
			erdVo.setTeamNo(0);
		}
		erdService.addErdTag(erdVo, tag, memId);
		
		return "redirect:/mypage";
	}
	
	@RequestMapping("/delErd")
	public String delErd(@RequestParam("erdNo")int erdNo){
		erdService.delErd(erdNo);
		
		return "jsonView";
	}
	
	// 라이브러리 erd 페이징 ajax
	@RequestMapping("/libErdAjax")
	public String libErdAjax(@RequestParam(name = "page", defaultValue = "1")int page, @RequestParam(name = "tagContent", required = false)String tagContent, Model model, HttpSession session) {
		
		PageVo pageVo = new PageVo();
		pageVo.setPageNo(page);
		Map<String, Object> allErdListPaging;
		
		// 검색일 때 페이징
		if(!tagContent.isEmpty()){
			pageVo.setSearch(tagContent);
			allErdListPaging = erdService.searchPagingList(pageVo);
		}else{ // 모든 erd paging
			allErdListPaging = erdService.getAllErdListPaging(pageVo);
		}
		model.addAllAttributes(allErdListPaging);
		model.addAttribute("paging", pageVo);
		
		return "jsonView";
	}
	
	// erd 검색
	@RequestMapping("/erdSearch")
	public String erdSearch(@RequestParam("searchTxt_modal")String searchTxt, Model model){
		List<ErdVo> searchList = erdService.searchList(searchTxt);
		model.addAttribute(searchList);
		
		return "jsonView";
	}
	
	// erd 이미지 조회
	@RequestMapping("/erdImg")
	public void erdImg(HttpServletRequest req, HttpServletResponse resp, @RequestParam("erdNo") int erdNo) throws IOException{

		logger.debug("***erdNo {}", erdNo);
		
		// 2. 해당 사용자 아이디로 사용자 정보 조회(realFilename)
		ErdVo erdInfo = erdService.getErdInfo(erdNo);

		// 3-1. memImg 존재 할 경우
		// 3-1-1. 해당 경로의 파일을 FileInputStream으로 읽는다.
		FileInputStream fis;
		if (erdInfo != null && erdInfo.getErdImg() != null) {
			fis = new FileInputStream(new File(erdInfo.getErdImg()));
		}
		// 3-2. memImg 존재하지 않을 경우
		// 3-2-1. /image/noImg.png(application.getRealPath())
		else {
			ServletContext application = req.getServletContext();
			String noimgPath = application.getRealPath("/image/noimg1.png");
			fis = new FileInputStream(new File(noimgPath));
		}
		// 4. FileInputStream을 response객체의 outputStream 객체에 write
		ServletOutputStream sos = resp.getOutputStream();

		byte[] buff = new byte[512];
		int len = 0;
		while ((len = fis.read(buff)) > -1) {
			sos.write(buff);
		}
		sos.close();
		fis.close();
	}
	
	@RequestMapping(path = "erdModify", method = RequestMethod.GET)
	public String erdModify(@RequestParam("erdNo")int erdNo, Model model){
		
		ErdVo erdVo = erdService.getErdInfo(erdNo);	// erd 정보
		List<TagVo> tagList = teamService.getErdTag(erdNo);	// erd Tag
		
		model.addAttribute("erdVo", erdVo);
		model.addAttribute("tagList", tagList);
		
		return "jsonView";
	}
}
