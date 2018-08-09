package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

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
	
	

	@RequestMapping("/searchfriend.do")
	public void searchFriend(HttpServletResponse response,@RequestParam("searchtext") String searchtext,HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		System.out.println("친구검색들어옴");
		ModelAndView mav = new ModelAndView();
		String id = (String)  session.getAttribute("loginId");
		System.out.println("검색어 : " + searchtext);
		List<MemberDTO> list = null;
		List<String> friendlist = new ArrayList<>();
		
		try {
			list = memberService.selectfriendlist(id,searchtext);
			System.out.println("해당하는거잘찾았냐");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		for(MemberDTO tmp : list) {
			System.out.println(tmp.getNickname());
			friendlist.add(tmp.getNickname());
		}
		
		try {
			new Gson().toJson(friendlist, response.getWriter());
			
		}catch(Exception e1) {
			e1.printStackTrace();
		}
	}

	
	

}
