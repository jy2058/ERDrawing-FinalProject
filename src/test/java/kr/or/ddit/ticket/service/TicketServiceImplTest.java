package kr.or.ddit.ticket.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.test.logicTestConfig;
import kr.or.ddit.ticket.dao.ITicketDao;

public class TicketServiceImplTest extends logicTestConfig{
	
	private Logger logger = LoggerFactory.getLogger(TicketServiceImplTest.class);
	
	@Resource(name="ticketService")
	private ITicketService ticketService;
	
	@Test
	public void test() {
	//	assertNotNull(memberService.selectMember("user212"));
	/*	assertNull(memberService.selectMember("user212"));
		assertEquals("윤한수",memberService.selectMember("user1").getMemNm());
		assertEquals(null,memberService.selectMember("user1333"));*/
	}
	}
