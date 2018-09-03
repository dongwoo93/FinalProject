package kh.sns.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.dto.Board_CommentDTO;
import kh.sns.dto.Board_LikeDTO;
import kh.sns.dto.FollowInfo;
import kh.sns.dto.Member_NoteDTO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_BookmarkService;
import kh.sns.interfaces.Board_CommentService;
import kh.sns.interfaces.Board_LikeService;
import kh.sns.interfaces.Member_FollowService;
import kh.sns.interfaces.Member_NoteService;
import kh.sns.util.LogUtil;

@Controller
public class Member_NoteController {
	
	@Autowired
	private Member_NoteService service;
	@Autowired private LogUtil lu;
	@Autowired private Member_FollowService fs;
	@Autowired private Board_CommentService cs;
	@Autowired private Board_LikeService ls;
	@Autowired private BoardService bs;
	@Autowired private Board_BookmarkService ks;
	
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
	
	// ================ 로그 컨트롤러 ================ 
	
	@RequestMapping("/my.log")
	public ModelAndView myLogMain(HttpServletResponse response, HttpSession session) throws Exception {
		String id = session.getAttribute("loginId").toString();
		ModelAndView mav = new ModelAndView();
		List<String> logins = lu.readLog(id, "login");
		List<String> logouts = lu.readLog(id, "logout");
		String joinStr = lu.readLog(id, "join").get(0);
		List<String> searches = lu.readLog(id, "search");
		
		List<FollowInfo> followList = fs.simpleFollowList(id);
		List<Board_CommentDTO> commentList = cs.simpleGetComments(id);
		
		List<Board_LikeDTO> likeList = ls.simpleGetLikeStatus(id);
		List<String> likeTitles = new ArrayList<>();
		for(Board_LikeDTO b : likeList) {
			likeTitles.add(bs.oneBoard(String.valueOf(b.getBoard_seq())).getContents());
		}
		
		List<Board_BookmarkDTO> markList = ks.simpleGetMark(id);
		List<String> markTitles = new ArrayList<>();
		for(Board_BookmarkDTO b : markList) {
			markTitles.add(bs.oneBoard(String.valueOf(b.getBoard_seq())).getContents());
		}
		
		
		mav.setViewName("mylog.jsp");
		mav.addObject("logins", logins);
		mav.addObject("logouts", logouts);
		mav.addObject("joinStr", joinStr);
		mav.addObject("searches", searches);
		mav.addObject("followList", followList);
		mav.addObject("commentList", commentList);
		mav.addObject("likeList", likeList);
		mav.addObject("likeTitles", likeTitles);
		mav.addObject("markList", markList);
		mav.addObject("markTitles", markTitles);
		return mav;
	}
}
