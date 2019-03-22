package kr.or.ddit.login;

import java.io.IOException;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.util.encrypt.kisa.sha256.KISA_SHA256;

@Controller
public class LoginController {

	private Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	@Resource(name = "memberService")
	private IMemberService memberService;

	@RequestMapping(path = "/login")
	public String login(Model model) {
		// 구글연동을 위한 주소 가져오기
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);
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
		} else {
			ra.addFlashAttribute("msg", "PassWord를 다시 확인해 주세요");
			return "redirect:" + req.getContextPath() + "/login";
		}
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		// session.invalidate(); // 세션 전체를 날려버림
		session.removeAttribute("SESSION_MEMBERVO"); // 하나씩 하려면 이렇게 해도 됨.
		return "main";
	}

	@RequestMapping(value = "/logins", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(HttpSession session,Model model, @RequestParam String code) throws Exception {
		logger.debug("code===");
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(),
				null);
		String accessToken = accessGrant.getAccessToken();
		Long expireTime = accessGrant.getExpireTime();
		if (expireTime != null && expireTime < System.currentTimeMillis()) {
			accessToken = accessGrant.getRefreshToken();
			logger.info("accessToken is expired. refresh token = {}", accessToken);
		}
		
		Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
		Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
		PlusOperations plusOperations = google.plusOperations();
		Person person = plusOperations.getGoogleProfile();
		logger.debug("=======f2{}",person.getBirthday());
		logger.debug("=======f3{}",person.getAccountEmail());
		logger.debug("=======f3{}",person.getEmailAddresses());
		logger.debug("=======f3{}",person.getEmails().size());
		
		
/*		
		MemberVo vo = new MemberVo(person.getId(), person.getId(), "pass", person.getDisplayName(), "kr");
		memberService.insertMember(vo);
		session.setAttribute("SESSION_MEMBERVO", vo);*/
		
		return "main";
	}
}
