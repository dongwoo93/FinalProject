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
import kh.sns.dto.MessengerDTO;
import kh.sns.interfaces.MemberService;
import kh.sns.interfaces.MessengerService;

@Controller
public class MessengerController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MessengerService messengerService;
	
	@RequestMapping("/dmfriendlist.do")
	public void searchFriend(HttpServletResponse response, @RequestParam("searchtext") String searchtext, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		System.out.println("dm 친구목록 들어옴");
		ModelAndView mav = new ModelAndView();
		String id = (String)  session.getAttribute("loginId");
		List<MemberDTO> list = null;
		List<String> friendlist = new ArrayList<>();
		
		try {
			list = memberService.selectfollowlist(id,searchtext);
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
	
	@RequestMapping("/selectUserId.do")
	public void selectUserId(HttpServletResponse response, @RequestParam("nickname") String nickname, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		System.out.println("아이디찾기들어옴");
		ModelAndView mav = new ModelAndView();
		MemberDTO dto = null;
		try {
			dto = memberService.selectUserId(nickname);
			System.out.println("해당하는거잘찾음 ?");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		try {
			new Gson().toJson(dto.getId(), response.getWriter());
			
		}catch(Exception e1) {
			e1.printStackTrace();
		}
	}
	
	@RequestMapping("/insertMessage.do")
	public void insertMessage(HttpServletResponse response, @RequestParam("message") String message,@RequestParam("receiver") String receiver,@RequestParam("sender") String sender, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		MessengerDTO dto = new MessengerDTO(0,sender,receiver,message,"");
		int result = 0;
		try {
			result = messengerService.insertMessage(dto);
			if(result == 1) {
				new Gson().toJson("전송성공", response.getWriter());
			}else {
				new Gson().toJson("전송실패", response.getWriter());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
		
	@RequestMapping("/selectmessenger.do")
	public void selectmessenger(HttpServletResponse response,@RequestParam("receiver") String receiver,@RequestParam("sender") String sender, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		List<MessengerDTO> message = new ArrayList<>();
		try {
			message = messengerService.selectmessenger(receiver,sender);
			new Gson().toJson(message, response.getWriter());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
