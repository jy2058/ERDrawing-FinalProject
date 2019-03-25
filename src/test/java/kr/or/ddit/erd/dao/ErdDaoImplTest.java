package kr.or.ddit.erd.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.test.logicTestConfig;

public class ErdDaoImplTest extends logicTestConfig{
	
	@Resource(name="erdDao")
	private IErdDao erdDao;

	/**
	* Method : testAddErd
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : erd 생성 테스트
	*/
	@Test
	public void testAddErd() {
		/***Given***/
		ErdVo erdVo = new ErdVo();
		
		erdVo.setErdTitle("테스트코드타이틀");
		erdVo.setErdScope("public");
		erdVo.setMemId("user3");
		erdVo.setTeamNo(0);
		/***When***/
		int addCnt = erdDao.addErd(erdVo);

		/***Then***/
		assertEquals(addCnt, 1);

	}
	
	/**
	* Method : testGetMyErdList
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 나의 erd 리스트 가져오기 테스트
	*/
	@Test
	public void testGetMyErdList(){
		/***Given***/
		String memId = "user3";
		/***When***/
		List<ErdVo> myErdList = erdDao.getMyErdList(memId);

		/***Then***/
		assertNotNull(myErdList);

	}
	
	

}
