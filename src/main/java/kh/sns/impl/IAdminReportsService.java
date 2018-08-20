package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.AdminReportCode;
import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportOutputSet;
import kh.sns.dto.AdminReportResultCode;
import kh.sns.dto.JQueryPieChartVO;
import kh.sns.interfaces.AdminReportsDAO;
import kh.sns.interfaces.AdminReportsService;
import kh.sns.interfaces.BoardDAO;

@Service
public class IAdminReportsService implements AdminReportsService {
	
	@Autowired	AdminReportsDAO ard;
	@Autowired	BoardDAO bdao;
	
	public IAdminReportsService() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	// @Transactional
	public AdminReportOutputSet getAllReports() throws Exception {
		List<AdminReportDTO> reportList = ard.getAllReports();
		List<AdminReportCode> codeList = ard.getAllAdminReportCode();
		List<AdminReportResultCode> resultList = ard.getAllAdminResultCode();
		AdminReportOutputSet aros = new AdminReportOutputSet();
		aros.setReportList(reportList);
		aros.setCodeList(codeList);
		aros.setResultList(resultList);
		return aros;
	}
	
	@Override
	public AdminReportOutputSet getReportsByRange(int start, int end) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int insertAnReport(AdminReportDTO ard) throws Exception {
		return this.ard.insertAnReport(ard);
	}
	
	@Override
	public int updateAnReport(AdminReportDTO ard) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<AdminReportCode> getReportCodeList() throws Exception {
		return ard.getReportCodeList();
	}
	
	@Override
	public List<JQueryPieChartVO> getAdminReportProcessedForPieChartVO() throws Exception {
		return ard.getAdminReportProcessedForPieChartVO();
	}
	
	@Override
	public List<AdminReportResultCode> getResultCodeList() throws Exception {
		return ard.getResultCodeList();
	}
	
	@Override
	public List<Integer> getAllAcceptedCounts() throws Exception {
		return ard.getAllAcceptedCounts();
	}
	
	@Override
	public List<Integer> getAcceptedCountsByRange() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	// @Transactional
	public int manageAnReport(AdminReportDTO report) throws Exception {
		AdminReportResultCode arrc = ard.getOneResultCode(report.getResultCode());
		
		int result = 1;
		
		if(arrc.getIsDelete().equalsIgnoreCase("y"))	result *= bdao.deleteBoard(report.getBoardSeq());
		if(arrc.getIsMemberBlocked().equalsIgnoreCase("y"))	{
			// 차단
		}	
		
		System.out.println("@@Result: " + result);
		
		if(result >= 1) {
			ard.updateAnReport(report);
			System.out.println("도달");
		}
		
		return result;
	}
	
	@Override
	public int deleteAnArticleByAdmin(int boardSeq) throws Exception {
		return bdao.deleteBoard(boardSeq);
	}
	
	@Override
	public int blockAnMemberByAdmin(String id, int day) throws Exception {
		return ard.blockAnMemberByAdmin(id, day);
	}
	
	@Override
	public AdminReportDTO getOneReport(int reportSeq) throws Exception {
		return ard.getOneReport(reportSeq);
	}

}
