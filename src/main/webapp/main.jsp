<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<script src="resources/js/main.js"></script>
<title>SoicalWired</title>
     
<script>
   if(${sessionScope.loginId != null}) {
      $(location).attr("href", "feed.bo");
   } 
</script>
</head>
<body>
 


<!-- <div id="formWrapper"> -->
<!--    <base href="https://s3-us-west-2.amazonaws.com/s.cdpn.io/4273/"> -->
<!--    <div id="slider"> -->
<!--       <figure> -->
<!--       <img src="austin-fireworks.jpg" alt> -->
<!--       <img src="taj-mahal_copy.jpg" alt> -->
<!--       <img src="ibiza.jpg" alt> -->
<!--       <img src="ankor-wat.jpg" alt> -->
<!--       <img src="austin-fireworks.jpg" alt> -->
<!--    </figure> -->
 
     
<div id="form">
      <!-- <div class="logo"> -->
      <!-- <h1 class="text-center head text-light display-4">SocialWired</h1> -->
      <!-- <p class="text-light">We ♥ new friends</p> -->
      <!-- </div> -->



      <div class="logo">
      <h1 class="text-center head text-dark display-4" style="font-weight:bold;">SocialWired</h1>
      <p class="" id="ptag">We ♥ new friends</p>
      </div>
   
      <form id="loginform" method="post"> 
         <div class="form-item">
            <p class="formLabel" style="font-weight:bold;">ID</p>
            <input type="id" name="id" id="id" class="form-style" autocomplete="off"/>
         </div>
         <div class="form-item">
            <p class="formLabel" style="font-weight:bold;">Password</p>
            <input type="password" name="pw" id="password" class="form-style" />
            <br>
            <div id="result"></div>
            
            
         </div>
         
         
         <div class="form-item">
         <p class="" style="font-weight:bold;"><a href="findPass.jsp" ><small>Forgot Password ?</small></a></p>   
         <p class="pull-left" style="font-weight:bold;"><a href="join.do"><small>Register</small></a></p>
         <input id="submit" type="submit" class="login pull-right" value="Log In" style="font-weight:bold;">
         <div id="preloader">
        <div id="loader"></div>
      </div>
         <div class="clear-fix"></div>
         </div> 
         </form>
         </div>
         
<!--     </div> -->
   
   
   
 </div>


   
   

</body>
</html>