package kr.or.ddit.member.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.test.logicTestConfig;

public class MemberDaoImplTest extends logicTestConfig{
	
	@Resource(name="memberDao")
	private IMemberDao memberDao;

	@Test
	public void testGetAllMember() {
		List<MemberVo> list = memberDao.getAllMember();
		assertEquals(5, list.size());
	}
	
	@Test
	public void testSelectMember() {
		MemberVo userid= memberDao.selectMember("user1");
		assertNotNull(userid);
		assertEquals("윤한수", userid.getMemNm());
	}

}
