package kr.or.ddit.post.model;

import java.util.Date;

public class PostVo {
	private int postNo;           //게시글번호
	private String postContent;   //게시글내용
	private Date postRegDt;       //작성일시
	private int postGn;           //그룹번호
	private String postDelFlag;   //삭제여부
	private int boardNo;          //게시판번호
	private int parentPostNo;     //부모게시글번호
	private String writerId;      //작성자아이디
	private String postTitle;     //게시글제목
	
}

