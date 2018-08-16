/*$(document).ready(function() {		
	
	// JS갱신좀..
		
		var originalPrivacyTab = $('#privacyTab').html();
		var newPrivacyTab = $('#tabthree').html();
		var newPrivacyTab2 = $('#tabfive').html();
		
		// 탭 내용 외부 연결			
	    $('.nav-item a').filter("[data-target='#${ param.targetTab }']").tab('show');		
		
	// 이메일 중복 확인

	$('#emailField').focusout(function() {
		var email = $('#emailField').val();

		$.ajax({
			url : "isEmailDuplicated.ajax",
			type : "get",
			data : {
				email : email
			}, // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
			success : function(response) {
				// console.log("AJAX Request 성공: ");
				console.log(response)
				if (response.indexOf('true') > -1) {
					$('#duplResultArea').html(
									"<span class='badge badge-pill badge-danger'>❌</span> 이미 존재하는 이메일입니다.");
					$('#emailField').val("");
					$('#emailField').focus();
				} else if (email != "") {
					$('#duplResultArea')
							.html("<span class='badge badge-pill badge-success'>✔</span> 사용 가능한 이메일입니다.");
				} else if (email == "") {
					$('#duplResultArea').text("");
				}

			},
			error : function() {
				console.log("에러 발생");
			},
			complete : function() {
				// console.log("AJAX 종료");
			}
		})
	}) // focustout 끝
	
	// 비밀번호 형식 확인
	
 	$('#inputPassword1').keyup(function() { 
		
		var regex = /^[a-zA-Z0-9!@()_-|]{6,20}$/  
		var pwd = $('#inputPassword1').val();
		// console.log(pwd);
		if(pwd == ""){
			
		}
		else if(regex.test(pwd)){
			// console.log(true)
			$('#pwdCheckArea').html("<span class='badge badge-pill badge-success'>✔</span> 사용하실 수 있습니다.");
		} else {
			// console.log(false)
			$('#pwdCheckArea').html("<span class='badge badge-pill badge-danger'>❌</span> 사용하실 수 없는 비밀번호입니다.");

		}			
	}) 
	
	// 비밀번호 재입력 확인

	$('#inputAfterPasswordOneMore').keyup(function() { 
		
		var pwd1 = $('#inputAfterPassword').val();
		var pwd2 = $('#inputAfterPasswordOneMore').val();

		if(pwd1 == ""){
			// 아무것도 안한다.
		}
		else if(pwd1==pwd2){
			$('#pwdRevalArea').html("<span class='badge badge-pill badge-success'>✔</span> 동일한 비밀번호입니다.");
		} else {
			console.log(false)
			$('#pwdRevalArea').html("<span class='badge badge-pill badge-danger'>❌</span> 비밀번호가 다릅니다.");

		}			
	})
	
	// 변경 버튼
	$('#pwdChangeBtn').click(function(){
		
		var pwd1 = $('#inputAfterPassword').val();
		var pwd2 = $('#inputAfterPasswordOneMore').val();		
		
		if(pwd1 != pwd2){
			alert('비밀번호를 동일하게 입력하세요.')
		} else {
			$('#pwdfrm').submit();
		}
	})
	
	// 탭 내용 외부 연결
	$('a[data-toggle="tabs"]').click(function (e) {	
		var target = this.href.split('#');
		console.log(target[1]);
	    $('.nav-item a').filter("[data-target='#"+ target[1] + "']").tab('show');
	})
	
	// 코멘트 메뉴
	$('#editCommentPane').click(function(){
		alert('editCommentPane')
		$('#privacyTab').html(newPrivacyTab);
	});
	
	// 개인 로그 보기 메뉴
	$('#editPersonalLogPane').click(function(){
		alert('editPersonalLogPane')
		$('#privacyTab').html(newPrivacyTab2);
	});
			
	
 	// 원래 코드
	$("a[id *= 'resetOriginalPrivacyTab']").click(function() {
		console.log(originalPrivacyTab);
		$('#privacyTab').html(originalPrivacyTab);
	}) 
	
	// 체크박스
	$("input[id*='chkAllow']").change(toggleCheckAjax);
	 $('#chkAllowEmail').change(toggleCheckAjax);
	$('#chkAllowSms').change(toggleCheckAjax); 
	

	function toggleCheckAjax(){		
		var fieldName = $(this).attr('name');
		// alert('chkAllowEmail')
		
		$.ajax({
			url : "toggleProfileCheckbox.ajax",
			type : "get",
			data : {
				fieldName : fieldName
			}, // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
			success : function(response) {
				// console.log("AJAX Request 성공: ");
				console.log(response)
				if(parseInt(response) >= 1){
					console.log(response + " 받았습니다.")
					// 아무것도 안한다.
				} else {
					alert('실패');
					// 체크박스 액션 취소하기 코드를 넣는다./
				}
				
			},
			error : function() {
				console.log("에러 발생");
			},
			complete : function() {
				// console.log("AJAX 종료");
			}
		})
	}
	
})*/