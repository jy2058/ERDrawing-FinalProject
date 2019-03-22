package kr.or.ddit.erdhistory.model;

import java.util.Date;

//erd 내역을 담는 Vo
//하나의 erd에 대해 여러개가 존재할 수 있다.
public class ErdHistVo {
	private int erdHistNo;			//erd내역번호
	private int erdNo;				//erd번호
	private String erdTitle;		//ERD제목
	private Date erdDt;				//생성날짜
	private String erdIsVisible;	//기본값 T   (스냅샷을 한 뒤에 F로 변경)
	private String snapImg;			//스냅샷이미지경로
	private Date snapCDt; 			//스냅샷 Create 생성날짜

	
}
