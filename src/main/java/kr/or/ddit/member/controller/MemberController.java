package kr.or.ddit.member.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;

@RequestMapping("/member")
@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(MemberController.class); 
	
	@Resource(name="memberService")
	private IMemberService memberService;
	
	@RequestMapping(path={"/login"}, method={RequestMethod.POST})
	public String Login(MemberVo memVo,HttpSession session){
		logger.debug("===memberVO" ,memVo);
		MemberVo memberVo =memberService.selectMember(memVo.getMemId());
		session.setAttribute("memberVo", memberVo);
		return "main";
	}

}
