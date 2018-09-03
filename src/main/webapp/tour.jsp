<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/tour.css">
<script src="resources/js/top.js"></script>
<script> var currentId = "${sessionScope.loginId}"; </script>
<script src="resources/js/timeline.js"></script>
	
	<script>
/* 좋아요 Script */
function likeit(e) {
	var board_seq = $(e).attr("value");
	$.ajax({
		url : "like.bo",
		type : "get",
		data : {
			board_seq : board_seq,
			id : "${sessionScope.loginId}",
			is_liked : "y"
		},
		success : function(resp) {
			console.log("들어왔니" +resp);
			$(e).next().show();
			$(e).hide(); 
			/* 좋아요 카운트 */
			if(resp != 0) {
				$("#count"+board_seq).text(resp + "명이 좋아합니다");
			}else {
				$("#count"+board_seq).text("");
			}
			
		},  
		error : function() {
			console.log("에러 발생!");
			}
		})
}

function unlikeit(e) {
	var board_seq = $(e).attr("value");
	$.ajax({
		url : "like.bo",
		type : "get",
		data : {
			board_seq : board_seq,
			id : "${sessionScope.loginId}",
			is_liked : "n"
		},
		success : function(resp) {
			console.log(resp);  
			$(e).prev().show();
			$(e).hide(); 
			/* 좋아요 카운트 */
			if(resp != 0) {
				$("#count"+board_seq).text(resp + "명이 좋아합니다");
			}else {
				$("#count"+board_seq).text("");
			}
			
		},
		error : function() {
			console.log("에러 발생!");
			}
		})
}
/* 북마크 Script */
function markit(e) {
    	var board_seq = $(e).attr("value");
    	$.ajax({
    		url : "bookmark.bo",
    		type : "get",
    		data : {
    			board_seq : board_seq,
    			id : "${sessionScope.loginId}",
    			is_marked : "y"
    		},
    		success : function(resp) {
    			$(e).next().show();
    			$(e).hide();
    		},
    		error : function() {
    			console.log("에러 발생!");
    			}
    		})
    }

function unmarkit(e) {
    	var board_seq = $(e).attr("value");
    	$.ajax({
    		url : "bookmark.bo",
    		type : "get",
    		data : {
    			board_seq : board_seq,
    			id : "${sessionScope.loginId}",
    			is_marked : "n"
    		},
    		success : function(resp) {
    			$(e).prev().show();
    			$(e).hide();	
    		},
    		error : function() {
    			console.log("에러 발생!");
    			}
    		})
    }

</script>

<div class="dropdown">
	<div class="dropdown-divider" id="tagmenu"></div>
		<label class="top" style="font-size: 12px;font-family: NANUMBARUNPENR !important;">
			<c:choose>
				<c:when test="${pageName eq '/tour.bo'}">
					둘러보기
				</c:when>
				<c:when test="${pageName eq '/search.bo'}">
					검색 결과: #${ param.search }
				</c:when>
				<c:otherwise>
					글쎄요.. 뭘까요?
				</c:otherwise>
			</c:choose>
		</label>
		<c:if test="${pageName eq '/tour.bo'}">
			<button class="btn btn-light text-dark dropdown-toggle down" type="button" id="dropdownMenuButton" 
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${category}</button>
			<div class="dropdown-divider" id="tagmenu"></div>
				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a href="tour.bo?cat=1" class="dropdown-item" style="cursor: pointer;font-family: NANUMBARUNPENR !important;font-size: 14px;width:150px;"><i class="fas fa-newspaper mr-1 pr-1 fa-1x"></i>최신글</a>
				<div class="dropdown-divider"></div>
				<a href="tour.bo?cat=2" class="dropdown-item" style="cursor: pointer;font-family: NANUMBARUNPENR !important;font-size: 14px;"><i class="fas fa-heart mr-1 pr-1 fa-1x"></i>좋아요</a>
				<div class="dropdown-divider"></div>
				<a href="tour.bo?cat=3" class="dropdown-item" style="cursor: pointer;font-family: NANUMBARUNPENR !important;font-size: 14px;"><i class="fas fa-tags mr-1 pr-1 fa-1x"></i>인기 태그 순</a>
				</div>
		</c:if>
		
