<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
    <%@ include file="include/top.jsp"%>
    <link rel="stylesheet" type="text/css" href="resources/css/mypage.css">
    <!-- <script src="resources/js/mypage.js"></script> -->
    
    
    
    <!-- 스크립트 외부 파일로 빼는건 나중에 고칠 부분이 없을 정도로 완성되었을 때 하는걸로 부탁드립니다. 외부 파일로 빼면 갱신이 너무 느려서요.. -->
    <script>
    $(document).ready(function() {	
    		
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
    	
    /* 	$('#inputPassword1').keyup(function() { 
    		
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
    	}) */
    	
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
    			
    	
    /* 	// 원래 코드
    	$("a[id *= 'resetOriginalPrivacyTab']").click(function() {
    		console.log(originalPrivacyTab);
    		$('#privacyTab').html(originalPrivacyTab);
    	}) */
    	
    	// 체크박스
    	$("input[id*='chkAllow']").change(toggleCheckAjax);
    	/* $('#chkAllowEmail').change(toggleCheckAjax);
    	$('#chkAllowSms').change(toggleCheckAjax); */
    	

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
    	
    	$('#changeBizBtn').click(function(){
    		$('.modal-title').text('비즈니스 계정으로 전환')
    		/* $('.modal-body').html() */
    		 $(".modal").modal();
    		 
    	})
    	
    	if("${category}" == '1') {
    		$("#a1").attr("class", "nav-link mp");
    		$("#profileTab").attr("class","tab-pane fade");	
    		$("#a2").attr("class", "active nav-link mp");
    		$("#passwordTab").attr("class", "tab-pane fade show active");
    		
    	}else if("${category}" == '2') {
    		$("#a1").attr("class", "nav-link mp");
    		$("#profileTab").attr("class","tab-pane fade");	
    		$("#a3").attr("class", "active nav-link mp");
    		$("#emailTab").attr("class", "tab-pane fade show active");
    	}else if("${category}" == '3') {
    		$("#a1").attr("class", "nav-link mp");
    		$("#profileTab").attr("class","tab-pane fade");	
    		$("#a4").attr("class", "active nav-link mp");
    		$("#privacyTab").attr("class", "tab-pane fade show active");
    	}else if("${category}" == '4') {
    		$("#a1").attr("class", "nav-link mp");
    		$("#profileTab").attr("class","tab-pane fade");
    		$("#a5").attr("class", "active nav-link mp");
    		$("#bizProfile").attr("class", "tab-pane fade show active");
    		
    	}
    })
    
    </script>
    
    
    

<!-- 맨 처음 로딩될 때 나와야 하는 메시지 -->
<!-- 포워드로 할 경우 param. 제거 -->
<c:if test="${ param.pwdChangeResult ne null }">
	<c:if test="${ param.pwdChangeResult eq 1 }">
		<script>alert('패스워드가 변경되었습니다.')</script>
	</c:if>
	<c:if test="${ param.pwdChangeResult eq -1 }">
		<script>alert('이전 패스워드가 틀립니다.')</script>
	</c:if>
	<c:if test="${ param.pwdChangeResult eq 0 }">
		<script>alert('서버 오류로 패스워드 변경이 안됨')</script>
	</c:if>
</c:if>

<c:if test="${ param.editProfileResult ne null }">
	<c:choose>
		<c:when test="${ param.editProfileResult eq 1 }">
			<script>alert('회원 정보가 변경되었습니다.')</script>
		</c:when>
		<c:otherwise>
			<script>alert('회원 정보 변경에 실패했습니다.')</script>
		</c:otherwise>
	</c:choose>
</c:if>    
	<div class="py-5">
		<div class="container mywrap">
		<br>    
			<div class="row"> 
				<div class="col-4">
				<img class="rounded-circle" alt="Cinque Terre" width="40" height="35" src="AttachedMedia/${profile_pic}">
								&nbsp;&nbsp;&nbsp;
								<span class="profile-user-name " style="font-weight:bold;">${member.id}</span> 
								<c:if test="${ memberBiz ne null and memberBiz.id eq sessionScope.loginId }">
									<span class="badge badge-pill badge-warning">biz</span>
								</c:if>
					<ul class="nav nav-pills flex-column">
						<li class="nav-item"><a id="a1" href="#"
							class="active nav-link mp " data-toggle="pill"
							data-target="#profileTab" id="navi">프로필 편집</a></li>
						<li class="nav-item"><a id="a2" href="#" class="nav-link mp "
							data-toggle="pill" data-target="#passwordTab" id="navi">비밀번호 변경</a></li>
