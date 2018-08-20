
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css"
	href="resources/css/myarticle.css">
<script src="resources/js/myarticle.js"></script>

<c:if test="${result.size() > 0}">
	<script> var list= []; </script>
	<c:forEach var="tmp" items="${result}" varStatus="status">
		<script>    
			list.push("${tmp.board_seq}");    
			
			</script>
	</c:forEach>
</c:if>

<div id="allwrapper">


	<div class="container my">
		<div class="profile">
			<div class="profile-image">
				<img
					src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces">
				<!-- 					  <img src="http://lorempixel.com/150/150/people/" class="hoverZoomLink"> -->
			</div>

			<div class="profile-user-settings">
				<h2 class="profile-user-name">${result[0].id}</h2>
				<div class="profile-edit-btn" id="toMy">프로필편집</div>
				<div class="profile-settings-btn">
					<i class="far fa-times-circle" id="logout"></i>
				</div>
				<!-- 					<button id="logout" type="button" class="btn btn-outline-danger">로그아웃</button> -->
			</div>

			<div class="profile-stats">
				<ul>
					<li><span class="profile-stat-count">${boardCount}</span> 게시글</li>
					<li><span class="profile-stat-count">${followerCount}</span>
						팔로워</li>
					<li><span class="profile-stat-count">${followingCount}</span>
						팔로우</li>
				</ul>
			</div>

			<div class="profile-bio">
				<p>
					<span class="profile-real-name">멋쟁이</span>&nbsp;&nbsp;난 오늘도 고독을
					즐긴다..
				</p>
			</div>
		</div>
	</div>



	<div class="tagmenu">
		<div class="row">
			<div class="col-md-12">
				<table class="table">
					<thead>
						<tr>
							<th class="text-center">게시물</th>
							<th class="text-center">태그됨</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>



	<div class="container my">

		<div class="gallery">
			<c:if test="${result.size() != 0}">



				<c:forEach var="tmp" items="${result}" varStatus="status">


					<div class="gallery-item" id="${tmp.board_seq}">
						<%-- 				<img src='https://images.unsplash.com/photo-1511765224389-37f0e77cf0eb?w=500&h=500&fit=crop' class='gallery-image' id="${tmp.board_seq}">    --%>
						<img src="AttachedMedia/${result2[status.index].system_file_name}"
							class="img-fluid">


						<%-- 					<div class="gallery-item-info" id="item${tmp.board_seq}"> --%>
						<div class="gallery-item-info">
							<ul>
								<li class="gallery-item-likes"><i class="fas fa-heart"></i>
									<c:out value="${likecount[tmp.board_seq]}" /></li>
								<li class="gallery-item-comments"><i class="fas fa-comment"></i>
									<c:out value="${commentcount[tmp.board_seq]}" /></li>
							</ul>
						</div>


						<script>
					
  
                       $("#${tmp.board_seq}").click(function() {
                    	   var seq = "${tmp.board_seq}";
                    	   $("#prev").val(${result[status.index-1].board_seq}); 
                    	   $("#next").val(${result[status.index+1].board_seq}); 
                    	   $("#hidden").val(${result[status.index].board_seq});
                    	   for(var i =0; i<list.length; i++) {
                   			if(seq == list[i]) {
                   				if(list.length == 1) {
            						$("#modalbtn").hide();
            					}
            					else if(i==0) {
            						$("#goPrev").hide();
            						$("#goNext").show();
            					}
                   				else if(i == (list.length-1)){
                   					$("#goNext").hide();
                   					$("#goPrev").show(); 
                   				} 
                   				else { 
                   					$("#goPrev").show(); 
                   					$("#goNext").show();
                   					
                   				}
                   				break;
                   			}
                   		}
                    	   $.ajax({
                	           type: "POST",
                	           url: "boardView.bo",
                	           data: {seq:seq},
                	           success: function(data)
                	           {
                	        	   if(data[1].length == 1) {
               						$("#carousel-prev").hide();
            						$("#carousel-next").hide();
                	        	   }else {
                	        		   $("#carousel-prev").show();
                	        		   $("#carousel-next").show();
                	        	   }
                	        	   $("#modalid").text(data.id);	        	   
//                 	               $("#modalcontents").text(data.contents);       
                				   $("#modalcontents").html(data[0].contents);
                	               $("#seq").val(data[0].board_seq);
                	               $("#modalid2").text(data[0].id);
                	               
                            	   $("#firstItem").append("<img class='first' src='AttachedMedia/"+data[1][0].system_file_name+"' alt=''>");
                            	   for(var i = 1; i < data[1].length; i++) {
                            		   $("#carousel-indicators li:last-child").after("<li class='element' data-target='#demo' data-slide-to="+i+"></li>");
                            		   $("#carousel-inner div:last-child").after("<div class='carousel-item element'><img class='element' src='AttachedMedia/"+data[1][i].system_file_name+"' alt=''></div>");
                            		   
                            	   }
                            	   
                	           	}
                	         });
                    	   
                          	$("#boardmodal").modal();                	   
                       });

                        
