<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">


    <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <style>
        /*    전체적인틀 CSS*/

        #allwrapper {
            height: auto;
        }

        #navbar {
            border-bottom: 1px solid #ccc;
            position: fixed;
            z-index: 1;
            width: 100%;
            background-color: #80DEEA;
        }

        #topwrapper {
            height: 72px;
        }

        #navcontainer {
            max-width: 1000px;
        }

        #search {
            height: 25px;
            border: 0.6px solid #ccc;
        }

        #instagramicon {
            color: white;
            border-right: 1px solid white;
            padding-right: 13px;
        }

        .nav-icon {
            font-size: 22px;
            color: white;
        }

        .nav-item>a {
            margin-left: 25px;
        }

        .navbar-nav {
            flex-direction: row;
        }

        @media(max-width: 768px) {
            .nav-icon {
                font-size: 20px;
            }
        }

        @media(min-width: 430px) {
            .logo {
                display: flex !important;
                flex-basis: auto;
            }
        }

        @media(max-width: 411.33px) {
            .nav-item>a {
                margin-left: 40px;
            }
        }

        .logo {
            display: none;
            flex-grow: 1;
        }

        #mainname {
            color: white;
        }

        #contents {
            max-width: 1000px;
            margin-left: auto;
            margin-right: auto;

        }

        #centerwrapper {
            height: 100%;
        }

        /*    전체적인틀 CSS 끝*/

        /*    글쓰기 contents CSS*/

        #writeform {
            width: 100%;
            margin-top: 3%;
        }

        #writetextarea {
            width: 100%;
            height: 250px;
            resize: none;
        }

        #submitbutton {
            border: none;
            background-color: white;
            cursor: pointer;
        }
        
        .imgWidth100 {
            width: auto;
            max-width: 100%;
            height: auto;
            vertical-align:middle;
        }
        
/*
        .divImgWidth100 {
            background-size: contain; 
            background-repeat: no-repeat; 
            background-position: center; 
            width: 100%; 
            height: 300px;
        }
*/
        
        #attachDivInner{
            
            text-align: center;
/*            display: table; margin-bottom: auto; margin-top: auto;*/
/*
            
            display:flex;
            justify-content:center;
            align-items:center;
*/
            line-height:620px;
        }
        
        
        
        
    </style>
    <script>
        // var filesArr = Array.prototype.slice.call(files);

        //        var index = 0;
        //        filesArr.forEach(function(f) {
        //            selImages.push(f);
        //
        //            if (input.files && input.files[index]) {
        //                var reader = new FileReader();
        //
        //                reader.onload = function(e) {
        //                  // $('#frontImage').attr('src', e.target.result);
        //                    $('frontImage').append(index)
        //                }
        //                reader.readAsDataURL(input.files[index]);
        //          }
        //        })

        //   }
        
         function imageInfo(obj){                 
                  
                  console.log(obj.width);
                  console.log(obj.height);
                  console.log(obj.naturalWidth);
                  console.log(obj.naturalHeight);
                  
              }
        
        var maxHeight = 0;
        function staticSetMaxImageHeight(obj) {
            console.log(obj.height );
            if ( maxHeight <= obj.height ){
                maxHeight = obj.height ;
                
            }
            console.log("mxh: " + maxHeight);
        }
        

        $(document).ready(function() {    
            
           
            
            $('#fileSelect').change(function() {
                alert('change')
                $('#attachDivInner').html('');
                readImage(this);
            })

            var selImages = [];
                   

            function readImage(input) {

                var files = input.files;

                console.log(files);

                for (i = 0; i < files.length; i++) {

                    console.log(files[i])

                    if (files[i].size > 1024 * 1024 * 10) {
                        alert('10MB 초과');
                        continue;
                    }

                    if (input.files && input.files[i]) {
                        var reader = new FileReader();

                        if (i == 0) {
                            reader.onload = function(e) {
                                $('#attachDivInner').append("<div class='carousel-item active'><img src='" + e.target.result + "' class='imgWidth100' onload='javascript:staticSetMaxImageHeight(this)'></div>");                                  
                                
                                
                            }
                        
                        } else {
                            reader.onload= function(e) {
                                $('#attachDivInner').append("<div class='carousel-item'><img src='" + e.target.result + "' class='imgWidth100' onload='javascript:staticSetMaxImageHeight(this)'></div>");                            
                                // alert('Final Max Height :' + maxHeight) 
//                                if (maxHeight > 620){
//                                    maxHeight = 620;
//                                } else if (maxHeight < 400){
//                                    maxHeight = 400;
//                                } else {
//                                    maxHeight = maxHeight
//                                }
//                             $('#attachDiv').css('height', maxHeight + 'px');
//                                maxHeight = 0;
                                
                                
  
                            }                          
                        }             
                        
                        
                        
                    }

                    reader.readAsDataURL(input.files[i]);
                    console.log(reader);     
                   
                              
                    
                }             
                
                    
                    // $('.imgWidth100').map(function(e){console.log(e)});
                
               

            }
        })
    </script>

