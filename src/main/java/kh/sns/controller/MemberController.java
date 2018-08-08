package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

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
		return "join.jsp";
	}
	
	
	@RequestMapping("/login.do")
	public ModelAndView memberLogin(MemberDTO dto, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(dto.getId());
		System.out.println(dto.getPw());
		int result = this.memberService.loginMem(dto);
		System.out.println(result);
		if(result == 1) {
			String sessionId = dto.getId();
			session.setAttribute("loginId",sessionId);
			mav.setViewName("feed.bo");
		}else {
			mav.setViewName("loginfail.jsp");
		}
		return mav;
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
