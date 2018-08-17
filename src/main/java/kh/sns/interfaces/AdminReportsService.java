package kh.sns.interfaces;

import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportOutputSet;

public interface AdminReportsService {
	
	public int insertAnReport(AdminReportDTO ard) throws Exception;
	public int updateAnReport(AdminReportDTO ard) throws Exception;
	// delete 는 없음
	
	public AdminReportOutputSet getAllReports() throws Exception;
	public AdminReportOutputSet getReportsByRange(int start, int end) throws Exception;
	
}
