package kr.or.ddit.erd.dao;

import java.util.List;

import kr.or.ddit.erd.model.DomainVo;

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

	
	

}
