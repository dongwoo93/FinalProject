package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.dto.FollowInfo;
import kh.sns.interfaces.Member_FollowService;

@Controller
public class Member_FollowController {
	
	@Autowired
	private Member_FollowService followservice;
	

	@RequestMapping("/recommendFollow.follow")
	public void getCommandFollow(HttpServletResponse response,HttpSession session, Board_BookmarkDTO dto,String id) throws Exception{
		response.setCharacterEncoding("UTF-8");
		List<FollowInfo> follow_list = new ArrayList<>();
		follow_list = followservice.toFeed(id);
	}
}
