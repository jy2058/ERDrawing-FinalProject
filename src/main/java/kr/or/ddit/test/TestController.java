package kr.or.ddit.test;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TeamVo;
import kr.or.ddit.team.service.ITeamService;

@Controller
public class TestController {
	private Logger logger = LoggerFactory.getLogger(TestController.class);

	@Resource(name="teamService")
	private ITeamService teamService;
	
	@Resource(name="erdService")
	private IErdService erdService;
	
	@RequestMapping(path="/")
	public String test1(){
		return "main";
	}
	
	@RequestMapping(path="/test2")
	public String test2(){
		return "test2";
	}
	
	
	@RequestMapping(path="/library")
	public String library(){
		return "library";
	}
	
	
	@RequestMapping(path="/join")
	public String join(){
		return "join";
	}
	
	

	
	@RequestMapping(path="/mypage")
	public String mypage(Model model, HttpSession session){
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		List<TeamVo> teamInfoList = teamService.getMemberAgreTeamInfoList(memId);
		model.addAttribute("teamInfoList", teamInfoList);
		
		session.setAttribute("teamInfoList", teamInfoList);
		
		logger.debug("====teamInfoList : {}", teamInfoList);
		
		// erd와 tagList Map으로 넘겨줌
		Map<String, Object> myErdTagMap = erdService.getMyErdTagMap(memId);
		model.addAllAttributes(myErdTagMap);
		
		
		return "mypage";
	}
	
	
	
	
	@RequestMapping(path="/modify")
	public String modify(){
		return "modify";
	}
	
	
	@RequestMapping(path="/team")
	public String team(@RequestParam("teamNo")int teamNo, Model model, HttpSession session){
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		List<TeamVo> teamInfoList = teamService.getMemberAgreTeamInfoList(memId);
		model.addAttribute("teamInfoList", teamInfoList);
		
		// erd와 tagList를 Map으로 넘겨줌
		Map<String, Object> teamErdTagMap = teamService.getTeamErdTagMap(teamNo);
		model.addAllAttributes(teamErdTagMap);
		
		TeamVo teamInfo = teamService.getTeamInfo(teamNo);
		model.addAttribute("teamInfo",teamInfo);
		
		// 팀 수락한  teamList와 teamMember 리스트
		Map<String, Object> teamMemberListMap = teamService.teamMemberListMap(teamNo);
		model.addAllAttributes(teamMemberListMap);
		
		return "team";
	}
	
	@RequestMapping(path="/insert")
	public String insert(){
		return "post/postInsert";
	}
	
	
	
	
	
	
	
	@RequestMapping(path="er")
	public String erdDrawing(){
		return "drawing/erdDrawing";
	}
	
	
	
	// 모달 페이지 변경 메소드 
	@RequestMapping("/pageViewAjax")
	public String testAjax(String value){
		String page = "";
		
		
		switch(value){
			case "erdAdd":
				page = "erd/erdadd";
				break;
				
			case "createTeam":
				page = "erd/teamCreate";
				break;
		}
		
		return page;
	}
	
	
	
}
