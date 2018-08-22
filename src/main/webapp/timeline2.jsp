<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/timeline.css">
<script> var currentId = "${sessionScope.loginId}"; </script>
<script src="resources/js/timeline.js"></script>
<script>
	
	$(function () {

		var ws = new WebSocket("ws://192.168.120.102/websocket?loginId=${sessionScope.loginId}");
		
		ws.onopen = function () {

		};
		
		ws.onmessage = function (msg) {
			var receivernickname = $("#dmnickname").text();
			$("#messagebox").append("<div class='message-box-holder'><div class='message-sender'><a>"+receivernickname+"</a></div><div class='message-box message-partner'>"+msg.data+"</div></div>");
	    };
		
	    ws.onclose = function (event) {

	    };
	    
	    $("#sendDm").keydown(function(key) {
			var message = $("#sendDm").val(); 
			var receiver = $("#userId").val();
			if (key.keyCode == 13) {
				$("#sendDm").val("");
				$.ajax({
	                url: "insertMessage.do", // 처리할 페이지(서블릿) 주소
	                type: "get",
	                data: {message:message,receiver:receiver,sender:"${sessionScope.loginId}"}, 
	                success: function(response) {
	                	console.log(response);
	                	if(response == "전송성공"){
	                		ws.send(receiver+":"+message);
		                	$("#messagebox").append("<div class='message-box-holder'><div class='message-box'>"+message+"</div></div>");
		                	var objDiv = document.getElementById("messagebox");
                            objDiv.scrollTop = objDiv.scrollHeight;   
	                	}
	                },
	                error: function() {
	                    console.log("에러");
	                },
	                complete: function(){
	                    console.log("AJAX완료");
	                }
	            });   
				
			}
		});
	});
	
	$(document).ready(function(){
		$('.chatbox').hide();
		
		$("#allwrapper").click(function(){
			closeDm();
		});
	});
  
    AOS.init();
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
    
    function commentover(e) { 
    	
	var seq = $(e).attr("value"); 
    var sessionid = $("#sessionid").val();
	var boardid = $("#boardid").val();  
	
		$("#ul"+seq).attr("style","background-color:#E1F5FE");
		$("#commenttxt"+seq).attr("style","word-wrap: break-word; background-color:#E1F5FE"); 
		
		if(sessionid == boardid) {      
		$("#commentdel"+seq).html("삭제");   
		$("#commentmod"+seq).html("수정");
		}  
	
    }
    
    function commentleave(e) {
    	var seq = $(e).attr("value"); 
		 
		$("#ul"+seq).attr("style",false);            
		$("#commenttxt"+seq).attr("style","word-wrap: break-word;"); 
		$("#commentdel"+seq).html("");  
		$("#commentmod"+seq).html("");
  
    }
    
    function delComment(e) {
			var board_seq = $(e).attr("value").split(":")[0]; 
			var comment_seq = $(e).attr("value").split(":")[1];
        	$.ajax({
                  type: "POST",  
                  url: "commentdel.co",      
                  data: {board_seq:board_seq,comment_seq:comment_seq},
                  success : function(cnt) {
                	  console.log(cnt);
                   $("#ul"+comment_seq).remove();    
                   if(cnt>2){ 
                       $("#myComment"+board_seq).html("&nbsp&nbsp모두 "+cnt+"개의 댓글보기")}
                       else {
                    	   $("#myComment"+board_seq).html("");  
                       }
                  }
                    
             }) //ajax 
    }

    function modComment(e) { 
       
      	 var comment_seq = $(e).attr("value");
    
      		 
      		 $("#commenttxt"+comment_seq).attr("contentEditable",true);
          	 $("#commenttxt"+comment_seq).attr("style","border:0.5px solid lightgray");
          	 $("#commenttxt"+comment_seq).focus();  
        
          	$(e).click(function() {
          			 var txt = $("#commenttxt"+comment_seq).val();
             	 	  
                    	$.ajax({    
                              type: "POST",    
                              url: "commentmod.co",    
                              data: {comment_seq:comment_seq, comment_contents:txt},   
                              success : function() {
                            	$("#commenttxt"+comment_seq).attr("contentEditable",false);
     		                    $("#commenttxt"+comment_seq).attr("style","border:none"); 
     		                   $("#commenttxt"+comment_seq).attr("style","background-color:#E1F5FE");
                              }  
                         }); //ajax 
          	})
          
    }
    
    
    function goBoard(){
    	var board_seq = $("#modalseq").val();
    	
    	$(location).attr('href','oneBoard.do?board_seq='+board_seq);
    }
    	
    function commentdisplay(e) {   
    	var board_seq = $(e).next().val(); 
    	$(".co"+board_seq).attr("style",false);      
    	$("#commenthide"+board_seq).html("접기");    
     
    }
    
    function commenthide(e) {  
    	var board_seq = $(e).next().val(); 
    	$(".co"+board_seq).attr("style","display:none;");    
    	$("#commenthide"+board_seq).html("");
    }
