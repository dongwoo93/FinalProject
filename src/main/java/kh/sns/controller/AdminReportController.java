package kh.sns.controller;

import javax.servlet.http.HttpSession;

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
	public ModelAndView reportManagementMain(HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		// 나중에 관리 권한을 가진 사람들만 접속되도록 변경
		if(session.getAttribute("loginId") == null) {
			mav.setViewName("redirect:에러페이지");
			return mav;
		}
		
		AdminReportOutputSet aros = ars.getAllReports();						
		
		mav.addObject("list", aros.getReportList());
		mav.addObject("code", aros.getCodeList());
		mav.addObject("result", aros.getResultList());
		mav.setViewName("admin_report.jsp");
		return mav;
	}
	
}
