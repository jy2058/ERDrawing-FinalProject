package kr.or.ddit.ticket.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.ticket.model.TicketVo;

@Repository("ticketDao")
public class TicketDaoImpl implements ITicketDao{

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<TicketVo> getAllTicketList() {
		return sqlSession.selectList("ticket.getAllTicketList");
	}

}
