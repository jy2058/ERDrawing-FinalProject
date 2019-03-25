package kr.or.ddit.team.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;
import kr.or.ddit.test.logicTestConfig;

public class TeamDaoImplTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(TeamDaoImplTest.class);
	
	@Resource(name="teamDao")
	private ITeamDao teamDao;

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
		List<TeamListVo> teamAllList = teamDao.getTeamAllList("user3");

		/***Then***/
		assertNotNull(teamAllList);
		logger.debug("====teamAllList : {}", teamAllList);
		
	}
	
	/**
	* Method : testGetTeamInfo
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 팀 정보 가져오기
	*/
	@Test
	public void testGetTeamInfo() {
		/***Given***/
		
		/***When***/
		TeamVo teamVo = teamDao.getTeamInfo(1);

		/***Then***/
		assertNotNull(teamVo);
		logger.debug("====teamVo : {}", teamVo);
		
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
		int insertTag = teamDao.insertTag(tagVo);

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
		tagVo.setTagContent("4");
		tagVo.setTagMaker("user3");
		/***When***/
		int insertTag = teamDao.insertTag(tagVo);

		/***Then***/
		assertEquals(1, insertTag);
		
	}
	
	/**
	* Method : testInsertTagHist
	* 작성자 : kjy
	* 변경이력 :
	* Method 설명 : 태그, erd 맵핑 테스트
	*/
	@Test
	public void testInsertTagHist(){
		/***Given***/
		TagHistVo tagHistVo = new TagHistVo();
		tagHistVo.setErdNo(1035);
		tagHistVo.setTagNo(1);
		/***When***/
		int cnt = teamDao.insertTagHist(tagHistVo);

		/***Then***/
		assertEquals(1, cnt);

		
	}
	
	@Test
	public void testGetTagNo(){
		/***Given***/
		String content = "1";
		/***When***/
		int tagNo = teamDao.getTagNo(content);

		/***Then***/
		assertEquals(1, tagNo);

	}
	
	@Test
	public void testGetErdTag(){
		/***Given***/
		int erdNo = 1035;
		/***When***/
		List<TagVo> erdTag = teamDao.getErdTag(erdNo);

		/***Then***/
		assertNotNull(erdTag);
	}
	
}
