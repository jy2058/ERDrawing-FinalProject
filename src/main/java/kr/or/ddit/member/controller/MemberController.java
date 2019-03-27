package kr.or.ddit.member.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.util.encrypt.kisa.sha256.KISA_SHA256;

@RequestMapping("/member")
@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Resource(name = "memberService")
	private IMemberService memberService;
	
	@RequestMapping("/join")	//회원가입
	public String join(MemberVo memVo,RedirectAttributes ra,HttpServletRequest req){
		logger.debug("===={}",memVo);
		String pass =KISA_SHA256.encrypt(memVo.getMemPass());
		MemberVo vo = new MemberVo(memVo.getMemId(), memVo.getMemMail(),pass , memVo.getMemNm(), memVo.getMemLang(), "basic");
		int cnt = memberService.insertMember(vo);
		
		if(cnt==1){
			ra.addFlashAttribute("msg", "회원가입에 성공 하셨습니다.");
		}else{
			ra.addFlashAttribute("msg", "회원가입에 실패하셨습니다.");
			return "join";
		}
		return "redirect:" + req.getContextPath() +"/";
		
	}
	
	@RequestMapping("/checkId")	//아이디 중복 체크
	public String checkId(MemberVo memVo,RedirectAttributes ram,Model model){
		MemberVo memId = memberService.selectMember(memVo.getMemId());
		if(memId==null){
		model.addAttribute("check", "OK");
		}else{
			model.addAttribute("check", "No");
		}
		return "jsonView";
		
	}
		
	

}
