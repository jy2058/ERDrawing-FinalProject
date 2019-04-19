package kr.or.ddit.ticket.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketVo;

public interface ITicketService {

	List<TicketVo> getAllTicketList();
	
	TicketVo selectTicket(String ticketNo);
	
	int insertTicket(TicketVo ticketVo);

	int updateTicket(TicketVo ticketVo);

	
	int deleteTicket(String ticketNo);
	
	List<TicketBuyHistVo> selectTicketHist(Map<String, Object> ticketMap);
	
	List<TicketBuyHistVo> selectTicketMonthList(Map<String, Object> ticketMap);
	
	List<TicketBuyHistVo> selectTicketYearList(String ticketNo);
	
	int insertticketBuyHist(TicketBuyHistVo ticketBuyHistVo);
}
