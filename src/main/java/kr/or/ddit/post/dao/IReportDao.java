package kr.or.ddit.post.dao;

import java.util.List;

import kr.or.ddit.post.model.ReportVo;

public interface IReportDao {
	
	List<ReportVo> getAllReport(String toMemId);
	
	ReportVo getReport(String toMemId);
	
	int insertReport(ReportVo reportVo);
	
}
