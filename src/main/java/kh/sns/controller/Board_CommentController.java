package kh.sns.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_CommentDTO;
import kh.sns.interfaces.Board_CommentService;

@Controller
public class Board_CommentController {

   @Autowired
   private Board_CommentService boardcommentservice;


   @RequestMapping("/comment.co")
   public void insertComment(Board_CommentDTO dto, HttpSession session, HttpServletResponse response) {
      System.out.println(dto.getComment_seq());
      String id = (String)session.getAttribute("loginId");
      dto.setId(id);
      
      int commentseq = 0;
      int count = 0; 
      try { 
         commentseq = this.boardcommentservice.getCommentSeq();
        // count = this.boardcommentservice.commentCount(dto.getBoard_seq());
         dto.setComment_seq(commentseq);
         int result =this.boardcommentservice.insertComment(dto);
         
         if(result >0) {  
            System.out.println("success");
            System.out.println(dto.getComment_seq()); 
            
            response.getWriter().print(dto.getComment_seq());
            response.getWriter().flush();
            response.getWriter().close();
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
   public void delComment(int board_seq,int comment_seq, HttpSession session, HttpServletResponse response)  {
      System.out.println(comment_seq);  
      int result = 0; 
      int count = 0;
      try {
         result = this.boardcommentservice.delComment(comment_seq);
         count = this.boardcommentservice.commentCount(board_seq);  
         System.out.println(result);   
         if(result > 0 ) {
            System.out.println("del success");   
         }   
         else {
            System.out.println("del failed");
         }
         System.out.println(count); 
       response.getWriter().print(count);
 		response.getWriter().flush();
 		response.getWriter().close();
           
      }catch(Exception e) {
         System.out.println("요기는  commentdel.co입니다");
         e.printStackTrace();
      }
     
   }
   
   @RequestMapping("/commentmod.co")
   public void modComment(Board_CommentDTO dto, HttpSession session, HttpServletResponse response)  {
      System.out.println(dto.getComment_seq() + " : " + dto.getComment_contents());  
      int result = 0; 
      try {
         result = this.boardcommentservice.modComment(dto);   
         System.out.println(result);   
         if(result > 0 ) {
            System.out.println("mod success");   
         }   
         else {
            System.out.println("mod failed");
         }
         
      }catch(Exception e) {
         System.out.println("요기는  commentmod.co입니다");
         e.printStackTrace();
      }
     
   }
   
   
   @RequestMapping("/insertComment.co")
   public void insertComment(HttpServletResponse response, Board_CommentDTO dto, HttpSession session)  {
	
	   	int result = 0;
	   	String id = (String)session.getAttribute("loginId");
	   	dto.setId(id);
	   	int comment_seq = 0;
	   	
	   	try {
	   		comment_seq = boardcommentservice.getCommentSeq();
	   		dto.setComment_seq(comment_seq);	
			result = boardcommentservice.insertComment(dto);
			
			 response.getWriter().print(comment_seq);
		 		response.getWriter().flush();
		 		response.getWriter().close();
		           
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   	
	   
	   
   }
}