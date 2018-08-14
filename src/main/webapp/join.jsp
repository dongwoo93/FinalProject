<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="robots" content="noindex">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../../../favicon.ico">

<title>Sign Up Page</title>

<!-- Bootstrap core CSS -->
<script src="https://code.jquery.com/jquery-3.3.1.js"
	integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>


<script
	src='//static.codepen.io/assets/editor/live/console_runner-ce3034e6bde3912cc25f83cccb7caa2b0f976196f2f2d52303a462c826d54a73.js'>
</script>
<script
	src='//static.codepen.io/assets/editor/live/css_live_reload_init-654f8ff86ff57fe42b9638d3bacf774c90ce371a1c6d0ae81f5d12823b0334eb.js'>
</script>

<!-- Custom styles for this template -->
<!--   <link href="css/joinning.css" rel="stylesheet"> -->
<script
	src='//static.codepen.io/assets/editor/live/console_runner-ce3034e6bde3912cc25f83cccb7caa2b0f976196f2f2d52303a462c826d54a73.js'>
</script>
<script
	src='//static.codepen.io/assets/editor/live/css_live_reload_init-654f8ff86ff57fe42b9638d3bacf774c90ce371a1c6d0ae81f5d12823b0334eb.js'>
</script>

<link rel="shortcut icon" type="image/x-icon"
	href="//static.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
<link rel="mask-icon" type=""
	href="//static.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg"
	color="#111" />
<link rel="canonical" href="https://codepen.io/vaskopetrov/pen/amxvrY" />

<link rel='stylesheet'
	href='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.3/css/materialize.min.css'>
<link rel='stylesheet'
	href='https://fonts.googleapis.com/icon?family=Material+Icons'>
<script
	src='//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js'></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<script src='https://code.jquery.com/jquery-2.1.1.min.js'></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js'></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">

<script type="text/javascript"
	src="resources/countdownTimer/js/jQuery.countdownTimer.js"></script>
<link rel="stylesheet" type="text/css"
	href="resources/countdownTimer/css/jQuery.countdownTimer.css" />
<style class="cp-pen-styles">
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
	background: white;
	padding: 20px 25px;
	border: 5px solid #26a69a;
	width: 550px;
	height: auto;
	box-sizing: border-box;
	position: relative;
}

.col.s6>.btn {
	width: 100%;
}

.gender-male, .gender-female {
	display: inline-block;
}

.gender-female {
	margin-left: 35px;
}

radio:required {
	border-color: red;
	opacity: 0;
}

.container {
	animation: showUp 0.5s cubic-bezier(0.18, 1.3, 1, 1) forwards;
}

@
keyframes showUp { 0% {
	transform: scale(0);
}

100%
{
transoform






:



 



scale






(1);
}
}
.row {
	margin-bottom: 10px;
}

.ngl {
	position: absolute;
	top: -20px;
	right: -20px;
}

/* rgb(244, 67, 54)  빨갱이 */
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
	left: 40%;
	margin-left: -21px;
	margin-top: -21px;
}

.display-none { /*감추기*/
	display: none;
}

.time {
	width: 30%;
	text-align: center;
	height: 40px;
}
</style>





<script>
/* 값 0일 경우 해당 파트는 유효성 검증이 안 된 것 
 * 1은 검증완료 된 것
 
 */
var idCheck = 0;
var pwCheck = 0;
var phoneCheck = 0;
var phoneConfirm=0;
var emailCheck = 0;
var nickCheck = 0;
var nameCheck = 0;
var genderCheck = 0;

window.onload = function() {
	
	/* 
	이름 한글만 입력
	*/
	 document.getElementById("name").oninput = function() {
		var text = document.getElementById("name").value;
		var regex = /[^가-힣]{2,}/;
		if (regex.test(text)) {
			var re = text.replace(regex, '');
			document.getElementById("name").value = re;
			console.log(re);
			
		}
	};
	
	

	

};	







