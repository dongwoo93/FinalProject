package kh.sns.controller;


import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kh.sns.beans.SendEmail;
import kh.sns.dto.MemberBusinessDTO;
import kh.sns.dto.MemberDTO;
import kh.sns.dto.MessengerDTO;
import kh.sns.dto.ProfileDTO;
import kh.sns.dto.Profile_ImageDTO;
import kh.sns.interfaces.MemberBusinessService;
import kh.sns.interfaces.MemberService;
import kh.sns.interfaces.ProfileService;

@Controller
public class ProfileController {
	
	@Autowired	private ProfileService profileService;
	@Autowired	private MemberService memberService;
	@Autowired	private MemberBusinessService mBizService;
	
	/*======*/
	@RequestMapping("/profile.member")
	public ModelAndView editProfile(HttpSession session, HttpServletResponse response, String cat) throws Exception {

		ModelAndView mav = new ModelAndView();

		if(session.getAttribute("loginId") != null) {
			String memberId = (String)session.getAttribute("loginId");
			System.out.println("currentLoginId: " + memberId);
			MemberDTO member = memberService.getOneMember(memberId);
			ProfileDTO profile = profileService.getOneProfile(memberId);
			String myImg = null;
			MemberBusinessDTO memberBiz = null;
			try {
				
				myImg = profileService.selectOneProfileImage(memberId);
				memberBiz = mBizService.selectAnMemberBiz(memberId);
			} catch(IndexOutOfBoundsException e) {
				System.err.println("This is not business account!!");
			}
			
			mav.addObject("member", member);
			mav.addObject("profile", profile);
			mav.addObject("memberBiz", memberBiz);
			mav.addObject("profile_pic", myImg);
			mav.addObject("category", cat);
			mav.setViewName("mypage2.jsp");

		} else {
			// 작업 추가
		}		

		return mav;

	}

	@RequestMapping("/editProfileProc.member")
	public ModelAndView editProfile(MemberDTO member, ProfileDTO profile, HttpSession seesion, HttpServletRequest request, HttpServletResponse response) throws Exception {

		member.setId(request.getSession().getAttribute("loginId").toString());
		profile.setId(request.getSession().getAttribute("loginId").toString());
		System.out.println(member);

		int result = memberService.updateOneMemberProfile(member, profile);

		ModelAndView mav = new ModelAndView();
		mav.addObject("editProfileResult", result);
		mav.setViewName("redirect:profile.member?targetTab=profileTab");	// 리다이렉트? 포워드?
		return mav;		
	}
	
	@RequestMapping("/toggleProfileCheckbox.ajax")
	public void toggleProfileCheckbox(HttpServletRequest request, HttpServletResponse response, HttpSession seesion) {		
		
		response.setCharacterEncoding("UTF8");
		try {
			PrintWriter xout = response.getWriter(); 
			String loginId = (String) seesion.getAttribute(("loginId"));
			String fieldName = request.getParameter("fieldName");
			
			String email = memberService.extractEmail(loginId);
			if(fieldName.equals("is_allow_email")){
				System.out.println("이메일이에요");
				SendEmail send = new SendEmail(3,loginId,email); 
				send.sendEmail();
			}else if(fieldName.equals("is_allow_sms")){
				System.out.println("문자에요");
				String phone = memberService.extractPhone(loginId);
				
				String to = "82"+phone;
	            String from="33644643087";
	            String finalMsg = ( loginId + " 님 저희 Social Wired와 함께 해주셔서 감사합니다." 
            			+"더욱 발전하는 서비스가 되도록 노력하겠습니다. 늘 새로운 상생을 꿈꾸는 SocialWired Copyright © SocialWired Corp.");              
	            
	            String message = URLEncoder.encode(finalMsg, "UTF-8");
	            
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
	            
	            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String line = null;
	            
	            while((line = br.readLine())!=null) {
	               System.out.println(line);
	            }
	            
	            System.out.println(result);
	            con.disconnect();            
	            br.close();
	          
			}
			
			System.out.println("@@fieldName: " + fieldName);
			int result = profileService.toggleProfileCheckbox(profileService.getOneProfile(request.getSession().getAttribute("loginId").toString())
					, fieldName);
			
			
			System.out.println("@@result: " + result);
			xout.print(result);
			xout.flush();
			xout.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}   
	}
	
