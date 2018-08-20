package kh.sns.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import kh.sns.dto.MemberDTO;
import kh.sns.util.EncryptUtils;
import kh.sns.util.LogUtil;

@Aspect
@Component
public class MemberAspect {
   @Pointcut("execution(* kh.sns.impl.*Service.signUp(*))")
   public void insertEncrypt() {}
   //회원가입 전 암호화 후 로그등록
   
   @Pointcut("execution(* kh.sns.impl.*Service.loginMem(..))")  
   public void loginEncrypt() {}
 //로그인 전 암호화 후 로그등록
   
   @Pointcut("execution(* kh.sns.impl.*Service.findPw(..))")  
   public void newPwEncrypt() {}
   // 비밀번호찾기
   
   
   @Pointcut("execution(* kh.sns.impl.*Service.updateOneMemberPassword(..))")  
   public void updatePwEncrypt() {}
   //마이페이지에서 비밀번호 변경
   
   @Around("insertEncrypt()")
   public int insertEncrypt(ProceedingJoinPoint pjp) {
	   
      MemberDTO dto = (MemberDTO)pjp.getArgs()[0];
      String pw = EncryptUtils.getSha256(dto.getPw());
      dto.setPw(pw);
      int result = 0;
      try {
        result = (Integer)pjp.proceed(new Object[] {dto}); // before after branch 분기점
         LogUtil log = new LogUtil();
         log.insertLog(dto.getId(),"join");  
      } catch (Throwable e) {
         e.printStackTrace();
      }  
      
      return result;
      
   }
   
   
    
   @Around("loginEncrypt()") 
   public int loginEncrypt(ProceedingJoinPoint pjp) {
	   MemberDTO dto = (MemberDTO)pjp.getArgs()[0];
	   dto.setPw(EncryptUtils.getSha256(dto.getPw())); 
	   int result = 0;
	      try {
	        result = (Integer)pjp.proceed(new Object[] {dto}); // before after branch 분기점
	         LogUtil log = new LogUtil();
	         log.insertLog(dto.getId(),"login");  
	      } catch (Throwable e) {
	         e.printStackTrace();
	      } 
	      
	      return result;
	      
   }
   
   @Before("newPwEncrypt()") 
   public void newPwEncrypt(JoinPoint jp) {  

	   MemberDTO dto = (MemberDTO)jp.getArgs()[0]; 
	   dto.setPw(EncryptUtils.getSha256(dto.getPw()));
   }
   
   @Before("updatePwEncrypt()")
   public void updatePwEncrypt(JoinPoint jp) {
      MemberDTO dto = (MemberDTO)jp.getArgs()[0];
      String pw = EncryptUtils.getSha256(dto.getPw());
      dto.setPw(pw);
   } 
   

}