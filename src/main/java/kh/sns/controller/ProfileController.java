package kh.sns.controller;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.ProfileService;

@Controller
public class ProfileController {
	
	@Autowired
	private ProfileService profileService;
	
	@RequestMapping("/toggleProfileCheckbox.ajax")
	public void toggleProfileCheckbox(HttpServletRequest request, HttpServletResponse response) {		
		
		response.setCharacterEncoding("UTF8");
		try {
			PrintWriter xout = response.getWriter();
			String fieldName = request.getParameter("fieldName");
			System.out.println("@@fieldName: " + fieldName);
			int result = profileService.toggleProfileCheckbox(profileService.getOneProfile(request.getSession().getAttribute("loginId").toString())
					, fieldName);
			System.out.println("@@result: " + result);
			xout.print(result);
			xout.flush();
			xout.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}   
	}

}