<!-- 						<li class="nav-item"><a href="#" class="nav-link mp text-muted" -->
<!-- 							data-toggle="pill" data-target="#tabthree" id="navi">허가된 앱</a></li> -->
						<li class="nav-item"><a id="a3" href="#" class="nav-link mp "
							data-toggle="pill" data-target="#emailTab" id="navi">이메일 및 SMS</a></li>
<!-- 						<li class="nav-item"><a class="nav-link mp text-muted" href="#" -->
<!-- 							data-toggle="pill" data-target="#tabfive" id="navi">연락처 관리</a></li> -->
						<li class="nav-item"><a id="a4" class="nav-link mp " href="#"
							data-toggle="pill" data-target="#privacyTab" id="navi" >공개 범위 및 보안</a></li>
							
						<c:if test="${ memberBiz ne null }">
							<li class="nav-item"><a id="a5" class="nav-link mp " href="#"
								data-toggle="pill" data-target="#bizProfile"><span class="badge badge-pill badge-warning">biz</span> 비즈니스 프로필</a></li>
						</c:if>
						
					</ul>
					
				</div>
				
				
				<!--  -->
				
				<div class="col-8" id="info">
					<div class="tab-content">
						<div class="tab-pane fade show active" id="profileTab" role="tabpanel">
						<br>
							<!-- profile form 시작 -->
							<h3 class="text-center" style="font-weight:bold;">프로필 편집</h3>
							<form action="editProfileProc.member" method="post">
