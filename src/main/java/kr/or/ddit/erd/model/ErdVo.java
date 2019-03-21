package kr.or.ddit.erd.model;

import java.util.Date;

public class ErdVo {
	private int erdNo;			//erd번호
	private String erdTitle;	//erd제목
	private String erdScope;	//erd범위 (public, private, team)
	private int erdReadCnt;		//조회수
	private Date erdCDt; 		//erd Create 날짜 
	private Date erdUDt; 		// erd Update 날짜
	private String erdColor;	//배경색
	private String memId;		//회원아이디(팀 erd인 경우 null이 들어감)
	private int teamNo;			//팀 번호 ( 팀 erd가 아닌 경우, null값이 들어감)
	
}
