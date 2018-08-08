package kh.sns.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
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
			System.out.println("여기는 feed.bo");
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
		mav.setViewName("myarticle.jsp");
		return mav;
	}
	
	@RequestMapping("/search.bo")
	public ModelAndView search(HttpSession session, String search){
		ModelAndView mav = new ModelAndView();
		System.out.println(search);
		List<BoardDTO> result = boardService.search(search);
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
	
	
	@RequestMapping("/write.board")
	public ModelAndView writeBoard() {
		System.out.println("@@WRITE BOARD");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("write.jsp");
		return mav;
	}

	@RequestMapping("/writeProc.bo")
	public ModelAndView writeProcBoard(
			HttpServletRequest request,
			@RequestParam("contents") String contents,
			@RequestParam("filename[]") MultipartFile files) {
		
		System.out.println("@@writeProc.test 접속되었습니다.");
		System.out.println(contents);
	
		
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		
		List<MultipartFile> mfList = mhsr.getFiles("filename[]");
		
		List<Board_MediaDTO> fileList = new ArrayList<Board_MediaDTO>();
		
		for(MultipartFile mf : mfList) {
			try {
				
				String originalName = mf.getOriginalFilename(); 
				
				// 시스템 파일명(임시)
				String fileName = originalName.substring(0, originalName.lastIndexOf('.'));
				String ext = originalName.substring(originalName.lastIndexOf('.')); // 확장자
				String saveFileName = fileName + "_" + (int)(Math.random() * 10000) + ext;
				
				// 설정한 path에 파일저장(임시)
				File serverFile = new File("d://temp" + File.separator + saveFileName); 
				mf.transferTo(serverFile);	// HDD에 전송
				
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
		
		// 테스트용 (else는 나중에 삭제)
		try {
			if(request.getSession().getAttribute("loginId") != null) {
				boardService.insertNewArticle(new BoardDTO(0, contents, request.getSession().getAttribute("loginId").toString(), "", "", ""), fileList);
			} else {
				boardService.insertNewArticle(new BoardDTO(0, contents, "yoon", "", "", ""), fileList);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		for(Board_MediaDTO m : fileList) {
			System.out.println(m.getOriginal_file_name());
			System.out.println(m.getSystem_file_name());
		}		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("feed.bo");
		return mav;
	}

}
