package kr.or.ddit.post.model;

import java.util.Date;

public class ReportVo {
	private String fromMemId; 		 //신고한 회원아이디
	private String ToMemId;  		 //신고당한 회원아이디
	private String reportReason; 	 //신고사유
	private Date reportDt;			 //신고날짜
	
	public ReportVo() {
	
	}
	
	public String getFromMemId() {
		return fromMemId;
	}
	public void setFromMemId(String fromMemId) {
		this.fromMemId = fromMemId;
	}
	public String getToMemId() {
		return ToMemId;
	}
	public void setToMemId(String toMemId) {
		ToMemId = toMemId;
	}
	public String getReportReason() {
		return reportReason;
	}
	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}
	public Date getReportDt() {
		return reportDt;
	}
	public void setReportDt(Date reportDt) {
		this.reportDt = reportDt;
	}
	@Override
	public String toString() {
		return "ReportVo [fromMemId=" + fromMemId + ", ToMemId=" + ToMemId + ", reportReason=" + reportReason
				+ ", reportDt=" + reportDt + "]";
	}

	
	
}
