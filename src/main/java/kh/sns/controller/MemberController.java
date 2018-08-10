package kh.sns.controller;

import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.sns.beans.SendEmail;
import kh.sns.beans.Sms;
import kh.sns.dto.MemberDTO;
import kh.sns.interfaces.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	
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
		ModelAndView mav = new ModelAndView();
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
	@RequestMapping("/sign.do")
	public ModelAndView signUp(MemberDTO dto) {
		ModelAndView mav = new ModelAndView();
		int result = this.memberService.signUp(dto);
		
		mav.addObject("result",result);
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
	/*======*/
	@RequestMapping("/profile.member")
	public ModelAndView editProfile(HttpSession session) throws Exception {
		
		System.out.println("currentLoginId: " + session.getAttribute("loginId").toString());
		MemberDTO member = memberService.getOneMember(session.getAttribute("loginId").toString());
		System.out.println();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mypage.jsp");
		mav.addObject("member", member);
		return mav;		
		
	}
	
	@RequestMapping("/editProfileProc.member")
	public ModelAndView editProfile(MemberDTO member, HttpServletRequest request) throws Exception {
		
		member.setId(request.getSession().getAttribute("loginId").toString());
		System.out.println(member);
		
		int result = memberService.updateOneMemberProfile(member);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("redirect:profile.member");
		return mav;		
	}
	
	
	@RequestMapping("/findPw.do")
	public ModelAndView findPw(String cId, String cEmail, HttpServletResponse response) throws Exception {
		
		
		System.out.println(cId);
		System.out.println(cEmail);
		int result =this.memberService.findPw(cId,cEmail);
		System.out.println(result);
		if(result==1) {
			
			String certification = memberService.changePass(cId);
			SendEmail send = new SendEmail(cEmail,certification);
			send.sendEmail();
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("findPass.jsp");
		return mav;		

	}
	
	@RequestMapping("/findId.do")
	public ModelAndView findId(String name, String phone, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		

		String id =this.memberService.findId(name, phone);
		int result = 0;
		System.out.println(id);
		if(id!=null) {
			
			Sms sms = new Sms();
			String num = sms.sendSMS(phone);
			
			result =2;
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("findPass.jsp");
		return mav;	
		
		
	}
	
	
	
	/*1. jsp 이름 폰번호입력
	2. 인증번호 받기  버튼 - 컨트롤러 - 
	3. 이름 폰번호가 같은 계정정보인지 
	4. 일치하면 , 인증번호 보내기 , 
	5. 인증번호 입력창 생성
	6. 인증번호 입력. - 컨트롤러
		
		(쿼리에 이메일을뽑)이메일이잖아*/


}
