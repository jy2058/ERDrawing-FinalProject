package kr.or.ddit.member.model;

import java.util.Date;

public class MemberVo {
	private String memId;  			//회원아이디
	private String memMail;			//이메일
	private String memPass;			//비밀번호
	private String memCancelFlag;	//탈퇴여부
	private String memImg;			//프로필이미지
	private String memAuth;			//관리자권한
	private String memNm;			//이름
	private String memIntro;		//자기소개
	private String memLang;			//사용언어
	private String memTel;			//핸드폰번호
	private Date memPeriod; 		//이용권 기한
	private Date memInDt;			//회원가입날짜
	private String memBlackFlag;	//블랙리스트여부
}
