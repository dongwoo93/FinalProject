<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>


<style>


#contents {
	max-width: 1000px;
	margin-left: auto;
	margin-right: auto;
	display: -webkit-box;
	
}

#centerwrapper {
	height: 100%;
	
}
 
/*컨테이너*/
.profile-image {
	width: calc(33.333% - 1rem);
	display: flex;
	margin-right: 3rem;
	align-items: center;
	margin-right: 3rem;
}

.profile-image img {
	border-radius: 50%;
}

.cock {
	float: left; 
}

.bookmark {
	float: left;
}

.icon {
	
	font-size: 20px;
	color: black;
	border: 0.5px;
}

.dot {
	font-size: 7px;
	color: lightgray;
}

.dot1 {
	font-size: 10px;
	color: #4FC3F7;
}

#comment {
	width: 85%;
	height: 5%;
	border: none;
	font-size: 13px;
	padding-left: 2%;
	margin-right: 2%;
	font-family: "Open Sans", Arial, sans-serif;
}

#contcenter {
	border-bottom: 0.3px solid lightgray;
}

.btn {
	font-size: 15px;
}

#peed {
	border: 0.3px solid lightgray;
}
  
#board {
	width: 62%;
	
}

#side {
	width: 38%;
}

#row {
	display: inline-block
}

    
    #myComment{
    	font-family: "Open Sans", Arial, sans-serif;
    	font-size: 11px;
    	
    }
    
    .hidden p {
 
    overflow: hidden;    
    text-overflow: ellipsis;
    white-space: nowrap; 
    width:60%;
    height: 20px;
    }
    
 
}

.idtxt {
	font-weight: 600;
}
.carousel-inner {   
		
	
}
.carousel-item {   
		
	
}
.boardimg {
	z-index:auto;
	max-height: 700px;
 
	
}

#id {
	font-family: "Open Sans", Arial, sans-serif;
	font-size: 11px;
}

#con {
	font-family: "Open Sans", Arial, sans-serif;
	font-size: 14px;  
}

#myContents {
	font-family: "Open Sans", Arial, sans-serif;
	font-size: 13px;
}

#myComment {
	font-family: "Open Sans", Arial, sans-serif;
	font-size: 11px;
}

.hidden p {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 60%;
	height: 20px;
}

  
.comment-contents li {
position:relative;	
		}  
  
#li1 {
width:14%;
display:contents;
    
   
}
#li2  {            
width:72%;         
padding-left:3%;     
}  

#li3 {
width:12%; 
text-align:right; 
padding-right:3%;	
}    
  
#li4 {
	width:12%; 
	display:contents; 

}  
  
.commenttxt { 
	border:none;
	width:100%; 
	word-wrap: break-word; 
	    
}  
  
.creco {   
	border:none;   
	width:83%;    
	  
}
 
#feed {    
	  border:0.5px solid #efe4e4;  
	  background-color: #FFFFFF;
	}
	
	#float{
	 	border:0.5px solid #efe4e4;  
	 /*	background-color: #FFFFFF;*/
	}
.commentline {   
	padding-left: 0px;   
	margin-left: 1%;   
	margin-bottom:0px;
} 

.carousel-indicators li {
  width: 10px;
  height: 10px;
  border-radius: 100%;
  bottom: -50px;
  background-color: lightgray;
}

.carousel-indicators .active {
    background-color: #4FC3F7;
}

.modal-body {  
	text-align: center;  
}

.cons{
	width: 485px;   
	border-radius: 1.5rem;
}

.dropdown-item:hover{
	background-color:#E1F5FE;  
}

.pointer {
	
	cursor:pointer;  
}


.mo1:hover {
	background-color:transparent;
}

.mo, .mo1 {
	cursor: pointer;
}

.mo:hover {
	background-color:#efefef;
}
.p_text {
	color: #999;
}
.modal-header {
    display: block;
}
.modal-title {
    text-align: center;
    font-weight: bold;
}
.headbtn {
    position: absolute;
    top : 2.5%
}
.footertbtn {
	width: 100%;
}
.item {
	margin-top: 10px;
	font-size: x-medium;
}
#report-head{
	font-size: small;
	font-weight: bold;
	margin-bottom: 20px;
}
.mbody {
	text-align: left;
}
.close{
   	 top : 2.5%;
   	 font-size: 25px;
}
.pic{
	width : 30px;
	height : 30px;   
}


</style>

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
				<c:forEach var="follower" items="${result}" varStatus="status"> 
				   <div class="container">
	  				 <hr class="_5mToa">		 
					    <div class="profile-image"> 
							<img class="ml-3 mr-2 pic" src="AttachedMedia/<c:out value='${profile_pic[follower.targetId]}'/>">	
							<a class="mt-6 idtxt"  style="font-size:16px; font-family:'HelveticaNeue','Arial', sans-serif;" href="board.bo?id=${follower.targetId}&cat=1">${follower.targetId}</a>						
				 		</div>		
					 <hr class="_5mToa">		 			      
				  </div>		
				</c:forEach> 			
			</div>
			
			
			<div style="border : 0px solid black;">		 			    				 
				<c:forEach var="follow" items="${result1}" varStatus="status"> 
				   <div class="container">
	  				 <hr class="_5mToa">		 
					    <div class="profile-image"> 
							<img class="ml-3 mr-2 pic" src="AttachedMedia/<c:out value='${profile_pic[follow.id]}'/>">	
							<a class="mt-6 idtxt"  style="font-size:16px; font-family:'HelveticaNeue','Arial', sans-serif;" href="board.bo?id=${follow.id}&cat=1">${follow.id}</a>						
				 		</div>								
			  		<hr class="_5mToa" >		 			      
				  </div>		
				</c:forEach>			
			</div>

		</div>
	
	</div>	
 	
 

	
	




<%@ include file="include/bottom.jsp"%>