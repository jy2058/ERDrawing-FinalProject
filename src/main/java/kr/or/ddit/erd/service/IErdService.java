package kr.or.ddit.erd.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.erd.model.ErdVo;

public interface IErdService {
	/**
	* Method : addErd
	* 작성자 : PC08
	* 변경이력 :
	* @param erdVo
	* @return
	* Method 설명 : erd 생성
	*/
	int addErd(ErdVo erdVo);
	

	/**
	* Method : addErdTag
	* 작성자 : kjy
	* 변경이력 :
	* @param erdVo
	* @param tag
	* @return
	* Method 설명 : erd 생성 시 태그도 함께 insert
	*/
	int addErdTag(ErdVo erdVo, String tag, String memId);
	
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
	* Method : getMyErdTagMap
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 나의 erd리스트와 태그 리스트 가져오기
	*/
	Map<String, Object> getMyErdTagMap(String memId);

}
