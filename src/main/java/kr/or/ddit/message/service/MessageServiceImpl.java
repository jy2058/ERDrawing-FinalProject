package kr.or.ddit.message.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.message.dao.IMessageDao;
import kr.or.ddit.message.model.MessageVo;

@Service("messageService")
public class MessageServiceImpl implements IMessageService{
	
	private Logger logger = LoggerFactory.getLogger(MessageServiceImpl.class);
	
	@Resource(name="messageDao")
	private IMessageDao messageDao;
	
	@Override
	public List<MessageVo> getAllMsg(String memId) {
		return messageDao.getAllMsg(memId);
	}

}
