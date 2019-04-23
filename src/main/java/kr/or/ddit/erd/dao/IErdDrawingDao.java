package kr.or.ddit.erd.dao;

import java.util.List;

import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.erdhistory.model.ErdHistVo;

public interface IErdDrawingDao {

	//도메인 리스트 가져오기
	List<DomainVo> domainList(int erdNo);

	//도메인 삭제
	int domainDelete(int domainNo);

	//도메인 수정
	int domainModify(DomainVo domainVo);

	//도메인 추가
	int domainInsert(DomainVo domainVo);

	//도메인 검색
	List<DomainVo> domainSearch(DomainVo domainVo);

	//erd 히스토리 추가
	int erdHistInsert(ErdHistVo erdHistVo);

	//erd 최신 히스토리 가져오기
	ErdHistVo erdMaxHistSelect(int erdNo);

	
	

}