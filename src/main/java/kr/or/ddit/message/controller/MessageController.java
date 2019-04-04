package kr.or.ddit.message.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.message.model.MessageVo;
import kr.or.ddit.message.service.IMessageService;
import kr.or.ddit.team.model.TeamListVo;

@RequestMapping("/message")
@Controller
public class MessageController {
	private Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@Resource(name="messageService")
	IMessageService messageService;
	
	@RequestMapping("/messageView")
	public String messageView(){
		return "member/message";
	}
	
	@RequestMapping("/insertMsg")
	public String insertMsg(MessageVo msgVo, @RequestParam("value")String value, HttpSession session){
		
		Object obj = session.getAttribute("SESSION_MEMBERVO");
		MemberVo memberVo = (MemberVo)obj;
		
		String memId = memberVo.getMemId();
		String receiverId = msgVo.getSenderId();
		String content="";
		int teamNo = msgVo.getTeamNo();
		
		msgVo.setReceiverId(receiverId);
		msgVo.setSenderId(memId);
		msgVo.setMsgType("n");
		
		TeamListVo teamListVo = new TeamListVo();
		teamListVo.setMemId(memId);
		teamListVo.setTeamNo(teamNo);
		
		switch(value){
			case "yes":
				content = memId + " 님이 초대를 수락하였습니다.";
				msgVo.setMsgContent(content);
				teamListVo.setTeamAgreeFlag("y");
				
				messageService.insertAplyMsg(msgVo, teamListVo);
				break;
				
			case "no":
				content = memId + " 님이 초대를 거절하였습니다.";
				msgVo.setMsgContent(content);
				teamListVo.setTeamAgreeFlag("n");
				
				messageService.insertAplyMsg(msgVo, teamListVo);
				break;
				
			case "del":
				messageService.delMsg(msgVo.getMsgNo());
				break;
				
			case "delAll":
				messageService.delMsgAll(memId);
				break;
		}
		
		return "jsonView";
	}

}
