<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script src="resources/js/main.js"></script>
<style>

body{
  background: url(http://www.timurtek.com/wp-content/uploads/2014/10/form-bg.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
  font-family:'HelveticaNeue','Arial', sans-serif;

}
a{color:#58bff6;text-decoration: none;}
a:hover{color:#aaa; }
.pull-right{float: right;}
.pull-left{float: left;}
.clear-fix{clear:both;}
div.logo{text-align: center; margin: 20px 20px 30px 20px; fill: #566375;}
.head{padding:40px 0px; 10px 0}
.logo-active{fill: #44aacc !important;}
#formWrapper{
   background: rgba(0,0,0,.2); 
   width:100%; 
   height:100%; 
   position: absolute; 
   top:0; 
   left:0;
   transition:all .3s ease;}  
.darken-bg{background: rgba(0,0,0,.5) !important; transition:all .3s ease;}

div#form{
   position: absolute;
   width:400px;
   height:320px;
   height:auto;
/*      background-color: #fff;   */
   margin:auto;
   border-radius: 5px;
   padding:20px;
   left:50%;
   top:50%;
   margin-left:-200px;
   margin-top:-300px;
   opacity : 0.9;
}
div.form-item{position: relative; display: block; margin-bottom: 40px;}
 input{transition: all .2s ease;}
 input.form-style{
   color:#8a8a8a;
   display: block;
   width: 100%;
   height: 44px;
    padding: 5px 5%; 
   border:1px solid #ccc;
/*     -moz-border-radius: 27px;  */
/*     -webkit-border-radius: 27px;  */
/*    border-radius: 27px; */
    -moz-background-clip: padding; 
    -webkit-background-clip: padding-box; 
   background-clip: padding-box;
   background-color: #fff;
   font-family:'HelveticaNeue','Arial', sans-serif;
   font-size: 105%;
   letter-spacing: .8px;
}
div.form-item .form-style:focus{outline: none; border:1px solid #58bff6; color:#58bff6; }
div.form-item p.formLabel {
   position: absolute;
   left:26px;
   top:10px;
   transition:all .4s ease;
   color:#bbb;}
.formTop{top:-22px !important; left:26px; background-color: #fff; padding:0 5px; font-size: 14px; color:#58bff6 !important;}
.formStatus{color:#8a8a8a !important;}
input[type="submit"].login{
   float:right;
   width: 112px;
   height: 37px;
/*    -moz-border-radius: 19px; */
/*    -webkit-border-radius: 19px; */
/*    border-radius: 19px; */
   -moz-background-clip: padding;
   -webkit-background-clip: padding-box;
   background-clip: padding-box;
   background-color: #80DEEA;
   border:1px solid #55b1df;
   border:none;
   color: #fff;
   font-weight: bold;
}
input[type="submit"].login:hover{background-color: #fff; border:1px solid #55b1df; color:#55b1df; cursor:pointer;}
input[type="submit"].login:focus{outline: none;}
h1{
   color 
}

#result {
text-align: center;
color: white;
}


</style>

<script>
if(${sessionScope.loginId != null}) {
	$(location).attr("href", "feed.bo");
}
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
	
		<form id="loginform" method="post">
	      <div class="form-item">
	         <p class="formLabel">id</p>
	         <input type="id" name="id" id="id" class="form-style" autocomplete="off"/>
	      </div>
	      <div class="form-item">
	         <p class="formLabel">Password</p>
	         <input type="password" name="pw" id="password" class="form-style" />
	         <!-- <div class="pw-view"><i class="fa fa-eye"></i></div> -->
	         <br>
	         <div id="result"></div>
	         
	      </div>
	      
	      <div class="form-item">
	      <p class=""><a href="" ><small>Forgot Password ?</small></a></p>   
	      <p class="pull-left"><a href="join.do"><small>Register</small></a></p>
	      <input id="submit" type="submit" class="login pull-right" value="Log In">
	      <div class="clear-fix"></div>
	      </div> 
	      </form>
	   	</div>
	</div>

 
</body>
</html>