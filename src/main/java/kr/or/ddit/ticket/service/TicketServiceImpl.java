package kr.or.ddit.ticket.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.ticket.dao.ITicketDao;
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

}
