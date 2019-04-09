package kr.or.ddit.ticket.dao;

import java.util.List;

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
}
