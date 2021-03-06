<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script src="https://code.jquery.com/jquery-3.3.1.js"
	integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
	crossorigin="anonymous"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<title>Insert title here</title>

</head>


<style>
body {
	background: #222;
	background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
		url('https://unsplash.it/1200/800/?random'); 
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center center;
	background-fill-mode: rgba(0, 0, 0, 0.5);
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}
.container { 
	margin-top: 100px;
	background: none;
	padding: 20px 25px;
	border: 5px solid #26a69a;
	width: 550px;
	height: auto;
	box-sizing: border-box;
	position: relative;
 
opacity: 0.7; 
}
.wrap-loading { /*화면 전체를 어둡게 합니다.*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',
		endColorstr='#20000000'); /* ie */
}  

.wrap-loading div { /*로딩 이미지*/
	position: fixed;
	top: 40%;
	left: 44%;
	margin-left: -21px;
	margin-top: -21px;
}
.display-none { /*감추기*/
	display: none;
}

</style>   

<body>
<script>
$(document).ready(function() {
	$('#send1').on("click",function() {
		  // your stuff
		 $('.wrap-loading').removeClass('display-none');
		 $("#login-form").submit();
			 
			   
			 
		  
	});
	  $("#send2").on('click',function(){
		  $('.wrap-loading').removeClass('display-none');
		  $("#login-form2").submit();
	
	   
	  });
  
		
	  
});

</script>
<c:choose>
<c:when test="${result=='0'}">
<script>
$('.wrap-loading').addClass('display-none');
alert("맞지 않는 계정 정보입니다. 다시 입력해주세요");
$("#id").val("");
$("#Cemail").val("");
$("#name").val("");
$("#email2").val("");

$("#id").focus();
</script>
</c:when>

<c:when test="${result=='1'}">
<script>
$('.wrap-loading').addClass('display-none');
alert("임시 비밀번호 전송 완료");

$(location).attr('href',"main.do");
</script>
</c:when>
<c:when test="${result=='2'}">
<script>
$('.wrap-loading').addClass('display-none');
alert("이메일 전송 완료");

$(location).attr('href',"main.do");
</script>
</c:when>
</c:choose>
  

<!------ Include the above in your HEAD tag ---------->

<div class="container">
							<div class="wrap-loading display-none" style="z-index:1000">
				<div>
					<img src="resources/images/loading3.gif">
				</div> 
			</div>
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="main.jsp" class="active" id="login-form-link">Login</a>
							</div>
							<div class="col-xs-6">
								<a href="join.jsp" id="register-form-link" style="float:right;">Register</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="login-form" action="findPw.do" method="post" role="form" >
									<div class="form-group">
										<label>Finding Password</label>
									</div>
									<div class="form-group">
										<input type="text" name="id" id="id" tabindex="1" class="form-control" placeholder="User Id" >
									</div>
									<div class="form-group">
										<input type="text" name="email" id="Cemail" tabindex="2" class="form-control" placeholder="Input Email Address">
									</div>
									
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="button" name="login-submit" id="send1" tabindex="4" class="form-control btn btn-login" value="SEND">
											</div>
										</div>
									</div>
			
								</form>
								
							</div>
							
							<div class="col-lg-12">
								<form id="login-form2" action="findId.do" method="post" role="form" >
									<div class="form-group">
										<label>Finding ID</label>
									</div>
									<div class="form-group">
										<input type="text" name="name" id="name" tabindex="1" class="form-control" placeholder="User Name" >
									</div>
									<div class="form-group ">
										<input type="text" name="email" id="email2" tabindex="2" class="form-control" placeholder="Input Email Address">
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="button" name="findId" id="send2"   tabindex="4" class="form-control btn btn-login" value="SEND">
											</div>
										</div>
									</div>
			
								</form>
								
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>