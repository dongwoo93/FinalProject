package kh.sns.util;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class LogUtil {
	
	
	public void insertLog(String id, String category) throws Exception {
		
		
		 HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		 

		 System.out.println(id + " : " +category);
		
		String realPath = request.getSession().getServletContext().getRealPath("/"+id+"/");
        File f = new File(realPath);
        if(!f.exists()){
           f.mkdir();
         }
        
        realPath = realPath+category+".txt";
        File f1 = new File(realPath);
        if(!f1.exists()){
           f1.createNewFile();
         } 
        
        System.out.println(realPath); 

		BufferedWriter bw = new BufferedWriter(new FileWriter(realPath,true));
		
		Date today = new Date();
	    SimpleDateFormat date = new SimpleDateFormat("yyyy년 MM월 dd일");
	    SimpleDateFormat time = new SimpleDateFormat("hh:mm a");
	    String log = date.format(today) + " " + time.format(today); 
	    System.out.println(log); 

	    bw.write(log); bw.newLine();
		bw.close();
	}
}
