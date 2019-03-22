package kr.or.ddit.erd.dao;

import static org.junit.Assert.assertEquals;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.erd.model.ErdVo;
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

}