//                        $("#modify${tmp.board_seq}").click(function() {
//                     	   $("#seq").val(${tmp.board_seq});  
//                           	$("#boardmodal").modal();                       	   
//                        });

						
//                        $("seq1").click(function() {             	      
//                          	$("#boardmodal").modal('show');                   	   
//                        });
           
					</script>


					</div>

					<!-- <script>
			num++;
		</script> -->
				</c:forEach>


			</c:if>


		</div>

		<!-- 			<div class="spinner"></div> -->

	</div>


</div>

<div class="modal fade" id="boardmodal" role="dialog">
	<div class="modal-dialog" role="document">

		<!-- 				<button id="goNext" class="btn btn-outline-primary">&#62;</button> -->
		<!-- 				<button id="goPrev" class="btn btn-outline-primary">&#60;</button> -->

		<!-- 				<div class="bg-white" id="goNext">&#62;</div> -->
		<!-- 		        <div class="bg-white" id="goPrev">&#60;</div> -->

<!-- 		<div class="modal-content" style="width:1000px;"> -->
<!-- 			<p class="text-center"> -->
<!-- 				<i class="fas fa-angle-double-left " id="goPrev" -->
<!-- 					style="font-size: 25px;"></i> -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
						
<!-- 				<i class="fas fa-angle-double-right text-right" id="goNext" style="font-size: 25px;"></i> -->
<!-- 			</p> -->
<!-- 		</div> -->
		
		<div class="modal-content" style="flex-direction: row;width:1000px;height:auto;">
			
			<div class="modal-content" style="width:3%;height:auto;">
				<i class="fas fa-angle-double-left " id="goPrev" 
 					style="font-size: 25px;"></i>
			</div>
			<div class="modal-content" style="width:64%;height:auto;">
				<div class="gallery-item" id="picture">
					<div id="demo" class="carousel slide" data-ride="carousel"
						data-interval="false">
						<ul id="carousel-indicators" class="carousel-indicators">
							<li id="firstli" data-target="#demo" data-slide-to="0"
								class="active"></li>
						</ul>
						<div id="carousel-inner" class="carousel-inner">
							<div id="firstItem" class="carousel-item active"></div>
						</div>
						<a id="carousel-prev" class="carousel-control-prev" href="#demo"
							data-slide="prev"> <span class="carousel-control-prev-icon"></span>
						</a> <a id="carousel-next" class="carousel-control-next" href="#demo"
							data-slide="next"> <span class="carousel-control-next-icon"></span>
						</a>
					</div>
				</div>

			</div>

			<div class="modal-content" style="width:30%;height:auto;">



				<div class="hidden" id="hidden"></div>
				<div class="hidden" id="prev"></div>
				<div class="hidden" id="next"></div>
				
				
				<div id="board" class="bg-white">
					<br>
					<div class="profile-image">
						<img class="ml-3 mr-2"
							src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
						<div id="modalid"></div>
					</div>

					<br> <br> <input id="seq" type=hidden name=board_seq>
					<div id="articlecontents" class="mt-2 mx-3 pb-2">
						<div class="bg-black" id="modalcontents"></div>
					</div>

				</div>
				


				<div class="bg-white" id="a">
					<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="navbar-brand "
						href="#"> <i class="far fa-heart icon"></i>
					</a> <a class="navbar-brand " href="#"> <i
						class="far fa-comment icon"></i>
					</a> <a class="navbar-brand " href="#"> <i
						class="far fa-bookmark icon"></i>
					</a>
				</div>


				


				<div class="py-2 bg-white">

					<input type="text" placeholder="댓글 달기..." class="ml-2 pl-2"
						id="comment">

					<script>
                $('#comment').keypress(function(event){
             	   var seq = $("#seq").val();
             	   var comment_contents = $("#comment").val();
             	     
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
                               data: {board_seq:seq, comment_contents : comment_contents},
                               success : function(seq) {
                  
                                $("#comment").val("");            
                              
                       }
                    })
                       }
                    }
                    
                });
                </script>

					<c:choose>
						<c:when test="${result[0].id == sessionScope.loginId}">

							<div class="btn-group bg-white">
								<button class="btn dropdown-toggle bg-white"
									data-toggle="dropdown"></button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">보관</a>
									<div class="dropdown-divider" id="modifydiv"></div>
									<a class="dropdown-item" id="modify" href="#">수정</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" id="modifysubmitbtn" href="#">수정완료</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" name=delete id="delete" href="#">삭제</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="#">부적절한콘텐츠신고</a>
								</div>
							</div>

							<script>
				
			</script>

						</c:when>
						<c:otherwise>
							<div class="btn-group bg-white">
								<button class="btn dropdown-toggle bg-white"
									data-toggle="dropdown"></button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">보관</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="#">부적절한콘텐츠신고</a>
								</div>
							</div>



						</c:otherwise>
					</c:choose>


				</div>
			</div>
			
			<div class="modal-content" id="connect" style="width:3%;height:auto;">
				<i class="fas fa-angle-double-right text-right" id="goNext" style="font-size: 25px;"></i>
			</div>
			
		</div>
	


	</div>
</div>
<%@ include file="include/bottom.jsp"%>