</head>

<body>

    <div id="topwrapper">
        <nav class="navbar navbar-expand-md navbar-light" id="navbar">
            <div class="container" id="navcontainer">
                <i class="fab fa-instagram fa-2x" id="instagramicon"></i>
                <div class="logo"><a class="navbar-brand ml-2 " href="#" id="mainname">Instagram</a></div>
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
                            <a class="nav-link" href="#"><i class="fas fa-pencil-alt nav-icon"></i></a>
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
    <div id="allwrapper">
    <form action='' method=post enctype="multipart/form-data">
        <div id="centerwrapper" class="pt-3">
            <div class="container" id="contents">
                <div class="row">
                    <div class="col-md-7 align-self-center">
                        <!-- -->
                        <input type="file" multiple=multiple id="fileSelect" name="filename[]">
                        <i class="far fa-images"></i>
                        <!-- -->
<!--                        <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_14.jpg" style="width: 100%;" id='frontImage'>-->


                        <div id="attachDiv" style="height: 600px;">
                            <div id="carouselAttachDiv" class="carousel slide " data-ride="carousel">
                                <div class="carousel-inner" id=attachDivInner>
                                    <div class="carousel-item">
                                    </div>
                                </div>
                                  <a class="carousel-control-prev" href="#carouselAttachDiv" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselAttachDiv" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                            </div>
                              
                        </div>


                        <div id="filter">
                            <div id="carouselExampleControls" class="carousel slide " data-ride="carousel">
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <div class="row">
                                            <div class="col-md-3 col-6 p-1">
                                                <a href="#">
                                  <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_2.jpg"> </a>
                                            </div>
                                            <div class="col-md-3 col-6 p-1">
                                                <a href="#">
                                  <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_14.jpg"> </a>
                                            </div>
                                            <div class="col-md-3 col-6 p-1">
                                                <a href="#">
                                  <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_16.jpg"> </a>
                                            </div>
                                            <div class="col-md-3 col-6 p-1">
                                                <a href="#">
                                  <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_16.jpg"> </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="carousel-item">
                                        <div class="row">
                                            <div class="col-md-3 col-6 p-1">
                                                <a href="#">
                                  <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_2.jpg"> </a>
                                            </div>
                                            <div class="col-md-3 col-6 p-1">
                                                <a href="#">
                                  <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_14.jpg"> </a>
                                            </div>
                                            <div class="col-md-3 col-6 p-1">
                                                <a href="#">
                                  <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_16.jpg"> </a>
                                            </div>
                                            <div class="col-md-3 col-6 p-1">
                                                <a href="#">
                                  <img class="d-block img-fluid" src="https://pingendo.github.io/templates/sections/assets/gallery_16.jpg"> </a>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5" id="writeform">
                        <div class="card">
                            <div class="card-body">
                                <textarea id="writetextarea" class="form-control p-0" placeholder="Contents..."></textarea>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><a>위치 태그하기</a></li>
                                <li class="list-group-item"><a>사람 태그하기</a></li>
                            </ul>
                        </div>
                        <div class="py-3">
                            <button type="submit" id="submitbutton"><i class="fas fa-arrow-right fa-2x"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>

        <div class="pt-4 pb-3" id="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-10">
                        <p class="lead">Sign up to our newsletter for the latest news</p>
                    </div>

                    <div class="col-4 col-md-2 align-self-center">
                        <p>@2018Instagram</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>