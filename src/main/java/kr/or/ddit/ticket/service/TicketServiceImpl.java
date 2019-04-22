package kr.or.ddit.ticket.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.ticket.dao.ITicketDao;
import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketVo;

@Service("ticketService")
public class TicketServiceImpl implements ITicketService{

	@Resource(name="ticketDao")
	private ITicketDao ticketDao;
	
	@Override
	public List<TicketVo> getAllTicketList() {
		return ticketDao.getAllTicketList();
	}

	@Override
	public TicketVo selectTicket(String ticketNo) {
		return ticketDao.selectTicket(ticketNo);
	}

	@Override
	public int insertTicket(TicketVo ticketVo) {
		return ticketDao.insertTicket(ticketVo);
	}

	@Override
	public int updateTicket(TicketVo ticketVo) {
		return ticketDao.updateTicket(ticketVo);
	}

	@Override
	public int deleteTicket(String ticketNo) {
		return ticketDao.deleteTicket(ticketNo);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketHist(Map<String, Object> ticketMap) {
		return ticketDao.selectTicketHist(ticketMap);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketMonthList(Map<String, Object> ticketMap) {
		return ticketDao.selectTicketMonthList(ticketMap);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketYearList(String ticketNo) {
		return ticketDao.selectTicketYearList(ticketNo);
	}

	@Override
	public int insertticketBuyHist(TicketBuyHistVo ticketBuyHistVo) {
		return ticketDao.insertticketBuyHist(ticketBuyHistVo);
	}

	@Override
	public List<TicketBuyHistVo> selectTicketYearPieList(Map<String, Object> ticketMap) {
		return ticketDao.selectTicketYearPieList(ticketMap);
	}

}
