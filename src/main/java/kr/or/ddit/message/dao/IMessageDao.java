package kr.or.ddit.message.dao;

import java.util.List;

import kr.or.ddit.message.model.MessageVo;

public interface IMessageDao {

	/**
	* Method : getAllMsg
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 멤버별 메시지 조회
	*/
	List<MessageVo> getAllMsg(String memId);
}
