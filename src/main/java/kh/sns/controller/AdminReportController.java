package kh.sns.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.AdminReportDTO;
import kh.sns.interfaces.AdminReportsService;

@Controller
public class AdminReportController {
	
	@Autowired
	AdminReportsService ars;
	
	@RequestMapping("/report.admin")
	public ModelAndView reportManagementMain() throws Exception {
		
		List<AdminReportDTO> list = ars.getAllReports();
				
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("admin_report.jsp");
		return mav;
	}
	
	@RequestMapping("/report.test")
	public ModelAndView reportTest() {
		
		try {
			List<AdminReportDTO> list = ars.getAllReports();
			
			list.forEach(System.out::println);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
	
		return mav;
	}
	
	
}
