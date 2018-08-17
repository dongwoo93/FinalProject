<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
    <!-- <link rel="stylesheet" type="text/css" href="resources/css/mypage.css"> -->
    <style>
    	
/*!
* Based on Bootstrap v4.0.0 (https://getbootstrap.com) 
 */
 
// Options
// 
// Quickly modify global styling by enabling or disabling optional features.
  
$enable-rounded:            true !default;
$enable-shadows:            true;
$enable-transitions:        true;
$enable-hover-media-query:  false;
$enable-grid-classes:       true;
$enable-print-styles:       true;

// Variables
//
// Colors

$theme-colors: (
  primary: #12bbad,
  secondary: #4f70ce,
  light: #f3f3f3,
  dark: #151515,
  info: #ccc,
  success: #28a745,
  warning: #ffc107,
  danger: #dc3545
);

$body-bg: white;
$body-color: #333;


$body-color-inverse: invert($body-color) !default;
$link-color: #12bbad;

// Fonts
$font-family-base: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
$headings-font-family: $font-family-base;
$display-font-family: $font-family-base;
$font-weight-normal: 200;
$headings-font-weight: 200;
$lead-font-size:   1.30rem;

$spacer: 1.5rem;

@import 'bootstrap-4.0.0';

 
html,body {
   height:100%;
    
}

.cover {
  min-height:100%;
  display:flex;
  align-items:center;
  

}


.bg-gradient {
  overflow: hidden;
  color: color-yiq(map-get($theme-colors, 'primary'));
  background: linear-gradient(-30deg, theme-color("secondary") 0%, theme-color("primary") 50%, theme-color("primary") 100%);
}

.filter-dark {
  overflow: hidden;
  position: relative;
  color: color-yiq(map-get($theme-colors, 'dark'));
	&:before {
    position: absolute;
    top:0px;
    left:0px;
    width:100%;
    height: 100%;
    content: ' ';
    background: rgba(map-get($theme-colors, 'dark'), 0.75);
  }
}

.filter-light {
  overflow: hidden;
  position: relative;
  color: color-yiq(map-get($theme-colors, 'light'));
	&:before {
    position: absolute;
    top:0px;
    left:0px;
    width:100%;
    height: 100%;
    content: ' ';
    background: rgba(map-get($theme-colors, 'light'),0.75);
  }
}

.filter-color {
  overflow: hidden;
  position: relative;
  color: color-yiq(map-get($theme-colors, 'primary'));
	&:before {
    position: absolute;
    top:0px;
    left:0px;
    width:100%;
    height: 100%;
    content: ' ';
    background: rgba(map-get($theme-colors, 'primary'), 0.75);
  }
}

.filter-gradient {
  overflow: hidden;
  position: relative;
  color: color-yiq(map-get($theme-colors, 'primary'));
	&:before {
    position: absolute;
    top:0px;
    left:0px;
    width:100%;
    height: 100%;
    content: ' ';
    background: linear-gradient(-30deg, transparentize(theme-color("secondary"), 0.1) 0%, transparentize(theme-color("primary"), 0.1) 50%, transparentize(theme-color("primary"), 0.05) 100%);
  }
}

.filter-fade-in {
  overflow: hidden;
  position: relative;
  &:before {
    position: absolute;
    top:0px;
    left:0px;
    width:100%;
    height: 100%;
    content: ' ';
    background: linear-gradient($body-bg, transparentize($body-bg, 0.2),transparentize($body-bg, 0.9),transparentize($body-bg, 1));
	}
}

.tab-pane p {
	font-size: 20px;
	border : 1px solid black;
}

.nav-item .mp {
	font-size: 20px;
	margin-top: 20px;

}

.tab-content > .active {
    display: block;
    margin-top: 0px;
    font-size: 17px;
  
}

.edit {
	font-size: 12px;
}

.in {
	padding-top: 15px;

}

