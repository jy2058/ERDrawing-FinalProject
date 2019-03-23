package kr.or.ddit.erd.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.service.ITeamService;

@RequestMapping("/erd")
@Controller
public class ErdController {
	private Logger logger = LoggerFactory.getLogger(ErdController.class);
	
	@Resource(name="erdService")
	private IErdService erdService;
	
	@Resource(name="teamService")
	private ITeamService teamService;
	
	@RequestMapping(path = { "/erdAdd" }, method = { RequestMethod.POST })
	public String makeErd(ErdVo erdVo, @RequestParam("tag")String tag, HttpSession session){
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		
		logger.debug("======erdTitle : {}  ", erdVo.getErdTitle());
		
		// 1. 공개설정이 팀일 때와 아닐 때 insert 값이 달라야 한다. --> xml에서 nullif문 이용
		// 1.1 팀일 때는 memId가 null이어야 한다.
		// 1.2 개인일 때는 teamNo가 null이어야 한다.
		
		logger.debug("=====erdScope : {} ", erdVo.getErdScope());
		
		// 공개설정이 팀일 때
		if(erdVo.getErdScope().equals("team")){
			logger.debug("======selectTeam : {}  ", erdVo.getTeamNo());
			erdVo.setTeamNo(erdVo.getTeamNo());
		}
		// 공개설정이 개인일 때
		else{
			erdVo.setMemId(memberVo.getMemId());
			erdVo.setTeamNo(0);
		}
		
		logger.debug("====tag : {}", tag);
	
		// erd가 생성 됐을 때 실행 돼야 함
		// 태그가 있을 때
		if(!tag.isEmpty()){
			logger.debug("====tag 안 비었어");
			String tagEmptyRemove = tag.replaceAll("\\p{Z}", "");	// 앞뒤 공백 제거
			logger.debug("====tagEmptyRemove : {}", tagEmptyRemove);
			String[] tagSplit = tagEmptyRemove.split(",");	// (,)로 자르기
			
			logger.debug("====tagSplit.length : {}", tagSplit.length);
			
			
			int cnt = 0;	// 모든 태그가 들어갔는지 확인
			for(String tagFinal : tagSplit){
				cnt++;
				// (,)만 넣은 값 판별
				if(!tagFinal.equals("")){
					logger.debug("====tagSplit : {}", tagFinal);

					TagVo tagVo = new TagVo();
					tagVo.setTagContent(tagFinal);
					tagVo.setTagMaker(memberVo.getMemId());
					
					teamService.insertTag(tagVo);	
				}
			}
			logger.debug("=====cnt : {}", cnt);
			// 태그 추가가 완료 됐을 때 erd 추가
			if(tagSplit.length == cnt){	
				erdService.addErd(erdVo);
			}else{
				// ERD 생성 실패 시
				//태그 넣은 거 rollback;
			}
		}
		// 태그가 없을 경우
		else
			erdService.addErd(erdVo);
		
		logger.debug("====erdVo.getErdNo() : {}", erdVo.getErdNo());
		//왜 before로 하면 sequence -1 이고 after하면 sequence +1 돼...? ㅜㅜㅜㅜㅜㅜㅜ
		// tag_hist 작업 해야 함
		
		return "mypage";
	}
}
