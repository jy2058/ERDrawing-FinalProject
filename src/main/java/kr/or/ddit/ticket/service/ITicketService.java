package kr.or.ddit.ticket.service;

import java.util.List;

import kr.or.ddit.ticket.model.TicketVo;

public interface ITicketService {

	List<TicketVo> getAllTicketList();
	
	TicketVo selectTicket(String ticketNo);
	
	int insertTicket(TicketVo ticketVo);

	int updateTicket(TicketVo ticketVo);
	
	int deleteTicket(String ticketNo);
}
