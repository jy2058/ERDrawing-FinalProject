package kr.or.ddit.team.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import kr.or.ddit.team.service.ITeamService;

@RequestMapping("/team")
@Controller
public class TeamController {
	private Logger logger = LoggerFactory.getLogger(TeamController.class);
	
	@Resource(name="memberService")
	private IMemberService memberService;
	@Resource(name="teamService")
	private ITeamService teamService;
	
	@RequestMapping(path="/teamCreate", method=RequestMethod.POST)
	public String teamCreate(TeamVo teamVo, @RequestParam("teamMember")List<String> teamMember, HttpServletRequest req, @RequestPart("profileImg")MultipartFile multipartFile, HttpSession session){

		logger.debug("===teamNm : {}", teamVo.getTeamNm());
		logger.debug("===getTeamIntro : {}", teamVo.getTeamIntro());
		logger.debug("===teamMember : {}", teamMember);
		
		logger.debug("===getOriginalFilename : {}", multipartFile.getOriginalFilename());
		
		String[] split = multipartFile.getOriginalFilename().split("\\.");
		String fileName = split[0];	// 파일 이름
		String ext = split[1];	// 확장자
		
		logger.debug("===fileName : {}, ext : {}", fileName, ext);
		
		String path = req.getRealPath("image");
		
		String filename = fileName + "_" + UUID.randomUUID().toString() + "." + ext;
		
		// 불러온 파일 저장할 공간 생성
		File profile = new File(path +"\\" + filename);
		try {
			multipartFile.transferTo(profile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		teamVo.setMakerId(memId);
		teamVo.setTeamImg(path +"\\" + filename);
		
		teamService.insertTeam(teamVo);
		int teamNo = teamVo.getTeamNo();
		
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
	
	@RequestMapping("/teamImg")
	public void teamImg(){
		//userController profileImg 참고
		//team이미지 없을 때 / 있을 때 사진 조회
		
		// view는 user.jsp
	}

}
