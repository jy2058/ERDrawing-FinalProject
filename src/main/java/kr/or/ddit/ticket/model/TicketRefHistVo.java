package kr.or.ddit.ticket.model;

import java.util.Date;

public class TicketRefHistVo {
	private int ticketBuyNo;			 //이용권구매번호
	private Date refundReqDt;            //환불신청날짜
	private String account;              //계좌번호
	private String bankNm;               //은행명
	private String accountHolder;        //예금주명
	private Date refund_Respdt;			 //환불날짜
}
