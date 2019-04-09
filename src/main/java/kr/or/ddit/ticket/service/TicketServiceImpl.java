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

}