.mywrap {
	border: 2px solid #ccc;
	

}
.rounded-circle{
	align : center;
	
}
.col-4{
/* 	border: 2px solid #ccc; */

}
	.profile-user-name {
		display: inline-block;
		font-size: 2.2rem;
		font-weight: 300;
		font-family: "Open Sans", Arial, sans-serif;
	}

	#navi{
		
		font-weight : bold;
	}
	
	#resetOriginalPrivacyTab{
	
		font-weight : bold;
	}
	#passwordTab{
		margin-top : 22px;
		font-family: "Open Sans", Arial, sans-serif;
	}
	
	#tabthree{		
		
		font-family: "Open Sans", Arial, sans-serif;
	}
	#emailTab{
		margin-top : 60px;
		font-family: "Open Sans", Arial, sans-serif;
	}
	
	#privacyTab{
		margin-top : 0px;
		font-family: "Open Sans", Arial, sans-serif;
	}
	
	
	#p{
	 border: 2px solid #ccc;
	 padding : 5px;
	 font-family: "Open Sans", Arial, sans-serif;
	}
    </style>
    
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
    <!-- <script src="resources/js/mypage.js"></script> -->
    
    
    
    <!-- 스크립트 외부 파일로 빼는건 나중에 고칠 부분이 없을 정도로 완성되었을 때 하는걸로 부탁드립니다. 외부 파일로 빼면 갱신이 너무 느려서요.. -->
    <script>
    $(document).ready(function() {	
    		
    		var originalPrivacyTab = $('#privacyTab').html();
    		var newPrivacyTab = $('#tabthree').html();
    		var newPrivacyTab2 = $('#tabfive').html();
    		
    		// 탭 내용 외부 연결			
    	    $('.nav-item a').filter("[data-target='#${ param.targetTab }']").tab('show');		
    		

    	
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
    	
    	$('[data-toggle="popover"]').popover({container: "body"});
    	
    	$('a[id*="popBoard"]').focus(function(){
    		var elem = $(this)
    		var seq = $(this).attr('id').replace('popBoard', '').split('_');
    		/* console.log(seq[0]);
    		console.log(seq[1]); */
    		
    		
    		$.ajax({
    			url : "getOneArticle.ajax",
    			type : "get",
    			data : {
    				seq : seq[1]
    			}, // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
    			success : function(response) {
    				// console.log(response.contents)
    				$(elem).attr('data-original-title', seq[0] + " | " + seq[1] + " | " + response.id + " | " + response.writedate)
    			   	$(elem).attr('data-content', response.contents)
    			},
    			error : function() {
    				console.log("에러 발생");
    			},
    			complete : function() {
    				// console.log("AJAX 종료");
    			}
    		}) // $AJAX 끝
    	})
    	
    	  $('a[id*="popComment"]').focus(function(){
    		var elem = $(this)
    		var seq = $(this).attr('id').replace('popComment', '').split('_');
    		/* console.log(seq[0]);
    		console.log(seq[1]);
    		console.log(seq[2]); */
    		
    		
    		$.ajax({
    			url : "getOneComment.ajax",
    			type : "get",
    			data : {
    				board_seq : seq[1],
    				comment_seq : seq[2]
    			}, // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
    			success : function(response) {
    				console.log(response)
    				var outputTitle = seq[0] + " | " + seq[2] + " | " + response[1].id + " | " + response[1].writedate;
    				
    				var outputText = response[1].comment_contents;
    				outputText += "<a>ee</a>"
    				outputText += "링크 안먹힘.."
    				
    				$(elem).attr('data-original-title', outputTitle)
    				$(elem).attr('data-content', outputText)
    			},
    			error : function() {
    				console.log("에러 발생");
    			},
    			complete : function() {
    				// console.log("AJAX 종료");
    			}
    		}) // $AJAX 끝
    	})
    	
    	/*파이 차트*/
    	$("#chartContainer").CanvasJSChart({ 
		title: { 
			text: "Worldwide Smartphone sales by brand - 2012",
			fontSize: 24
		}, 
		axisY: { 
			title: "Products in %" 
		}, 
		legend :{ 
			verticalAlign: "center", 
			horizontalAlign: "right" 
		}, 
		data: [ 
		{ 
			type: "pie", 
			showInLegend: true, 
			toolTipContent: "{label} <br/> {y} %", 
			indexLabel: "{y} %", 
			dataPoints: [ 
				{ label: "Samsung",  y: 0, legendText: "Samsung"}, 
				{ label: "Apple",    y: 19.1, legendText: "Apple"  }, 
				{ label: "Huawei",   y: 4.0,  legendText: "Huawei" }, 
				{ label: "LG",       y: 3.8,  legendText: "LG Electronics"}, 
				{ label: "Lenovo",   y: 33.5,  legendText: "Lenovo" }, 
				{ label: "Others",   y: 39.6, legendText: "Others" } 
			] 
		} 
		] 
	}); 
    	

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
				<img src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces"
								class="rounded-circle" alt="Cinque Terre" width="40" height="35">
								&nbsp;&nbsp;&nbsp;
								<span class="profile-user-name " style="font-weight:bold;">${member.id}</span>
					<ul class="nav nav-pills flex-column">
						<li class="nav-item"><a href="#"
							class="active nav-link mp " data-toggle="pill"
							data-target="#reportMain" style="font-weight:bold;" id="navi">리포트 통계 Ⅰ</a></li>
						<li class="nav-item"><a href="#" class="nav-link mp "
							data-toggle="pill" data-target="#reportCode" id="navi">리포트 통계 Ⅱ</a></li>
<!-- 						<li class="nav-item"><a href="#" class="nav-link mp text-muted" -->
<!-- 							data-toggle="pill" data-target="#tabthree" id="navi">허가된 앱</a></li> -->
						<li class="nav-item"><a href="#" class="nav-link mp "
							data-toggle="pill" data-target="#resultCode" id="navi">리포트 통계 Ⅲ</a></li>
 						<li class="nav-item"><a class="nav-link mp" href="#" 
 							data-toggle="pill" data-target="#tabfive" id="navi">Code Legends</a></li> 
					<!-- 	<li class="nav-item"><a class="nav-link mp " href="#"
							data-toggle="pill" data-target="#reportLog" id="resetOriginalPrivacyTab" >과거 기록 열람</a></li> -->
					</ul>
					
				</div>
				
				
				<!--  -->
				
				<div class="col-8" id="info">
					<div class="tab-content">
						<div class="tab-pane fade show active" id="reportMain" role="tabpanel">
						<br>
							<!-- <h3 class="text-center" style="font-weight:bold;">리포트 통계</h3> -->
							<div id="chartContainer" style="width: 100%; height: 300px"></div>
						</div>
						
						
						<div class="tab-pane fade" id="reportCode" role="tabpanel">
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
						
						
						<div class="tab-pane fade" id="resultCode" role="tabpanel">
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
					
						
						<div class="tab-pane fade" id="reportLog" role="tabpanel">
							<h3 style="font-weight:bold;">계정 공개 범위: </h3>
							<br><div class="form-check">&nbsp;&nbsp;
						        <label class="form-check-label">
						          <input class="form-check-input" type="checkbox" name=is_allow_public value="y" id=chkAllowPublic
						          ${ profile.is_allow_public eq 'y' ? 'checked' : '' }>
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
						
						  
						
					</div>
				</div>
			</div>
			<br>
			<div>
				<table class="table table-hover">
							  <thead>
							    <tr class="table-warning">
							      <th scope="col">No.</th>
							      <th scope="col">리포트 종류</th>
							      <th scope="col">Board No.</th>
							      <th scope="col">Comment No.</th>
							      <th scope="col">Reported Date</th>
							      <th scope="col">Reporter's Comment</th>
							      <th scope="col">조회일</th>
							      <th scope="col">처리일</th>
							      <th scope="col">처리 결과</th>
							      <th scope="col">관리자 코멘트</th>
							      <th scope="col">작업</th>
							    </tr>
							  </thead>
							  <tbody>
							  
							  <c:forEach var="i" items="${ list }" varStatus="k">
							  	<tr>
							      <th scope="row">${ i.reportSeq }</th>
							      <td>${ i.reportCode }: ${code[k.index].reportCodeDescription}</td>
							      <td><a href="#;return false;" id='popBoard${ i.reportSeq }_${ i.boardSeq }' title="" data-container="body" data-toggle="popover" data-placement="top" data-content="내용 표시" data-original-title="타이틀 표시" aria-describedby="popover371932">${ i.boardSeq }</a></td>
							      <td>
							      	<c:choose>
							      		<c:when test="${ i.commentSeq eq 0 }">-</c:when>
							      		<c:otherwise>
							      			<a href="#;return false;"  id='popComment${ i.reportSeq }_${ i.boardSeq }_${ i.commentSeq }' title="" data-container="body" data-toggle="popover" data-placement="top" data-content="내용 표시" data-original-title="타이틀 표시" aria-describedby="popover371932">${ i.commentSeq }</a>
							      		</c:otherwise>
							      	</c:choose>
							      		
							      	</td>
							      <td>${ i.reportedDate }</td>
							      <td>${ i.reportersComment }</td>
							      <td>${ i.adminFirstReadDate }</td>
							      <td>${ i.adminAcceptedDate }</td>
							      <td>${ i.resultCode }: ${ result[k.index].resultDescription }</td>
							      <td>${ i.adminComment }</td>
							      <td><a href="#;return false;">처리</a></td>
							    </tr>
							  </c:forEach>
					
							 
							  </tbody>
							</table>
			</div>
		</div>
		<br>
	</div>
	<%@ include file="include/bottom.jsp"%>