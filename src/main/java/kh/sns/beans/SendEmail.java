package kh.sns.beans;


import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.imageio.ImageIO;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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
	            msg.setSubject("Social Wired에서 알려드립니다 ", "UTF-8");
	           
	            if(num==1) {
	            	msg.setText("아이디: " + id , "UTF-8");
	            }else if(num==3){
	            
	            	msg.setText( id + " 님 저희 Social Wired와 함께 해주셔서 감사합니다.<br>"
	            			+"더욱 발전하는 서비스가 되도록 노력하겠습니다. 늘 새로운 상생을 꿈꾸는 SocialWired <br>"
	            			+"사용자 여러분들의 소중한 의견도 기다립니다.여러분들의 목소리를 경청하여 지금까지 그래왔던 것처럼  <br>"
	            			+"여러분들과 함께 성장하겠습니다.변화하는 SocialWired 모습을 함께 지켜 봐주시기 바랍니다.감사합니다. <br>"
	            			+"SocialWired 드림 본 메일은 발신전용입니다. 궁금한 사항을 문의하시려면 SocialWired 서비스 문의를 이용해 주세요. Copyright © SocialWired Corp."
	            			, "UTF-8");
	            }   
	           
	            else if(num==0) {
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



