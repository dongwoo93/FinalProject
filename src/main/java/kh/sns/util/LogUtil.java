package kh.sns.util;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
public class LogUtil {
	

	public void insertLog(String id, String category, String content) throws Exception {
		
		
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
	    
	    if(!(content.equals("")) ) {   
	    	 bw.write(content); bw.newLine();
	    }
		bw.close();
	}
	
	public List<String> readLog(String id, String categoryName) {

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

		String realPath = request.getSession().getServletContext().getRealPath("/"+id+"/");
		File f = new File(realPath);
		if(!f.exists()){
			f.mkdir();
		}
		System.out.println(realPath);

		FileReader fr = null;
		BufferedReader br = null;
		
		List<String> outputStrings = null;

		try{

			// "ReadFile.txt" 파일을 읽는 FileReader 객체 생성
			// BufferedReader 객체 생성
			fr = new FileReader(realPath + categoryName + ".txt");
			br = new BufferedReader(fr);

			String s = null;
			outputStrings = new ArrayList<>();

			// ReadFile.txt 에서 한줄씩 읽어서 BufferedRaeder에 저장한다.
			while((s=br.readLine())!=null){

				System.out.println(s);
				outputStrings.add(s);
			}


		}catch(Exception e){

			e.printStackTrace();

		}finally{
			// BufferedReader FileReader를 닫아준다.
			if(br != null) try{br.close();}catch(IOException e){}
			if(fr != null) try{fr.close();}catch(IOException e){}
			
		}
		
		return outputStrings;

	}
}
