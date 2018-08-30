package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_LocationService;

@Controller
public class Board_LocationController {
	
	@Autowired
	private Board_LocationService board_locationservice;
	
	@Autowired
	private BoardService boardservice;
	
	@RequestMapping("/mymap.bo")
	public ModelAndView deleteBoard(HttpSession session, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String id = (String) session.getAttribute("loginId");
		
		
		List<Board_LocationDTO> pin = new ArrayList<>();
		pin = board_locationservice.selectLocation(id);
		
		mav.addObject("pin",pin);
		mav.setViewName("mymap.jsp");
		return mav;	
	}
}
