package kh.sns.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.MemberDTO;
import kh.sns.interfaces.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	@RequestMapping("/main.do")
	public String toIndex() throws Exception {
		return "redirect:main.jsp";

	}
	
	@RequestMapping("/join.do")
	public String toInput() throws Exception {
		return "redirect:join.jsp";
	}
	
	
	@RequestMapping("/login.do")
	public void memberLogin(MemberDTO dto, HttpSession session, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		response.setCharacterEncoding("UTF-8");
		System.out.println(dto.getId());
		System.out.println(dto.getPw());
		int result = this.memberService.loginMem(dto);
		System.out.println(result);
		if(result == 1) {
			String sessionId = dto.getId();
			session.setAttribute("loginId",sessionId);
		}else {
			
		}
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
		
	}
	@RequestMapping("/sign.do")
	public ModelAndView signUp(MemberDTO dto) {
		ModelAndView mav = new ModelAndView();
		int result = this.memberService.signUp(dto);
		
		mav.addObject("result",result);
		mav.setViewName("join.jsp");
		return mav;
	}
	@RequestMapping("/dupId.do")
	public void isIdExist(MemberDTO dto, HttpServletResponse response) throws Exception{
		System.out.println("오냐?");
//		int result =this.memberService.isIdExist(dto);
		response.getWriter().print(1);
		response.getWriter().flush();
		response.getWriter().close();
	}
	

}
