package kr.or.ddit.team.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.team.model.TeamVo;

@RequestMapping("/team")
@Controller
public class TeamController {
	private Logger logger = LoggerFactory.getLogger(TeamController.class);
	
	@RequestMapping(path="/teamCreate", method=RequestMethod.POST)
	public String teamCreate(TeamVo teamVo, HttpServletRequest req, @RequestPart("profileImg")MultipartFile multipartFile){

		logger.debug("===teamNm : {}", teamVo.getTeamNm());
		logger.debug("===getTeamIntro : {}", teamVo.getTeamIntro());
		
		
		String path = req.getRealPath("image");
		
		logger.debug("===path:{}", path);
		
		String filename = multipartFile.getOriginalFilename() + "_" + UUID.randomUUID().toString();
		
		// 불러온 파일 저장할 공간 생성
		File profile = new File(path +"\\" + filename);
		try {
			multipartFile.transferTo(profile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return "redirect:/mypage";
	}

}
