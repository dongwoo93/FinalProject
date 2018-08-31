package kh.sns.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import kh.sns.dto.Board_CommentDTO;
import kh.sns.dto.Board_LikeDTO;
import kh.sns.dto.FollowInfo;
import kh.sns.util.LogUtil;

@Component
@Aspect
public class LogAspect {
	
	   
	   @Pointcut("execution(* kh.sns.impl.*Service.insertComment(..))")  
	   public void insertComment() {}
	 // 댓글insert 후 log
	   
	   @Pointcut("execution(* kh.sns.impl.*Service.insertLike(..))")  
	   public void insertLike() {}
	 // 좋아요 insert 후 log

	   @Pointcut("execution(* kh.sns.impl.*Service.insertFollowInfo(..))")  
	   public void insertFollowInfo() {}
	 // follow insert 후 log
	   
	   
	   @Pointcut("execution(* kh.sns.impl.*Service.insertSearch(..))")  
	   public void insertSearch() {}
	 // 검색어 insert 후 log
	   
	   
	   @Around("insertSearch()")  
	   public int insertSearch(ProceedingJoinPoint pjp) {
	      // Before
	      String id = pjp.getArgs()[0].toString();
	      String keyword = pjp.getArgs()[1].toString();
	     
	    ;
	      int result = 0;
	      try {
	         result = (Integer)pjp.proceed(new Object[] {id, keyword}); // before after branch 분기점
	         LogUtil log = new LogUtil();
		       log.insertLog(id,"search",keyword);   
	         // After  
	      } catch (Throwable e) {
	         e.printStackTrace();
	      } 
	      return result;
	   }

	   
	   @After("insertFollowInfo()") 
	   public void insertFollowInfo(JoinPoint jp) { 
		   try {
		   FollowInfo dto = (FollowInfo)jp.getArgs()[0]; 
		   LogUtil log = new LogUtil();
		   
	       log.insertLog(dto.getId(),"follow",dto.getId()+":"+dto.getTargetId());   
		   }catch(Throwable e) {
		         e.printStackTrace();
		      }  
	   }
	   
	   
	   @After("insertLike()") 
	   public void insertLike(JoinPoint jp) {     
		   try {
			  
		   Board_LikeDTO dto = (Board_LikeDTO)jp.getArgs()[0]; 
		   System.out.println(dto.getId() + " :::::::::::::::::::: " +Integer.toString(dto.getBoard_seq()));   
		   LogUtil log = new LogUtil();
		  
	       log.insertLog(dto.getId(),"like",Integer.toString(dto.getBoard_seq()));   
		   }catch(Throwable e) {
		         e.printStackTrace();
		      }  
	   }
	   
	   @After("insertComment()") 
	   public void commentlog(JoinPoint jp) { 
		   try {
		   Board_CommentDTO dto = (Board_CommentDTO)jp.getArgs()[0]; 
		   LogUtil log = new LogUtil();
		   String content = dto.getBoard_seq()+ ":" +dto.getComment_contents();
	       log.insertLog(dto.getId(),"comment",content);   
		   }catch(Throwable e) {
		         e.printStackTrace();
		      }  
	   }
	   

}
