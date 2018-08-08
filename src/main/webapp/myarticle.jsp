<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
 <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css"> 
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
 <script src="https://code.jquery.com/jquery-3.3.1.js"></script> 
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<html>
<head>
 
<style>

@import url(https://fonts.googleapis.com/css?family=Open+Sans:300,400,600);
@import url(https://use.fontawesome.com/releases/v5.0.8/css/all.css);


	:root {
		font-size: 12px;
	}
	
	*,
	*::before,
	*::after {
		box-sizing: border-box;
	}
	
	body{
/* 		 border : 1px solid black; */
		 height:auto;
		 font-family: "Open Sans", Arial, sans-serif;
		 min-height: 100vh;
		 padding-bottom: 3rem; 
	 	 
	 } 
    
    #allwrapper{
      	height:auto;    
/*      border : 1px solid black; */
   	}
    
    #navbar{
        border-bottom: 1px solid #ccc;
        position: fixed;
        z-index: 1;
        width: 100%;
        background-color: #35e0db;
       
        
    }
    
    #topwrapper{
        height:auto;
    }
    
    #navcontainer{
        max-width: 1000px;
    }
    
    #searchform{
        height: 30px;
        border: 0.6px solid #ccc;
        width : 300px;
        
    }
    
    #instagramicon {
        color: white;
        border-right: 1px solid white;
        padding-right: 13px;
    }
    
    .nav-icon{
        font-size: 25px;
        color: white;
    }
    
    .nav-item> a {
        margin-left: 25px;
    }
    
    .navbar-nav {
        flex-direction: row;
    }
    
    @media(max-width: 768px){
        .nav-icon {
            font-size: 30px;
        }
    }
    
    @media(min-width: 430px){
        .logo {
                display: flex !important;
                  flex-basis: auto;
        }
    }
    
    @media(max-width: 411.33px){
        .nav-item> a {
            margin-left: 40px;
        }
    }
    
    .logo{
        display: none;
        flex-grow: 1;
    }
  
  
	img {
		display: block;
	}
	.container {
		max-width: 93.5rem;
		margin: 0 auto;
		padding: 0 2rem;
	}
	
	.tagmenu {
		max-width: 100rem;
		margin: 0 auto;
		padding: 0 2rem;
	}
	
	/* Profile Section */	
	.profile {
		padding: 5rem 0;
	}
	
	.profile::after {
		content: "";
		display: block;
		clear: both;
	}	
	.profile-image {
		float: left;
		width: calc(33.333% - 1rem);
		display: flex;
		justify-content: center;
		align-items: center;
		margin-right: 3rem;
	}	
	.profile-image img {
		border-radius: 50%;
	}
	.profile-user-settings,
	.profile-stats,
	.profile-bio {
		float: left;
		width: calc(66.666% - 2rem);
	}
	.profile-user-settings {
		margin-top: 1.1rem;
	}
	
	.profile-user-name {
		display: inline-block;
		font-size: 3.2rem;
		font-weight: 300;
	}
	.profile-edit-btn {
		display: inline-block;
		font-size: 1.4rem;
		line-height: 1.8;
		border: 0.1rem solid #dbdbdb;
		border-radius: 0.3rem;
		padding: 0 2.4rem;
		margin-left: 2rem;
		cursor: pointer;
	}
	.profile-settings-btn {
		display: inline-block;
		font-size: 2rem;
		cursor: pointer;
		margin-left: 1rem;
	}
	.profile-stats {
		margin-top: 2.3rem;
	}
	.profile-stats li {
		display: inline-block;
		font-size: 1.6rem;
		line-height: 1.5;
		margin-right: 4rem;
		cursor: pointer;
	}
	.profile-stats li:last-of-type {
		margin-right: 0;
	}
	.profile-bio {
		font-size: 1.6rem;
		font-weight: 400;
		line-height: 1.5;
		margin-top: 2.3rem;
	}
	.profile-real-name,
	.profile-stat-count,
	.profile-edit-btn {
		font-weight: 600;
	}
	
	
	/* Gallery Section */
	.gallery {
		display: flex;
		flex-wrap: wrap;
		margin: -1rem -1rem;
		padding-bottom: 3rem;
	}
	.gallery-item {
		position: relative;
		flex: 1 0 22rem;
		margin: 1rem;
		color: #fff;
		cursor: pointer;
	}
	.gallery-item:hover .gallery-item-info {
		display: flex;
		justify-content: center;
		align-items: center;
		position: absolute;
		top: 0;
		width: 80%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.3);
	 
	}
	.gallery-item-info {
		display: none;
		
	}
	.gallery-item-info li {
		display: inline-block;
		font-size: 1.7rem;
		font-weight: 600;
	}
	.gallery-item-likes {
		margin-right: 2.2rem;
	}
	.gallery-item-type {
		position: absolute;
		top: 1rem;
		right: 1rem;
		font-size: 2.5rem;
		text-shadow: 0.2rem 0.2rem 0.2rem rgba(0, 0, 0, 0.1);
	}
	.fa-clone,
	.fa-comment {
		transform: rotateY(180deg);
	}
	.gallery-image {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	
	
	/* Spinner */	
	.spinner {
		width: 5rem;
		height: 5rem;
		border: 0.6rem solid #999;
		border-bottom-color: transparent;
		border-radius: 50%;
		margin: 0 auto;
		animation: spinner 1s linear infinite;
	}
	
	
	/* Media Query */
	@media screen and (max-width: 40rem) {
		.profile {
			display: flex;
			flex-wrap: wrap;
			padding: 4rem 0;
		}
	
	.profile::after {
			display: none;
	}
	
	.profile-image,
	.profile-user-settings,
	.profile-bio,
	.profile-stats {
		float: none;
		width: auto;
	}
	
	.profile-image img {
		width: 7.7rem;
	}
	
	.profile-user-settings {
		flex-basis: calc(100% - 10.7rem);
		display: flex;
		flex-wrap: wrap;
		margin-top: 1rem;
	}
	
	.profile-user-name {
		font-size: 2.2rem;
	}
	
	.profile-edit-btn {
		order: 1;
		padding: 0;
		text-align: center;
		margin-top: 1rem;
	}
	
	.profile-edit-btn {
		margin-left: 0;
	}
	
	.profile-bio {
		font-size: 1.4rem;
		margin-top: 1.5rem;
	}
	
	.profile-edit-btn,
	.profile-bio,
	.profile-stats {
		flex-basis: 100%;
	}
	
	.profile-stats {
		order: 1;
		margin-top: 1.5rem;
	}
	
	.profile-stats ul {
		display: flex;
		text-align: center;
		padding: 1.2rem 0;
		border-top: 0.1rem solid #dadada;
		border-bottom: 0.1rem solid #dadada;
	}
	
	.profile-stats li {
		font-size: 1.4rem;
		flex: 1;
		margin: 0;
	}
	
	.profile-stat-count {
		display: block;
		}
	}
	
	
	/* Spinner Animation */	
	@keyframes spinner {
		to {
			transform: rotate(360deg);
		}
	}
	
	@supports (display: grid) {
		.profile {
			display: grid;
			grid-template-columns: 1fr 2fr;
			grid-template-rows: repeat(3, auto);
			grid-column-gap: 3rem;
			align-items: center;
	}
	
	.profile-image {
		grid-row: 1 / -1;
	}
	
	.gallery {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(22rem, 1fr));
		grid-gap: 2rem;
	}
	
	.profile-image,
	.profile-user-settings,
	.profile-stats,
	.profile-bio,
	.gallery-item,
	.gallery {
		width: auto;
		margin: 0;
	}
	
	@media (max-width: 40rem) {
		.profile {
			grid-template-columns: auto 1fr;
			grid-row-gap: 1.5rem;
	}
	
	.profile-image {
			grid-row: 1 / 2;	
	}
	
	.profile-user-settings {
			display: grid;
			grid-template-columns: auto 1fr;
			grid-gap: 1rem;
	}
	
		.profile-edit-btn,
		.profile-stats,
		.profile-bio {
		grid-column: 1 / -1;
	}
	
		.profile-user-settings,
		.profile-edit-btn,
		.profile-settings-btn,
		.profile-bio,
		.profile-stats {
			margin: 0;
			}
		}
	}
	
