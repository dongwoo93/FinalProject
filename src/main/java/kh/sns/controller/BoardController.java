package kh.sns.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
	
	@RequestMapping("/write.board")
	public ModelAndView writeBoard() {
		System.out.println("@@WRITE BOARD");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("write");
		return mav;
	}

	@RequestMapping("/writeProc.test")
	public ModelAndView writeProcTest(
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
				String ext = originalName.substring(originalName.lastIndexOf('.')); // 확장자
				String saveFileName = (int)(Math.random() * 100000) + ext;
				
				// 설정한 path에 파일저장(임시)
				File serverFile = new File("d://temp" + File.separator + saveFileName); 
				mf.transferTo(serverFile);	// HDD에 전송
				
				//fileList.add();
				
				// 테스트용
				boardService.insertNewArticle(new BoardDTO(0, contents, "yoon", "", "", ""), new Board_MediaDTO(0, 0, "p", originalName, saveFileName));
				
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
		
		
		for(Board_MediaDTO m : fileList) {
			System.out.println(m.getOriginal_file_name());
			System.out.println(m.getSystem_file_name());
		}
		
		
		ModelAndView mav = new ModelAndView();
		return mav;
	}

}
