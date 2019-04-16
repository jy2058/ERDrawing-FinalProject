package kr.or.ddit.ticket.dao;

import static org.junit.Assert.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.test.logicTestConfig;
import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.util.encrypt.kisa.sha256.KISA_SHA256;

public class TicketDaoImplTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(TicketDaoImplTest.class);
	
	@Resource(name="ticketDao")
	private ITicketDao ticketDao;

	@Test
	public void testTicketHistList() {
		Map<String,Object> map = new HashedMap();
		map.put("startDt", "20181101");
		map.put("endDt", "20200101");
		map.put("ticketNo", "2");
		List<TicketBuyHistVo> list = ticketDao.selectTicketHist(map);
		for(TicketBuyHistVo vo: list )
		assertTrue(list.size()>20);
	}
	
	

}
