<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	
	body{
	 border : 1px solid black;
	 height:auto;
	 
	 
	}
    #allwrapper{
      height:auto;
      border : 1px solid black;
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
    
    #search{
        height: 25px;
        border: 0.6px solid #ccc;
    }
    
    #instagramicon {
        color: white;
        border-right: 1px solid white;
        padding-right: 13px;
    }
    
    .nav-icon{
        font-size: 22px;
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
    
  	#a{
  	 height : auto;	
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
                    <a class="nav-link" href="#" ><i class="fas fa-pencil-alt nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-compass nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-heart nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-user nav-icon"></i></a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
      </div>
   
   
   <div id="a">
    	하핫
   </div>
    
    
    <div id="allwrapper">
   		

  
      <div id="centerwrapper">
      
 
        <div class="container" id="contents">
        

    <div class="container-fluid p-1">
      <div class="row ">
        <div class="p-0 col-md-4 col-6 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_dogs.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_bird.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_farm.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_girl.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_nose.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
        <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
           <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
           <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
           <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
           <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
           <div class="col-md-4 col-6 p-0 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_feet.jpg" class="img-fluid"> </div>
           <div class="p-0 col-md-4 col-6 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_dogs.jpg" class="img-fluid"> </div>
           <div class="p-0 col-md-4 col-6 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_dogs.jpg" class="img-fluid"> </div>
           <div class="p-0 col-md-4 col-6 p-1">
          <img src="https://pingendo.github.io/templates/sections/assets/gallery_dogs.jpg" class="img-fluid"> </div>
          
      </div>
    </div>
  
            
        </div>
      </div>
</div>
 
      <div class="pt-4 pb-3  " id="footer">
           <div class="container">
              <div class="row" >
                <div class="col-md-10">
                  <p class="lead">SocialWired 정보지원홍보 센터API채용 정보개인정보처리방침약관디렉터리프로필해시태그언어</p>
                </div>

                <div class="col-4 col-md-2 align-self-center">
                  <p>@2018SocialWired</p>
                </div>
              </div>
          </div>
      </div>
  
</body>

</html>