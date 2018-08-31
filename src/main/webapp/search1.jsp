<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/search1.css">   

<script>
/* 좋아요 Script */
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
         console.log("들어왔니" +resp);
         $(e).next().show();
         $(e).hide(); 
         /* 좋아요 카운트 */
         if(resp != 0) {
            $("#count"+board_seq).text(resp + "명이 좋아합니다");
         }else {
            $("#count"+board_seq).text("");
         }
         
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
         console.log(resp);  
         $(e).prev().show();
         $(e).hide(); 
         /* 좋아요 카운트 */
         if(resp != 0) {
            $("#count"+board_seq).text(resp + "명이 좋아합니다");
         }else {
            $("#count"+board_seq).text("");
         }
         
      },
      error : function() {
         console.log("에러 발생!");
         }
      })
}
/* 북마크 Script */
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

</script>




<div id="allwrapper">
	<input type="text" id=caretposition>
	<div class="" id="centerwrapper">
		<div class="container" id="contents">
		
			
		<table class="table">  
									<thead>
										<tr>
											<th class="text-center" style="font-family: NANUMBARUNPENR !important;box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.2), 0 1px 1px 0 rgba(0, 0, 0, 0.19);"><a
												href="search.bo?search=${search}" style="font-family: NANUMBARUNPENR !important;color:#4f70ce;font-size:14px;">바둑판</a></th>
											<th class="text-center" style="font-family: NANUMBARUNPENR !important;box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.2), 0 1px 1px 0 rgba(0, 0, 0, 0.19);"><a
												href="search1.bo?search=${search}" style="font-family: NANUMBARUNPENR !important;color:#4f70ce;font-size:14px;">피드</a></th> 
										</tr>
									</thead>
								</table>
		

<c:choose> 
<c:when test="${result.size() <0}">
	<h1>검색 결과가 없습니다.</h1>
</c:when>
<c:otherwise>

