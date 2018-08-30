<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
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
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/top.css">
<script src="resources/js/top.js"></script>
<script>


</script>

<script>
	$(document).ready(function(){
	
		$.ajax({
            url: "alertCount.do", // 처리할 페이지(서블릿) 주소
            type: "get",
            data: {id:"${sessionScope.loginId}"}, 
            success: function(response) {
            	if(response != 0){
            		$("#totalreadcount2").show();
            		$("#totalreadcount2").text(response);
            	}
            },
            error: function() {
                console.log("에러");
            },
            complete: function(){
                console.log("AJAX완료");
            } 
        });
		
		$.ajax({
            url: "getTotalMessage.do", // 처리할 페이지(서블릿) 주소
            type: "get",
            data: {id:"${sessionScope.loginId}"}, 
            success: function(response) {
            	if(response != 0){
            		$("#totalreadcount").show();
            		$("#totalreadcount").text(response);
            	}
            },
            error: function() {
                console.log("에러");
            },
            complete: function(){
                console.log("AJAX완료");
            } 
        });
		
  
    $.ajax({
      	url : "alerting.top",
      	type : "get",
      	         
      	success : function(resp) {        
      	
      		for(var i=0; i<resp.length; i++){     
      			var name = resp[i][3].split(" ")[0];  
      			var cont = "님이"+resp[i][3].split("님이")[1];          
      		       
      			$("#alertcont:last-child").append("<ul class='dropdown-item navbar' style='font-family: NANUMBARUNPENR !important;font-size: 14px;'><li style='width:15%'><img src='AttachedMedia/a'></li><li style='width:64%; '><a style='font-weight:900; font-size:17px; padding-right:5px;'>"+name+"</a><a>"+cont+"</a></li><li style='width:10%'>"+resp[i][2]+"</li><li style='width:10%; text-align:center; '><img src='AttachedMedia/a'></li></ul><div class='dropdown-divider'></div>");
      		
      		}		  
      	 },  
      	 error : function() {
      	 console.log("에러 발생!");
      	 }
      	  });

	})
</script>
</head>


<body>
	<script>
var curinput;
$(function() {    
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
            	  var cnt = 0;
            	  console.log(data);
            	  response(
            			  $.map(data, function(item) {
            					  return {
                        			  label: item.id,
                        			  value: item.id,
                        			  link: item.link,
                        			  name: item.name,
                        			  img: item.img,
                        			  tag: item.tags,
                        			  count: item.count,
                        			  category : item.category,
                        			  index: cnt++
                        			  
                        		  }
            	  })
            	  );
            	  
                
                }
            });

          },
        select: function(event, ui) {
            console.log(ui.item);
            
            window.location = ui.item.link;
        },

        focus: function(event, ui) {
        	$(".div0").css("background", "none");
        	$("#autodiv"+ui.item.index).css("background-color", "lightgrey");
        	console.log(ui.item.index);
        	return false;
        }

    })
    .autocomplete("instance")._renderItem = function(div, item) {
    	if(item.category == "People") {
    		return $("<div class='div0' id='autodiv"+item.index+"'>").append("<div><div id='div1'><img id='searchimg' src='"+item.img+"'><div id='textdiv'><span style='color: black; font-weight: bold; font-size: 16px;'>"+item.label+"</span><br><span style='color: gray;'>"+item.name+"</span></div></div></div>").appendTo(div);
    	}else if(item.category == "Tag") {
    		return $("<div class='div0' id='autodiv"+item.index+"'>").append("<div><div id='div1'><img id='searchimg' src='"+item.img+"'><div id='textdiv'><span style='color: black; font-weight: bold; font-size: 16px;'>#"+item.tag+"</span><br><span style='color: gray;'>게시물 "+item.count+"개</span></div></div></div>").appendTo(div);
    	}
    	
    };
    
    
    
    

});
</script>




 <span style="color: black;"></span>
      <div id="topwrapper">
          <nav class="navbar navbar-expand-md navbar-light" id="navbar">
            <div class="container" id="navcontainer">
              <i class="fab fa-instagram fa-2x" id="instagramicon"></i>
              <div class="logo"><a class="navbar-brand ml-2 text-white" href="feed.bo">SocialWired</a></div>
              <div class="collapse navbar-collapse">
                  <form id="go" action="search.bo" class="form-inline m-0" onsubmit="return false;">
                  <input id="searchform" class="form-control" name="search" type="text" placeholder="친구의이름과 #'키워드' 를검색하세요">
                </form>
              </div>
              <div id="nav-icons"> 
                <ul class="navbar-nav">
                
                 <li class="nav-item">
                    <a class="nav-link" onclick="openDm()"><i class="far fa-comment-alt nav-icon"><span id="totalreadcount" style='display:none;'></span></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="write.board" ><i class="fas fa-pencil-alt nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="tour.bo?cat=1"><i class="far fa-compass nav-icon"></i></a>
                  </li>
                            <li class="nav-item dropdown">
                   
                    <a class="nav-link dropdown-toggle" href="#" id="alerticon" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
          <i class="far fa-heart nav-icon">
          <span id="totalreadcount2" ><i class="fas fa-comment-alt fa-flip-vertical fa-2x"></i></span>
        </i>   
             
        </a>      
     	            
                    <div class="dropdown-menu dropdown-menu-right px-3" style="width:500px; height:360px; overflow-y:auto;" aria-labelledby="navbarDropdown" id="alertcont">  
     
           </div>
                  </li>
          
                    
                  
                  <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
          <i class="far fa-user nav-icon"></i>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
         <a class="dropdown-item" style="font-family: NANUMBARUNPENR !important;font-size: 12px; width:200px;" href="board.bo?id=${sessionScope.loginId}&cat=1"><i class="fas fa-user mr-1 pr-1 fa-1x"></i>내 계정</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" style="font-family: NANUMBARUNPENR !important;font-size: 12px;" href="profile.member?cat=0"><i class="fas fa-chalkboard-teacher mr-1 pr-1 fa-1x"></i>프로필 편집</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" style="font-family: NANUMBARUNPENR !important;font-size: 12px;" href="calendar.bo"><i class="fas fa-newspaper mr-1 pr-1 fa-1x"></i>나의 게시판</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" style="font-family: NANUMBARUNPENR !important;font-size: 12px;" href="logout.do"><i class="fas fa-sign-out-alt mr-1 pr-1 fa-1x"></i>로그아웃</a>
        </div>
      </li>
                  
                </ul>
              </div>
            </div>
          </nav>
      </div>