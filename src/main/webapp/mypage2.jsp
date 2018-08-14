<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
    <link rel="stylesheet" type="text/css" href="resources/css/mypage.css">
    <script src="resources/js/mypage.js"></script>

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
							data-target="#profileTab" style="font-weight:bold;" id="navi">프로필 편집</a></li>
						<li class="nav-item"><a href="#" class="nav-link mp "
							data-toggle="pill" data-target="#passwordTab" id="navi">비밀번호 변경</a></li>
<!-- 						<li class="nav-item"><a href="#" class="nav-link mp text-muted" -->
<!-- 							data-toggle="pill" data-target="#tabthree" id="navi">허가된 앱</a></li> -->
						<li class="nav-item"><a href="#" class="nav-link mp "
							data-toggle="pill" data-target="#emailTab" id="navi">이메일 및 SMS</a></li>
<!-- 						<li class="nav-item"><a class="nav-link mp text-muted" href="#" -->
<!-- 							data-toggle="pill" data-target="#tabfive" id="navi">연락처 관리</a></li> -->
						<li class="nav-item"><a class="nav-link mp " href="#"
							data-toggle="pill" data-target="#privacyTab" id="resetOriginalPrivacyTab" >공개 범위 및 보안</a></li>
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
					           <label for="example-text-input" style="font-weight:bold;" >이름</label>
					           <input type="text" class="form-control" id="example-text-input" value="${member.name}" name="name"> 
					        </div>
					        
					        <div class="form-group">
					           <label for="example-text-input" style="font-weight:bold;" >사용자 이름</label>
					           <input type="text" class="form-control" id="example-text-input" value="${member.nickname}" name="nickname"> 
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
		</div>
		<br>
	</div>
	<%@ include file="include/bottom.jsp"%>