package kr.or.ddit.member.service;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.test.logicTestConfig;

public class MemberServiceImplTest extends logicTestConfig{
	@Resource(name="memberService")
	private IMemberService memberService;
	
	@Test
	public void test() {
	//	assertNotNull(memberService.selectMember("user212"));
		assertNull(memberService.selectMember("user212"));
		assertEquals("윤한수",memberService.selectMember("user1").getMemNm());
		assertEquals(null,memberService.selectMember("user1333"));
	}

}