<c:forEach var="result" items="${result}">

		<div class="py-2 my-5" id="feed">
                  <div class="profile-image">
                     <img class="ml-3 mr-2"
                        src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
                    
                     <br> 
                     <a class="mt-1 idtxt" id="id" href="#">
                    
						${result.id}
						
                     
                     </a>
                  </div>
                  
		
		<div class="mt-2" id="boardimg">
							<div id="myCarousel0" class="carousel slide" data-ride="carousel"
								data-interval="false" style="height: 600px;">
								<ul id="carousel-indicators" class="carousel-indicators">
									<li id="firstli" data-target="#myCarousel0" data-slide-to="0"
										class="active"></li>
									<c:forEach begin="1" var="media"
 										items="${result2[0]}" varStatus="status2"> 
 										<li data-target="#myCarousel0" data-slide-to="${status2.index}"></li> 
 									</c:forEach> 
								</ul>
								<div id="carousel-inner" class="carousel-inner" style="height: 600px;">
									<div id="firstItem" class="carousel-item active">
										<img class='boardimg' width='100%' src='AttachedMedia/${result2[0][0].system_file_name}' alt=''>
									</div> 
									<c:forEach begin="1" var="media"
										items="${result2[0]}">
										<div class="carousel-item">
 											<img class='boardimg' width='100%' 
 												src="AttachedMedia/${media.system_file_name}" alt="">
										</div> 
 									</c:forEach> 

								</div>

								<a id="carousel-prev0" class="carousel-control-prev" href="#myCarousel0"
									data-slide="prev"> <span class="carousel-control-prev-icon"></span>
								</a> <a id="carousel-next0" class="carousel-control-next"
									href="#myCarousel0" data-slide="next"> <span
									class="carousel-control-next-icon"></span>
								</a>
							</div>

						</div>
		
		<div id="cont">
		
		<nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
                        <div class="container">
                           <a class="navbar-brand"> 
                           <c:choose>
                           <c:when test="${not empty like}">    
                         			  <i 
                                       style="cursor: pointer; display: none; " id="likeit"
                                       class="far fa-heart icon mr-1"  onclick="likeit(this)"></i>
                                    <i 
                                       style="font-weight: bold;  color: red; cursor: pointer;"
                                       id="likecancel" class="far fa-heart icon mr-1"
                                       onclick="unlikeit(this)"></i>
                           </c:when>
                           <c:otherwise>
                           			<i 
                                       style="cursor: pointer; " id="likeit"
                                       class="far fa-heart icon mr-1" onclick="likeit(this)"></i>
                                    <i 
                                       style="font-weight: bold; display: none; color: red; cursor: pointer;"
                                       id="likecancel" class="far fa-heart icon mr-1"
                                       onclick="unlikeit(this)"></i>
                           </c:otherwise>
                           </c:choose>
                                    
                                 <i class="far fa-comment icon"></i>
                           </a>
                           <c:choose>
                             <c:when test="${not empty bookmark}">
                           <a class="btn navbar-btn ml-2 text-white ">                                                    
                                    <i  id="mark"
                                       class="far fa-bookmark icon"
                                       style="cursor: pointer; display: none;"
                                       onclick="markit(this)"></i>
                                    <i 
                                       style="cursor: pointer;  font-weight: bold; color: #00B8D4;"
                                       id="markcancel"  class="far fa-bookmark icon"
                                       onclick="unmarkit(this)"></i>                                      
                           </a>            
                             </c:when>
                              <c:otherwise>
                           			 <a class="btn navbar-btn ml-2 text-white "> 
                           			 
                                    <i  id="mark"
                                       class="far fa-bookmark icon"
                                       style="cursor: pointer; "
                                       onclick="markit(this)"></i>
                                    <i 
                                       style="cursor: pointer; display: none;  font-weight: bold; color: #00B8D4;"
                                       id="markcancel"  class="far fa-bookmark icon"
                                       onclick="unmarkit(this)"></i>                       
                           </a>
                            </c:otherwise>
                           </c:choose>
                        </div>
                     </nav>
				
		<div id="contcenter" class="mt-2 mx-3 pb-2">
		
		<div class="navbar-nav">
                           <a class="ml-1 idtxt" id="con"
                              href="">${result.id}</a>

                           <div class='pl-3' id="contdiv">
                         
                           	<script>
                        		  var regex = /(#[^#\s,;<>. ]+)/gi;
                        		  var originalText = "${b.contents}"
                        		  var innerCode = ""
                                  if (regex) {
                                      innerCode = "<span class=fugue>" + originalText
                                          .replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                                              "</a><span class=fugue>") + "</span>"
                                      innerCode += "<kz></kz>"
                                      /* document.write(innerCode) */
                                      $('#contdiv').html(innerCode);
                                  }
                        		</script>
                           </div>
                           
                           
                           <script> 
                           
                           
                           
     /*      var regex = /(#[^#\s,;]+)/gi  ;            
        var txt = "${tmp.contents}";                    
          var newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");        
          // $("#contdiv").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);           
      $("#contdiv${tmp.board_seq}").html(newtxt);    
        
      function tag(e) {
         var search = $(e).html().split("#")[1]; 
         $(location).attr("href","search.bo?search="+search); 

      }
 */
      </script>
                        </div>
                     
                        <div class="comment-contents" id="comment-contents">
                       
                     <%--   <c:forEach var="item" items="${result}">
                          
                        <ul class="commentline navbar-nav"  onmouseover="commentover(this)" value="${item.comment_seq}" onmouseleave="commentleave(this)">
                        <li id="li1"><a href="#" id="writerId${item.comment_seq}">${item.id}</a></li>
                        <li id="li2">
                        	
                        	<div contenteditable=false id="commentSection${item.comment_seq}" class='commenttxt'>
                        		<script>
                        		  var regex = /(#[^#\s,;<>. ]+)/gi;
                        		  var originalText = "${item.comment_contents}"
                        		  var innerCode = ""
                                  if (regex) {
                                      innerCode = "<span class=fugue>" + originalText
                                          .replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                                              "</a><span class=fugue>") + "</span>"
                                      innerCode += "<kz></kz>"
                                      /* document.write(innerCode) */
                                      $("#commentSection${item.comment_seq}").html(innerCode)
                                  }
                        		</script>
                        	</div>
                        </li>
                       			
                        <li id="li3"><a style="cursor:pointer;" onclick="delComment(this)"  id="commentdel${item.comment_seq}"></a></li>     
                        <li id="li4"><a style="cursor:pointer;" onclick="modComment(this)" id='commentmod${item.comment_seq}'></a></li>
                        
                        </ul>                       
                        </c:forEach> --%>
            				<input type=hidden id='sessionid' value="${sessionScope.loginId}">            
                        
                        </div>
                        
		</div> <!-- contcenter -->
		   <div class="crecodiv py-2 navbar-nav">   


                      
                           <!-- <input type="text" placeholder="댓글 달기..." name="comment_contents" class="creco  ml-2 " id="comment"> -->
                           <div contenteditable=true class="creco ml-3" id="comment">댓글 달기...</div>
                           <input type=hidden id=shifted_comment name=comment_contents>
                           <input type=hidden id="caretposition" value="0">

                              <div class="btn-group">
                                 <i id="modalBoardBtn" onclick="modal(this)" class="fas fa-ellipsis-h btn mr-1"
                                    data-toggle="modal"> </i>
                              </div>

                        
                     </div> <!-- crecodiv -->
		
		</div><!-- cont -->
		
		</div> <!--  feed  -->
		

	
</c:forEach>  

</c:otherwise>
</c:choose>
	
      </div>
      <!-- container -->
      
     
      
   </div>
   <!-- centerwrapper -->
   
</div>
<!--  allwrapper-->
										
      <%@ include file="include/bottom.jsp"%>





