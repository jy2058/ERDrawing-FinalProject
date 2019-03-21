package kr.or.ddit.message.model;

import java.util.Date;

public class MessageVo {
	
	private int msgNo;			//쪽지번호
	private String senderId;	//보내는(송신)회원아이디
	private Date sendDt;		//보낸 날짜
	private String msgTitle;	//제목
	private String msgContent;	//내용
	private String msgType;		//쪽지구분 (팀초대 수락인지? / 단순 쪽지인지)

}
