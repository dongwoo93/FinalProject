<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css">
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  
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
    
    #search{
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
  <div class="py-5">
    <div class="container mywrap">
      <div class="row">
        <div class="col-4">
          <ul class="nav nav-pills flex-column">
            <li class="nav-item">
              <a href="#profile" class="active nav-link mp" data-toggle="pill" data-target="#tabone">프로필 편집</a>
            </li>
            <li class="nav-item">
              <a href="#password" class="nav-link mp" data-toggle="pill" data-target="#tabtwo">비밀번호 변경</a>
            </li>
            <li class="nav-item">
              <a href="#app" class="nav-link mp" data-toggle="pill" data-target="#tabthree">허가된 앱</a>
            </li>
            <li class="nav-item" >
              <a href="email" class="nav-link mp" data-toggle="pill" data-target="#tabfour">이메일 및 SNS</a>
            </li>
            <li class="nav-item">
              <a class="nav-link mp" href="contact" data-toggle="pill" data-target="#tabfive">연락처 관리</a>
            </li>
            <li class="nav-item">
              <a class="nav-link mp" href="" data-toggle="pill" data-target="#tabsix">공개 범위 및 보안</a>
            </li>
          </ul>
        </div>
        <div class="col-8">
          <div class="tab-content">
            <div class="tab-pane fade show active" id="tabone" role="tabpanel">
            <img src="resources/images/profile_image.jpg" class="rounded-circle" alt="Cinque Terre" width="50">
              <div class="form-group row in">
  <label for="example-text-input" class="col-2 col-form-label">이름</label>
  <div class="col-10">
    <input class="form-control edit" type="text" value="" id="example-text-input">
  </div>
</div>
<div class="form-group row in">
  <label for="example-search-input" class="col-2 col-form-label">사용자 이름</label>
  <div class="col-10">
    <input class="form-control edit" type="text" value="" id="example-search-input">
  </div>
</div>
<div class="form-group row in">
  <label for="example-email-input" class="col-2 col-form-label">웹 사이트</label>
  <div class="col-10">
    <input class="form-control edit" type="text" value="" id="example-email-input">
  </div>
</div>
<div class="form-group row in">
  <label for="example-url-input" class="col-2 col-form-label">이메일</label>
  <div class="col-10">
    <input class="form-control edit" type="text" value="" id="example-url-input">
  </div>
</div>
<div class="form-group row in">
  <label for="example-tel-input" class="col-2 col-form-label">전화번호</label>
  <div class="col-10">
    <input class="form-control edit" type="text" value="" id="example-tel-input">
  </div>
</div>
<div class="form-group row in">
  <label for="example-password-input" class="col-2 col-form-label">성별</label>
  <div class="col-10 in">
    <select class="custom-select edit">
  <option selected value="n">선택안함</option>
  <option value="m">남성</option>
  <option value="f">여성</option>
</select>
  </div>
</div>
<div class="form-group row in">
  <label for="example-color-input" class="col-2 col-form-label">Color</label>
  <div class="col-10">
    <input class="form-control edit" type="color" value="#563d7c" id="example-color-input">
  </div>
</div>
            </div>
            <div class="tab-pane fade" id="tabtwo" role="tabpanel">
              <p class="">Tab pane two. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
            <div class="tab-pane fade" id="tabthree" role="tabpanel">
              <p class="">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
            <div class="tab-pane fade" id="tabfour" role="tabpanel">
              <p class="">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
            <div class="tab-pane fade" id="tabfive" role="tabpanel">
              <p class="">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
            <div class="tab-pane fade" id="tabsix" role="tabpanel">
              <p class="">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
<link rel="stylesheet" type="text/css" href="resources/css/settings.css">

</html>