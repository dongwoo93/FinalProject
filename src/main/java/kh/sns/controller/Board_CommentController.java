package kh.sns.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.Board_CommentDTO;
import kh.sns.interfaces.Board_CommentService;

@Controller
public class Board_CommentController {

	@Autowired
	private Board_CommentService boardcommentservice;


//	@RequestMapping("/comment.co")
//	public ModelAndView insertComment(Board_CommentDTO dto, HttpSession session) {
//		String id = (String)session.getAttribute("loginId");
//		dto.setId(id);
//		int result = 0;
//		try {
//			result =this.boardcommentservice.insertComment(dto);
//		}catch(Exception e) {
//			System.out.println("요기는 comment.co입니다");
//			e.printStackTrace();
//		}
//		ModelAnd
//		
//		
//		return null;
//	}

}