</style>

<script>
$(document).ready(function() {
	
	$('#searchform').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13'){
          var text = $("#searchform").val();
        	if(text == ""){
        		alert("검색어를 입력해 주세요");
        	}
        	else{
        		$("#go").attr("onsubmit","return true;");
        	} 
        }
    });
})

</script>

</head>

<body>
 
      <div id="topwrapper">
          <nav class="navbar navbar-expand-md navbar-light" id="navbar">
            <div class="container" id="navcontainer">
              <i class="fab fa-instagram fa-2x" id="instagramicon"></i>
              <div class="logo"><a class="navbar-brand ml-2 text-white" href="#">SocialWired</a></div>
              <div class="collapse navbar-collapse">
                <form id="go" action="search.bo" class="form-inline m-0" onsubmit="return false;">
                  <input id="searchform" class="form-control" name="search" type="text" placeholder="검색">
                </form>
              </div>
              <div id="nav-icons">
                <ul class="navbar-nav">
                
                 <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-comment-alt nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="write.board" ><i class="fas fa-pencil-alt nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-compass nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-heart nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="board.bo"><i class="far fa-user nav-icon"></i></a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
      </div>
   <br><br><br>
  
    
    
    <div id="allwrapper">
   

	  <div class="container">
			<div class="profile">
				<div class="profile-image">
					<img src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces">
				</div>
	
				<div class="profile-user-settings">
					<h1 class="profile-user-name">손민수</h1>
					<div class="profile-edit-btn">팔로잉</div>
					<div class="profile-settings-btn"><i class="fas fa-cog"></i></div>
				</div>
	
				<div class="profile-stats">
					<ul>
						<li><span class="profile-stat-count">164</span> 게시글</li>
						<li><span class="profile-stat-count">188</span> 팔로워</li>
						<li><span class="profile-stat-count">206</span> 팔로우</li>
					</ul>
				</div>
	
				<div class="profile-bio">
					<p><span class="profile-real-name">멋쟁이</span>&nbsp;&nbsp;난 오늘도 고독을 즐긴다..</p>
				</div>
			</div>
		</div>
		
		
		
    <div class="tagmenu">
      <div class="row">
        <div class="col-md-12">
          <table class="table">
            <thead>
              <tr>
                <th class="text-center">게시물</th>
                <th class="text-center">태그됨</th>
              </tr>
            </thead>
          </table>
        </div>
      </div>
    </div>

		
	
