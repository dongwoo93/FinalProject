<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="https://v40.pingendo.com/assets/4.0.0/default/theme.css"
	type="text/css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<html>
<head>

<style>
@import
	url(https://fonts.googleapis.com/css?family=Open+Sans:300,400,600);

@import url(https://use.fontawesome.com/releases/v5.0.8/css/all.css);

/* Base Styles */
:root {
	/* Base font size */
	font-size: 10px;
}

*, *::before, *::after {
	box-sizing: border-box;
}

body {
	border: 1px solid black;
	height: auto;
	font-family: "Open Sans", Arial, sans-serif;
	min-height: 100vh;
	padding-bottom: 3rem;
}

#allwrapper {
	height: auto;
}

#navbar {
	border-bottom: 1px solid #ccc;
	position: fixed;
	z-index: 1;
	width: 100%;
	background-color: #35e0db;
}

#topwrapper {
	height: 72px;
}

#navcontainer {
	max-width: 1000px;
}

#searchform {
	height: 30px;
	border: 0.6px solid #ccc;
	width: 300px;
}

#instagramicon {
	color: white;
	border-right: 1px solid white;
	padding-right: 13px;
}

.nav-icon {
	font-size: 30px;
	color: white;
}

.nav-item>a {
	margin-left: 25px;
}

.navbar-nav {
	flex-direction: row;
}

@media ( max-width : 768px) {
	.nav-icon {
		font-size: 20px;
	}
}

@media ( min-width : 430px) {
	.logo {
		display: flex !important;
		flex-basis: auto;
	}
}

@media ( max-width : 411.33px) {
	.nav-item>a {
		margin-left: 40px;
	}
}

.logo {
	display: none;
	flex-grow: 1;
}

#contents {
	max-width: 1000px;
	margin-left: auto;
	margin-right: auto;
}

#centerwrapper {
	height: 100%;
}

.portfolio-item {
	margin-bottom: 20px;
}

#icon {
	float: right;
	font-size: 18px;
	margin-right: 5px;
}

#searchTop {
	margin-top: 5px;
	margin-left: 5px;
}
</style>
</head>

<script>
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
			$(e).next().show();
			$(e).hide();
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
			$(e).prev().show();
			$(e).hide();
			
		},
		error : function() {
			console.log("에러 발생!");
			}
		})
}
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

<body>

	<div id="topwrapper">
		<nav class="navbar navbar-expand-md navbar-light" id="navbar">
			<div class="container" id="navcontainer">
				<i class="fab fa-instagram fa-2x" id="instagramicon"></i>
				<div class="logo">
					<a class="navbar-brand ml-2 text-white" href="#">SocialWired</a>
				</div>
				<div class="collapse navbar-collapse">
					<form class="form-inline m-0">
						<input class="form-control" type="text" placeholder="검색"
							id="search">
					</form>
				</div>
				<div id="nav-icons">
					<ul class="navbar-nav">

						<li class="nav-item"><a class="nav-link" href="#"><i
								class="far fa-comment-alt nav-icon"></i></a></li>
						<li class="nav-item"><a class="nav-link" href="write.board"><i
								class="fas fa-pencil-alt nav-icon"></i></a></li>
						<li class="nav-item"><a class="nav-link" href="#"><i
								class="far fa-compass nav-icon"></i></a></li>
						<li class="nav-item"><a class="nav-link" href="#"><i
								class="far fa-heart nav-icon"></i></a></li>
						<li class="nav-item"><a class="nav-link" href="board.bo"><i
								class="far fa-user nav-icon"></i></a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<div id="allwrapper">
		<div id="centerwrapper">
			<div class="container" id="contents">

				<!-- choose문 시작하는 지점 -->
				<c:choose>
					<c:when test="${result.size() > 0}">

						<div class="card-columns">
							<c:forEach var="result" items="${result}" varStatus="status">
								<div class="card">
									<h4 class="card-title" id="searchTop">
										<img src="" alt="Card image cap" width="30" class="rounded-circle"> 
										<a>${result.id}
											<!-- 아이콘 -->
											 <a class="btn navbar-btn ml-2 text-white ">
							                 <i value="${tmp.board_seq}" id="mark" class="far fa-bookmark icon" onclick="markit(this)"></i>
							                 <i value="${tmp.board_seq}" style="font-weight: bold; color: #28a745; display: none;" id="markcancel" class="far fa-bookmark icon" onclick="unmarkit(this)"></i>
							                 </a> 
								 			<i value="${tmp.board_seq}" style="cursor: pointer;" id="likeit" class="far fa-heart icon mr-1" onclick="likeit(this)"></i>
						                    <i value="${tmp.board_seq}" style="font-weight: bold; color: red; display: none; cursor: pointer;" id="likecancel" class="far fa-heart icon mr-1" onclick="unlikeit(this)"></i>

										</a> <a href="#">팔로우</a>
									</h4>

									<c:forEach var="media" items="${result2[status.index]}">
										<a href="#"> <!--src='AttachedMedia/${media.system_file_name}'-->
											<img class="card-img-top"
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
			</div>
		</div>

		<div class="pt-4 pb-3  " id="footer">
			<div class="container">
				<div class="row">
					<div class="col-md-10">
						<p class="lead">SocialWired 정보지원홍보 센터API채용
							정보개인정보처리방침약관디렉터리프로필해시태그언어</p>
					</div>

					<div class="col-4 col-md-2 align-self-center">
						<p>@2018SocialWired</p>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>