</div>


<!-- 카드 DIV -->
<div id="contents">	
	<c:choose>
			<c:when test="${result.size() < 4}">
				<div id=deck class="card-deck"  style=" width: 600px;">
			</c:when>
				<c:otherwise>
					<div id=deck class="card-columns">
				</c:otherwise>
	</c:choose>
	
<c:forEach var="result" items="${result}" varStatus="status">
		<div class="card" id="card">
			<h4 class="card-title" id="tourTop">
			
			<c:choose>
					<c:when test="${profile_pic.containsKey(result.id)}">
                  
                  <img src="AttachedMedia/<c:out value='${profile_pic[result.id]}'/>" alt="Card image cap" width="30" height="30" class="rounded-circle">
                     
                  </c:when>
                  <c:otherwise>
                     <img src="resources/images/standard.jpg" alt="Card image cap" width="30" height="30" class="rounded-circle">
                  </c:otherwise>
					</c:choose>
				  
				
					<a id="ids" href="board.bo?id=${result.id}&cat=1">${result.id}</a>
					<!-- 북마크 -->
						<c:choose> 
										<c:when test="${bookmark.containsKey(result.board_seq)}">

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" style="display: none;"
													onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4;" id="markcancel"
													class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>  

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4; display: none;"
													id="markcancel" class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:otherwise>
									    </c:choose>   
						<!-- 좋아요 -->
							<c:choose>
								<c:when test="${result3.containsKey(result.board_seq)}">
									<i value="${result.board_seq}" style="cursor: pointer; display: none;" 
										id="likeit" class="far fa-heart icon mr-1" onclick="likeit(this)">
									</i>
									<i value="${result.board_seq}" style="color: red; cursor: pointer;" 
										id="likecancel" class="fas fa-heart" onclick="unlikeit(this)">
									</i>
									<!-- 좋아요 카운트 -->
									<c:choose>
										<c:when test="${result4[result.board_seq] != null}">
											<p id="p">
												<i value="${result.board_seq}" id="count${result.board_seq}">
												<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다</i>
											</p>
										</c:when>
											<c:otherwise>
												<p id="p">
													<i value="${result.board_seq}" id="count${result.board_seq}">
													<c:out value="${result4[result.board_seq]}"/></i>
												</p>
											</c:otherwise>
									</c:choose>
								</c:when>
									<c:otherwise>   
										<i value="${result.board_seq}" style="cursor: pointer;" 
											id="likeit" class="far fa-heart icon mr-1" 
											onclick="likeit(this)">
										</i>
			                   			<i value="${result.board_seq}" style="color: red; display: none; cursor: pointer;" 
			                   				id="likecancel" class="fas fa-heart" 
			                   				onclick="unlikeit(this)">
			                   			</i>
										<!-- 좋아요 카운트 -->
										<c:choose>
											<c:when test="${result4[result.board_seq] != null}">
												<p id="p">
													<i value="${result.board_seq}" id="count${result.board_seq}">
													<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다</i>
												</p>
											</c:when>
												<c:otherwise>
													<p id="p">
														<i value="${result.board_seq}" id="count${result.board_seq}">
														<c:out value="${result4[result.board_seq]}"/></i>
													</p>
												</c:otherwise>
										</c:choose>
									</c:otherwise>
							</c:choose>	
			</h4> <div class="dropdown-divider"  id="modifydiv"></div>
				<!-- 태그,글 보이기 -->
					<div class="hidden" style="padding-left: 5px" id="hidden${result.board_seq}">
						<script> $("#myContents${result.board_seq}").attr("style","overflow:visible"); </script>
							<p id="myContents${result.board_seq}">${result.contents}</p>
								<script>    
									var text = $("#myContents${result.board_seq}").text();  
									var regex = /(#[^#\s,;]+)/gi  ;              
									var newtxt;
	  								if(text != null) {
	  									 newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
	  								}        
  							        $("#myContents${result.board_seq}").html(newtxt);  
								</script>
					</div>
			<!-- 이미지 -->
			<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
				<a href="oneBoard.do?board_seq=${result.board_seq}" > <!--src='AttachedMedia/${media.system_file_name}'-->
					<img class="card-img-top" 
						id="card" src='AttachedMedia/${media.system_file_name}'
						alt="해당 게시글로 바로가기">
				</a>
			</c:forEach>
		</div>
	</c:forEach>
	</div>
</div>

<!-- 무한스크롤 -->
<script>
	var globalAjaxUrl = "";
	var globalStartNum = 16;
	var globalCat = "";
	var globalSearch = "";
	console.log("${pageName}")
	console.log("${pageName}" == "/search.bo")
	if("${pageName}" == "/tour.bo"){
		globalAjaxUrl = "tourForJson.ajax"
		globalStartNum = ${TOUR_PER_PAGE + 1}
		
		if("${param.cat}" == ""){
			console.log("param cat 값 없음")
			globalCat = "1"
		} else {
			globalCat = "${param.cat}"
		}
		
	} else if("${pageName}" == "/search.bo") {
		globalAjaxUrl = "searchForJson.ajax"
		globalStartNum = ${SEARCH_PER_PAGE + 1};
		globalSearch = "${param.search}"
	}
	
	$(window).scroll(function(){
		if ($(window).scrollTop() >= $(document).height() - $(window).height()) {
			console.log('xcccccx');
			$.ajax({
	            url: globalAjaxUrl, // 처리할 페이지(서블릿) 주소
	            type: "get",
	            data: {start: globalStartNum, cat: globalCat, search: globalSearch},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
	            success: function(r) {
	            
	        		console.log(r);
	        		console.log("cat: ${param.cat}")
	        		console.log("search: ${param.search}")
	           		if(r.isAvailableMoreData){	// 가져올 게시글이 더 있나요?           		
	            		var c = "";
	           			// c += "<div class='card-columns'>"
	           			
	           			for(ele = 0; ele < r.result.length; ele++){
	           				// console.log(r.result[ele]);
		           			c += "<div class='card' id='card'>"
		           			c += "<h4 class='card-title' id='tourTop'>"
		           			c += "<img src='루이.jpg' alt='Card image cap' width='30' height='30' class='rounded-circle'>"	// ★★  이 부분 사진 주소 수정
		           		 	c += "<a id='ids' href='board.bo?id=" + r.result[ele].id + "&cat=1'>" + r.result[ele].id + "</a>"	   
		           		 	
		           		 	// test='bookmark.containsKey(result.board_seq)'
		           		 	var boardSeq = r.result[ele].board_seq
		           		 	// console.log(r.mapmark[boardSeq])
		           		 	if( typeof r.mapmark[boardSeq] != "undefined" ){
			           		 	c += "<i value='" + boardSeq + "' id='mark' class='far fa-bookmark icon pointer' style='display: none;' onclick='markit(this)'></i>"
								c += "<i value='" + boardSeq + "' style='font-weight: bold; color: #00B8D4;' id='markcancel' class='far fa-bookmark icon pointer'"
								c += "onclick='unmarkit(this)'></i>"							
		           		 	} else {
		           		 		c += "<i value='" + boardSeq + "' id='mark' class='far fa-bookmark icon pointer' onclick='markit(this)'></i>"
								c += "<i value='" + boardSeq + "' style='font-weight: bold; color: #00B8D4; display: none;' id='markcancel'" 
								c += "class='far fa-bookmark icon pointer' onclick='unmarkit(this)'></i>"
		           		 	}
		           		 	
		           		 	// 좋아요
		           		 	// if: result3(map).containsKey(result.board_seq)
		           		 	if( typeof r.map[boardSeq] != "undefined" ){
		           		 		c += "<i value='" + boardSeq + "' style='cursor: pointer; display: none;'" 
		           		 		c += "id='likeit' class='far fa-heart icon mr-1' onclick='likeit(this)'></i>"
								c += "<i value='" + boardSeq + "' style='color: red; cursor: pointer;' id='likecancel'"
								c += "class='fas fa-heart' onclick='unlikeit(this)'></i>"
								
								// if: countlike[result.board_seq] != null
								if(typeof r.countlike[board_seq] != "undefined" && r.countlike[board_seq] != null){
									c += "<p id='p'><i value='" + boardSeq + "' id='count" + boardSeq + "'>"
									c += r.countlike[board_seq] + "명이 좋아합니다." + "</i></p>"
								} else {
									c += "<p id='p'><i value='" + boardSeq + "' id='count" + boardSeq + "'></i></p>"
								}								
		           		 	} else {
		           		 		c += "<i value='" + boardSeq + "' style='cursor: pointer;' id='likeit' "
		           		 		c += "class='far fa-heart icon mr-1' onclick='likeit(this)'></i><i value='" + boardSeq + "' " 
		           		 		c += "style='color: red; display: none; cursor: pointer;' id='likecancel' class='fas fa-heart'  "
		                   		c += "onclick='unlikeit(this)'></i>"
		                   		// if: countlike[result.board_seq] != null
									if(typeof r.countlike[board_seq] != "undefined" && r.countlike[board_seq] != null){
										c += "<p id='p'><i value='" + boardSeq + "' id='count" + boardSeq + "'>"
										c += r.countlike[board_seq] + "명이 좋아합니다." + "</i></p>"
									} else {
										c += "<p id='p'><i value='" + boardSeq + "' id='count" + boardSeq + "'></i></p>"
									}	
		           		 	}
		           					
		           			c += "</h4>" 
		           			
	           				c += "<div class='dropdown-divider'  id='modifydiv'></div>"
		           		 	c += "<div class='hidden' style='padding-left: 5px' id='hidden" + boardSeq + "'>"
		           		 	// == pure == 
		           			$('#myContents' + boardSeq).attr('style','overflow:visible');		           			
		           			var text = r.result[ele].contents
							var regex = /(#[^#\s,;<>.]+)/gi;              
							var newtxt = "<span class=text-muted>(내용없음)</span>";
								if(text != null || typeof text != "undefined" ) {
									 newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>" + "$1" + "</a>");
								}   
		           			c += "<p id='myContents" + boardSeq + "'>" + newtxt + "</p>"
		           			
		           			// forEach begin='0' end='0' var='media' items=result2[status.index]
		           			
	           				// c += "<a href='#' >"
	           				try {
	           					c += "<a href='oneBoard.do?board_seq=" + boardSeq + "'>" 
							    c += "<img class='card-img-top' id='card' src='AttachedMedia/" 
									+ r.media[ele][0].system_file_name + "' alt='해당 게시글로 바로가기'"
								c += "</a>"
							}
							catch(e) {
								console.log(e)
							}
	           				
	           				// c += "</a>"
		           		 	c += "</div>"	// hidden div 끝
		           		 	c += "</div>"	// modifydiv 끝
		           			c += "</div>"	// card div 끝
	           			}  			
	           			
	           			
	           			// c += "</div>"	// card-columns 끝
	           			$("#deck").append(c)
	           			
	            		globalStartNum = parseInt(r.nextStartNum);
	            	} else {
	            		console.log(false);
	            		return false;
	            	} 

	            },
	            error: function() {
	                console.log("에러 발생");
	            },
	            complete: function(){
	            	console.log("완료");
	            }
	        });
			
	    
		}
		else{
			console.log("짧음")
		}
	}); // window scroll 끝


</script>

<%@ include file="include/bottom.jsp"%>