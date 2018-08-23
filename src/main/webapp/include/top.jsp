<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
 <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css"> 
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
 <script src="https://code.jquery.com/jquery-3.3.1.js"></script> 
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/top.css">
<script src="resources/js/top.js"></script>
</head>

<body>
<script type="text/javascript">

$(function() {

    var availableCity = [
    	{ link: "board.bo?id=ykng10",
        label: "ykng10"
        },
    	{ link: "www.example.com",
      label: "James Bond"
    	}];

    $("#searchform").autocomplete({

    	source: function( request, response ) {
            $.ajax({
            	type: 'post',
            	dataType: "json",
              url: "searchAccount.do",
              data: {
                term: request.term
              },
              success: function(data) {
            	alert(data);
                response(data);
                }
            });
          },
        minLength: 2,
        select: function(event, ui) {
            console.log(ui.item);
        },

        focus: function(event, ui) {

            return false;

            //event.preventDefault();

        }

    });

});



</script>




 
      <div id="topwrapper">
          <nav class="navbar navbar-expand-md navbar-light" id="navbar">
            <div class="container" id="navcontainer">
              <i class="fab fa-instagram fa-2x" id="instagramicon"></i>
              <div class="logo"><a class="navbar-brand ml-2 text-white" href="feed.bo">SocialWired</a></div>
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
                    <a class="nav-link" href="tour.bo?cat=1"><i class="far fa-compass nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-heart nav-icon"></i></a>
                  </li>
                  <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="far fa-user nav-icon"></i>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="board.bo?id=${sessionScope.loginId}">내 계정</a>
          <a class="dropdown-item" href="profile.member">프로필 편집</a>
          <a class="dropdown-item" href="calendar.bo">나의 게시판</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="logout.do">로그아웃</a>
        </div>
      </li>
                  
                </ul>
              </div>
            </div>
          </nav>
      </div>