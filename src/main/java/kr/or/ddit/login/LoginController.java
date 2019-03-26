package kr.or.ddit.login;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String login(Model model) {
		return "login";
	}

	@RequestMapping(path = { "/login" }, method = { RequestMethod.POST })
	public String Login(MemberVo vo, HttpSession session, RedirectAttributes ra, HttpServletRequest req) {
		MemberVo checkMemVo = memberService.selectMember(vo.getMemId());
		
		
		if (checkMemVo == null) {
			ra.addFlashAttribute("msg", "Id를 다시 확인해 주세요");
			return "redirect:" + req.getContextPath() + "/login";
		} else if (checkMemVo.getMemId().equals(vo.getMemId())
				&& checkMemVo.getMemPass().equals(KISA_SHA256.encrypt(vo.getMemPass()))) {
			session.setAttribute("SESSION_MEMBERVO", vo);
			return "main";
		}else if(checkMemVo.getMemEmailDiv().equals("google")){
			ra.addFlashAttribute("msg", "google로 로그인 해주세요");
			return "redirect:" + req.getContextPath() + "/login";
		}
		else if(checkMemVo.getMemEmailDiv().equals("kakao")){
			ra.addFlashAttribute("msg", "kakao로 로그인 해주세요");
			return "redirect:" + req.getContextPath() + "/login";
		}
		else {
			ra.addFlashAttribute("msg", "PassWord를 다시 확인해 주세요");
			return "redirect:" + req.getContextPath() + "/login";
		}
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		// session.invalidate(); // 세션 전체를 날려버림

	logger.debug("==cooc{}",request.getCookies().length);
	session.removeAttribute("SESSION_MEMBERVO"); // 하나씩 하려면 이렇게 해도 됨.
		return "main";
	}

	@RequestMapping(value = "/logins", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(String[] info,HttpSession session) throws Exception {
		MemberVo memId = memberService.selectMember(info[3]);
		MemberVo vo = new MemberVo(info[3], info[3], "--", info[1], "kr","google");
		vo.setMemImg(info[2]);
		if(memId==null){
			memberService.insertMember(vo);
			session.setAttribute("SESSION_MEMBERVO", vo);
		}
		else{
			session.setAttribute("SESSION_MEMBERVO", vo);
		}
		return "main";
	}
	
	@RequestMapping(value = "/kakaoLogin")
	public String kakaoLogin(String info, HttpSession session) {
		logger.debug("==info{}",info);
		String[] email =info.split(",");
		if(email.length<4){	//이메일 수락 안햇을시
			String[] emailId =email[0].split(":");
			logger.debug("==email{}",emailId[1]);
			
			MemberVo memId = memberService.selectMember(emailId[0]);
			MemberVo vo = new MemberVo(emailId[0], emailId[0], "--", emailId[0], "kr","kakao");
			if(memId==null){
				memberService.insertMember(vo);
				session.setAttribute("SESSION_MEMBERVO", vo);
			}
			else{
				session.setAttribute("SESSION_MEMBERVO", vo);
			}
		}
	
		else{	//이메일 수락시 
			String[] strEmail =email[5].split("\"");
			logger.debug("==email{}",strEmail[3]);	//이메일값
			
			MemberVo memId = memberService.selectMember(strEmail[3]);
			MemberVo vo = new MemberVo(strEmail[3], strEmail[3], "--", strEmail[3], "kr","kakao");
			if(memId==null){
				memberService.insertMember(vo);
				session.setAttribute("SESSION_MEMBERVO", vo);
			}
			else{
				session.setAttribute("SESSION_MEMBERVO", vo);
			}
		}
		return "main";
	}
	}
