package kr.or.ddit.erd.dao;

import java.util.List;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.util.model.PageVo;

public interface IErdDao {
	/**
	* Method : addErd
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : erd 생성
	*/
	int addErd(ErdVo erdVo);
	
	/**
	* Method : getMyErdList
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 나의 Erd리스트 가져오기
	*/
	List<ErdVo> getMyErdList(String memId);
	
	/**
	* Method : delErd
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : erd 삭제
	*/
	int delErd(int erdNo);

	/**
	* Method : getAllErdList
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : 모든 erd 리스트 가져오기
	*/
	List<ErdVo>getAllErdList();
	
	/**
	* Method : getAllErdListPaging
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : 모든 ERD 페이징 리스트
	*/
	List<ErdVo>getAllErdListPaging(PageVo pageVo);
	
	/**
	* Method : getAllErdCnt
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : 모든 ERD 개수
	*/
	int getAllErdCnt();
}