$("document").ready(function(){

/* 다시쓰기  */

	$("#cancel").click(function(){
		
		$(".validate").val("");
		
	});
	
$("#back").click(function(){
		
		$(location).attr('href',"main.do");
		
	});
	
$("#id").click(function(){
	
	$("#chId").remove();	
	
});	

$("#nick").click(function(){
	
	$("#chNick").remove();	
	
});	
$("#email").click(function(){
	
	$("#chEmail").remove();	
	
});	

	
	
	/* 
	회원가입완료 유효성
	*/
	
$("#sign").click(function(){
	var gender = $('input[name=gender]:checked').val()
	
	var id = "아이디를 다시 입력하세요";
	var pw = "비밀번호를 다시 입력하세요";
	var name = "이름을 다시 입력하세요";
	var nick = "닉네임을 다시 입력하세요";
	var email = "이메일을 다시 입력하세요";
	var phone = "번호를 다시 입력하세요";
	var gen = "성별을 다시 입력하세요";
	
	if(idCheck==0 || pwCheck == 0 || phoneCheck == 0 ||
			 phoneConfirm==0 ||
			 emailCheck == 0 ||
			 nickCheck == 0 ||
			 nameCheck == 0 || gender==null
			 ){	
				if(idCheck==0){
					alert(id);
					$("#id").val("");
					$("#id").focus();
				}else if( nameCheck==0){
					alert(name);
					$("#name").val("");
					$("#name").focus();
				}
				else if(pwCheck==0){
					alert(pw);
					$("#pw").val("");
					$("#pw").focus();
				}else if(emailCheck==0){
					alert(email);
					$("#email").val("");
					$("#email").focus();
				}else if( nickCheck==0){
					alert(nick);
					$("#nick").val("");
					$("#nick").focus();
				}else if(phoneCheck==0){
					alert(phone);
					$("#phone").val("");
					$("#phone").focus();
				} else if(phoneConfirm==0){
					alert(phone);
					$("#certification").val("");
					$("#certification").focus();
				}else if( gender==null){
					alert(gen);
					$(".gender").focus();
				}		
				
			}
	
});
	 
	 
/**
 * 번호 유효성
 */
	
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
	                    phoneCheck = 1;
	                    console.log(phoneCheck);
	                    
	               
	                }
	                else
	                {
	                    alert("유효하지 않은 전화번호 입니다.");
	                   
	                    $(this).val("");
	                    $(this).focus();
	                    phoneCheck = 0;
	                    console.log(phoneCheck);
	        			
	                }
	            }
	            else 
	            {
	                alert("유효하지 않은 전화번호 입니다.");
	               
	                $(this).val("");
	                $(this).focus();
	                phoneCheck = 0;
                    console.log(phoneCheck);
	            }
	      }
	       
	  }); 
	 
 
	 /**
	  *인증번호
	  */

	 
	$("#confirm").click(function(){
		console.log("클릭");
		var phone = $("#phone").val();
		if(phoneCheck==1){
			console.log("맞아용");
			var yes = confirm(phone+"맞아용?");
			
			if(yes){
				
				console.log("인증번호 ");
				
				
				 $.ajax({
					url:"sms.do",
					type:"post",
					data:{
						phone : phone
						},	
						 beforeSend: function() {
						  
						        $('.wrap-loading').removeClass('display-none');

						    },
						    complete: function() {
						
						        $('.wrap-loading').addClass('display-none');

						    }, 

					success:function(data){
						
						if((!data=="")){
							alert("인증번호 전송완료");
							$("input[name=phone]").attr("readonly",true);
						var start = $(".confirm");
						start.after(
								"<div class='row phoneinput'><div class='input-field col s6'><input type='text' id='certification' name='certification' class='validate' placeholder='인증번호를 입력하세요'></div> <div class='input-field time'></div></div>");
						
						timeCount();
							
						$("#certification").keyup(function(){
							var insert = $("#certification").val();
							if(insert==data){
								$("#certification").css("background-color", "#ccff33");
								 $("input[name=certification]").attr("readonly",true);
									
								phoneConfirm=1;		
								alert("인증 성공");
							}else{
								$("#certification").css("background-color", "red");
								phoneConfirm=0;		
							
							}
								
							});
						
						}else{
							alert("올바른 번호를 입력해주세요");
							$("#certification").remove();
							$("#phone").val("");
							$("#phone").focus();
						}	
					}	
					
				});	
			}else{
				alert("올바른 번호를 입력해주세요");
				$("#phone").val("");
				$("#phone").focus();
			}
			
		}else{
			alert("올바른 번호를 입력해주세요");
			$(this).val("");
			$(this).focus();
		}
	});	 
	 
	 
	 $("#nick").keyup(function(){
		 $("#chNick").remove();
	 })
	 
});


 function checkPwd(){
			var inputed = $("#pw").val();
			var reinputed = $("#pwCheck").val();
			if(reinputed =="" && (inputed !=reinputed || inputed==reinputed)){
				pwCheck=0;
				console.log(pwCheck);
				return false;
			}
			else if(inputed == reinputed && inputed.length>5 && reinputed.length>5){
				
				pwCheck =1;
				console.log(pwCheck);
				return true;
			
			}else if(inputed!=reinputed){
				pwCheck=0;
				console.log(pwCheck);
				return false;
			}
			if(inputed=="" && reinputed=="" ){
				pwCheck=0;
				console.log(pwCheck);
				return false;
			}	
		
		}	

 function checkId() {
		setTimeout(
				function() {
					var color = $("#id").css("border-bottom-color");
					var id = $("#id").val();
					console.log(color);
					
					if(color == "rgb(76, 175, 80)" || color=="") {
						console.log("띵동");
						 $.ajax({
				                url: "dupId.do", // 처리할 페이지(서블릿) 주소
				                type: "get",
				                data: {id : id},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
				                success: function(data) {
				                    console.log("AJAX Request 성공");
				                   if(data==1){
				                
				                	   idCheck=0;
				                	   var start = $(".id");
				   						start.after('<div class="mt-2" id="chId"><i class="fas fa-ban mt-4" style="color:red; font-size:30px" ></i></div>');
				                	


				                	   alert("이미 사용중인 아이디 입니다");
				                	   
				                	   $("#id").val("");
				                	   $("#id").focus();
				                	   
				   						
				                   }else if(data==0){
				               
				                	   idCheck=1;
		                	   var start = $(".id");
				   				start.after(
				   						'<div class="mt-2" id="chId"><i class="fas fa-check-square mt-4" style="color:green; font-size:30px" ></i></div>');
				                	   alert("사용 가능한 아이디 입니다.");
				                	   
				                   }
				                   
				                },
				                error: function() {
				                    console.log("에러 발생");
				                    idCheck=0;
				                },
				                complete: function(){
				                    console.log("AJAX 종료");
				                }
				            }); 
				          
						
						console.log(idCheck);
					} else {
						console.log("땡");
						idCheck=0;
						console.log(idCheck);
					}
				},
				500);
}
 
 function checkNick() {
		setTimeout(
				function() {
					var color = $("#nick").css("border-bottom-color");
					var nick = $("#nick").val();
		
					if(color == "rgb(76, 175, 80)" || color=="") {
						console.log("띵동");
						 $.ajax({
				                url: "nickCheck.do", // 처리할 페이지(서블릿) 주소
				                type: "get",
				                data: {nick: nick},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
				                success: function(data) {
				                    console.log("AJAX Request 성공");
				                 
				                    if(data==1){
						                
					                	   nickCheck=0;
					                	   var start = $(".nick");
					   						start.after('<div class="mt-2" id="chNick"><i class="fas fa-ban mt-4" style="color:red; font-size:30px" id="chId"></i></div>');
					                	


					                	   alert("이미 사용중인 닉네임 입니다");
					                	   
					                	   $("#nick").val("");
					                	   $("#nick").focus();
					                	   
					   						
					                   }else if(data==0){
					               
					                	   nickCheck=1;
			                	   var start = $(".nick");
					   				start.after(
					   						'<div class="mt-2" id="chNick"><i class="fas fa-check-square mt-4" style="color:green; font-size:30px" id="chId"></i></div>');
					                	   alert("사용 가능한 닉네임 입니다.");
					                	   
					                   }
				                },
				                error: function() {
				                    console.log("에러 발생");
				                },
				                complete: function(){
				                    console.log("AJAX 종료");
				                }
				            }); 
				       
						console.log(nickCheck);
					} else {
						console.log("떙");
						nickCheck=0;
						console.log(nickCheck);
					}
				},
				500);
}
 
 function checkEmail() {
		setTimeout(
				function() {
					var color = $("#email").css("border-bottom-color");
					var email = $("#email").val();
					console.log(color);
					
					if(color == "rgb(76, 175, 80)" || color=="") {
						console.log("띵동");
				
					   $.ajax({
				                url: "emailCheck.do", // 처리할 페이지(서블릿) 주소
				                type: "get",
				                data: {email: email},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
				                success: function(data) {
				                    console.log("AJAX Request 성공");
				                    console.log(data);
				                    if(data==2){
						              
				                    		emailCheck=0;
					                	   var start = $(".email");
					   						start.after('<div class="mt-2" id="chEmail"><i class="fas fa-ban mt-4" style="color:red; font-size:30px" id="chId"></i></div>');
					                	


					                	   alert("이미 사용중인 이메일 입니다");
					                	   
					                	   $("#email").val("");
					                	   $("#email").focus();
					                	   
					   						
					                   }else if(data==0){
					               
					                	   emailCheck=1;
			                	   var start = $(".email");
					   				start.after('<div class="mt-2" id="chEmail"><i class="fas fa-check-square mt-4" style="color:green; font-size:30px" id="chId"></i></div>');
					                	   alert("사용 가능한 이메일 입니다.");
					                	   
					                   }                 
				                },
				                error: function() {
				                    console.log("에러 발생");
				                },
				                complete: function(){
				                    console.log("AJAX 종료");
				                }
				            });  
				          
			
						console.log(emailCheck);
					} else {
						console.log("떙");
						emailCheck=0;
						console.log(emailCheck);
					}
				},
				500);
}
 
 
 function timeCount(){
	
	$(".time").countdowntimer({
		 minutes : 3,
		 seconds : 0,
		 timeUp: timeIsUp,
		 size:"sm"
	 });
	
	function timeIsUp() {
        alert("유효시간이 만료 됐습니다");
        $(".phoneinput").remove();
        $("input[name=phone]").attr("readonly",false);
        $("#phone").val("");
        $("#phone").focus();
    }	
	$("#currentTime").remove("style");
 }
 
 
 function  checkName() {
		var name = $("#name").val();
		if(name.length>1){
			nameCheck=1;
			console.log(nameCheck);
		}else{
			nameCheck=0;
			console.log(nameCheck);
		}
}

