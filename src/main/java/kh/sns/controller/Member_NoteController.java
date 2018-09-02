package kh.sns.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.Member_NoteDTO;
import kh.sns.interfaces.Member_NoteService;

@Controller
public class Member_NoteController {
	
	@Autowired
	private Member_NoteService service;
	
	@RequestMapping("/goNote.memo")
	public ModelAndView getNote(HttpSession session) {
		String sessionId = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView();
		try {
			List<Member_NoteDTO> result = service.selectNote(sessionId);
			mav.addObject("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("mymemo.jsp");
		return mav;
	}
	
	@RequestMapping("/addNote.memo")
	public void insertNote(HttpServletResponse response, HttpSession session, Member_NoteDTO dto) {
		response.setCharacterEncoding("UTF-8");
		String seq = null;
		try {
			seq = service.getNoteSeq();
			dto.setSeq(seq);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		dto.setId((String) session.getAttribute("loginId"));
		int result = 0;
		try {
			result = service.insertNote(dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(result == 0) {
					response.getWriter().print("false");
				}else {
					response.getWriter().print(seq);
				}
				
				response.getWriter().flush();
				response.getWriter().close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/deleteNote.memo")
	public void deleteNote(HttpServletResponse response, HttpSession session, String seq) {
		response.setCharacterEncoding("UTF-8");
		int result = 0;
		try {
			result = service.deleteNote(seq);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				response.getWriter().print(result);
				response.getWriter().flush();
				response.getWriter().close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/updateNote.memo")
	public void updateNote(HttpServletResponse response, HttpSession session, Member_NoteDTO dto) {
		response.setCharacterEncoding("UTF-8");
		int result = 0;
		try {
			result = service.updateNote(dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().print(result);
				response.getWriter().flush();
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
