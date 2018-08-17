package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.AdminReportCode;
import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportResultCode;

public interface AdminReportsDAO {

	public int insertAnReport(AdminReportDTO ard) throws Exception;
	public int updateAnReport(AdminReportDTO ard) throws Exception;
	// delete 는 없음
	
	public List<AdminReportDTO> getAllReports() throws Exception;
	public List<AdminReportDTO> getReportsByRange(int start, int end) throws Exception;
	
	public List<AdminReportCode> getAllAdminReportCode() throws Exception;
	public List<AdminReportCode> getAdminReportCodeByRange(int start, int end) throws Exception;
	
	public List<AdminReportResultCode> getAllAdminResultCode() throws Exception;
	public List<AdminReportResultCode> getAdminResultCodeByRange(int start, int end) throws Exception;
}
