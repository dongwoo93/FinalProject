package kh.sns.controller;

import javax.servlet.http.HttpServletResponse;

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
	public void doLike(HttpServletResponse response, Board_BookmarkDTO dto) throws Exception{
		
		System.out.println(dto.getBoard_seq() + ":" + dto.getId() + ":" + dto.getIs_marked());
	
		response.setCharacterEncoding("UTF-8");
		response.getWriter().println("띠용");
	
		
		if(dto.getIs_marked().equals("y")) {
			bookmarkservice.insertBookmark(dto);
		}
		else if(dto.getIs_marked().equals("n")) {
			bookmarkservice.deleteBookmark(dto);
		}
		
	}

}
