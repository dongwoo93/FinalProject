<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/timeline.css">

<script>
    $(document).ready(function(){
    	$("#modalBoardBtn").click(function(){
    		
    		$("#changeBoardModal").modal();
    		
    	});
    	
    })

		  
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
		$("#commenttxt"+seq).attr("style","border:none; width:100%; background-color:#E1F5FE"); 
		
		if(sessionid == boardid) {      
		$("#commentdel"+seq).html("삭제");   
		$("#commentmod"+seq).html("수정");
		}  
		
		
	 
				
    }
    
    function commentleave(e) {
    	var seq = $(e).attr("value"); 
		
		$("#ul"+seq).attr("style",false);      
		$("#commenttxt"+seq).attr("style","border:none; width:100%"); 
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
    
      		 
      		 $("#commenttxt"+comment_seq).attr("readonly",false);
          	 $("#commenttxt"+comment_seq).attr("style","border:0.5px solid lightgray");
          	 $("#commenttxt"+comment_seq).focus();  
        
          	$(e).click(function() {
          			 var txt = $("#commenttxt"+comment_seq).val();
             	 	  
                    	$.ajax({    
                              type: "POST",    
                              url: "commentmod.co",    
                              data: {comment_seq:comment_seq, comment_contents:txt},  
                              success : function() {
                            	$("#commenttxt"+comment_seq).attr("readonly",true);
     		                    $("#commenttxt"+comment_seq).attr("style","border:none"); 
     		                   $("#commenttxt"+comment_seq).attr("style","background-color:#E1F5FE");
                              }  
                         }); //ajax 
          	})
          
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
										<img class='boardimg' width='100%'
											src='AttachedMedia/${result2[status.index][0].system_file_name}'
											alt=''>
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
													style="cursor: pointer; display: none;" id="likeit"
													class="far fa-heart icon mr-1" onclick="likeit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: red; cursor: pointer;"
													id="likecancel" class="far fa-heart icon mr-1"
													onclick="unlikeit(this)"></i>
											</c:when>
											<c:otherwise>
												<i value="${tmp.board_seq}" style="cursor: pointer;"
													id="likeit" class="far fa-heart icon mr-1"
													onclick="likeit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: red; display: none; cursor: pointer;"
													id="likecancel" class="far fa-heart icon mr-1"
													onclick="unlikeit(this)"></i>

											</c:otherwise>
										</c:choose> <i class="far fa-comment icon"></i>
									</a>
									
									<a class="btn navbar-btn ml-2 text-white "> <c:choose>
											<c:when test="${bookmark.containsKey(tmp.board_seq)}">

												<i value="${tmp.board_seq}" id="mark"
													class="far fa-bookmark icon"
													style="cursor: pointer; display: none;"
													onclick="markit(this)"></i>
												<i value="${tmp.board_seq}"
													style="cursor: pointer; font-weight: bold; color: #00B8D4;"
													id="markcancel" class="far fa-bookmark icon"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>

												<i value="${tmp.board_seq}" id="mark"
													style="cursor: pointer;" class="far fa-bookmark icon"
													onclick="markit(this)"></i>
												<i value="${tmp.board_seq}"
													style="cursor: pointer; font-weight: bold; color: #00B8D4; display: none;"
													id="markcancel" class="far fa-bookmark icon"
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

								<p class="text-info pt-4 mb-1" id="myComment${tmp.board_seq}"></p>
								<div class="comment-contents"
									id="comment-contents${tmp.board_seq}">

									<!-- 댓글자리 -->

									<c:forEach var="commenttmp" items="${commentresult}">
										<c:choose>
											<c:when test="${commenttmp.key == tmp.board_seq}">
												<c:forEach var="comment" items="${commenttmp.value}">

													<c:if test="${commenttmp.value.size() > 2 }">
														<script>    
                     $("#myComment${tmp.board_seq}").html("&nbsp&nbsp모두 ${commenttmp.value.size()}개의 댓글보기")
                     </script>   
                     </c:if> 
						  
						  
							<ul id="ul${comment.comment_seq}" value="${comment.comment_seq}" onmouseover="commentover(this)" onmouseleave="commentleave(this)" class="commentline navbar-nav">       
							<li id='li1'><a href="board.bo?id=${comment.id}">${comment.id}</a></li>    
							<li id='li2'><input type=text id='commenttxt${comment.comment_seq}' class='commenttxt' value="${comment.comment_contents }"  readonly></li> 
	
							<li id='li3'><a id='commentdel${comment.comment_seq}' value="${tmp.board_seq}:${comment.comment_seq}" onclick="delComment(this)" style="cursor: pointer;"></a> </li>
							<li id='li4'><a id='commentmod${comment.comment_seq}' value="${comment.comment_seq}" onclick="modComment(this)" style="cursor: pointer;"></a> </li>    
  
							</ul>  
						</c:forEach>
							</c:when>  
								</c:choose>
							
						</c:forEach>
						</div>
								</div>



							<!--               -->


							<div class="crecodiv py-2 navbar-nav">


								<input type="hidden" id="board_seq" name="board_seq"
									value="${tmp.board_seq}"> &nbsp&nbsp&nbsp <input
									type="text" placeholder="댓글 달기..."
									name="comment_contents${tmp.board_seq}" class="creco  ml-2 "
									id="comment${tmp.board_seq}">

								<c:choose>
									<c:when test="${result[0].id == sessionScope.loginId}">

										<div class="btn-group bg-white">
											<i id="modalBoardBtn" class="fas fa-ellipsis-h btn mr-1"
												data-toggle="modal"> </i>
										</div>

									</c:when>
									<c:otherwise>
										<div class="btn-group bg-white">
											<i id="modalBoardBtn" class="fas fa-ellipsis-h btn mr-1 ">
											</i>

										</div>


									</c:otherwise>
								</c:choose>

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
	                                               $("#comment-contents${tmp.board_seq}").prepend("<ul id='ul"+seq+"' value='"+seq+"' onmouseover='commentover(this)' onmouseleave='commentleave(this)'><li style='display: inline-block; width:14%'><a href='board.bo?id=${sessionScope.loginId}'>${sessionScope.loginId}</a></li><li style='display: inline-block; width:61%'><input type=text id='commenttxt"+seq+"' style='border:none; width:100%' value='"+text+"' readonly></li><li style='display: inline-block; width:12%'><a id='commentdel"+seq+"'  style='cursor: pointer;'></a> </li><li style='display: inline-block; width:12%'><a id='commentmod"+seq+"' value='"+seq+"' onclick='modComment(this)'  style='cursor: pointer;'></a></li></ul>");
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

														<div class="modal-body">
															<a class="dropdown-item" href="#">게시물로 이동</a>
															<div class="dropdown-divider" id="modifydiv"></div>
															<a class="dropdown-item" id="modify" href="#">부적절한 콘텐츠 신고</a>
															<div class="dropdown-divider"></div>
															<a class="dropdown-item" id="modifysubmitbtn" href="#">퍼가기</a>
															<div class="dropdown-divider"></div>
															<a class="dropdown-item" name=delete id="delete" href="#">링크 복사하기</a>

														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-secondary"
																data-dismiss="modal">Close</button>
														</div>
													</div>
														</c:when>
														<c:otherwise>
														   <div class="modal-content">
		              <div class="modal-body">
		              <a class="dropdown-item" href="#">보관</a>	              
		              <div class="dropdown-divider"></div>
		              
		              <a class="dropdown-item" href="#">부적절한콘텐츠신고</a>
		              </div>
		              </div> 
														
														</c:otherwise>
															</c:choose>	
												</div>
											</div>
					
		           
		       			
								
      <%@ include file="include/bottom.jsp"%>
  