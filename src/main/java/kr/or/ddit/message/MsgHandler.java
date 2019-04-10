package kr.or.ddit.message;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

@Repository
public class MsgHandler implements WebSocketHandler{
	private Logger logger = LoggerFactory.getLogger(MsgHandler.class);
	
	List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	//클라이언트가 서버로 연결된 이후에 실행
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		logger.debug("***연결완료 : {}", session.getId());
		
	}

	@Override
	// 클라이언트가 서버로 메세지를 전송했을 때 실행
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		logger.debug("***sessionList : {}로부터 message.getPayload() : {}", session.getId(), message.getPayload());
		for (WebSocketSession sess : sessionList) { 
			sess.sendMessage(new TextMessage(session.getId() + " : " + message.getPayload())); 
		}
	}

	@Override
	// 연결된 클라이언트에서 예외 발생 시 실행
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		
	}

	@Override
	// 클라이언트가 연결을 끊었을 때 실행
	public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
		sessionList.remove(session); 
		logger.debug("{} 연결 끊김", session.getId());
	}

	@Override
	public boolean supportsPartialMessages() {
		// TODO Auto-generated method stub
		return false;
	}

}
