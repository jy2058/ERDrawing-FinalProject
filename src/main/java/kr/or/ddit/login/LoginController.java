package kr.or.ddit.login;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.util.encrypt.kisa.sha256.KISA_SHA256;

@RequestMapping("/login")
@Controller
public class LoginController {

	private Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Resource(name = "memberService")
	private IMemberService memberService;

	@RequestMapping(path = "/login")
	public String login() {
		return "login";
	}

	@RequestMapping(path = { "/login" }, method = { RequestMethod.POST })
	public String Login(MemberVo vo, HttpSession session, RedirectAttributes ra) {

		logger.debug("===memVowwww {} ", memberService.selectMember(vo.getMemId()));

			MemberVo memberVo = memberService.selectMember(vo.getMemId());
			if(memberVo!=null){
			if(!memberVo.getMemId().equals(vo.getMemId())){
				ra.addAttribute("msg", "Id를 다시 확인해 주세요");
				return "login";
			}
			if (memberVo.getMemId().equals(vo.getMemId())
					&& memberVo.getMemPass().equals(KISA_SHA256.encrypt(vo.getMemPass()))) {
				session.setAttribute("memberVo", memberVo);
				return "main";
			} else {
				ra.addAttribute("msg", "PassWord를 다시 확인해 주세요");
				return "login";
			
		} 
	}else {
		ra.addAttribute("msg", "PassWord를 다시 확인해 주세요");
		return "login";
	
} 
	}
}
