package kh.sns.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.AdminReportOutputSet;
import kh.sns.interfaces.AdminReportsService;

@Controller
public class AdminReportController {
	
	@Autowired
	AdminReportsService ars;
	
	@RequestMapping("/report.admin")
	public ModelAndView reportManagementMain() throws Exception {
		
		AdminReportOutputSet aros = ars.getAllReports();
						
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", aros.getReportList());
		mav.addObject("code", aros.getCodeList());
		mav.setViewName("admin_report.jsp");
		return mav;
	}
	
	@RequestMapping("/report.test")
	public ModelAndView reportTest() {
		
		
		
		ModelAndView mav = new ModelAndView();
	
		return mav;
	}
	
	
}
