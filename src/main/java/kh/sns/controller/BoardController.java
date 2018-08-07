package kh.sns.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
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
			System.out.println("�뿬湲곕뒗 feed.bo");
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", list);
		mav.setViewName("timeline.jsp");;
		
		return mav;
	}
	
	
	@RequestMapping("/write.board")
	public ModelAndView writeBoard() {
		System.out.println("@@WRITE BOARD");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("write");
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
	
	@RequestMapping("/writeProc.test")
	public ModelAndView writeProcTest(
			HttpServletRequest request,
			@RequestParam("contents") String contents,
			@RequestParam("filename[]") MultipartFile files) {
		
		System.out.println("@@writeProc.test �젒�냽�릺�뿀�뒿�땲�떎.");
		System.out.println(contents);
	
		
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		
		List<MultipartFile> mfList = mhsr.getFiles("filename[]");
		
		List<Board_MediaDTO> fileList = new ArrayList<Board_MediaDTO>();
		
		for(MultipartFile mf : mfList) {
			try {
				
				String originalName = mf.getOriginalFilename(); 
				
				// �떆�뒪�뀥 �뙆�씪紐�(�엫�떆)
				String fileName = originalName.substring(0, originalName.lastIndexOf('.'));
				String ext = originalName.substring(originalName.lastIndexOf('.')); // �솗�옣�옄
				String saveFileName = fileName + "_" + (int)(Math.random() * 10000) + ext;
				String realPath = request.getSession().getServletContext().getRealPath("/image/");
                   
                File f = new File(realPath);
                if(!f.exists()){
                   f.mkdir();
                }
          
				
				// �꽕�젙�븳 path�뿉 �뙆�씪���옣(�엫�떆)
				File serverFile = new File(realPath + File.separator + saveFileName); 
				mf.transferTo(serverFile);	// HDD�뿉 �쟾�넚
				
				fileList.add(new Board_MediaDTO(0, 0, "p", originalName, saveFileName));
				
				
				
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// �뀒�뒪�듃�슜
		try {
			boardService.insertNewArticle(new BoardDTO(0, contents, "yoon", "", "", ""), fileList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		for(Board_MediaDTO m : fileList) {
			System.out.println(m.getOriginal_file_name());
			System.out.println(m.getSystem_file_name());
		}
		
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}

}
