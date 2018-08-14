package kh.sns.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.sns.dto.Board_LikeDTO;
import kh.sns.interfaces.Board_LikeService;

@Controller
public class Board_LikeController {
	
	@Autowired
	private Board_LikeService board_likeservice;
	
	@RequestMapping("/like.bo")
	public void doLike(HttpServletResponse response, Board_LikeDTO dto, String likecount) throws Exception{
		int likeResult = 0;
		System.out.println(dto.getBoard_seq() + ":" + dto.getId() + ":" + dto.getIs_liked());
	
		response.setCharacterEncoding("UTF-8");
		if(dto.getIs_liked().equals("y")) {
			board_likeservice.insertLike(dto);
		}
		else if(dto.getIs_liked().equals("n")) {
			board_likeservice.deleteLike(dto);
		}
		
		int likeCount = board_likeservice.selectLike(dto);
		response.getWriter().println(likeCount);
		
		
	}

}
