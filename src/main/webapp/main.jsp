<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-2.1.0.min.js" ></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script src="resources/js/main.js"></script>
<script>
if(${sessionScope.loginId != null}) {
	$(location).attr("href", "feed.bo");
}
$(document).ready(function(){
   var formInputs = $('input[type="id"],input[type="password"]');
   formInputs.focus(function() {
       $(this).parent().children('p.formLabel').addClass('formTop');
       $('div#formWrapper').addClass('darken-bg');
       $('div.logo').addClass('logo-active');
   });
   
   formInputs.focusout(function() {
      if ($.trim($(this).val()).length == 0){
      $(this).parent().children('p.formLabel').removeClass('formTop');
      }
      $('div#formWrapper').removeClass('darken-bg');
      $('div.logo').removeClass('logo-active');
   });
   
   $('p.formLabel').click(function(){
       $(this).parent().children('.form-style').focus();
   });
});
</script>


</head>
<body>


<div id="formWrapper">

<div id="form">
		<!-- <div class="logo"> -->
		<!-- <h1 class="text-center head text-light display-4">SocialWired</h1> -->
		<!-- <p class="text-light">We ♥ new friends</p> -->
		<!-- </div> -->



		<div class="logo">
		<h1 class="text-center head text-light display-4">SocialWired</h1>
		<p class="text-light">We ♥ new friends</p>
		</div>
	
		<form action="login.do" method="post">
	      <div class="form-item">
	         <p class="formLabel">id</p>
	         <input type="id" name="id" id="id" class="form-style" autocomplete="off"/>
	      </div>
	      <div class="form-item">
	         <p class="formLabel">Password</p>
	         <input type="password" name="pw" id="password" class="form-style" />
	         <!-- <div class="pw-view"><i class="fa fa-eye"></i></div> -->
	         <br>
	         <p class><a href="" ><small>Forgot Password ?</small></a></p>   
	      </div>
	      
	      <div class="form-item">
	      <p class="pull-left"><a href="join.do"><small>Register</small></a></p>
	      <input type="submit" class="login pull-right" value="Log In">
	      <div class="clear-fix"></div>
	      </div> 
	      </form>
	   	</div>
	</div>

</body>
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
</html>