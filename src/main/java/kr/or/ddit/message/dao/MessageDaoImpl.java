package kr.or.ddit.message.dao;

import java.util.List;
import java.util.Map;

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

	@Override
	public int insertMsg(Map<String, Object> memberMap) {
		return sqlSession.insert("member.insertMsg", memberMap);
	}

	@Override
	public int insertAplyMsg(MessageVo messageVo) {
		return sqlSession.insert("member.insertAplyMsg", messageVo);
	}

	@Override
	public int delMsg(int msgNo) {
		return sqlSession.delete("member.delMsg", msgNo);
	}

	@Override
	public int delMsgAll(String memId) {
		return sqlSession.delete("member.delMsgAll", memId);
	}

}
