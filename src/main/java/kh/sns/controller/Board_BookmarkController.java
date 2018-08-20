package kh.sns.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.interfaces.Board_BookmarkService;

@Controller
public class Board_BookmarkController {
	
	@Autowired
	private Board_BookmarkService bookmarkservice;
	

	@RequestMapping("/bookmark.bo")
	public void doLike(HttpServletResponse response,HttpSession session, Board_BookmarkDTO dto) throws Exception{
		response.setCharacterEncoding("UTF-8");
		
		String id = (String) session.getAttribute("loginId");
		dto.setId(id);
		System.out.println(dto.getBoard_seq() + ":" + dto.getId() + ":" + dto.getIs_marked());

		int result = 0;
		
		if(dto.getIs_marked().equals("y")) {
			result = bookmarkservice.insertBookmark(dto);
		}
		else if(dto.getIs_marked().equals("n")) {
			bookmarkservice.deleteBookmark(dto);
		}
	
	}

}
