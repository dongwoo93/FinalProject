package kh.sns.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.sns.dto.Board_CommentDTO;
import kh.sns.interfaces.Board_CommentService;

@Controller
public class Board_CommentController {

	@Autowired
	private Board_CommentService boardcommentservice;


	@RequestMapping("/comment.co")
	public void insertComment(Board_CommentDTO dto, HttpSession session, HttpServletRequest response) {
		String id = (String)session.getAttribute("loginId");
		dto.setId(id);
		int result = 0;
		try {
			result =this.boardcommentservice.insertComment(dto);
			
			if(result >0) { 
				System.out.println("success");
			}
			else {  
				System.out.println("failed");  
			}

		}catch(Exception e) {
			System.out.println("요기는 comment.co입니다");
			e.printStackTrace();
		}
	
	}
	
	@RequestMapping("/commentdel.co")
	public void delComment(String comment_seq ,HttpServletResponse response)  {
		System.out.println(comment_seq);  
		int result = 0; 
		try {
			result = this.boardcommentservice.delComment(Integer.parseInt(comment_seq));   
			System.out.println(result);   
			if(result > 0 ) {
				System.out.println("del success");	
			}	
			else {
				System.out.println("del failed");
			}
			
		}catch(Exception e) {
			System.out.println("요기는  commentdel.co입니다");
			e.printStackTrace();
		}
	  
	}
}
