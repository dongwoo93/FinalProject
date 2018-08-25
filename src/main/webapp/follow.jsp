<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/follow.css">
<script src="resources/js/myarticle.js"></script>
<script>

$(document).ready(function(){

    $("#cancelFollow").click(function() {

      $("#exampleModalCenter").modal();                             
                    });
      
  
})
</script>
<div id="allwrapper" style="margin-top:50px;">

	<div class="container">

	   <hr class="_5mToa ">					
		<ul class="nav">
			<li class="nav-item">
				 <a class="nav-link" href="followerlist.do?id=${pageid}&cat=1">팔로워</a>
			</li>
			<li class="nav-item">
				 <a class="nav-link" href="followlist.do?id=${pageid}&cat=1">팔로우</a>
			</li>
		</ul>				
						
			<div style="border : 0px solid black;">		 			    				 
				<c:forEach var="follow" items="${result}" varStatus="status"> 
				   <div class="container">
	  				 <hr class="_5mToa">		 
					    <div class="profile-image"> 
							<img class="ml-3 mr-2 pic" src="AttachedMedia/<c:out value='${profile_pic[follow.targetId]}'/>">	
							<a class="mt-6 idtxt"  style="font-size:16px; font-family:'HelveticaNeue','Arial', sans-serif;" href="board.bo?id=${follow.targetId}&cat=1">${follow.targetId}</a>						
				 		</div>		
					 <hr class="_5mToa">		 			      
				  </div>		
				</c:forEach> 			
			</div>
			
			
			<div style="border : 0px solid black;">		 			    				 
				<c:forEach var="follower" items="${result1}" varStatus="status"> 
				   <div class="container">
	  				 <hr class="_5mToa">	
	  				 	  
				
							<img class="ml-3 mr-2 pic" src="AttachedMedia/<c:out value='${profile_pic[follower.id]}'/>">	
							<a class="mt-6 idtxt"  style="font-size:16px; font-family:'HelveticaNeue','Arial', sans-serif;" href="board.bo?id=${follower.id}">${follower.id}</a>
							  
							
							<div class="profile-edit-btn float-right mt-2 mr-2" id="cancelFollow" style="height:40px;">팔로잉</div>
							<div class="profile-edit-btn float-right mt-2 mr-2" onclick="follow('${sessionScope.loginId}', '${pageid}')" id="follow" style="height:40px; background-color:#35e0db;display: none;">팔로우</div>		      
							
			  		<hr class="_5mToa" >		 			      
				  </div>
				
	  			  
				</c:forEach>	 	 
			</div>

		</div>
	
	</div>	
 	
 

	
	<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
    
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h2>정말 팔로우를 취소하시겠습니까?</h2>    
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="yes" onclick="unfollow('${sessionScope.loginId}', '${pageid}')" >YES</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
       
      </div>
    </div>
  </div>
</div>




<%@ include file="include/bottom.jsp"%>