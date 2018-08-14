<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
    <link rel="stylesheet" type="text/css" href="resources/css/search.css">
    <div id="allwrapper">
		<div id="centerwrapper">
			<div class="container" id="contents">
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
			
			$(e).next().text(resp);
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
			$(e).prev().text(resp);
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
				<!-- choose문 시작하는 지점 -->
				<c:choose>
					<c:when test="${result.size() > 0}">
						<div class="card-columns">
							<c:forEach var="result" items="${result}" varStatus="status">
								<div class="card" id="card">
									<h4 class="card-title" id="searchTop">
										<img
											src="https://scontent-icn1-1.cdninstagram.com/vp/7c370096e65b401d7c23388739c4f142/5C09D614/t51.2885-19/s150x150/37329457_1608380405938260_7561205846328213504_n.jpg"
											width="30" class="rounded-circle"> <a>${result.id}
											<!-- 북마크 -->
											<i value="${result.board_seq}" id="mark" class="far fa-bookmark icon" onclick="markit(this)"></i>
                						    <i value="${result.board_seq}" style="font-weight: bold; color: #28a745; display: none;" id="markcancel" class="far fa-bookmark icon" onclick="unmarkit(this)"></i>
											<!-- 좋아요 -->
											<c:choose>
												<c:when test="${result3.containsKey(result.board_seq)}">
													<i value="${result.board_seq}" style="cursor: pointer; display: none;" id="likeit" class="far fa-heart icon mr-1" onclick="likeit(this)"><c:out value="${result4[result.board_seq]}"/></i>
		                   						    <i value="${result.board_seq}" style="font-weight: bold; color: red; cursor: pointer;" id="likecancel" class="far fa-heart icon mr-1" onclick="unlikeit(this)">${result4[result.board_seq]}</i>
												</c:when>
													<c:otherwise>   
														<i value="${result.board_seq}" style="cursor: pointer;" id="likeit" class="far fa-heart icon mr-1" onclick="likeit(this)">${result4[result.board_seq]}</i>
		                   						    	<i value="${result.board_seq}" style="font-weight: bold; color: red; display: none; cursor: pointer;" id="likecancel" class="far fa-heart icon mr-1" onclick="unlikeit(this)">${result4[result.board_seq]}</i>												
													</c:otherwise>
											</c:choose>
										</a> <a href="#">팔로우</a>
									</h4>
										<!-- 태그,글 보이기 -->
									  <div class="hidden" style="padding-left: 5px" id="hidden${result.board_seq}">
											<script>
												$("#myContents${result.board_seq}").attr("style","overflow:visible");
											</script>
												<p id="myContents${result.board_seq}">${result.contents}</p>
												<script>    
												var plus = "";    
												var txt = "${result.contents}";       
										    	  if(txt.length > 48) {                
										    		  plus = "<p id='${result.board_seq}' >&nbsp-더보기</p>";
								 		    	  }
												$("#myContents${result.board_seq}:last-child").after("</p>"+plus);   			
											   	$("#${result.board_seq}").click(function() { 
											   		$("#myContents${result.board_seq}").attr("style","overflow:visible");  
											   	});
										   </script>
										</div>
										<!-- 이미지 -->
											<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
												<a href="#"> <!--src='AttachedMedia/${media.system_file_name}'-->
													<img class="card-img-top" id="card"
													src='AttachedMedia/${media.system_file_name}'
													alt="Card image cap"></a>
											</c:forEach>
								</div>
							</c:forEach>
						</div>
					</c:when>
						<c:otherwise>
							<h1>검색 결과가 없습니다.</h1>
						</c:otherwise>
				</c:choose>
				<!-- choose문 끝나는 지점 -->

      <%@ include file="include/bottom.jsp"%>