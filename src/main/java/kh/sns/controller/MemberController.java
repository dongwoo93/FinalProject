package kh.sns.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
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
	
	/*======*/
	@RequestMapping("/profile.member")
	public ModelAndView editProfile(HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		if(session.getAttribute("loginId") != null) {
			System.out.println("currentLoginId: " + session.getAttribute("loginId").toString());
			MemberDTO member = memberService.getOneMember(session.getAttribute("loginId").toString());
			System.out.println();
			
			mav.setViewName("mypage.jsp");
			mav.addObject("member", member);
		} else {
			// 작업 추가
		}		
		
		return mav;		
		
	}
	
	@RequestMapping("/editProfileProc.member")
	public ModelAndView editProfile(MemberDTO member, HttpServletRequest request) throws Exception {
		
		member.setId(request.getSession().getAttribute("loginId").toString());
		System.out.println(member);
		
		int result = memberService.updateOneMemberProfile(member);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("redirect:profile.member");
		return mav;		
	}
	
	@RequestMapping("/isEmailDuplicated.ajax")
	public void checkEmailDuplicated(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF8");
		// PrintWriter를 꺼내기 전에 response의 인코딩을 설정
		response.setCharacterEncoding("UTF8");
		PrintWriter xout = response.getWriter();   
		
		boolean isEmailDuplicated = false;
		int result = memberService.checkEmailDuplicated(request.getParameter("email"), 
				request.getSession().getAttribute("loginId").toString());
		if(result >= 1) {
			isEmailDuplicated = true;
		} else {
			isEmailDuplicated = false;
		}
		
		System.out.println("isEmailDuplicated: " + isEmailDuplicated + "(" + result + ")");

		xout.println(isEmailDuplicated);
	}
	
	@RequestMapping("/passwordChangeProc.member")
	public ModelAndView passwordChange(MemberDTO member, HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String id = request.getSession().getAttribute("loginId").toString();
		String beforePassword = request.getParameter("beforePassword");
		
		boolean isBeforePasswordCorrect = memberService.getOneMember(id).getPw().equals(beforePassword);
		if(isBeforePasswordCorrect) {
			member.setId(request.getSession().getAttribute("loginId").toString());
			System.out.println(member);
			
			int result = memberService.updateOneMemberPassword(member);
			
			mav.addObject("result", result);
		} else {
			// 이전 패스워드 입력이 틀렸을 때
			mav.addObject("result", 0);
			System.out.println("이전 패스워드 입력이 틀림");
		}
		mav.setViewName("redirect:profile.member");
		
		return mav;		
	}
	

}
