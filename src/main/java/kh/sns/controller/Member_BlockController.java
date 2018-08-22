package kh.sns.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.sns.dto.Member_BlockDTO;
import kh.sns.interfaces.Member_BlockService;

@Controller
public class Member_BlockController {
	@Autowired
	private Member_BlockService service;
	
	@RequestMapping("/block.mem")
	public void blockMember(Member_BlockDTO dto, HttpSession session, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		int result = service.insertBlock(dto);
		if(result == 1) {
			response.getWriter().print(dto.getId() + "님을 차단하였습니다");
		}else {
			response.getWriter().println("차단에 실패하였습니다");
		}
		response.getWriter().flush();
		response.getWriter().close();
	}
}
