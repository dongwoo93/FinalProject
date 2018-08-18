package kh.sns.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import kh.sns.util.EncryptUtils;
import kh.sns.dto.MemberDTO;

@Aspect
@Component
public class MemberAspect {
   @Pointcut("execution(* kh.sns.impl.*Service.signUp(*))")
   public void insertEncrypt() {}
   
   @Pointcut("execution(* kh.sns.impl.*Service.loginMem(..))")  
   public void loginEncrypt() {}
   
   @Before("insertEncrypt()")
   public void insertEncrypt(JoinPoint jp) {
      MemberDTO dto = (MemberDTO)jp.getArgs()[0];
      String pw = EncryptUtils.getSha256(dto.getPw());
      dto.setPw(pw);
   }
    
   @Before("loginEncrypt()") 
   public void loginEncrypt(JoinPoint jp) {
	   MemberDTO dto = (MemberDTO)jp.getArgs()[0];
	   dto.setPw(EncryptUtils.getSha256(dto.getPw()));
   }
}