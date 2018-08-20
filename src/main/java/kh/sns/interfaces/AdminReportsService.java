package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.AdminReportCode;
import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportOutputSet;
import kh.sns.dto.AdminReportResultCode;
import kh.sns.dto.JQueryPieChartVO;

public interface AdminReportsService {
	
	public int insertAnReport(AdminReportDTO ard) throws Exception;
	public int updateAnReport(AdminReportDTO ard) throws Exception;
	// delete 는 없음
	
	public AdminReportOutputSet getAllReports() throws Exception;
	public AdminReportOutputSet getReportsByRange(int start, int end) throws Exception;
	
	public AdminReportDTO getOneReport(int reportSeq) throws Exception;
	
	public List<AdminReportCode> getReportCodeList() throws Exception;
	public List<JQueryPieChartVO> getAdminReportProcessedForPieChartVO() throws Exception;
	
	public List<AdminReportResultCode> getResultCodeList() throws Exception;	
	
	public List<Integer> getAllAcceptedCounts() throws Exception;
	public List<Integer> getAcceptedCountsByRange() throws Exception;
	
	// 종합작업
	public int manageAnReport(AdminReportDTO report) throws Exception;
	
	// 삭제(관리자)
	public int deleteAnArticleByAdmin(int boardSeq) throws Exception;
	
	// 차단(관리자)
	public int blockAnMemberByAdmin(String id, int day) throws Exception;
}
