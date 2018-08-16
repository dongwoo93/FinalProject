package kh.sns.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kh.sns.beans.SendEmail;
import kh.sns.dto.MemberDTO;
import kh.sns.dto.ProfileDTO;
import kh.sns.interfaces.MemberService;
import kh.sns.interfaces.ProfileService;

@Controller
public class MessengerController {
	
	@Autowired
	private MemberService memberService;
	
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
}
