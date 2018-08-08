<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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


<script>


window.onload = function() {
	/* 
	/* document.getElementById("name").oninput = function() {
		var text = document.getElementById("name").value;
		var regex = /[^가-힣]{2,}/;
		if (regex.test(text)) {
			var re = text.replace(regex, '');
			document.getElementById(
					"name").value = re;
			console.log(re);
			
		}
	}; */ 
	
	
	
	


};	



$("document").ready(function(){
	
	
	
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
	                    phone = 1;
                  		 console.log(phone);
	                }
	                else
	                {
	                    alert("유효하지 않은 전화번호 입니다.");
	                   
	                    $(this).val("");
	                    $(this).focus();
	                    phone = 0;
	                    console.log(phone);
	        			
	                }
	            }
	            else 
	            {
	                alert("유효하지 않은 전화번호 입니다.");
	               
	                $(this).val("");
	                $(this).focus();
	                phone = 0;
                    console.log(phone);
	            }
	      }
	       
	  }); 
	 

})


 function checkPwd(){
			var inputed = $("#pw").val();
			var reinputed = $("#pwCheck").val();
			if(reinputed =="" && (inputed !=reinputed || inputed==reinputed)){
				pwCheck=0;
				
			}
			else if(inputed == reinputed){
				
				pwCheck =1;
				console.log(pwcheck);
			
			}else if(inputed!=reinputed){
				pwCheck=0;
			
			}
			if(inputed==""&& reinputed=="" ){
				pwCheck=0;
			}	
		}	
		

</script>
<style class="cp-pen-styles">
body {
	background: #222;
	/* 	background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
		url('https://unsplash.it/1200/800/?random'); */
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
</style>
<script>

						 function check() {
								setTimeout(
										function() {
											var color = $("#id").css("border-bottom-color");
											alert(color);
											if(color == "rgb(76, 175, 80)" || color=="") {
												console.log("띵동");
												
												
												
											} else {
												console.log("떙");
											}
										},
										1000);
								
					 }
						</script>
</head>

<body>

	<div class="container">
		<div class="row">
			<form class="col s12" id="reg-form" action="" method="post">
				<div class="row">
					<div class="input-field col s6">
						<input pattern="^[A-Za-z]{1}[A-Za-z0-9]{3,19}$" id="id" name="id"
							onblur="check()" type="text" class="validate" required> <label
							for="id">ID</label>



					</div>
					<div class="input-field col s6">
						<input pattern="[^가-힣]{2,}" id="name" name="name" type="text"
							class="validate" required> <label for="pw">Name</label>
					</div>
				</div>
				<div class="row">

					<div class="input-field col s6">
						<input id="pw" name="pw" oninput="checkPwd()" type="password"
							class="validate" minlength="6" required> <label for="pw">PassWord</label>
					</div>
					<div class="input-field col s6">
						<input id="pwCheck" oninput="checkPwd()" type="password"
							class="validate" minlength="6" required> <label
							for="pwCheck">Password Check</label>



					</div>



				</div>
				<div class="row">
					<div class="input-field col s12">
						<input id="email" name="email" type="email" class="validate"
							required> <label for="email">Email</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12">
						<input id="nick" name="nick" type="text" class="validate" required>
						<label for="nick">Nickname</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12 ph">
						<input id="phone" name="phone" type="text" class="validate"
							minlength="6" required> <label for="phone">Input
							Your Phone Number</label>
					</div>
				</div>
				<div class="row ">
					<div class="input-field col s12 mx-auto">
						<div class="gender-male">
							<input class="with-gap" name="gender" type="radio" id="male"
								value="1" required /> <label for="male">Male</label>
						</div>
						<div class="gender-female">
							<input class="with-gap" name="gender" type="radio" id="female"
								value="2" required /> <label for="female">Female</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s6">
						<button
							class="btn btn-large btn-register waves-effect waves-light"
							type="submit" id="sign" name="action">
							Register <i class="material-icons right">done</i>
						</button>
					</div>
					<div class="input-field col s6">
						<button
							class="btn btn-large btn-register waves-effect waves-light"
							type="button" id="cancel" name="action">
							Cancel <i class="material-icons right">done</i>
						</button>
					</div>

				</div>
			</form>
		</div>
		<a title="Login"
			class="ngl btn-floating btn-large waves-effect waves-light red"><i
			class="material-icons">input</i></a>
	</div>


</body>

</html>