	@RequestMapping("/uploadImg.profile")
	public void uploadProfileImage(MultipartHttpServletRequest multi, HttpServletResponse response, HttpSession session) throws Exception {
		// 저장 경로 설정
		response.setCharacterEncoding("UTF-8");
		int result;
		int setImg;
		String id = (String) session.getAttribute("loginId");
        String root = multi.getSession().getServletContext().getRealPath("AttachedMedia");
        System.out.println(root);
         
        String newFileName = ""; // 업로드 되는 파일명
         
        File dir = new File(root);
        if(!dir.isDirectory()){
            dir.mkdir();
        }
         
        Iterator<String> files = multi.getFileNames();
            String uploadFile = files.next();
                         
            MultipartFile mFile = multi.getFile(uploadFile);
            String fileName = mFile.getOriginalFilename();
            // System.out.println("실제 파일 이름 : " +fileName);
            newFileName = System.currentTimeMillis()+"."
                    +fileName.substring(fileName.lastIndexOf(".")+1);
            // System.out.println("시스템 파일 이름 : " +newFileName);
            Profile_ImageDTO dto = new Profile_ImageDTO(id, fileName, newFileName, "y", "");
            setImg = profileService.updateProfileImages(id);
            result = profileService.insertProfileImage(dto);
            if(result == 1) {
            	try {
                    mFile.transferTo(new File(root+"/"+newFileName));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            	response.getWriter().print("적용 완료");
            }else {
            	response.getWriter().print("적용 실패");
            }
            
            response.getWriter().flush();
            response.getWriter().close();
            
            
        
	}
	
	@RequestMapping("/updateImg.profile")
	public void updateProfileImage(HttpServletResponse response, Profile_ImageDTO dto, HttpSession seesion) throws Exception {
		response.setCharacterEncoding("UTF-8");
		int setImg = profileService.updateProfileImages(dto.getId());
		int updateImg = profileService.updateProfileImages2(dto.getSystem_file_name());
		System.out.println(setImg +":"+updateImg);
		if(setImg > 0 && updateImg > 0) {
			response.getWriter().print("적용 완료");
		}else {
			response.getWriter().print("적용 실패");
		}
		
		response.getWriter().flush();
        response.getWriter().close();
	}
	
	@RequestMapping("/deleteImg.profile")
	public void deleteProfileImage(HttpServletResponse response, Profile_ImageDTO dto, HttpSession seesion) throws Exception {
		response.setCharacterEncoding("UTF-8");
		
		int deleteImg = profileService.deleteProfileImage(dto.getSystem_file_name());

		if(deleteImg > 0) {

		}else {
			response.getWriter().print("삭제 실패");
		}
		
		response.getWriter().flush();
        response.getWriter().close();
	}
	
	@RequestMapping("updateDefault.profile")
	public void updateDefault(HttpServletResponse response, String id, HttpSession seesion) throws Exception {
		response.setCharacterEncoding("UTF-8");
		int result = profileService.updateProfileImages(id);
		
		if(result > 0) {
			response.getWriter().print("적용 완료");
		}else {
			response.getWriter().print("적용 실패");
		}
		
		response.getWriter().flush();
        response.getWriter().close();
	}
	
	// 최초 1회 변경입니다.
	@RequestMapping("/changeBizAccount.profile")
	public ModelAndView changeBizAccount(HttpSession session, HttpServletResponse response) throws Exception {
		
		String id = session.getAttribute("loginId").toString();
		MemberDTO member = memberService.getOneMember(id);
		
		try {
			if(mBizService.selectAnMemberBiz(id) != null) {
				System.err.println("이미 있는 사람");
				return null;
			}
		} catch(IndexOutOfBoundsException e) {
			System.err.println("IndexOutOfBoundsException이 제일 골치아프다..");
		}
		
		MemberBusinessDTO mbiz = new MemberBusinessDTO();
		mbiz.setBizWebsite(profileService.getOneProfile(id).getWebsite());
		mbiz.setBizEmail(member.getEmail());
		mbiz.setBizPhone(member.getPhone());
		mbiz.setId(id);
		mbiz.setIsAllowEnterProfile("y");
		
		int result = mBizService.insertAnMemberBiz(mbiz);		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:profile.member?targetTab=bizProfile");
		mav.addObject("bizChangeResult", result);
		return mav;
		
	}
	
	@RequestMapping("/updateBizProfileProc.member")
	public ModelAndView updateBizProfileProc(HttpSession session, MemberBusinessDTO memberBiz, 
			HttpServletResponse response) throws Exception {
		String id = session.getAttribute("loginId").toString();
		memberBiz.setId(id);
		//System.out.println(memberBiz.getIsAllowEnterProfile());
		if(memberBiz.getIsAllowEnterProfile() == null)	memberBiz.setIsAllowEnterProfile("y");
		int result = mBizService.updateAnMemberBiz(memberBiz);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:profile.member?targetTab=bizProfile");
		mav.addObject("updateBizProfileResult", result);
		return mav;
	}
	
	@RequestMapping("/setWidget.ajax")
	public void setWidget(HttpServletResponse response,@RequestParam("widget1") String widget1,@RequestParam("widget2") String widget2, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		String id = session.getAttribute("loginId").toString();

		int widgetresult = 0;
		try {
			widgetresult = profileService.setWidget(id,widget1,widget2);
			new Gson().toJson(widgetresult, response.getWriter());
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
