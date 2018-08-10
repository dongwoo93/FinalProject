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
<script>
$("#phone").on('keydown', function(e){
    // 숫자만 입력받기
     var trans_num = $(this).val().replace(/-/gi,'');
	var k = e.keyCode;
				
	if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) ))
	{
	    e.preventDefault();
	
	}
	
 }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
     if($(this).val() == '') return;

     // 기존 번호에서 - 를 삭제합니다.
     var trans_num = $(this).val().replace(/-/gi,'');
   
     // 입력값이 있을때만 실행합니다.
     if(trans_num != null && trans_num != '')
     {
         // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
         if(trans_num.length==11 || trans_num.length==10) 
         {   
             // 유효성 체크
            
             var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
             if(regExp_ctn.test(trans_num))
             {
                 // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿔줍니다.
                 
                 trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
                 $(this).val(trans_num);
               
              
            
             }
             else
             {
                 alert("유효하지 않은 전화번호 입니다.");
                
                 $(this).val("");
                 $(this).focus();
             
     			
             }
         }
         else 
         {
             alert("유효하지 않은 전화번호 입니다.");
            
             $(this).val("");
             $(this).focus();
          
         }
   }
    
}); 


</script>

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
</style>
<body>
<c:choose>
<c:when test="${result=='0'}">
<script>
alert("맞지 않는 계정 정보입니다. 다시 입력해주세요");
$("#id").val("");
$("#email").val("");
$("#id").focus();
</script>
</c:when>

<c:when test="${result=='1'}">
<script>
alert("임시 비밀번호 전송 완료");

$(location).attr('href',"main.do");
</script>
</c:when>
<c:when test="${result=='2'}">
<script>
alert("이메일 전송 완료");

$(location).attr('href',"main.do");
</script>
</c:when>
</c:choose>


<!------ Include the above in your HEAD tag ---------->

<div class="container">
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="main.jsp" class="active" id="login-form-link">Login</a>
							</div>
							<div class="col-xs-6">
								<a href="join.jsp" id="register-form-link">Register</a>
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
										<input type="text" name="cId" id="id" tabindex="1" class="form-control" placeholder="User Id" >
									</div>
									<div class="form-group">
										<input type="text" name="cEmail" id="Cemail" tabindex="2" class="form-control" placeholder="Input Email Address">
									</div>
									
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="SEND">
											</div>
										</div>
									</div>
									
								</form>
								
							</div>
							
							<div class="col-lg-12">
								<form id="login-form" action="findId.do" method="post" role="form" >
									<div class="form-group">
										<label>Finding ID</label>
									</div>
									<div class="form-group">
										<input type="text" name="name" id="name" tabindex="1" class="form-control" placeholder="User Name" >
									</div>
									<div class="form-group ">
										<input type="text" name="phone" id="phone" tabindex="2" class="form-control" placeholder="Phone Number">
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="findId" id="findId" tabindex="4" class="form-control btn btn-login" value="인증번호 받기">
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