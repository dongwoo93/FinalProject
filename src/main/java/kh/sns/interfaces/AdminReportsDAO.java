package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.AdminReportDTO;

public interface AdminReportsDAO {

	public int insertAnReport(AdminReportDTO ard) throws Exception;
	public int updateAnReport(AdminReportDTO ard) throws Exception;
	// delete 는 없음
	
	public List<AdminReportDTO> getAllReports() throws Exception;
	public List<AdminReportDTO> getReportsByRange(int start, int end) throws Exception;
}
