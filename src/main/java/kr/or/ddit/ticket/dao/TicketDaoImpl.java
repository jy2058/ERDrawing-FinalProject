package kr.or.ddit.ticket.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketVo;

@Repository("ticketDao")
public class TicketDaoImpl implements ITicketDao{

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<TicketVo> getAllTicketList() {
		return sqlSession.selectList("ticket.getAllTicketList");
	}

	@Override
	public TicketVo selectTicket(String ticketNo) {
		return sqlSession.selectOne("ticket.selectTicket",ticketNo);
	}

	@Override
	public int insertTicket(TicketVo ticketVo) {
		return sqlSession.insert("ticket.insertTicket",ticketVo);
	}

	@Override
	public int updateTicket(TicketVo ticketVo) {
		return sqlSession.update("ticket.updateTicket",ticketVo);
	}

	@Override
	public int deleteTicket(String ticketNo) {
		return sqlSession.delete("ticket.deleteTicket",ticketNo);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketHist(Map<String, Object> ticketMap) {
		return sqlSession.selectList("ticket.selectTicketHist",ticketMap);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketMonthList(Map<String, Object> ticketMap) {
		return sqlSession.selectList("ticket.selectTicketMonthList",ticketMap);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketYearList(String ticketNo) {
		return sqlSession.selectList("ticket.selectTicketYearList",ticketNo);
	}

	@Override
	public int insertticketBuyHist(TicketBuyHistVo ticketBuyHistVo) {
		return sqlSession.insert("ticket.insertticketBuyHist",ticketBuyHistVo);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketYearPieList(Map<String, Object> ticketMap) {
		return sqlSession.selectList("ticket.selectTicketYearPieList",ticketMap);
	}

	@Override
	public List<Map<String, Object>> getAllTicketRefList() {
		return  sqlSession.selectList("ticket.getAllTicketRefList");
		
	}
	
	

}
