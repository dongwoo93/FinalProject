package kh.sns.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.sns.dto.Member_CalendarDTO;
import kh.sns.interfaces.Member_CalendarService;

@Controller
public class Member_CalendarController {

	@Autowired
	private Member_CalendarService service;

	@RequestMapping("/insert.cal")
	public void insertCalendar(HttpSession session, HttpServletResponse response, Member_CalendarDTO dto) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		String sessionId = (String) session.getAttribute("loginId");
		String seq = null;
		try {
			seq = service.getCalendarSeq();
			dto.setSeq(seq);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		dto.setId(sessionId);
		int result = 0;
		try {
			result = service.insertCalendar(dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JsonObject object = new JsonObject();
				object.addProperty("result", result);
				object.addProperty("seq", seq);
				new Gson().toJson(object, response.getWriter());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/update.cal")
	public void updateCalendar(HttpSession session, HttpServletResponse response, Member_CalendarDTO dto) {
		response.setCharacterEncoding("UTF-8");
		String sessionId = (String) session.getAttribute("loginId");
		dto.setId(sessionId);
		int result = 0;
		try {
			result = service.updateCalendar(dto);
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
