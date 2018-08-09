package kh.sns.controller;

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
		
		System.out.println("currentLoginId: " + session.getAttribute("loginId").toString());
		MemberDTO member = memberService.getOneMember(session.getAttribute("loginId").toString());
		System.out.println();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mypage.jsp");
		mav.addObject("member", member);
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
	

}
