package kr.or.ddit.team.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;
import kr.or.ddit.test.logicTestConfig;

public class TeamServiceImplTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(TeamServiceImplTest.class);
	
	@Resource(name="teamService")
	private ITeamService teamService;

	/**
	* Method : testGetTeamAllList
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 회원의 팀 리스트 가져오기
	*/
	@Test
	public void testGetTeamAllList() {
		/***Given***/
		
		/***When***/
		List<TeamListVo> teamAllList = teamService.getTeamAllList("user3");

		/***Then***/
		assertNotNull(teamAllList);
		logger.debug("====teamAllList : {}", teamAllList);
		

	}
	
	/**
	* Method : testGetMemberTeamInfoList
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 회원의 팀 정보 가져오기
	*/
	@Test
	public void testGetMemberTeamInfoList(){
		/***Given***/
		/***When***/
		List<TeamVo> memberTeamInfoList = teamService.getMemberTeamInfoList("user3");

		/***Then***/
		assertNotNull(memberTeamInfoList);
		
		logger.debug("====memberTeamInfoList : {}", memberTeamInfoList);
		

	}
	
	/**
	* Method : testGetMemberAgreTeamInfoList
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 회원이 수락한 팀 정보 가져오기
	*/
	@Test
	public void testGetMemberAgreTeamInfoList(){
		/***Given***/
		/***When***/
		List<TeamVo> memberTeamInfoList = teamService.getMemberAgreTeamInfoList("user3");

		/***Then***/
		assertNotNull(memberTeamInfoList);
		
		logger.debug("====memberTeamInfoList : {}", memberTeamInfoList);
		

	}
	
	/**
	* Method : testInsertTag
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 태그 insert 중복 됐을 때
	*/
	@Test
	public void testInsertTagDuple() {
		/***Given***/
		TagVo tagVo = new TagVo();
		tagVo.setTagContent("1");
		tagVo.setTagMaker("user3");
		/***When***/
		int insertTag = teamService.insertTag(tagVo);

		/***Then***/
		assertNotEquals(1, insertTag);
		
	}
	
	/**
	* Method : testInsertTagNew
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 태그 insert 중복 없을 때
	*/
	@Test
	public void testInsertTagNew() {
		/***Given***/
		TagVo tagVo = new TagVo();
		tagVo.setTagContent("5");
		tagVo.setTagMaker("user3");
		/***When***/
		int insertTag = teamService.insertTag(tagVo);

		/***Then***/
		assertEquals(1, insertTag);
		
	}
	

}
