<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

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

	/* Base Styles */
	:root {
		/* Base font size */
		font-size: 10px;
	}
	
	*,
	*::before,
	*::after {
		box-sizing: border-box;
	}
	
	body{
 		 border : 1px solid black; 
		 height:auto;
		 font-family: "Open Sans", Arial, sans-serif;
		 min-height: 100vh;
		 padding-bottom: 3rem; 
	 
	 } 

    #allwrapper{
      height:auto;
   }
    
    #navbar{
        border-bottom: 1px solid #ccc;
        position: fixed;
        z-index: 1;
        width: 100%;
        background-color: #35e0db;
    }
    
    #topwrapper{
        height:72px;
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
        font-size: 30px;
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
            font-size: 20px;
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
    
    #contents{
        max-width: 1000px;
        margin-left: auto;
        margin-right: auto;
        
    }
    
    #centerwrapper{
        height: 100%;
    }
    
    .portfolio-item {
     	margin-bottom: 20px;
    }
    
    #icon{
    	float: left;
    	font-size: 20px;
    	margin-right: 5px;
    }
    
    #book{
    	float:right;
    	font-size: 20px;
    	margin-right: 5px;
    }

</style>
</head>



<body>
 
      <div id="topwrapper">
          <nav class="navbar navbar-expand-md navbar-light" id="navbar">
            <div class="container" id="navcontainer">
              <i class="fab fa-instagram fa-2x" id="instagramicon"></i>
              <div class="logo"><a class="navbar-brand ml-2 text-white" href="#">SocialWired</a></div>
              <div class="collapse navbar-collapse">
                <form class="form-inline m-0">
                  <input class="form-control" type="text" placeholder="검색" id="search">
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
    <div id="allwrapper">
      <div id="centerwrapper">
        <div class="container" id="contents">
          <!-- choose문 시작하는 지점 -->
          <c:choose> 
          	<c:when test="${result.size() > 0}">

             <div class="row">
             	 <c:forEach var="result" items="${result}">	
			           <div id="bigbox" class="col-lg-4 col-sm-6 portfolio-item" >
			             <div class="card h-150">
			             	<h4 class="card-title">
			             	 <img src="https://scontent-icn1-1.cdninstagram.com/vp/7c370096e65b401d7c23388739c4f142/5C09D614/t51.2885-19/s150x150/37329457_1608380405938260_7561205846328213504_n.jpg" width="30" class="rounded-circle">
				             	 <a>${result.id}</a>
				                 <a href="#">팔로우</a>
			                </h4>
				               <a href="#">
				                 <img class="card-img-top" src='${system_file_name}' alt="Card image cap"> </a>
				               <div class="card-body">
				                <i id="icon" class="far fa-heart"></i>
				                <i id="book" class="far fa-bookmark"></i>
				                <i id="icon" class="far fa-comment"></i>
			              	   </div>
			             </div>
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
              <div class="row" >
                <div class="col-md-10">
                  <p class="lead">SocialWired 정보지원홍보 센터API채용 정보개인정보처리방침약관디렉터리프로필해시태그언어
</p>
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