<!-- 								<div class="form-group row in"> -->
<!-- 									<label for="example-text-input" class="col-2 col-form-label" style="font-weight:bold;">이름</label> -->
<!-- 									<div class="col-10"> -->
<!-- 										<input class="form-control edit" type="text" -->
<%-- 											value="${ member.name }" id="example-text-input" name="name" --%>
<!-- 											required>											 -->
<!-- 									</div> -->
<!-- 								</div> -->
									<div class="form-group">
					           <label for="nameField" style="font-weight:bold;" >이름</label>
					           <input type="text" class="form-control" id="nameField" value="${member.name}" name="name"> 
					        </div>
					        
					        <div class="form-group">
					           <label for="nicknameField" style="font-weight:bold;" >사용자 이름</label>
					           <input type="text" class="form-control" id="nicknameField" value="${member.nickname}" name="nickname"> 
					        </div>
					        
					         <div class="form-group">
					           <label for="websiteField" style="font-weight:bold;" >웹 사이트</label>
					           <input type="text" class="form-control" value="${ profile.website }" id="websiteField" name=website> 
					        </div>

								<!-- 소개 필드 -->
								 <div class="form-group"> 
     								 <label for="introduceArea" style="font-weight:bold;">소개</label>
     								 	<textarea class="form-control" id="introduceArea" rows="3" name=introduce>${ profile.introduce }</textarea>	
   								 </div>
   			
								<!-- 이메일 필드 -->
								<div class="form-group">		
									<label for="InputEmail1" style="font-weight:bold;">이메일</label>
										<input class="form-control" type="email" value="${ member.email }" id="InputEmail1" name="email">
									<div id='duplResultArea'></div>
								</div>

						
								
							<div class="form-group">
					           <label for="example-tel-input" style="font-weight:bold;" >전화번호</label>
					           <input type="text" class="form-control" id="example-tel-input" value="${ member.phone }" name="phone"> 
					        </div>
								
							<div class="form-group">
								<label for="custom-select edit" class="form-label" style="font-weight:bold;">성별</label>
										<!-- 성별따라 바뀌게 -->
										<select class="custom-select edit" name="gender">
											<option
												${ member.gender ne '남' && member.gender ne '여' ? 'selected' : '' }
												value="n">선택안함</option>
											<option ${ member.gender eq '남' ? 'selected' : ''} value="남">남성</option>
											<option ${ member.gender eq '여' ? 'selected' : ''} value="여">여성</option>
										</select>
							</div>
							
							
							<div class="form-group"> 
     							<label for="example-color-input" style="font-weight:bold;">색상</label>
     							<input class="form-control" id="example-color-input" type="color" value="#563d7c">	
   							</div>
								
								
							<div class="form-group text-center "> 
								<button type=submit class="btn btn-light text-dark" style="font-weight:bold;">제출</button>
								<button type=button class="btn btn-light text-dark" style="font-weight:bold;">계정을 일시적으로 비활성화</button>
								<c:if test="${ memberBiz eq null }">
									<button type=button class="btn btn-light text-dark" style="font-weight:bold;" id="changeBizBtn">비즈니스 계정으로 전환</button>
								</c:if>
								
							</div>		
									
						</form>
							<!-- profile form 끝 -->
						</div>
						
						
						<div class="tab-pane fade" id="passwordTab" role="tabpanel">
							<h3 class="text-center" style="font-weight:bold;">비밀번호 변경</h3>
							<div class="form-group">
								<form action='passwordChangeProc.member' method=post id=pwdfrm>
									<label for="inputBeforePassword" style="font-weight:bold;">이전 비밀번호</label> 
									<input type="password" class="form-control" id="inputBeforePassword" placeholder="Password" name=beforePassword>
									<br>
									<label for="inputAfterPassword" style="font-weight:bold;">새 비밀번호</label> 
									<input type="password" class="form-control" id="inputAfterPassword" placeholder="Password">
									<br>
									<label for="inputAfterPasswordOneMore" style="font-weight:bold;">새 비밀번호 확인</label> 
									<input type="password" class="form-control" id="inputAfterPasswordOneMore" placeholder="Password" name=pw>
									<div id=pwdRevalArea></div>
									<br>
									<div class="form-group text-center "> 
										<button type=submit class="btn btn-light text-dark" id="pwdChangeBtn" style="font-weight:bold;">비밀번호 변경</button>
									</div>		
								</form>
							</div>
							
						</div>
						
						
						
						<!-- 코멘트 설정 수정란 -->
						<div class="tab-pane fade" id="tabthree" role="tabpanel">
							<h3 style="font-weight:bold;">댓글 필터링</h3>
							<p id="p"><strong style="font-weight:bold;">키워드 필터</strong></p>
							<form>
							 	<div class="form-group">
							      <label for="exampleTextarea" style="font-weight:bold;">게시물에서 위에 입력한 단어나 문구가 포함된 댓글을 숨깁니다.</label>
							      <textarea placeholder="쉼표(,)로 구분하여 키워드를 추가하세요." class="form-control" id="exampleTextarea" rows="5" ></textarea>
							    </div>
							</form>
							 <div class="form-check">
						        <label class="form-check-label">
						          <input class="form-check-input" type="checkbox" name=is_allow_share value="y" id=chkAllowShare
						          ${ profile.is_allow_share eq 'y' ? 'checked' : '' }>
						           <strong style="font-weight:bold;">기본 키워드 사용</strong>
						        </label>
						        <p id="p"><small>게시물에서 자주 신고된 키워드가 포함된 댓글을 숨깁니다.</small></p>
						    </div>
						</div>
						<!-- -- -->
						
						
						<div class="tab-pane fade" id="emailTab" role="tabpanel">
							<h2 class="" style="font-weight:bold;">받아보기:</h2><br>
							 <div class="form-check">
						        <label class="form-check-label">
						          <input class="form-check-input" type="checkbox" name=is_allow_email id=chkAllowEmail value="y" 
									${ profile.is_allow_email eq 'y' ? 'checked' : '' }>
						           <strong style="font-weight:bold;">뉴스 이메일</strong>
						        </label>
						        <br>유용한 최신 정보를 빠짐없이 받아보세요.
						      </div><br>
						      <div class="form-check">
						        <label class="form-check-label">
						          <input class="form-check-input" type="checkbox" name=is_allow_sms value="y"  id=chkAllowSms
						          ${ profile.is_allow_sms eq 'y' ? 'checked' : '' }>
						           <strong style="font-weight:bold;">SMS 메시지</strong>
						        </label>
						        <br>SMS로 알림을 받아보세요.
						      </div><br>
						</div>
						
<!-- 						<div class="tab-pane fade" id="tabfive" role="tabpanel"> -->
<!-- 							<div class=row> -->
<!-- 								<div class=col-6> -->
<!-- 									<h1>계정 정보</h1> -->
<!-- 										<p>가입한 날짜<br><span class="text-muted">1800년 01월 01일</span></p> -->
<!-- 										<p>계정 공개 범위 변경 사항 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>비밀번호 변경 사항 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>이전 이메일 주소 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>이전 전화번호 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>생년월일<br><span class="text-muted">여기에 표시할 정보가 없습니다.</span></p> -->
<!-- 									<hr> hr은 나중에 공백으로 대체 -->
<!-- 									<h1>프로필 정보</h1> -->
<!-- 										<p>이전 사용자 이름 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>이전 이름 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>이전 소개 텍스트 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>소개의 이전 링크 <br><a href="#">모두 보기</a></p> -->
<!-- 								</div> -->
<!-- 								<div class=col-6> -->
<!-- 									<h1>연결관계</h1> -->
<!-- 										<p>현재 팔로우 요청 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>회원님을 팔로우하는 계정 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>팔로우하는 계정 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>팔로우하는 해시태그 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>회원님이 차단한 계정 <br><a href="#">모두 보기</a></p> -->
<!-- 										<hr> hr은 나중에 공백으로 대체 -->
<!-- 									<h1>활동</h1> -->
<!-- 										<p>로그인 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>로그아웃 <br><a href="#">모두 보기</a></p> -->
<!-- 										<p>검색 내역 <br><a href="#">모두 보기</a></p> -->
<!-- 										<hr> hr은 나중에 공백으로 대체 -->
<!-- 									<h1>광고</h1> -->
<!-- 										<p>광고 관심사 <br><a href="#">모두 보기</a></p> -->
<!-- 								</div> -->
								
