package kr.or.ddit.message.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.message.model.MessageVo;
import kr.or.ddit.test.logicTestConfig;

public class MessageServiceImplTest extends logicTestConfig{
	private Logger logger = LoggerFactory.getLogger(MessageServiceImplTest.class);
	
	@Resource(name="messageService")
	private IMessageService messageService;

	/**
	* Method : testGetAllMsg
	* 작성자 : PC08
	* 변경이력 :
	* Method 설명 : 멤버 별 메시지 조회
	*/
	@Test
	public void testGetAllMsg() {
		/***Given***/
		String memId = "user2";
		/***When***/
		List<MessageVo> allMsg = messageService.getAllMsg(memId);

		/***Then***/
		assertNotNull(allMsg);
		logger.debug("===allMsg : {}", allMsg);
	}

}
