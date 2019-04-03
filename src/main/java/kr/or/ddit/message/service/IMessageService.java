package kr.or.ddit.message.service;

import java.util.List;

import kr.or.ddit.message.model.MessageVo;

public interface IMessageService {
	
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
