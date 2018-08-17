package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.AdminReportCode;
import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportOutputSet;
import kh.sns.interfaces.AdminReportsDAO;
import kh.sns.interfaces.AdminReportsService;

@Service
public class IAdminReportsService implements AdminReportsService {
	
	@Autowired
	AdminReportsDAO ard;

	
	public IAdminReportsService() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	// @Transactional
	public AdminReportOutputSet getAllReports() throws Exception {
		List<AdminReportDTO> reportList = ard.getAllReports();
		List<AdminReportCode> codeList = ard.getAllAdminReportCode();
		AdminReportOutputSet aros = new AdminReportOutputSet();
		aros.setReportList(reportList);
		aros.setCodeList(codeList);
		return aros;
	}
	
	@Override
	public AdminReportOutputSet getReportsByRange(int start, int end) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int insertAnReport(AdminReportDTO ard) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int updateAnReport(AdminReportDTO ard) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	

}
