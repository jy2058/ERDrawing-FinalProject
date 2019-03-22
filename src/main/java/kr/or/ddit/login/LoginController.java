package kr.or.ddit.login;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
	public String Login(MemberVo vo, HttpSession session,RedirectAttributes ra,HttpServletRequest req) { 
		MemberVo checkMemVo = memberService.selectMember(vo.getMemId());

		if (checkMemVo == null) {
			ra.addFlashAttribute("msg", "Id를 다시 확인해 주세요");
			return "redirect:"+req.getContextPath()+"/login";
		} else if (checkMemVo.getMemId().equals(vo.getMemId())
				&& checkMemVo.getMemPass().equals(KISA_SHA256.encrypt(vo.getMemPass()))) {
			session.setAttribute("SESSION_MEMBERVO", vo);
			return "main";
		} else {
			ra.addFlashAttribute("msg", "PassWord를 다시 확인해 주세요");
			return "redirect:"+req.getContextPath()+"/login";
		}
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		//session.invalidate(); // 세션 전체를 날려버림
		session.removeAttribute("SESSION_MEMBERVO"); // 하나씩 하려면 이렇게 해도 됨.
		return "main"; 
	}
}
