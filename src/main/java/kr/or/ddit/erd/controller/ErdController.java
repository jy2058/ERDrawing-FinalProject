package kr.or.ddit.erd.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.service.ITeamService;

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
		
		logger.debug("====erdVo.getErdNo() : {}", erdVo.getErdNo());
		//왜 before로 하면 sequence -1 이고 after하면 sequence +1 돼...? ㅜㅜㅜㅜㅜㅜㅜ
		// tag_hist 작업 해야 함
		
		return "mypage";
	}
}
