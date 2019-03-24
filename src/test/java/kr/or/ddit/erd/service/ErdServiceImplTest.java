package kr.or.ddit.erd.service;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.test.logicTestConfig;

public class ErdServiceImplTest extends logicTestConfig{
	@Resource(name="erdService")
	private IErdService erdService;

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
		
		erdVo.setErdTitle("테스트코드서비스타이틀");
		erdVo.setErdScope("public");
		erdVo.setMemId("user3");
		erdVo.setTeamNo(1);
		/***When***/
		int addCnt = erdService.addErd(erdVo);

		/***Then***/
		assertEquals(addCnt, 1);
		
	}
	
	/*@Test
	public void testAddErdTagFull() {
		*//***Given***//*
		ErdVo erdVo = new ErdVo();
		
		String tag = "1,3,4,5";
		
		
		erdVo.setErdTitle("테스트코드고친거");
		erdVo.setErdScope("public");
		erdVo.setMemId("user3");

		*//***When***//*
		int addCnt = erdService.addErdTag(erdVo, tag);

		*//***Then***//*
		assertEquals(addCnt, 1);
		
	}
*/
}
