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
    	
    		var globalChartNumber = 1;
    		
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
    	

    	// 작업 처리
    	$("a[id*='dealReport_']").click(function(){
    		var managerComment = prompt($(this).attr('title') + " | " + "처리 코멘트 입력(없을 경우 확인 버튼 클릭) ");
    		var reportSeq = $(this).attr('id').replace("dealReport_", "");
    		var resultCode = $(this).attr('title').split(":")[0]
    		console.log( reportSeq + managerComment + resultCode );
    		
    		$.ajax({
    			url : "manageAnReport.ajax",
    			type : "post",
    			data : {
    				reportSeq : reportSeq,
    				managerComment : managerComment,
    				resultCode : resultCode
    			}, // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
    			success : function(response) {
    				console.log(response)
    				location.reload();
    			},
    			error : function() {
    				console.log("에러 발생");
    			},
    			complete : function() {
    				// console.log("AJAX 종료");
    			}
    		}) // $AJAX 끝
    	});
    	
    	$('[data-toggle="popover"]').popover({container: "body"});
    	
        	
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
    	
    	// 보드 클릭
    	$('a[id*="popBoard"]').click(function(){
    		var seq = $(this).attr('id').replace('popBoard', '').split('_');
    		$.ajax({
    			type: "get",
                url: "boardView.bo",
                data: {seq : seq[1]},
                success: function(response) {
                	console.log(response[0])
                	$(".modal-title").text(seq[0] + " | " + seq[1] + " | " + response[0].id + " | " + response[0].writedate)
                	var bodyStr = "<p>" + response[0].contents + "</p>";
                	for(item in response[1]){
                		bodyStr += "<img src='AttachedMedia/" + response[1][item].system_file_name + "' style='width: 400px;'>";
                	}                	
                	$(".modal-body").html(bodyStr)
                	console.log(response[1])
                },
                error : function() {
                	$(".modal-title").text("삭제된 것 같습니다.");
                	$(".modal-body").text("글을 찾을 수 없습니다.")
    			},
    			complete : function() {
    				// console.log("AJAX 종료");
    			}
    		});
    		$("#boardmodal").modal();
    	})
    	
    	$('a[id*=stat]').click(function(){
    		/* alert($(this).attr("id")) */
    		globalChartNumber = $(this).attr("id").replace("stat", "");    		
    		
    		$.ajax({
    			url : "chartRenew.ajax",
    			type : "get",
    			data : {
    				chart: globalChartNumber
    			}, // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
    			success : function(response) {
    				// console.log(response)
    				var chart = $("#chartContainer").CanvasJSChart(); 
    			
    	    		chart.options.data[0].dataPoints = response;    		 
    	    		chart.render();
    				
    			},
    			error : function() {
    				console.log("에러 발생");
    			},
    			complete : function() {
    				// console.log("AJAX 종료");
    			}
			})
    		
    	})
    	
	
		    	/*파이 차트*/
		/*     $("#chartContainer").CanvasJSChart({ 
				title: { 
					text: "Reports Stats",
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
					type: "doughnut", 
					showInLegend: true, 
					toolTipContent: "{label} <br/> {y} 건", 
					indexLabel: "{y} 건", 
					// label: 원 안에서 보이는 것
					dataPoints: ${pieChartObject}/* [ 
						{ label: "스팸",  y: 1, legendText: "1: 스팸"}, 
						{ label: "음란물",  y: 0, legendText: "2: 나체, 음란물"},
						{ label: "편파적 발언",    y: 1, legendText: "3: 편파적 발언"  }, 
						{ label: "폭력",  y: 0, legendText: "4: 폭력, 위협"},
						{ label: "마약",  y: 1, legendText: "5: 마약"},
						{ label: "따돌림",  y: 0, legendText: "6: 괴롭힙 및 따돌림"},
						{ label: "재산권 침해",  y: 0, legendText: "7: 지적재산권 침해"},
						{ label: "자해",   y: 0, legendText: "8: 자해" } 
					]  
				} 
				] 
			});    */  
    	

    	
    	
    	// chartRenew
		setInterval(function(){			
			$.ajax({
    			url : "chartRenew.ajax",
    			type : "get",
    			data : {
    				chart: globalChartNumber
    			}, // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
    			success : function(response) {
    				// console.log(response)
    				var chart = $("#chartContainer").CanvasJSChart();     		 
    	    		chart.options.data[0].dataPoints = response;    		 
    	    		chart.render();
    				
    			},
    			error : function() {
    				console.log("에러 발생");
    			},
    			complete : function() {
    				// console.log("AJAX 종료");
    			}
			})
    	}, 30000)
    	
    	
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
							class="nav-link mp " data-toggle="pill"
							data-target="#reportMain" style="font-weight:bold;" id="stat1">광고 통계 Ⅰ</a></li>
						<li class="nav-item"><a href="#" class="nav-link mp "
							data-toggle="pill" data-target="#reportMain" id="stat2">광고 통계 Ⅱ</a></li>
