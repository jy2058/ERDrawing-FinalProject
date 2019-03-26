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
		if(email.length<5){	//이메일 수락 안햇을시
			
			String str_emailImg = "";
			String[] emailId =email[0].split(":");
			logger.debug("==emailId{}",emailId[1]);			//"이미지"
			
			String[] emailImg =email[1].split("\"profile_image\"");
		    logger.debug("==emailImg{}",emailImg[1]);			//"이미지"
		    if(!emailImg[1].equals(":null")){
			String[] str_emailImgs =emailImg[1].split("\"");
			str_emailImg=str_emailImgs[1];
			logger.debug("==emailImg1{}",str_emailImgs[1]);		//이미지값
		    }
		    
			String[] emailNicName =email[2].split(":");
			logger.debug("==email{}",emailNicName[1]);			//"닉네임"
			String[] str_emailNicName =emailNicName[1].split("\"");
			logger.debug("==email{}",str_emailNicName[1]);		//닉네임
			
			MemberVo memId = memberService.selectMember(emailId[1]);
			MemberVo vo = new MemberVo(emailId[1], emailId[1], "--", str_emailNicName[1], "kr","kakao");
			vo.setMemImg(str_emailImg);
			if(memId==null){
				memberService.insertMember(vo);
				session.setAttribute("SESSION_MEMBERVO", vo);
			}
			else{
				session.setAttribute("SESSION_MEMBERVO", vo);
			}
		}
		/*{"kaccount_email":"hyuns0410@naver.com","kaccount_email_verified":true,"id":1050004750,"properties":{"profile_image":null,"nickname":"현지","thumbnail_image":null}}
		  {"kaccount_email":"hyuns0410@naver.com","kaccount_email_verified":true,"id":1050004750,"properties":{"profile_image":null,"nickname":"현지","thumbnail_image":null}}
		  {"id":1050004750,"properties":{"profile_image":null,"nickname":"현지","thumbnail_image":null}}
		  {"id":1050336822,"properties":{"profile_image":"http://k.kakaocdn.net/dn/wP9nw/btqtOa9InY0/M026ovyy6T5virJtPbPBXK/profile_640x640s.jpg","nickname":"윤한수","thumbnail_image":"http://k.kakaocdn.net/dn/wP9nw/btqtOa9InY0/M026ovyy6T5virJtPbPBXK/profile_110x110c.jpg"}}
		  {"id":1050420424,"properties":{"profile_image":"http://k.kakaocdn.net/dn/bZmQ5u/btqtQyoqCcM/6BD83x6wwgOwTZV27w6de0/profile_640x640s.jpg","nickname":"황수정","thumbnail_image":"http://k.kakaocdn.net/dn/bZmQ5u/btqtQyoqCcM/6BD83x6wwgOwTZV27w6de0/profile_110x110c.jpg"}}
		*/else{	//이메일 수락시 
			String str_emailImg = "";
			
			String[] strEmail =email[0].split(":");
			String[] str_email  = strEmail[1].split("\"");
			logger.debug("==email => {}",str_email[1]);	//이메일
			
			String[] emailImg =email[3].split("\"profile_image\"");
		    logger.debug("==emailImg{}",emailImg[1]);			//"이미지"
		    if(!emailImg[1].equals(":null")){
				String[] str_emailImgs =emailImg[1].split("\"");
				str_emailImg=str_emailImgs[1];
				logger.debug("==emailImg이미지 => {}",str_emailImgs[1]);		//이미지값
			    }
		    
		    String[] emailNicName =email[4].split(":");
			logger.debug("==email{}",emailNicName[1]);			//"닉네임"
			String[] str_emailNicName =emailNicName[1].split("\"");
			logger.debug("==닉네임=> {}",str_emailNicName[1]);		//닉네임
			
			MemberVo memId = memberService.selectMember(str_email[1]);
			MemberVo vo = new MemberVo(str_email[1], str_email[1], "--", str_emailNicName[1], "kr","kakao");
			vo.setMemImg(str_emailImg);
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
