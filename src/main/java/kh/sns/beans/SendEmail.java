package kh.sns.beans;


import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kh.sns.impl.IMemberDAO;

public class SendEmail {
	private int num;
	private String id=null;	
	private String cEmail;
	private String certification;

	public SendEmail() {
		super();
	}
	
	 
	public SendEmail(int num, String id, String cEmail) {
		super();// 아이디 찾기
		this.num = num;
		this.id = id;
		this.cEmail = cEmail;
	}	
	
	public SendEmail(String cEmail, String certification) {
		super();  //비밀번호 찾기
		this.cEmail = cEmail;
		this.certification = certification;
	}
	
	public void sendEmail() {
         	
	        Properties p = System.getProperties();
	        p.put("mail.smtp.starttls.enable", "true");     // gmail은 무조건 true 고정
	        p.put("mail.smtp.host", "smtp.gmail.com");      // smtp 서버 주소
	        p.put("mail.smtp.auth","true");                 // gmail은 무조건 true 고정
	        p.put("mail.smtp.port", "587");                 // gmail 포트
	           
	        Authenticator auth = new MyAuthentication();
	         
	        //session 생성 및  MimeMessage생성
	        Session sessionMail = Session.getDefaultInstance(p, auth);
	        MimeMessage msg = new MimeMessage(sessionMail);
	         
	        try{
	            //편지보낸시간
	            msg.setSentDate(new Date());
	             
	            InternetAddress from = new InternetAddress() ;
	             
	             
	            from = new InternetAddress("<SemiauctionGo@gmail.com>");
	             
	            // 이메일 발신자
	            msg.setFrom(from);
	             
	             
	            // 이메일 수신자
	            InternetAddress to = new InternetAddress(cEmail);
	            msg.setRecipient(Message.RecipientType.TO, to);
	             
	            // 이메일 제목
	            msg.setSubject("찾으시는 비밀~", "UTF-8");
	             
	            // 이메일 내용 1은 비번 2는 아이디
	            if(num==1) {
	            	msg.setText("아이디: " + id , "UTF-8");
	            }else {
	            	msg.setText("임시 비밀번호 : " + certification , "UTF-8");
	            }
	            // 이메일 헤더
	            msg.setHeader("content-Type", "text/html");
	             
	            //메일보내기
	            javax.mail.Transport.send(msg);
	             
	        }catch (AddressException addr_e) {
	            addr_e.printStackTrace();
	        }catch (MessagingException msg_e) {
	            msg_e.printStackTrace();
	        }
	    }
	 
	}
	 
	 
	class MyAuthentication extends Authenticator {
	      
	    PasswordAuthentication pa;
	    
	 
	    public MyAuthentication(){
	         
	        String id = "SemiauctionGo";       // 구글 ID
	        String pw = "cnlgoTwh";          // 구글 비밀번호
	 
	        // ID와 비밀번호를 입력한다.
	        pa = new PasswordAuthentication(id, pw);
	      
	    }
	    // 시스템에서 사용하는 인증정보
	    public PasswordAuthentication getPasswordAuthentication() {
	        return pa;
	    }
}