<!-- 						<li class="nav-item"><a href="#" class="nav-link mp text-muted" -->
<!-- 							data-toggle="pill" data-target="#tabthree" id="navi">허가된 앱</a></li> -->
<!-- 						<li class="nav-item"><a href="#" class="nav-link mp "
							data-toggle="pill" data-target="#resultCode" id="stat3">리포트 통계 Ⅲ</a></li>
 						<li class="nav-item"><a class="nav-link mp" href="#" 
 							data-toggle="pill" data-target="#tabfive" id="stat4">Code Legends</a></li>  -->
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
							<div id="chartContainer2" style="width: 100%; height: 100%"></div>
						</div>
						
						
						
						<div class="tab-pane fade" id="tabthree" role="tabpanel">
							<div></div>
						</div>
						<!-- -- -->
						
						
						<div class="tab-pane fade" id="resultCode" role="tabpanel">
							<div></div>
						</div>
					
						
						<div class="tab-pane fade" id="reportLog" role="tabpanel">
							<div></div>
						 
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
							      <th scope="col">Board No.</th>
							      <th scope="col">Attached URL</th>
							      <th scope="col">상품 판매 목적?</th>
							      <th scope="col">URL 클릭수</th>
							      <th scope="col" title="1회 노출 당 비용(Cost Per One)">CPO</th>
							      <th scope="col" title="1회 클릭 당 비용(Cost Per Click)">CPC</th>
							      <th scope="col">잔여 노출수</th>
							      <th scope="col">심사결과</th>
							      <th scope="col">코멘트</th>
							      <th scope="col">작업</th>
							    </tr>
							  </thead>
							  <tbody>
							  
							  <c:forEach var="i" items="${ bList }" varStatus="k">
							  	<tr>
							      <th scope="row">${ i.boardBizSeq }</th>
							      <%-- <td>${ i.boardSeq }</td> --%>
							      <td><a href="#;return false;" id='popBoard${ i.boardBizSeq }_${ i.boardSeq }'>${ i.boardSeq }</a></td>
							      <td><a href="${ i.moreInfoWebsite }" target=_blank>바로가기</a></td>
							      <td>${ i.isWebsitePurposeOfPurchase eq 'y' ? '네' : '아니오' }</td>
							      <td>${ i.clickCount }</td>
							      <td>${ i.costPerMille }</td>
							      <td>${ i.costPerClick }</td>
							      <td>${ i.remainedPublicExposureCount }</td>
							      <td>${ i.isAllowed }</td>
							      <td>${ i.rejectedMessage }</td>						      
							      <td><a href='#'>허용</a> | <a href='#'>거부</a></td>
							    </tr>
							  </c:forEach>
					
							 
							  </tbody>
							</table>
			</div>
											<div class="modal" id=boardmodal>
											  <div class="modal-dialog" role="document" >
											    <div class="modal-content">
											      <div class="modal-header">
											        <h5 class="modal-title">Modal title</h5>
											        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
											          <span aria-hidden="true">&times;</span>
											        </button>
											      </div>
											      <div class="modal-body">
											        <p>Modal body text goes here.</p>
											      </div>
											      <div class="modal-footer">
											        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
											        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
											      </div>
											    </div>
											  </div>
											</div>
		</div>
		<br>
	</div>
	<%@ include file="include/bottom.jsp"%>