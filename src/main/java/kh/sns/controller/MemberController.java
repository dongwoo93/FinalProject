package kh.sns.controller;

import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kh.sns.beans.SendEmail;
import kh.sns.dto.MemberDTO;
import kh.sns.dto.Profile_ImageDTO;
import kh.sns.interfaces.MemberBusinessService;
import kh.sns.interfaces.MemberService;
import kh.sns.interfaces.ProfileService;
import kh.sns.util.EncryptUtils;
import kh.sns.util.LogUtil;

@Controller
public class MemberController {

	@Autowired	private MemberService memberService;
	@Autowired	private ProfileService profileService;
	@Autowired	private MemberBusinessService mBizService;

	@RequestMapping("/main.do")
	public String toIndex() throws Exception {
		return "redirect:main.jsp";

	}

	@RequestMapping("/join.do")
	public String toInput() throws Exception {
		return "redirect:join.jsp";
	}


	@RequestMapping("/login.do")
	public void memberLogin(MemberDTO dto, HttpSession session, HttpServletResponse response) throws Exception {

		response.setCharacterEncoding("UTF-8");
		System.out.println(dto.getId());
		System.out.println(dto.getPw());
		int result = this.memberService.loginMem(dto);
		System.out.println(result);
		if(result == 1) {
			String sessionId = dto.getId();
			session.setAttribute("loginId",sessionId);

		}else {

		}
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();	
	}

	@RequestMapping("/logout.do")
	public ModelAndView memberLogout(MemberDTO dto, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		String id= (String)session.getAttribute("loginId");
		session.invalidate(); 
		LogUtil log = new LogUtil(); 
		log.insertLog(id,"logout");   
		mav.setViewName("redirect:main.jsp");
		return mav;
	}

	@RequestMapping("/sign.do")
	public ModelAndView signUp(MemberDTO dto, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int joinresult = 0;
		int insertMem = 0 ;
		int insertProfile = 0;
		try {
			insertMem = this.memberService.signUp(dto);
			insertProfile = this.memberService.insertProfile(dto.getId());

			if(insertMem> 0 && insertProfile > 0) {
				joinresult = 1;
			}

		}catch(Exception e) {  

			e.printStackTrace();
		}
		mav.addObject("result",joinresult);
		mav.setViewName("join.jsp");
		return mav;
	}

	@RequestMapping("/dupId.do")
	public void isIdExist(String id, HttpServletResponse response) throws Exception{

		int result =this.memberService.isIdExist(id);
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
	}
	@RequestMapping("/nickCheck.do")
	public void isNickExist(String nick, HttpServletResponse response) throws Exception{

		int result =this.memberService.isNickExist(nick);
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
	}
	@RequestMapping("/emailCheck.do")
	public void isEmailExist(String email, HttpServletResponse response) throws Exception{

		int result =this.memberService.isEmailExist(email);

		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
	}
	@RequestMapping("/sms.do")
	public void sms(String phone, HttpServletResponse response,HttpServletRequest request) throws Exception{
		String  pswd = "";
		StringBuffer sb1 = new StringBuffer();
		// 占쏙옙占쏙옙 5占쏙옙占?
		for( int i = 0; i<5; i++) {

			sb1.append((char)((Math.random() * 10)+48)); //占싣쏙옙키占쏙옙호 48(1) 占쏙옙占쏙옙 10占?
		}

		pswd = sb1.toString();

		String to = "82"+request.getParameter("phone");
		String from="33644643087";
		String message = pswd;  
		String sendUrl = "https://www.proovl.com/api/send.php?user=6394162&token=mZJb0hlGqKxlgbpx4GqNTH4lX0aNAQ04";

		StringBuilder sb = new StringBuilder();

		sb.append(sendUrl);

		sb.append("&to="+to);

		sb.append("&from="+from);

		sb.append("&text="+message);



		System.out.println(sb.toString());

		URL url = new URL(sb.toString());

		HttpURLConnection con = (HttpURLConnection)url.openConnection();

		int result = con.getResponseCode();

		System.out.println(result);

		con.disconnect();
		response.getWriter().print(message);
		response.getWriter().flush();
		response.getWriter().close();


	}



