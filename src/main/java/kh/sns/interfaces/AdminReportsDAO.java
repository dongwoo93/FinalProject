package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.AdminReportCode;
import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportResultCode;
import kh.sns.dto.JQueryPieChartVO;

public interface AdminReportsDAO {

	public int insertAnReport(AdminReportDTO ard) throws Exception;
	public int updateAnReport(AdminReportDTO report) throws Exception;
	// delete 는 없음
	
	public List<AdminReportDTO> getAllReports() throws Exception;
	public List<AdminReportDTO> getReportsByRange(int start, int end) throws Exception;
	
	public AdminReportDTO getOneReport(int reportSeq) throws Exception;
	public AdminReportResultCode getOneResultCode(int resultCode) throws Exception;
	
	public List<AdminReportCode> getAllAdminReportCode() throws Exception;
	public List<JQueryPieChartVO> getAdminReportProcessedForPieChartVO() throws Exception;
	
	public List<AdminReportResultCode> getAllAdminResultCode() throws Exception;
	
	public List<AdminReportCode> getReportCodeList() throws Exception;
	
	public List<AdminReportResultCode> getResultCodeList() throws Exception;
	
	public List<Integer> getAllAcceptedCounts() throws Exception;
	public List<Integer> getAcceptedCountsByRange() throws Exception;
	
	// 삭제(관리자)
	// BoardDAO 이용
	
	// 차단(관리자)
	public int blockAnMemberByAdmin(String id, int day) throws Exception;

}
