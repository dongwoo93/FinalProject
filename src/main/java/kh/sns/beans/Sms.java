package kh.sns.beans;

import java.net.HttpURLConnection;
import java.net.URL;

public class Sms {

public String sendSMS(String phone) {	
	try {
	String  pswd = "";
    StringBuffer sb1 = new StringBuffer();
    // 占쏙옙占쏙옙 5占쏙옙占?
    for( int i = 0; i<5; i++) {

        sb1.append((char)((Math.random() * 10)+48)); //占싣쏙옙키占쏙옙호 48(1) 占쏙옙占쏙옙 10占?
    }

    pswd = sb1.toString();

 String to = "82"+phone;
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
 return message;
	}catch(Exception e) {
		e.printStackTrace();
		return null;	
	}


}
}
