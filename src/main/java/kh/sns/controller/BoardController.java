package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_TagsDTO;
import kh.sns.interfaces.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/feed.bo")
	public ModelAndView toFeed() {
		
		
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		String id="hyong07";
		try {
			list = boardService.getFeed(id);
		}catch(Exception e) {
			System.out.println("�뿬湲곕뒗 feed.bo");
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", list);
		mav.setViewName("timeline.jsp");;
		
		return mav;
	}
	
	@RequestMapping("/board.bo")
	public ModelAndView getBoard(HttpSession session){
		ModelAndView mav = new ModelAndView();
		String id = (String) session.getAttribute("loginId");
		List<BoardDTO> result = boardService.getBoard(id);
		mav.addObject("result", result);	
		mav.setViewName("myarticle1.jsp");
		return mav;
	}
	
	@RequestMapping("/search.bo")
	public ModelAndView search(HttpSession session, String search){
		ModelAndView mav = new ModelAndView();
		System.out.println(search);
		List<Board_TagsDTO> result = boardService.search("search");
		System.out.println(result.size());
		mav.addObject("result", result);	
		mav.setViewName("search.jsp");
		return mav;
	}
	
	@RequestMapping("/mypage.bo")
	public ModelAndView toMypage(){
		ModelAndView mav = new ModelAndView();
		
		
		return mav;
	}
	
}
