package kh.sns.aspect;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

@Aspect
@Controller
public class LoginAspect {

	@Pointcut("execution(* kh.sns.controller.Board*Controller.*(..))")
	public void boardMethod() {}
	
	@Pointcut("execution(* kh.sns.controller.ProfileController.*(..))")
	public void profileMethod() {}
	
	@Pointcut("execution(* kh.sns.controller.Member_BlockController.*(..))")
	public void bloackMethod() {}

	@Around(value="boardMethod() || profileMethod() || bloackMethod()")
	 public Object trace(ProceedingJoinPoint joinPoint) throws Throwable{
		 
		System.out.println("#### LoginAspect 시작 ####");    
		        HttpServletRequest request = null;
		        HttpServletResponse response = null;
		        HttpSession session = null;
		        ModelAndView mav = null;
		        for ( Object o : joinPoint.getArgs() ){
		            if ( o instanceof HttpServletRequest ) {
		                request = (HttpServletRequest)o;
		            }
		            if ( o instanceof HttpServletResponse ) {
		                response = (HttpServletResponse)o;
		            }
		            if ( o instanceof ModelAndView ) {
		            	mav = (ModelAndView)o;
		            }
		            if ( o instanceof HttpSession ) {
		            	session = (HttpSession)o;
		            }
		        }
		        try{
		            
		 
		                String loginId = (String) session.getAttribute("loginId");
		                // String userEnterType = (String) session.getAttribute("UserEnterType");
		 
		                System.out.println("### Margo ==> loginId : " + loginId);
		                if (loginId == null || "".equals(loginId)) {
		                    System.out.println("### Margo ==> in if loginId : "
		                            + loginId);
		                     throw new RuntimeException("먼저 로그인을 하셔야 합니다.");
		                }          
		        }catch(Exception e){
		             throw new RuntimeException("먼저 로그인을 하셔야 합니다.");
		 
		        }      
		        Object result = joinPoint.proceed();
		System.out.println("#### LoginAspect 끝 ####");     
		        return result;
		    }
}