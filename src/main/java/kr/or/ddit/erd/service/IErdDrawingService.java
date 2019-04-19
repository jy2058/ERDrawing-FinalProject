package kr.or.ddit.erd.service;

import java.util.List;

import kr.or.ddit.erd.model.DomainVo;

public interface IErdDrawingService {

	//도메인 리스트 출력	//	사용안함 (search로 대체함)
	List<DomainVo> domainList(int erdNo);
	
	//도메인 검색
	List<DomainVo> domainSearch(DomainVo domainVo);

	//도메인 등록 및 수정
	int domainUpdate(DomainVo domainVo);

	//도메인 삭제
	int domainDelete(int domainNo);




}
