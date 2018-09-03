package kh.sns.controller;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
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
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.MyMapDTO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_LocationService;

@Controller
public class Board_LocationController {
	
	@Autowired
	private Board_LocationService board_locationservice;
	
	@Autowired
	private BoardService boardservice;
	
	@RequestMapping("/mymap.bo")
	public ModelAndView mymap(HttpSession session, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String id = (String) session.getAttribute("loginId");
		
		
		 List<Board_LocationDTO> pin = new ArrayList<>();
		 MyMapDTO mymap = new MyMapDTO();
         pin = board_locationservice.selectLocation(id);
         mymap = board_locationservice.selectMyMap(id);
		
		mav.addObject("pin",pin);
		mav.addObject("mymap",mymap);
		mav.setViewName("mymap.jsp");
		return mav;	
	}
	
	@RequestMapping("/setMyMap.bo")
	public ModelAndView setMyMap(HttpSession session,@RequestParam("cluster") String cluster,@RequestParam("pin") String pin, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String id = (String) session.getAttribute("loginId");
		
		int result = 0;
		
        result = board_locationservice.setMyMap(id,cluster,pin);
		
        if(result >0) {
        	mav.setViewName("mymap.bo");
        }
        else {
        	
        }
		
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
	
	@RequestMapping("/shareMap.bo")  
	public ModelAndView shareMap(HttpSession session,@RequestParam("mapurl") String mapurl,HttpServletResponse response,HttpServletRequest request) throws Exception {
		 ModelAndView mav = new ModelAndView();
		 String id = (String) session.getAttribute("loginId");
		 System.out.println(mapurl);
		 
		 InputStream inputStream = null;
		 OutputStream outputStream = null;
		 String realPath = request.getSession().getServletContext().getRealPath("/AttachedMedia/"); 
		 System.out.println(realPath);
		 String saveFileName = "mymap_" + (int)(Math.random() * 10000) + ".png";
		 int result = 0;
		 try {
		       URL url = new URL(mapurl);
		       inputStream = url.openStream();
		       outputStream = new FileOutputStream(realPath + saveFileName);     
		  
		       byte[] buffer = new byte[2048];
		       int length;
		  
		       while ((length = inputStream.read(buffer)) != -1) {
		           outputStream.write(buffer, 0, length);
		       }
		       
		       List<Board_MediaDTO> boardMediaList =  new ArrayList<>();
		       boardMediaList.add(new Board_MediaDTO(0, 0, "p", "map", saveFileName, null, null, null));
		       result = boardservice.insertNewArticle(new BoardDTO(0,"",id,"","",""), boardMediaList , null, null, null);
		       
		       if(result>0) {
		    	   mav.setViewName("redirect:mymap.bo");
		       }else {
		    	   
		       }
		 } catch (MalformedURLException e) {
		       System.out.println("MalformedURLException :- " + e.getMessage());
		  
		 } catch (FileNotFoundException e) {
		       System.out.println("FileNotFoundException :- " + e.getMessage());
		  
		 } catch (IOException e) {
		       System.out.println("IOException :- " + e.getMessage());
		  
		 } finally {
		        try {
		       inputStream.close();
		       outputStream.close();
		  
		 } catch (IOException e) {
		        System.out.println("Finally IOException :- " + e.getMessage());
		 }
	}

        
		return mav;	
	}
}
