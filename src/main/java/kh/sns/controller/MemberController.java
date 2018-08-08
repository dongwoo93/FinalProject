package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
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
	
	private boolean isMav = false;


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
	
	

	@RequestMapping("/write.board")
	public ModelAndView writeBoard(HttpSession session) {
		System.out.println("@@WRITE BOARD");
		ModelAndView mav = new ModelAndView();
		String id = (String)  session.getAttribute("loginId");
		List<MemberDTO> list = null;
		List<String> friendlist = new ArrayList<>();
		
		try {
			list = memberService.selectfriendlist(id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		for(MemberDTO tmp : list) {
			friendlist.add(tmp.getNickname());
		}
		mav.addObject("friendlist", friendlist);
		mav.setViewName("write.jsp");
		return null;
	}

	
	

}
