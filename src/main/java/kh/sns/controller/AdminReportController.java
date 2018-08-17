package kh.sns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminReportController {
	
	@RequestMapping("/report.admin")
	public ModelAndView reportManagementMain() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_report.jsp");
		return mav;
	}
	
}
