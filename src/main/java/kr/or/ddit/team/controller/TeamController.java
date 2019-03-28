package kr.or.ddit.team.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.team.model.TeamVo;

@RequestMapping("/team")
@Controller
public class TeamController {
	private Logger logger = LoggerFactory.getLogger(TeamController.class);
	
	@Resource(name="memberService")
	private IMemberService memberService;
	
	@RequestMapping(path="/teamCreate", method=RequestMethod.POST)
	public String teamCreate(TeamVo teamVo, @RequestParam("teamMember")List<String> teamMember, HttpServletRequest req, @RequestPart("profileImg")MultipartFile multipartFile){

		logger.debug("===teamNm : {}", teamVo.getTeamNm());
		logger.debug("===getTeamIntro : {}", teamVo.getTeamIntro());
		logger.debug("===teamMember : {}", teamMember);
		
		
		String path = req.getRealPath("image");
		
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
	
	@RequestMapping(path="/auto", method=RequestMethod.GET)
	public String auto(Model model, String value){
		
		logger.debug("===term:{}",value);
		
		List<MemberVo> list = memberService.getAutoFindMem(value);
		logger.debug("===list:{}",list);
		
		JSONArray array = new JSONArray();
		
		for(MemberVo vo : list){
			JSONObject obj = new JSONObject();
			obj.put("img", vo.getMemImg());
			obj.put("id", vo.getMemId());
			array.add(obj);
			
		}
		
		model.addAttribute("array", array);
		return "jsonView";
		
	}

}
