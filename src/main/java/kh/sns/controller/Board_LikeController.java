package kh.sns.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.sns.dto.Board_LikeDTO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_LikeService;

@Controller
public class Board_LikeController {
	
	@Autowired
	private Board_LikeService board_likeservice;
	
	@Autowired
	private BoardService board_service;
	
	
	@RequestMapping("/like.bo")
	public void boardLike(Board_LikeDTO dto, HttpServletResponse res,  HttpSession session) {
		System.out.println(dto.getBoard_seq() + dto.getIs_liked());   
		String id = (String) session.getAttribute("loginId");
		dto.setBoard_seq(Math.abs(dto.getBoard_seq()));  
		dto.setId(id);
		
		
		int result = 0;
		try {
			String board_id = board_service.getBoardModal(Integer.toString(dto.getBoard_seq())).getId();
			 
			if(dto.getIs_liked().equals("y")) {
			
			result = board_likeservice.insertLiko(dto);
			}else if(dto.getIs_liked().equals("n")) {
				board_likeservice.deleteLike(dto);
			}
			
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(board_id);
			res.getWriter().flush();
			res.getWriter().close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
