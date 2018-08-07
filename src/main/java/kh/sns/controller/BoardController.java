package kh.sns.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

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

	
	@RequestMapping("/board.bo")
	public ModelAndView getBoard(HttpSession session){
		ModelAndView mav = new ModelAndView();
		String id = (String) session.getAttribute("loginId");
		List<BoardDTO> result = boardService.getBoard(id);
		mav.addObject("result", result);	
		mav.setViewName("myarticle1.jsp");
		return mav;
	}
	
}