</script>
<div id="allwrapper">
	<div class="" id="centerwrapper">
		<div class="container" id="contents">
			<div id="board">

				<script>var num = 1;</script>

				<c:forEach var="tmp" items="${result}" varStatus="status">

					<div class="py-2 my-5" data-aos="fade-up" data-aos-once="true"id="feed">
						<div class="profile-image">
							<img class="ml-3 mr-2"
								src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
							<%--               <h5 class="mt-1 idtxt">${tmp.id}</h5>  --%>
							<br> 
							<a class="mt-1 idtxt" id="id" href="board.bo?id=${tmp.id}">${tmp.id}<br>Dangsan.South Korea</a>
						</div>
						<div class="mt-2" id="boardimg">
							<div id="myCarousel${status.index}" class="carousel slide" data-ride="carousel"
								data-interval="false" style="height: 600px;">
								<ul id="carousel-indicators" class="carousel-indicators">
									<li id="firstli" data-target="#myCarousel${status.index}" data-slide-to="0"
										class="active"></li>
									<c:forEach begin="1" var="media"
										items="${result2[status.index]}" varStatus="status2">
										<li data-target="#myCarousel${status.index}" data-slide-to="${status2.index}"></li>
									</c:forEach>
								</ul>
								<div id="carousel-inner" class="carousel-inner" style="height: 600px;">
									<div id="firstItem" class="carousel-item active">
										<img class='boardimg' width='100%' src='AttachedMedia/${result2[status.index][0].system_file_name}' alt=''>
									</div> 
									<c:forEach begin="1" var="media"
										items="${result2[status.index]}">
										<div class="carousel-item">
											<img class='boardimg' width='100%'
												src="AttachedMedia/${media.system_file_name}" alt="">
										</div>
									</c:forEach>

								</div>

								<a id="carousel-prev${status.index}" class="carousel-control-prev" href="#myCarousel${status.index}"
									data-slide="prev"> <span class="carousel-control-prev-icon"></span>
								</a> <a id="carousel-next${status.index}" class="carousel-control-next"
									href="#myCarousel${status.index}" data-slide="next"> <span
									class="carousel-control-next-icon"></span>
								</a>
							</div>

						</div>
  

						<div id="cont">
							<nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
								<div class="container">
									<a class="navbar-brand"> <c:choose>
											<c:when test="${like.containsKey(tmp.board_seq)}">
												<i value="${tmp.board_seq}"
													style="display: none;" id="likeit"
													class="far fa-heart icon mr-1 pointer" onclick="likeit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: red;"
													id="likecancel" class="far fa-heart icon mr-1 pointer"
													onclick="unlikeit(this)"></i>
											</c:when>
											<c:otherwise>
												<i value="${tmp.board_seq}"
													id="likeit" class="far fa-heart icon mr-1 pointer"
													onclick="likeit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: red; display: none; "
													id="likecancel" class="far fa-heart icon mr-1 pointer"
													onclick="unlikeit(this)"></i>

											</c:otherwise>
										</c:choose> <i class="far fa-comment icon"></i>
									</a>
									
									<a class="btn navbar-btn ml-2 text-white "> <c:choose>
											<c:when test="${bookmark.containsKey(tmp.board_seq)}">

												<i value="${tmp.board_seq}" id="mark"
													class="far fa-bookmark icon pointer"
													style=" display: none;"
													onclick="markit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: #00B8D4;"
													id="markcancel" class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>

												<i value="${tmp.board_seq}" id="mark"
													 class="far fa-bookmark icon pointer"
													onclick="markit(this)"></i>
												<i value="${tmp.board_seq}"
													style=" font-weight: bold; color: #00B8D4; display: none;"
													id="markcancel" class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:otherwise>
										</c:choose>




									</a>
								</div>
							</nav>



							<div id="contcenter" class="mt-2 mx-3 pb-2">
								<!-- 글내용자리 -->
								<div class="navbar-nav">
									<a class="ml-1 idtxt" id="con${tmp.board_seq}"
										href="board.bo?id=${tmp.id}">${tmp.id}</a>

									<div class='pl-3' id="contdiv${tmp.board_seq}"></div>
									<script>
			 var regex = /(#[^#\s,;]+)/gi  ;            
		  var txt = "${tmp.contents}";                    
          var newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");        
          // $("#contdiv").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);           
      $("#contdiv${tmp.board_seq}").html(newtxt);    
        
      function tag(e) {
         var search = $(e).html().split("#")[1]; 
         $(location).attr("href","search.bo?search="+search); 

      }

		</script>
								</div>
								<!-- 글내용자리 -->

								<p class="text-info pointer pt-4 mb-1" id="myComment${tmp.board_seq}" onclick="commentdisplay(this)"></p>
								<input type=hidden  value="${tmp.board_seq}">  
								<div class="comment-contents" id="comment-contents${tmp.board_seq}" >  

									<!-- 댓글자리 -->

									<c:forEach var="commenttmp" items="${commentresult}">
										<c:choose>
											<c:when test="${commenttmp.key == tmp.board_seq}">
											
													<c:if test="${commenttmp.value.size() > 2 }">
														<script>    
                     $("#myComment${tmp.board_seq}").html("&nbsp&nbsp모두 ${commenttmp.value.size()}개의 댓글보기")
                     var num = 0;
                     </script>    
                     </c:if>    
											
												<c:forEach var="comment" items="${commenttmp.value}">
  
							<ul id="ul${comment.comment_seq}" style="display:none"  value="${comment.comment_seq}" onmouseover="commentover(this)" onmouseleave="commentleave(this)" class='commentline navbar-nav co${tmp.board_seq}'>       
							<li id='li1'><a href="board.bo?id=${comment.id}">${comment.id}</a></li>     
							<li id='li2'><div id='commenttxt${comment.comment_seq}' class='commenttxt txt${tmp.board_seq}' style='word-wrap: break-word;'>${comment.comment_contents }</div></li> 
	
							<li id='li3'><a id='commentdel${comment.comment_seq}' value="${tmp.board_seq}:${comment.comment_seq}" onclick="delComment(this)" class="pointer"></a> </li>
							<li id='li4'><a id='commentmod${comment.comment_seq}' value="${comment.comment_seq}" onclick="modComment(this)" class="pointer"></a> </li>    
  
							</ul>  
							  
							<script>
							$("#ul${commenttmp.value[0].comment_seq}").attr("style",false);
							$("#ul${commenttmp.value[1].comment_seq}").attr("style",false);
							</script>
							 
						</c:forEach>
						
							</c:when>  
								</c:choose>
							
						</c:forEach>
						</div>       
						<p class="text-info pointer pt-3 pl-1" id="commenthide${tmp.board_seq}" onclick="commenthide(this)"></p>
						<input type=hidden  value="${tmp.board_seq}">  
								</div>


 
							<!--               -->

        
							<div class="crecodiv pl-2 py-2 navbar-nav">

  
							
									<input type="text" placeholder="댓글 달기..." name="comment_contents${tmp.board_seq}" class="creco  ml-2 " id="comment${tmp.board_seq}">

										<div class="btn-group bg-white">
											<i id="modalBoardBtn${tmp.board_seq}" value="${tmp.board_seq}:${tmp.id}" onclick="modal(this)" class="fas fa-ellipsis-h btn mr-1"
												data-toggle="modal"> </i>
										</div>

								
							</div>

							<script>
						
					
								$('#comment${tmp.board_seq}').keypress(function(event){
	                                var keycode = (event.keyCode ? event.keyCode : event.which);
	                                if(keycode == '13'){
	                                   var text = $("#comment${tmp.board_seq}").val();
	                                   if(text == ""){
	                                      alert("댓글을 입력해주세요");
	                                   }
	                                   else {  
	                                      $.ajax({ 
	                                              type: "POST",  
	                                              url: "comment.co",    
	                                              data: {board_seq:${tmp.board_seq}, comment_contents : text},
	                                              success : function(seq) {     
	                                               $("#comment${tmp.board_seq}").val("");              
	                                               $("#comment-contents${tmp.board_seq}").prepend("<ul class='navbar-nav commentline' id='ul"+seq+"' value='"+seq+"' onmouseover='commentover(this)' onmouseleave='commentleave(this)'><li id='li1' ><a href='board.bo?id=${sessionScope.loginId}'>${sessionScope.loginId}</a></li><li id='li2'><div id='commenttxt"+seq+"' style='word-wrap: break-word;' class='commenttxt'>"+text+"</div></li><li id='li3'><a id='commentdel"+seq+"' onclick='delComment(this)' value='${tmp.board_seq}:"+seq+"' class='pointer'></a> </li><li id='li4'><a id='commentmod"+seq+"' value='"+seq+"' onclick='modComment(this)'  class='pointer'></a></li></ul>");
	                            				  }
		                                     }); //ajax 
		                                   }    
		                                }  
		                            }); 
							 

						 		</script>
						</div>
						<!--cont  -->
					</div>
					<!-- feed -->
					<script>
					if("${result2[status.index].size()}" == 1) {
   						$("#carousel-prev${status.index}").hide();
						$("#carousel-next${status.index}").hide();
    	        	   }else {
    	        		   $("#carousel-prev${status.index}").show();
    	        		   $("#carousel-next${status.index}").show();
    	        	   }
					</script>
				</c:forEach>
			</div>
			<!-- board -->


		</div>
		<!-- container -->
		<div class="col-md-6 align-self-center" id="side">
			<br>
		</div>
	</div>
	<!-- centerwrapper -->
</div>
<!--  allwrapper-->


<div class="modal fade" id="changeBoardModal" tabindex="-1" role="dialog">
   <!-- <div class="modal-dialog modal-dialog-centered" role="document">
  			<input type=hidden id=modalseq>
  			    <div class="modal-content">
               <div class="modal-body">
               <div class="dropdown-divider" ></div>   
                  <a class="dropdown-item" onclick="goBoard()">게시물로 이동</a>
                  <div class="dropdown-divider" ></div>
                  <a class="dropdown-item" onclick="modal2(this)" style="cursor: pointer;">부적절한 콘텐츠 신고</a>
                  <div class="dropdown-divider" ></div>
                  <a class="dropdown-item" href="#">링크 복사</a>
                  <div class="dropdown-divider" ></div> 
                  <a class="dropdown-item" href="#">팔로우 취소</a>   
                  
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary"
                     data-dismiss="modal">Close</button>
               </div>
            </div>
         
   </div> -->
</div>

<div class="modal" id="changeBoardModal2" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered" role="document">
  			<input type=hidden id=modalseq>
  			    <div class="modal-content">
  			    <div class="modal-header">
          			<h4 class="modal-title">신고</h4>
        		</div>
               <div class="modal-body"> 
                  <a class="dropdown-item mo" onclick="">폭력 또는 폭력 위협</a>
                  <div class="dropdown-divider" ></div>
                  <a class="dropdown-item mo" onclick="">마약 판매 및 홍보</a>
                  <div class="dropdown-divider" ></div>
                  <a class="dropdown-item mo" onclick="">괴롭힘 및 따돌림</a>
                  <div class="dropdown-divider" ></div> 
                  <a class="dropdown-item mo" onclick="">지적 재산권 침해</a>
                  <div class="dropdown-divider" ></div> 
                  <a class="dropdown-item mo" onclick="">스스로 신체적 상해를 입히는 행위</a> 
                  
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary"
                     data-dismiss="modal">Close</button>
               </div>
            </div> 
   </div>
</div>

<div class="modal" id="reportModal" tabindex="-1" role="dialog">
   <div class="modal-dialog modal-dialog-centered" role="document">
  			<input type=hidden id=modalid>
  			    <div class="modal-content">
  			    <div class="modal-header">
          			<h4 class="modal-title">신고</h4>
        		</div>
               <div class="modal-body">
                <div style="text-align: left;">
                <p style="color: #262626; font-weight: 600; margin-bottom: 8px;">편파적 발언 또는 상징으로 신고할까요?</p>
                <p style="margin-bottom: 8px;">삭제 대상:</p>
                <ul style="list-style-type: disc; margin: 0 0 8px 0;">
                <li style="margin-bottom: 8px;">나치 상징(하켄크로이츠)이나 백인 우월주의를 나타내는 손 모양 등 편파적 발언 또는 상징에 관한 사진</li>
                <li style="margin-bottom: 8px;">폭력을 조장하거나 사람의 정체성을 바탕으로 공격하는 내용의 게시물</li>
                <li style="margin-bottom: 8px;">신체적 상해, 절도 또는 기물 파손에 대한 협박</li>
                </ul>
                <p style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는 공개되지 않습니다.</p>
                <p style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급 서비스 기관에 연락하세요.</p>
                <button type="button" class="btn btn-primary" style="width: 100%">제출</button>
                </div>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary"
                     data-dismiss="modal">Close</button>
               </div>
            </div>
         
   </div>
</div>
												
					<!--                                  DM -->
					<script>
					function openDm() {
						$("#dmfriendlist *").remove();
						$.ajax({
			                url: "dmfriendlist.do", // 처리할 페이지(서블릿) 주소
			                type: "get",
			                data: {searchtext: ""},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
			                success: function(response) {
			                    for(var i=0;i<response.length;i++){
			                   	 $("#dmfriendlist").append("<li onclick='openmessage(this)'><img src='루이.jpg' class='dmimg'>"+response[i]+"<a class='favorite'><i class='far fa-star' onclick='checkfavorite(this)'></i></a></li>");
			                    }
			                },
			                error: function() {
			                    console.log("에러 발생");
			                },
			                complete: function(){
			                    console.log("AJAX 종료");
			                }
			            });   
					    document.getElementById("dm").style.width = "17%";
					    document.getElementById("allwrapper").style.marginLeft = "17%";
					    document.getElementById("footer").style.marginLeft = "17%";
					}

					function closeDm() {
					    document.getElementById("dm").style.width = "0";
					    document.getElementById("allwrapper").style.marginLeft= "0";
					    document.getElementById("footer").style.marginLeft = "0";
					}
					
					function checkfavorite(e){
						$(e).attr('class','fas fa-star');
					}
					
					function openmessage(e){
						var nickname = $(e).text();
						$("#dmnickname").text(nickname);
						$("#messagebox *").remove(); 
						
						$.ajax({
			                url: "selectUserId.do", // 처리할 페이지(서블릿) 주소
			                type: "get",
			                data: {nickname: nickname},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
			                success: function(response) {
			                	$('.chatbox').show();
			                	$("#userId").val(response);
			                	var receiver = $("#userId").val();
			                	$.ajax({
					                url: "selectmessenger.do", // 처리할 페이지(서블릿) 주소
					                type: "get",
					                data: {receiver: receiver,sender:"${sessionScope.loginId}"},    
					                success: function(response) {
					                	 for(var i=0;i<response.length;i++){
					                		 if(response[i].sender == "${sessionScope.loginId}"){
					                			 $("#messagebox").append("<div class='message-box-holder'><div class='message-box'>"+response[i].message+"</div></div>");
					                		 }
					                		 else{
					                			 $("#messagebox").append("<div class='message-box-holder'><div class='message-sender'><a>"+nickname+"</a></div><div class='message-box message-partner'>"+response[i].message+"</div></div>")
					                		 }
					                	 }
					                	 var objDiv = document.getElementById("messagebox");
				                         objDiv.scrollTop = objDiv.scrollHeight;  
					                },
					                error: function() {
					                    console.log("에러 발생");
					                },
					                complete: function(){
					                    console.log("AJAX 종료");
					                }
					            });
			                },
			                error: function() {
			                    console.log("에러 발생");
			                },
			                complete: function(){
			                    console.log("AJAX 종료");
			                }
			            });
						
						
					};
					</script>
                     <div class="nav-side-menu" id="dm">
					     <!-- Brand -->
				            <div class="brand"><i class="fab fa-facebook-messenger mr-1"></i>Messenger</div>

				            <!-- Search body -->
				            <div id="search">
				                <input type="text" class="form-control" placeholder="Search">
				            </div>
					  
					        <div class="menu-list">
					  
					            <ul id="menu-content" class="menu-content collapse out">
					                <li  data-toggle="collapse" data-target="#favorite" class="collapsed active">
					                  <a href="#"><i class="fas fa-star"></i>즐겨찾기<span class="arrow"></span></a>
					                </li>
					                <ul class="sub-menu collapse" id="favorite">
					                    <li class="active"><a href="#">CSS3 Animation</a></li>
					                    <li><a href="#">General</a></li>
					                    <li><a href="#">Buttons</a></li>
					                </ul>
					
					
					                <li data-toggle="collapse" data-target="#service" class="collapsed">
					                  <a href="#"><i class="fab fa-fort-awesome-alt fa-lg"></i>최근 목록<span class="arrow"></span></a>
					                </li>  
					                <ul class="sub-menu collapse" id="service">
					                  <li>New Service 1</li>
					                  <li>New Service 2</li>
					                  <li>New Service 3</li>
					                </ul> 
					            </ul>
					    	 </div>
					    	 <ul id="dmfriendlist">
					    	 	
					    	 </ul>
					</div>
					
					
<!--          DM메세지창 -->
                 <div class="chatbox-holder">
  
  <div class="chatbox group-chat">
    <div class="chatbox-top">
      <div class="chatbox-avatar">
        <a target="_blank" href=""><img src="루이.jpg" /></a>
      </div>
      
      <div class="chat-group-name" id="dmnickname">
        
      </div>
      <input type="hidden" id="userId">
      <div class="chatbox-icons">
        <label for="chkSettings"><i class="fa fa-gear"></i></label><input type="checkbox" id="chkSettings" />
        <div class="settings-popup">
          <ul>
            <li><a href="#">Group members</a></li>
            <li><a href="#">Add members</a></li>
            <li><a href="#">Delete members</a></li>
            <li><a href="#">Leave group</a></li>
          </ul>
        </div>
        <a href="javascript:void(0);"><i class="fa fa-minus"></i></a>
        <a href="javascript:void(0);"><i class="fa fa-close"></i></a>       
      </div>      
    </div>
    
    <div class="chat-messages" id="messagebox">

            
    </div>
    
    <div class="chat-input-holder">
      <input type="text" class="chat-input" id="sendDm">
    </div>
    
    <div class="attachment-panel">
      <a href="#" class="fa fa-thumbs-up"></a>
      <a href="#" class="fa fa-camera"></a>
      <a href="#" class="fa fa-video-camera"></a>
      <a href="#" class="fa fa-image"></a>
      <a href="#" class="fa fa-paperclip"></a>
      <a href="#" class="fa fa-link"></a>
      <a href="#" class="fa fa-trash-o"></a>
      <a href="#" class="fa fa-search"></a>
    </div>
  </div>
</div>

<script>
$(function(){
	  $('.fa-minus').click(function(){    
		  $(this).closest('.chatbox').toggleClass('chatbox-min');
	  });
	  $('.fa-close').click(function(){
	    $(this).closest('.chatbox').hide();
	  });
});
</script>
                      
                        
      <%@ include file="include/bottom.jsp"%>
      
      
  