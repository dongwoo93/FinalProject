package kh.sns.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.dto.MessengerDTO;
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
	
	@RequestMapping("/getBoard.do")
	public void insertMessage(HttpServletResponse response, @RequestParam("id") String id,@RequestParam("lat") String lat,@RequestParam("lng") String lng, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		ModelAndView mav = new ModelAndView();
		List<BoardDTO> list = new ArrayList<>();
		List<String> img = new ArrayList<>();
		List<Object> object = new ArrayList<>();
		try {
			list = board_locationservice.getBoard(id,lat,lng);
			for(BoardDTO dto : list) {
				img.add(boardservice.search2(dto.getBoard_seq()).get(0).getSystem_file_name());
			}
			
			object.add(list);
			object.add(img);
			new Gson().toJson(object, response.getWriter());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
