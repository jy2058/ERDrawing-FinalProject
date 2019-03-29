package kr.or.ddit.post.model;

import java.util.Date;

public class CommentLikeVo {
	private int cmtNo;		// 댓글번호
	private String memId;	// 회원아이디
	private Date CmtLikeDt; // 댓글 좋아요를 누른 날짜
	private int likeCheck;    
	
	public CommentLikeVo(){
		
	}
	
	public CommentLikeVo(int cmtNo, String memId){
		super();
		this.cmtNo = cmtNo;
		this.memId = memId;
	}
	
	public int getCmtNo() {
		return cmtNo;
	}
	public void setCmtNo(int cmtNo) {
		this.cmtNo = cmtNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Date getCmtLikeDt() {
		return CmtLikeDt;
	}
	public void setCmtLikeDt(Date cmtLikeDt) {
		CmtLikeDt = cmtLikeDt;
	}

	public int getLikeCheck() {
		return likeCheck;
	}

	public void setLikeCheck(int likeCheck) {
		this.likeCheck = likeCheck;
	}

	
	
}
