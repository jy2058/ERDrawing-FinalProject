package kr.or.ddit.erd.dao;

import java.util.List;

import kr.or.ddit.erd.model.ErdVo;

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

}