</script>

</head>

<body>
	<c:choose>
		<c:when test="${result==0}">
			<script>
alert("회원가입 실패");
$(location).attr("href", "join.jsp")
</script>
		</c:when>
		<c:when test="${result==1}">
			<script>
alert("회원가입 성공");
$(location).attr("href", "main.jsp");
</script>
		</c:when>
		<c:otherwise>
			<div class="container">
				<div class="row">
					<form class="col s12" id="reg-form" action="sign.do" method="post">
						<div class="row">
							<div class="input-field col s6 id">

								<input pattern="^[A-Za-z]{1}[A-Za-z0-9]{3,19}$" id="id"
									name="id" onblur="checkId()" type="text" class="validate"
									required> <label for="id">ID 4~19자리(영문 숫자 혼합)</label>



							</div>


							<div class="input-field col s6 name">
								<input id="name" name="name" type="text" minlength="2"
									onblur="checkName()" class="validate" required> <label
									for="name">Name 한글만 입력 해 주세요</label>
							</div>
						</div>
						<div class="row">

							<div class="input-field col s6 pw">
								<input id="pw" name="pw" oninput="checkPwd()" type="password"
									class="validate" minlength="6" required> <label
									for="pw">PassWord 6자리 이상</label>
							</div>
							<div class="input-field col s6 pw2">
								<input id="pwCheck" oninput="checkPwd()" type="password"
									class="validate" minlength="6" required> <label
									for="pwCheck">Password Check</label>



							</div>



						</div>
						<div class="row">
							<div class="input-field col s12 email">
								<input id="email" name="email" type="email"
									onblur="checkEmail()"
									pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"
									class="validate" required> <label for="email">Email</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s12 nick">
								<input id="nick" onblur="checkNick()" name="nickname"
									type="text" pattern="^[A-Za-z]{1}[A-Za-z0-9]{3,19}$"
									class="validate" required> <label for="nick">Nickname 4~19자리(영문 숫자 혼합)</label>
							</div>
						</div>
						<div class="row confirm">
							<div class="input-field col s9 phone">
								<input id="phone" name="phone" type="text" class="validate"
									required> <label for="phone">Input Your Phone
									Number</label>
							</div>
							<div class="input-field col s3 ">
								<button
									class="btn btn-large btn-register waves-effect waves-light"
									type="button" id="confirm" style="height: 70%">
									번호인증 <i class="material-icons right"></i>
								</button>

							</div>
						</div>
						<p id="currentTime"></p>
						<div class="row ">
							<div class="input-field col s12 mx-auto">
								<div class="gender-male">
									<input class="with-gap" name="gender" type="radio" id="male"
										value="남" required /> <label for="male">Male</label>
								</div>
								<div class="gender-female">
									<input class="with-gap" name="gender" type="radio" id="female"
										value="여" required /> <label for="female">Female</label>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s6">
								<button
									class="btn btn-large btn-register waves-effect waves-light"
									type="submit" id="sign" name="action" style="height: 90%">
									Register <i class="material-icons right">done</i>
								</button>
							</div>
							<div class="input-field col s6">
								<button
									class="btn btn-large btn-register waves-effect waves-light"
									type="button" id="cancel" name="action" style="height: 90%">
									다시쓰기^^7 <i class="material-icons right">done</i>
								</button>
							</div>

						</div>



					</form>
				</div>
				<a title="Login"
					class="ngl btn-floating btn-large waves-effect waves-light red"><i
					class="material-icons" id="back">input</i></a>
			</div>
			<div class="wrap-loading display-none">
				<div>
					<img src="resources/images/loading.gif">
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</body>

</html>