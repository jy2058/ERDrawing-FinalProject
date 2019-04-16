package kr.or.ddit.ticket.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketVo;

public interface ITicketDao {
	/**
	 * Method : getAllTicketList
	 * 작성자 : PC02
	 * 변경이력 :
	 * @return
	 * Method 설명 : 티켓 전체 조회
	 */
	List<TicketVo> getAllTicketList();
	
	
	/**
	 * Method : selectTicket
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 : 특정 티켓 정보 조회
	 */
	TicketVo selectTicket(String ticketNo);
	
	/**
	 * Method : insertTicket
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketVo
	 * @return
	 * Method 설명 :티켓 추가 
	 */
	int insertTicket(TicketVo ticketVo);
	
	/**
	 * Method : updateTicket
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 :티켓정보 수정
	 */
	int updateTicket(TicketVo ticketVo);
	
	/**
	 * Method : deleteTicket
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 : 티켓 삭제 
	 */
	int deleteTicket(String ticketNo);
	
	/**
	 * Method : selectTicketHist
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param ticketNo
	 * @return
	 * Method 설명 : 티켓 
	 */
	List<TicketBuyHistVo> selectTicketHist(Map<String, Object> ticketMap);
	
	
}
