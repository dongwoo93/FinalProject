package kh.sns.controller;


import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kh.sns.dto.Profile_ImageDTO;
import kh.sns.interfaces.ProfileService;

@Controller
public class ProfileController {
	
	@Autowired
	private ProfileService profileService;
	
	@RequestMapping("/toggleProfileCheckbox.ajax")
	public void toggleProfileCheckbox(HttpServletRequest request, HttpServletResponse response) {		
		
		response.setCharacterEncoding("UTF8");
		try {
			PrintWriter xout = response.getWriter();
			String fieldName = request.getParameter("fieldName");
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
            Profile_ImageDTO dto = new Profile_ImageDTO(id, fileName, newFileName, "y");
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

}
