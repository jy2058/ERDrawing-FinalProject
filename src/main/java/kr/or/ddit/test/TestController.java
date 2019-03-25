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

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
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
	public String team(){
		return "team";
	}
	
	@RequestMapping(path="/insert")
	public String insert(){
		return "post/postInsert";
	}
	
}