	@RequestMapping("/findPw.do")
	public ModelAndView findPw(MemberDTO dto, HttpServletResponse response) throws Exception {
		
		
		 String certification = Integer.toString((int)(Math.random() * 9000 + 1000));
		 dto.setPw(certification);
		 
		int result =this.memberService.findPw(dto);
		System.out.println(result);
		if(result==1) {
			
			SendEmail send = new SendEmail(dto.getEmail(),certification);
			send.sendEmail();
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("findPass.jsp");
		return mav;		
	}


	@RequestMapping("/isEmailDuplicated.ajax")
	public void checkEmailDuplicated(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF8");
		// PrintWriter를 꺼내기 전에 response의 인코딩을 설정
		response.setCharacterEncoding("UTF8");
		PrintWriter xout = response.getWriter();   

		boolean isEmailDuplicated = false;
		int result = memberService.checkEmailDuplicated(request.getParameter("email"), 
				request.getSession().getAttribute("loginId").toString());
		if(result >= 1) {
			isEmailDuplicated = true;
		} else {
			isEmailDuplicated = false;
		}

		xout.println(isEmailDuplicated);
	}

	@RequestMapping("/findId.do")
	public ModelAndView findId(String name, String email, HttpServletResponse response) throws Exception {

		List<MemberDTO> findId =this.memberService.findId(name, email);


		int result = 0;




		if(findId.size() == 1) {
			System.out.println("id:"+findId.get(0).getId());
			SendEmail sendemail = new SendEmail(1,findId.get(0).getId(),email);
			sendemail.sendEmail();
			result = 2;
		}else {
			result = 0;
		}



		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);

		mav.setViewName("findPass.jsp");
		return mav;	


	}



	/*1. jsp 이름 폰번호입력
	2. 인증번호 받기  버튼 - 컨트롤러 - //
	3. 이름 폰번호가 같은 계정정보인지 
	4. 일치하면 , 인증번호 보내기 , //  

	5. 인증번호 입력창 생성
	6. 인증번호 입력. - 컨트롤러

		(쿼리에 이메일을뽑)이메일이잖아*/



	@RequestMapping("/passwordChangeProc.member")
	public ModelAndView passwordChange(MemberDTO member, HttpServletRequest request) throws Exception {

		ModelAndView mav = new ModelAndView();

		String id = request.getSession().getAttribute("loginId").toString();
		String beforePassword = request.getParameter("beforePassword");

		EncryptUtils encrypt = new EncryptUtils(); 
		beforePassword = encrypt.getSha256(beforePassword);

		boolean isBeforePasswordCorrect = memberService.getOneMember(id).getPw().equals(beforePassword);
		if(isBeforePasswordCorrect) {
			member.setId(request.getSession().getAttribute("loginId").toString());
			System.out.println(member);

			int result = memberService.updateOneMemberPassword(member);

			mav.addObject("pwdChangeResult", result);
		} else {
			// 이전 패스워드 입력이 틀렸을 때
			mav.addObject("pwdChangeResult", -1);
			System.out.println("이전 패스워드 입력이 틀림");
		}
		mav.setViewName("redirect:profile.member?targetTab=passwordTab");

		return mav;		
	}

	@RequestMapping("/searchfriend.do")
	public void searchFriend(HttpServletResponse response, @RequestParam("searchtext") String searchtext, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		System.out.println("친구검색들어옴");
		ModelAndView mav = new ModelAndView();
		String id = (String)  session.getAttribute("loginId");
		System.out.println("검색어 : " + searchtext);
		List<MemberDTO> list = null;
		List<String> friendlist = new ArrayList<>();

		try {
			list = memberService.selectfriendlist(id,searchtext);
			System.out.println("해당하는거잘찾았냐");
		}catch(Exception e) {
			e.printStackTrace();
		}

		for(MemberDTO tmp : list) {
			System.out.println(tmp.getNickname());
			friendlist.add(tmp.getNickname());
		}

		try {
			new Gson().toJson(friendlist, response.getWriter());

		}catch(Exception e1) {
			e1.printStackTrace();
		}
	}
	
	@RequestMapping("/searchAccount.do")
	public void searchAccount(HttpServletResponse response, String term, HttpSession session) throws Exception {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		List<MemberDTO> result = memberService.findMember(term);
		
		JsonArray list = new JsonArray();
		
		for(int i = 0; i < result.size(); i++) {
			JsonObject object = new JsonObject();
			object.addProperty("id", result.get(i).getId());
			object.addProperty("name", result.get(i).getName());
			object.addProperty("link", "board.bo?id="+result.get(i).getId()+"&cat=1");
			object.addProperty("img", "AttachedMedia/"+profileService.selectOneProfileImage(result.get(i).getId()));
			object.addProperty("category", "People");
			System.out.println(object);
			list.add(object);
		}
		System.out.println(list);
		
		
		
		new Gson().toJson(list, response.getWriter());
	}
}
