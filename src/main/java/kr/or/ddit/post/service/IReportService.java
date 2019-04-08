package kr.or.ddit.post.service;

import java.util.List;

import kr.or.ddit.post.model.ReportVo;

public interface IReportService {
	
	List<ReportVo> getAllReport(String toMemId);

	ReportVo getReport(String toMemId);

	int insertReport(ReportVo reportVo);

}
