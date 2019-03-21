package kr.or.ddit.post.model;

import java.util.Date;

public class commentsVo {
	private int cmtNo;     		//댓글번호
	private Date cmtRegDt; 		//댓글 작성 날짜
	private String cmtContent;  //내용
	private String cmtDelFlag;	//댓글삭제구분(T/F)
	private int postNo;			//게시글번호
	private String memId;		//댓글작성자아이디
}