<div class="container">

     <div class="gallery">
      <c:if test="${result.size() != 0}">

		
		
		        <c:forEach var="tmp" items="${result}"   >
		
			
				<div class="gallery-item">  
				<img src='https://images.unsplash.com/photo-1511765224389-37f0e77cf0eb?w=500&h=500&fit=crop' class='gallery-image' id="${tmp.board_seq}">   
				
				 
					<div class="gallery-item-info" id="mo${tmp.board_seq}">    
						<ul>
							<li class="gallery-item-likes"><i class="fas fa-heart"></i> 18</li>
							<li class="gallery-item-comments"><i class="fas fa-comment"></i> 2</li>
						</ul>
					</div>
				
				
				<script>
  
                       $("#"+ ${tmp.board_seq}).click(function() {
                    	   $("#seq").val(${tmp.board_seq});  
                          	$("#boardmodal").modal();
                             
                    
                    	   
                       });
                        
                       $("#mo"+ ${tmp.board_seq}).click(function() {
                    	   $("#seq").val(${tmp.board_seq});  
                          	$("#boardmodal").modal();
                             
                    
                    	   
                       });

				</script>
				
				</div>
			
		<!-- 	<script>
			num++;
			</script> -->
		</c:forEach>
		
		
      </c:if>
     

	</div>			
	
<!-- 			<div class="spinner"></div> -->
	
		</div>
	

	</div>
 
      <div class="pt-4 pb-3  " id="footer">
           <div class="container">
              <div class="row" >
                <div class="col-md-10">
                  <p class="lead">SocialWired 정보지원홍보 센터 API 채용 정보 개인정보처리방침 약관 디렉터리 프로필 해시 태그 언어</p>
                </div>

                <div class="col-4 col-md-2 align-self-center">
                  <p>@2018SocialWired</p>
                </div>
              </div>
          </div>
      </div>
      
       <div class="modal" id="boardmodal"> 
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" >Cencel failed</h5>
          <button type="button" class="close" data-dismiss="modal">
            <span>×</span>
          </button>
        </div>
        <div class="modal-body">
        <input type=text id="seq">
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
        </div>
      </div>
    </div>
  </div>
  
</body>

</html>