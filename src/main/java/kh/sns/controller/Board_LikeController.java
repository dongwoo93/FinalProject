package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import kh.sns.dto.Board_LikeDTO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_LikeService;

@Controller
public class Board_LikeController {
	
	@Autowired
	private Board_LikeService board_likeservice;
	
	@Autowired
	private BoardService board_service;
	
//	
//	@RequestMapping("/like.bo")
//	public void boardLike(Board_LikeDTO dto, HttpServletResponse res,  HttpSession session) {
//		System.out.println(dto.getBoard_seq() + dto.getIs_liked());   
//		String id = (String) session.getAttribute("loginId");
//		dto.setBoard_seq(Math.abs(dto.getBoard_seq()));  
//		dto.setId(id);
//		
//		
//		int result = 0;
//		try {
//			String board_id = board_service.getBoardModal(Integer.toString(dto.getBoard_seq())).getId();
//			 
//			if(dto.getIs_liked().equals("y")) {
//			
//			result = board_likeservice.insertLiko(dto);
//			}else if(dto.getIs_liked().equals("n")) {
//				board_likeservice.deleteLike(dto);
//			}
//			
//			res.setCharacterEncoding("UTF-8");
//			res.getWriter().print(board_id);
//			res.getWriter().flush();
//			res.getWriter().close();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
//	
	
	@RequestMapping("/like.bo")
	public void boardLike(Board_LikeDTO dto, HttpServletResponse res,  HttpSession session) {
		res.setCharacterEncoding("UTF-8");
		res.setContentType("application/json");
		System.out.println(dto.getBoard_seq() + dto.getIs_liked());   
		String id = (String) session.getAttribute("loginId");
		dto.setBoard_seq(Math.abs(dto.getBoard_seq()));  
		dto.setId(id);
		
		
		int result = 0;
		List<int[]> rs = new ArrayList<>();
		int count = 0;
		try {
		
			String board_id = board_service.getBoardModal(Integer.toString(dto.getBoard_seq())).getId();
			if(dto.getIs_liked().equals("y")) {
			
			result = board_likeservice.insertLiko(dto);
			}else if(dto.getIs_liked().equals("n")) {
				board_likeservice.deleteLike(dto);
			}
			
			rs = board_likeservice.selectLikeCount();
			for(int[] tmp : rs) {
				if(tmp[0] == dto.getBoard_seq()) {
					count = tmp[1];
				}
			}
			
			List<Object> result1 = new ArrayList<>();
			result1.add(count);
			result1.add(board_id);
		
			
			new Gson().toJson(result1,res.getWriter());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
