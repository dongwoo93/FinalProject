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
		
		
		<ul class="nav text-center">
			<li class="nav-item" style="width:500px;font-family: NANUMBARUNPENR !important;font-size: 14px;font-weight:bold;"><a class="nav-link"
				href="followerlist.do?id=${pageid}&cat=1">팔로워</a></li>
			<li class="nav-item" style="width:500px;font-family: NANUMBARUNPENR !important;font-size: 14px;font-weight:bold;"><a class="nav-link"
				href="followlist.do?id=${pageid}&cat=1">팔로우</a></li>
		</ul>
		
		
		<hr class="_5mToa">
		
		<div style="border:0px solid black;font-family: NANUMBARUNPENR !important;font-size: 14px;">
			<div class="container" style="width:100%">
				<div class="row mt-2">
					<c:forEach var="follow" items="${result}" varStatus="status">
						<div href="board.bo?id=${follow.targetId}&cat=1" style="height:300px;background-color:white;border:5px solid #eff1f4;font-family: NANUMBARUNPENR !important;font-size: 14px;" class="col-md-2 mx-3 mb-3">
							<div class="text-center mt-4" style="cursor:pointer;" onclick="goprofile(this)">
								  <img class="" src="AttachedMedia/<c:out value='${profile_pic[follow.targetId]}'/>" style="border-radius:100%; width:120px; height:120px;">
							</div>
						    <a href="board.bo?id=${follow.targetId}&cat=1"><h5 class="text-center mt-3">${follow.targetId}</h5></a>
							<div class="text-center mt-5">
						<c:choose>
							<c:when test="${sessionScope.loginId == follow.targetId}">
							</c:when>
							<c:when test="${isFollow[status.index]}">
							
						
							<button class="btn btn-light text-dark" style="font-weight:bold;margin-right:32px;font-family: NANUMBARUNPENR !important;" id="cancelFollow${status.index}">팔로잉</button>
							<button class="btn btn-info text-dark" onclick="follow('${sessionScope.loginId}', '${follow.targetId}', '${status.index}')"
										id="follow${status.index}" style="display:none;font-weight:bold;margin-right:32px;font-family: NANUMBARUNPENR !important;">팔로우 <i class="fas fa-plus"></i></button>

					
							
							
							</c:when>

    
							<c:otherwise>
									
							<button class="btn btn-light text-dark" style="font-weight:bold;margin-right:32px;display:none;font-family: NANUMBARUNPENR !important;" id="cancelFollow${status.index}">팔로잉</button>
							<button class="btn btn-info  text-dark" style="font-weight:bold;margin-right:32px;font-family: NANUMBARUNPENR !important;" onclick="follow('${sessionScope.loginId}', '${follow.targetId}', '${status.index}')"
										id="follow${status.index}">팔로우 <i class="fas fa-plus"></i></button>
										
							</c:otherwise>
						</c:choose>
							
							</div>
						</div>
						<script>
							function goprofile(e){
								var id = $(e).parent().find("h5").text();
								$(location).attr("href","board.bo?id="+id+"&cat=1");
							}
							
							$("#cancelFollow${status.index}").click(function() {
								$("#yes").attr("onclick","unfollow('${sessionScope.loginId}', '${follower.id}', '${status.index}')");
								$("#exampleModalCenter").modal();
							});
						</script>
					 </c:forEach>
					 </div>

				</div>
			</div>


		<div style="border: 0px solid black;">
			<div class="container" style="width:100%">
				<div class="row mt-2">
					<c:forEach var="follower" items="${result1}" varStatus="status">
						<div href="board.bo?id=${follower.id}&cat=1" style="height:300px; background-color:white; border:5px solid #eff1f4;font-family: NANUMBARUNPENR !important;font-size: 14px;" class="col-md-2 mx-3 mb-3">
							<div class="text-center mt-4" style="cursor:pointer;" onclick="goprofile(this)">
								  <img class="" src="AttachedMedia/<c:out value='${profile_pic[follower.id]}'/>" style="border-radius:100%; width:120px; height:120px;">
							</div>
						    <a href="board.bo?id=${follower.id}&cat=1"><h5 class="text-center mt-3">${follower.id}</h5></a>
							<div class="text-center mt-5">
							<c:choose>
								<c:when test="${sessionScope.loginId == follower.id}">
								</c:when>
								<c:when test="${isFollow[status.index]}">
									<button class="btn btn-light text-dark" style="font-weight:bold;margin-right:32px;font-family: NANUMBARUNPENR !important;" id="cancelFollow${status.index}">팔로잉</button>
									<button class="btn btn-info  text-dark" style="font-weight:bold;margin-right:32px;display:none;font-family: NANUMBARUNPENR !important;" onclick="follow('${sessionScope.loginId}', '${follower.id}', '${status.index}')"
										id="follow${status.index}">팔로우 <i class="fas fa-plus"></i></button>
								</c:when>
		
		  
								<c:otherwise>
									<button class="btn btn-light text-dark" style="font-weight:bold;margin-right:32px;font-family: NANUMBARUNPENR !important;display:none;" id="cancelFollow${status.index}">팔로잉</button>
									<button class="btn btn-info text-dark" style="font-weight:bold;margin-right:32px;font-family: NANUMBARUNPENR !important;" onclick="follow('${sessionScope.loginId}', '${follower.id}', '${status.index}')"
										id="follow${status.index}">팔로우 <i class="fas fa-plus"></i></button>
								</c:otherwise>
							</c:choose> 
								
							</div>
						</div>
						<script>
							function goprofile(e){
								var id = $(e).parent().find("h5").text();
								$(location).attr("href","board.bo?id="+id+"&cat=1");
							}
							
							$("#cancelFollow${status.index}").click(function() {
								$("#yes").attr("onclick","unfollow('${sessionScope.loginId}', '${follower.id}', '${status.index}')");
								$("#exampleModalCenter").modal();
							});
						</script>
					 </c:forEach>
					 </div>
				</div>
		</div>
		<hr class="_5mToa">
	</div>

</div>




<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
		<div class="modal-content" style="border:5px solid #eff1f4;font-family:NANUMBARUNPENR !important;font-size: 14px;">
			<div class="modal-header">

				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" style="border:5px solid #eff1f4;font-family:NANUMBARUNPENR !important;font-size: 14px;">
				<h4 class="modal-title"
						style="font-family: NANUMBARUNPENR !important; font-size: 14px;">
						정말 팔로우를 취소하시겠습니까?</h4>
			</div>
			<div class="modal-footer">
				<button type="button" style="font-family: NANUMBARUNPENR !important;font-size: 14px;width:80px;" class="btn btn-light text-dark" data-dismiss="modal"
					id="yes" onclick="">YES</button>
				<button type="button" style="font-family: NANUMBARUNPENR !important;font-size: 14px;width:80px;" class="btn btn-light text-dark" data-dismiss="modal">Close</button>

			</div>
		</div>
	</div>
</div>




<%@ include file="include/bottom.jsp"%>