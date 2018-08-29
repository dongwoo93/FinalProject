<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/follow.css">
<script>
function follow(id1, id2, index) {
	   var id = id1; 
	   var targetId = id2; 
	   $.ajax({ 
	      url : "follow.do", 
	      type : "post", 
	      data : { 
	         id : id, 
	         targetId : targetId, 
	      }, 
	      success : function(resp) { 
	         $("#cancelFollow"+index).show(); 
	         $("#follow"+index).hide(); 
	          
	      }, 
	      error : function() { 
	         console.log("에러 발생!"); 
	         } 
	      }) 
	} 
	 
	function unfollow(id1, id2, index) {
	   var id = id1; 
	   var targetId = id2; 
	   $.ajax({ 
	      url : "deletefollow.do", 
	      type : "post", 
	      data : { 
	         id : id, 
	         targetId : targetId, 
	      }, 
	      success : function(resp) { 
	         $("#follow"+index).show(); 
	         $("#cancelFollow"+index).hide(); 
	          
	      }, 
	      error : function() { 
	         console.log("에러 발생!"); 
	         } 
	      }) 
	}
</script>

<div id="allwrapper" style="margin-top: 50px;">

	<div class="container">
		<hr class="_5mToa ">
			<ul class="nav">
				<li class="nav-item"><a class="nav-link"
					href="followerlist.do?id=${pageid}&cat=1">팔로워</a></li>
				<li class="nav-item"><a class="nav-link"
					href="followlist.do?id=${pageid}&cat=1">팔로우</a></li>
			</ul>
		
		<div style="border: 0px solid black; margin-top:50px;">
			<c:forEach var="follow" items="${result}" varStatus="status">
				<div class="container" style="width:50%; margin-top: 20px;">
						<img class="rounded-circle" id="img"
							src="AttachedMedia/<c:out value='${profile_pic[follow.targetId]}'/>">
						<a class="mt-6 idtxt"
							style="font-size: 16px; font-family: 'HelveticaNeue', 'Arial', sans-serif;"
							href="board.bo?id=${follow.targetId}&cat=1">${follow.targetId}</a>
						<c:choose>
							<c:when test="${sessionScope.loginId == follow.targetId}">
							</c:when>
							<c:when test="${isFollow[status.index]}">
								<div class="btn btn-outline-primary btn"
									id="cancelFollow${status.index}">팔로잉</div>
								<div class="btn btn-outline-primary btn"
									onclick="follow('${sessionScope.loginId}', '${follow.targetId}', '${status.index}')"
									id="follow${status.index}"
									style="background-color: #35e0db; display: none; color: black;">팔로우</div>
							</c:when>

    
							<c:otherwise>
								<div class="btn btn-outline-primary btn"
									id="cancelFollow${status.index}"
									style="display: none;">팔로잉</div>
								<div class="btn btn-outline-primary btn"
									onclick="follow('${sessionScope.loginId}', '${follow.targetId}', '${status.index}')"
									id="follow${status.index}" style="background-color: #35e0db; color: black;">팔로우</div>
							</c:otherwise>
						</c:choose>

			
					<hr class="_5mToa ">
				</div>
				<script>
					$("#cancelFollow${status.index}").click(function() {
						$("#yes").attr("onclick","unfollow('${sessionScope.loginId}', '${follow.targetId}', '${status.index}')");
						$("#exampleModalCenter").modal();
					});
				</script>
			</c:forEach>
		</div>


		<div style="border: 0px solid black;">
			<c:forEach var="follower" items="${result1}" varStatus="status">
				<div class="container" style="width:40%">
					<hr class="_5mToa">
				
					<img class="ml-3 mr-2 pic"
						src="AttachedMedia/<c:out value='${profile_pic[follower.id]}'/>">
					<a class="mt-6 idtxt"
						style="font-size: 16px; font-family: 'HelveticaNeue', 'Arial', sans-serif;"
						href="board.bo?id=${follower.id}&cat=1">${follower.id}</a>
					<c:choose>
						<c:when test="${sessionScope.loginId == follower.id}">
						</c:when>
						<c:when test="${isFollow[status.index]}">
							<div class="btn btn-outline-primary btn"
								id="cancelFollow${status.index}">팔로잉</div>
							<div class="btn btn-outline-primary btn"
								onclick="follow('${sessionScope.loginId}', '${follower.id}', '${status.index}')"
								id="follow${status.index}"
								style="background-color: #35e0db; display: none; color: black;">팔로우</div>
						</c:when>

  
						<c:otherwise>
							<div class="btn btn-outline-primary btn"
								id="cancelFollow${status.index}"
								style="display: none;">팔로잉</div>
							<div class="btn btn-outline-primary btn"
								onclick="follow('${sessionScope.loginId}', '${follower.id}', '${status.index}')"
								id="follow${status.index}" style="background-color: #35e0db; color: black;">팔로우</div>
						</c:otherwise>
					</c:choose>
					 
					<hr class="_5mToa">
				</div>
				<script>
					$("#cancelFollow${status.index}").click(function() {
						$("#yes").attr("onclick","unfollow('${sessionScope.loginId}', '${follower.id}', '${status.index}')");
						$("#exampleModalCenter").modal();
					});
				</script>
			</c:forEach>
		</div>

	</div>

</div>




<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">

				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h2>정말 팔로우를 취소하시겠습니까?</h2>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-dismiss="modal"
					id="yes" onclick="">YES</button>
				<button type="button" class="btn btn-outline-danger" data-dismiss="modal">Close</button>

			</div>
		</div>
	</div>
</div>




<%@ include file="include/bottom.jsp"%>