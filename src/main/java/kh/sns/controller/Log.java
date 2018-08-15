package kh.sns.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Log {

	public void insertLog(String realPath, String category) throws Exception {
		System.out.println(category);
		BufferedWriter bw = new BufferedWriter(new FileWriter(realPath,true));
		BufferedReader br = new BufferedReader(new FileReader(realPath));
		String line = null;
		
		Date today = new Date();
	    SimpleDateFormat date = new SimpleDateFormat("yyyy년 MM월 dd일");
	    SimpleDateFormat time = new SimpleDateFormat("hh:mm a");
	    String log = date.format(today) + " " + time.format(today); 
	    System.out.println(log); 
	  
	    
		while((line = br.readLine()) != null) { 
			if(line.contains(category)) {  
				line.replace("["+category+"]","["+category+"]\n"+log);
				
			}
		}
		bw.close();
		br.close();
	}
}
