package kr.or.ddit.message.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.message.model.MessageVo;

@Repository("messageDao")
public class MessageDaoImpl implements IMessageDao{

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<MessageVo> getAllMsg(String memId) {
		return sqlSession.selectList("member.getAllMsg", memId);
	}

}
