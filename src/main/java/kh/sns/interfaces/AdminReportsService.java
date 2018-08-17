package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.AdminReportCode;

public interface AdminReportsService {
	
	public int insertAnReport(AdminReportCode arc) throws Exception;
	public int updateAnReport(AdminReportCode arc) throws Exception;
	// delete 는 없음
	
	public List<AdminReportCode> getAllReports() throws Exception;
	public List<AdminReportCode> getReportsByRange(int start, int end) throws Exception;
	
}