<!-- 							</div> -->
<!-- 						</div> -->
						
						<div class="tab-pane fade" id="privacyTab" role="tabpanel">
							<h3 style="font-weight:bold;">계정 공개 범위: </h3>
							<br><div class="form-check">&nbsp;&nbsp;
						        <label class="form-check-label">
						          <input class="form-check-input" type="checkbox" name=is_allow_public value="n" id=chkAllowPublic
						          ${ profile.is_allow_public eq 'n' ? 'checked' : '' }>
						           <strong style="font-weight:bold;">비공개 계정</strong>
						        </label>
						        <p id="p"><small>계정이 비공개 상태인 경우 회원님이 승인한 사람만 SocialWired에서 회원님의 사진과 동영상을 볼 수 있습니다. 기존 팔로워는 영향을 받지 않습니다.</small></p>
						    </div>
						    <hr>
						    <h3 style="font-weight:bold;">활동 상태: </h3>
						    <br><div class="form-check">&nbsp;&nbsp;
						        <label class="form-check-label">
						          <input class="form-check-input" type="checkbox" name=is_allow_status value="y" id=chkAllowStatus
						          ${ profile.is_allow_status eq 'y' ? 'checked' : '' }>
						           <strong style="font-weight:bold;">활동 상태 표시</strong>
						        </label>
						        <p id="p"><small>SocialWired 앱에서 최근 활동한 시간 정보가 회원님이 팔로우하는 계정 및 메시지를 보낸 모든 사람에게 표시됩니다. 이 설정을 해제하면 다른 계정의 활동 상태를 볼 수 없습니다.</small></p>
						    </div>
						    <hr>
						    <h3 style="font-weight:bold;">스토리 공유: </h3>
						   <br><div class="form-check">&nbsp;&nbsp;
						        <label class="form-check-label">
						          <input class="form-check-input" type="checkbox" name=is_allow_share value="y" id=chkAllowShare
						          ${ profile.is_allow_share eq 'y' ? 'checked' : '' }>
						           <strong style="font-weight:bold;">공유 허용</strong>
						        </label>
						        <p id="p"><small>사람들이 회원님의 스토리를 메시지로 공유할 수 있습니다.</small></p>
						    </div>
						    <hr>
						    <!-- 댓글 설정 -->
						    <div>
						    	<h3 style="font-weight:bold;">댓글:</h3>
						    	<a class="nav-link mp text-muted" href="#" id="editCommentPane">댓글 설정 수정</a>
						    </div>
						    <!-- -- -->
						    <hr>
						     <!-- 내가 나온 사진 -->
						    <fieldset class="form-group">
						      <!-- <legend>Radio buttons</legend> -->
						      <h3 style="font-weight:bold;">내가 나온 사진: </h3>
						     <br> <div class="form-check">&nbsp;&nbsp;
						        <label class="form-check-label">
						          <input type="radio" class="form-check-input" name="optionsRadios" id="optionsRadios1" value="option1" checked="">
						          	자동으로 추가
						        </label>
						      </div>
						      <div class="form-check">
						      <label class="form-check-label">&nbsp;&nbsp;
						          <input type="radio" class="form-check-input" name="optionsRadios" id="optionsRadios2" value="option2">
						          	수동으로 추가
						        </label>
						      </div>
						      
						    </fieldset>
						    <!-- -- -->
						    <hr>
						      <!-- 계정 데이터 설정 -->
						    <div>
						    	<h3 style="font-weight:bold;">계정 데이터: </h3>
						    	<a href="#" class="nav-link mp text-muted" href="#" id="editPersonalLogPane">계정 데이터 보기</a>
						    </div>
						    <!-- -- -->
						    <hr>
						 <h3 style="font-weight:bold;">2단계 인증: </h3>
						<div class="form-check">							
					        <br><label class="form-check-label">&nbsp;&nbsp;    
					          <input class="form-check-input" type="checkbox" name=is_allow_login2 value="y" id=chkAllowLogin2
					          ${ profile.is_allow_login2 eq 'y' ? 'checked' : '' }>
					           <strong style="font-weight:bold;">보안 코드 필요</strong>
					        </label>
					        <p id="p"><small>이 옵션을 설정하면 회원님이 로그인한 것이 맞는지 확인해야 할 때 보안 코드가 전송됩니다.</small></p>
						  </div>
						 <hr>
						 
						</div>
						
						<c:if test="${ memberBiz ne null }">
							<div class="tab-pane fade" id="bizProfile" role="tabpanel">

								<!-- business form 시작 -->
							<h3 class="text-center" style="font-weight:bold;">비즈니스 프로필 편집</h3>
							<small>비즈니스 도구에 오신 것을 환영합니다. 고객이 프로필에 있는 버튼을 통해 바로 연락할 수 있도록 휴대폰 번호, 이메일 또는 위치정보를 추가하세요. 게시물을 홍보하여 비즈니스 성장을 도모할 수 있습니다.
							<br><br>비즈니스 프로필에 입력된 정보는 일반 프로필 정보와는 별도로 취급됩니다.</small>
							<hr>
							 
							<form action="updateBizProfileProc.member" method="post">

					         <div class="form-group">
					           <label for="websiteField" style="font-weight:bold;" >비즈니스 웹 사이트</label>
					           <input type="text" class="form-control" value="${ memberBiz.bizWebsite }" id="bizWebsiteField" name=bizWebsite> 
					        </div>

								 <div class="form-group"> 
     								 <label for="introduceArea" style="font-weight:bold;">비즈니스 이메일</label>
     								 <input type="email" class="form-control" value="${ memberBiz.bizEmail }" id="bizEmailField" name=bizEmail> 	
   								 </div>
   			
								<div class="form-group">		
									<label for="InputEmail1" style="font-weight:bold;">비즈니스 전화번호</label>
										<input class="form-control" type="tel" value="${ memberBiz.bizPhone }" id="bizPhoneField" name="bizPhone">
									<div id='duplResultArea'></div>
								</div>						
							<hr>
							 <input class="form-check-input" type="checkbox" name='isAllowEnterProfile' value="n" id=bizChkXXXXX ${ memberBiz.isAllowEnterProfile eq 'n' ? 'checked' : '' }>
							<strong style="font-weight:bold;">타임라인 광고에서 프로필 페이지에서 불허</strong><br>
						     <small>타임라인 광고에서 프로필 링크를 불허합니다(?) 비공개 계정 설정과는 다르며 공개 계정인 경우 프로필 페이지로 접속할 수 있습니다.</small>
				
						     <hr>
								잔액 결제하기: 돈이 있어야 광고를 하죠? 현재 잔액은 ￦<fmt:formatNumber>${ memberBiz.deposit }</fmt:formatNumber> 입니다. 
								<button type=button>결제하기</button>
								
							<hr>
								
							<div class="form-group text-center "> 
								<button type=submit class="btn btn-light text-dark" style="font-weight:bold;">제출</button>
								<button type=button class="btn btn-light text-dark" style="font-weight:bold;">일반 계정으로 전환</button>
								
							</div>		
									
						</form>
							<!-- business form 끝 -->

	 						</div>							
						</c:if>
												
						  
						
					</div>
				</div>
			</div>
			<br>
		</div>
		<br>
	</div>
	
													<div class="modal">
													  <div class="modal-dialog" role="document">
													    <div class="modal-content">
													      <div class="modal-header">
													        <h5 class="modal-title">Modal title</h5>
													        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
													          <span aria-hidden="true">&times;</span>
													        </button>
													      </div>
													      <div class="modal-body">
													      	<table style="padding: 4px">
													      		<tr>
													      			<td style="width: 23%"><img src=resources/images/business.png width=100 height=100></td>
													      			<td style="width: 77%"><p>비즈니스 도구에 오신 것을 환영합니다. <br><br>고객이 프로필에 있는 버튼을 통해 바로 연락할 수 있도록 휴대폰 번호, 이메일 또는 위치정보를 추가하세요. <br><br>게시물을 홍보하여 비즈니스 성장을 도모할 수 있습니다.</p></td>
													      		</tr>
													      	</table>
													        
													      </div>
													      <div class="modal-footer">
													      	<form action='changeBizAccount.profile' method=post>
													        	<button type="submit" class="btn btn-primary">비즈니스 계정으로 전환</button>
													        </form>
													        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
													      </div>
													    </div>
													  </div>
													</div>
	<%@ include file="include/bottom.jsp"%>