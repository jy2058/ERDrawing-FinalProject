package kr.or.ddit.erd.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;

@RequestMapping("/erd")
@Controller
public class ErdController {
	private Logger logger = LoggerFactory.getLogger(ErdController.class);
	
	@Resource(name="erdService")
	private IErdService erdService;
	
	@RequestMapping(path = { "/erdAdd" }, method = { RequestMethod.POST })
	public String makeErd(ErdVo erdVo, HttpSession session){
		
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		
		logger.debug("======erdVo : {}  ", erdVo.getErdTitle());
		
		// 1. 공개설정이 팀일 때와 아닐 때 insert 값이 달라야 한다.
		
		logger.debug("=====erdScope : {} ", erdVo.getErdScope());
		
		
		// 공개설정이 팀일 때
		if(erdVo.getErdScope() == "team"){
			
		}
		// 팀이 아닐 때
		else{
			// erd insert
			erdVo.setMemId(memberVo.getMemId());
			erdService.addErd(erdVo);
		}
		return "mypage";
	}

}
