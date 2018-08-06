package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.BoardDTO;
import kh.sns.interfaces.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/feed.bo")
	public ModelAndView toFeed() {
		
		
		List<BoardDTO> list = new ArrayList();
		String id="hyong07";
		try {
			list = boardService.getFeed(id);
		}catch(Exception e) {
			System.out.println("여기는 feed.bo");
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", list);
		mav.setViewName("test.jsp");;
		
		return mav;
	}
	

}
