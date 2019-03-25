package kr.or.ddit.member.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.test.logicTestConfig;
import kr.or.ddit.util.encrypt.kisa.sha256.KISA_SHA256;

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
	
	@Test
	public void testInsertMember() {
		String pass = KISA_SHA256.encrypt("test");
		MemberVo vo = new MemberVo("test3","testmail", pass, "테스트", "kr","google");
		int cnt = memberDao.insertMember(vo);
		assertNotNull(cnt);
		assertEquals(1, cnt);
	}

}
