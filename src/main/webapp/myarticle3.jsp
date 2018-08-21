<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css"
	href="resources/css/myarticle.css">
<script src="resources/js/myarticle.js">


</script>



<c:if test="${result.size() > 0}">
	<input type=hidden id='sessionid' value="${sessionScope.loginId}">
	<script> var list= []; </script>
	<script>
	function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#profileimg')
                    .attr('src', e.target.result);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
	</script>
	<script>
	function updateImg(name) {
		 $('#profileimg').attr('src', "AttachedMedia/"+name);
		 $("#hiddenimgname").val(name);
	}
	</script>
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
				<a data-target="#profileimage" data-toggle="modal" style="cursor: pointer;">
				<c:choose>
				
				<c:when test="${profileImg.size() > 0}">
				<c:forEach items="${profileImg}" var="proimg">
				<c:if test="${proimg.is_selected eq 'y'}">
				<img src="AttachedMedia/${proimg.system_file_name}" width="152px" height="152px" style="object-fit: cover;"></a>
				</c:if>
				</c:forEach>
				</c:when>
				
				<c:otherwise>
				<img src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces" width="152px" height="152px" style="object-fit: cover;"></a>
				</c:otherwise>
				</c:choose>
				<!--                  <img src="http://lorempixel.com/150/150/people/" class="hoverZoomLink"> -->
			</div>


			<c:choose>
				<c:when test="${result[0].id == sessionScope.loginId}">


					<div class="profile-user-settings">

						<h2 class="profile-user-name">${result[0].id}</h2>
						<div class="profile-edit-btn" id="toMy" style="height: 40px;">프로필편집</div>
						<div class="profile-settings-btn">
							<i class="far fa-times-circle" id="logout"></i>
						</div>
						<!-- 					<button id="logout" type="button" class="btn btn-outline-danger">로그아웃</button> -->
					</div>

				</c:when>
				<c:when test="${isFollow}">

					<div class="profile-user-settings">
						<h2 class="profile-user-name">${result[0].id}</h2>
						<div class="profile-edit-btn" id="cancelFollow"
							style="height: 40px;">팔로잉</div>
						<div class="profile-settings-btn">
							<i class="fas fa-undo-alt"></i>
						</div>

					</div>

				</c:when>

				<c:otherwise>

					<div class="profile-user-settings">
						<h2 class="profile-user-name">${result[0].id}</h2>
						<div class="profile-edit-btn" id="follow"
							style="height: 40px; background-color: #35e0db;">팔로우</div>
						<div class="profile-settings-btn">
							<i class="fas fa-undo-alt"></i>
						</div>

					</div>

				</c:otherwise>
			</c:choose>



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


	<c:choose>
		<c:when
			test="${(result[0].id != sessionScope.loginId) && isBlock || isNotPublic}">
			<div class="block container">
				<br>
				<br> <br>
				<br>
				<h2>비공개 계정입니다</h2>
				<br>
				<h4>사진 및 동영상을 보려면 팔로우하세요</h4>
				<br>
				<br> <br>
				<br>
			</div>


		</c:when>

		<c:otherwise>


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
								<img src="AttachedMedia/${result2[status.index].system_file_name}" class="img-fluid" style="object-fit:cover;">

								<div class="gallery-item-info">
									<ul>
										<li class="gallery-item-likes"><i class="fas fa-heart"></i>
											<c:out value="${likecount[tmp.board_seq]}" /></li>
										<li class="gallery-item-comments"><i
											class="fas fa-comment"></i> <c:out
												value="${commentcount[tmp.board_seq]}" /></li>
									</ul>
								</div>




								<script>
               
       
                       $("#${tmp.board_seq}").click(function() {
                    	   var objDiv = document.getElementById("articlecomment");
                           objDiv.scrollTop = 0;            
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
                                 $("#modalid1").text(data.id);   
//                                   $("#modalcontents").text(data.contents);       
                               $("#modalcontents").html(data[0].contents);
                                  $("#seq").val(data[0].board_seq);
                                  $("#modalid2").text(data[0].id);
                                     
                                  $("#likeit").val(data[0].board_seq);
                                  $("#likecancel").val(data[0].board_seq); 
                                  $("#mark").val(data[0].board_seq);
                                  $("#markcancel").val(data[0].board_seq);
                          
                                
                                  $("#firstItem").append("<img class='first' src='AttachedMedia/"+data[1][0].system_file_name+"' alt=''>");
                                  for(var i = 1; i < data[1].length; i++) {
                                     $("#carousel-indicators li:last-child").after("<li class='element' data-target='#demo' data-slide-to="+i+"></li>");
                                     $("#carousel-inner div:last-child").after("<div class='carousel-item element'><img class='element' src='AttachedMedia/"+data[1][i].system_file_name+"' alt=''></div>");   
                                       
                                  }
                                      
                                  $(".commentline").remove();          
                                  for(var i =0; i<data[2].length; i++){                
                                	  $("#articlecomment:last-child").append("<ul id='ul"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)'><li id='li1'><a href='' class='mr-2' id='commentid'>"+data[2][i].id+"</a></li><li id='li2'><div class='commenttxt txt' id='commenttxt"+data[2][i].comment_seq+"' style='word-wrap:break-word'>"+data[2][i].comment_contents+"</div></li></ul>"
                                			  +"<ul id='ul2"+data[2][i].comment_seq+"' style='background-color:#E1F5FE; display:none;' class='commentline2 navbar-nav' onmouseover = 'commentover2(this)' onmouseleave='commentleave2(this)'><li id='li3' value='"+data[2][i].board_seq+"'><i class='far fa-trash-alt py-1 pointer' id='del"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='delComment(this)'></i></li><li id='li4' value='"+data[2][i].board_seq+"'><i class='fas fa-pencil-alt py-1 pl-3 pointer' id='mod"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='modComment(this)'></i><li></ul>");      
                                  }
                                           
                                 
                              
                                  
                                  $("#likeit").attr("style", "display:none;");
                                  $("#likecancel").attr("style", "font-weight: bold; color: red; display:none; "); 
                                  if(data[3] != null) { 
                                	  $("#likecancel").attr("style", "font-weight: bold; color: red; ");   
                                  }else {
                                	  $("#likeit").attr("style", false);
                                  }
                                  
                                  
                                  $("#mark").attr("style", "display:none;");
                                  $("#markcancel").attr("style", "font-weight: bold; color: #00B8D4; display:none; ");   
                                  if(data[4] != null) { 
                                	  $("#markcancel").attr("style", "font-weight: bold; color: #00B8D4;");   
                                  }else {
                                	  $("#mark").attr("style", false);
                                  }
                            

                                 }
                            });
                          
                             $("#boardmodal").modal();                      
                       });

                     
                       
//                        $("#modify${tmp.board_seq}").click(function() {
//                           $("#seq").val(${tmp.board_seq});  
//                              $("#boardmodal").modal();                             
//                        });

                  
//                        $("seq1").click(function() {                      
//                             $("#boardmodal").modal('show');                         
//                        });
           
               </script>


							</div>

							<!-- <script>
         num++;
      </script> -->
						</c:forEach>


					</c:if>


				</div>

				<!--          <div class="spinner"></div> -->

			</div>

		</c:otherwise>
	</c:choose>

</div>

<div class="modal fade" id="boardmodal" role="dialog">
	<div class="modal-dialog bo" role="document">



		<div class="modal-content view"
			style="flex-direction: row; width: 60px; height: auto; opacity: 0.5;">
			<div class="" style="width: 30px;; height: auto;">
				<i class="fas fa-angle-double-left " id="goPrev"
					style="font-size: 25px;"></i>
			</div>


			<div class="" id="connect" style="width: 30px; height: auto;">
				<i class="fas fa-angle-double-right text-right" id="goNext"
					style="font-size: 25px;"></i>
			</div>
		</div>
		<br>


		<div class="modal-content view"
			style="flex-direction: row; width: 1000px; height: auto;">

			<div class="modal-content view" style="width: 70%; height: auto;">
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

			<div class="modal-content view" style="width: 30%; height: auto;">



				<div class="hidden" id="hidden"></div>
				<div class="hidden" id="prev"></div>
				<div class="hidden" id="next"></div>


				<div id="board" class="bg-white">
					<br>
					<div class="profile-image">
						<img class="ml-3 mr-2"
							src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
						<div class="" id="modalid2" style="font-size: 16px;"></div>
					</div>



					<br> <br> <input id="seq" type=hidden name=board_seq>


					<div id="articlecomment"
						style="overflow-y: auto; word-wrap: break-word; height: 350px;"
						class="mt-2 mx-3">

						<div id="articlecontents" class="mt-2 pb-2 mr-2 ">
							<div class="bg-black" id="modalcontents"></div>
						</div>

					</div>

				</div>



				<div class="bg-white" id="a">
					<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="navbar-brand "
						href="#"> <i id="likeit" style="display: none;"
						class="far fa-heart icon mr-1 pointer" onclick="likeit(this)"></i>
						<i style="font-weight: bold; color: red; display: none;"
						id="likecancel" class="far fa-heart icon mr-1 pointer"
						onclick="unlikeit(this)"></i>


					</a> <a class="navbar-brand " href="#"> <i
						class="far fa-comment icon"></i>
					</a> <a class="navbar-brand " href="#"> <i id="mark"
						class="far fa-bookmark icon pointer" style="display: none;"
						onclick="markit(this)"></i> <i
						style="font-weight: bold; color: #00B8D4; display: none;"
						id="markcancel" class="far fa-bookmark icon pointer"
						onclick="unmarkit(this)"></i>


					</a>
				</div>





				<div class="py-2 bg-white text-right">

					<input type="text" placeholder="댓글 달기..." class="creco"
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
                                $("#articlecomment:last-child").append("<ul id='ul"+seq+"' value='"+seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)' ><li id='li1'><a href='' class='mr-2'>${sessionScope.loginId}</a></li><li id='li2'><div id='commenttxt"+seq+"' class='commenttxt txt' style='word-wrap:break-word'>"+comment_contents+"</div></li></ul>");           
                                
  
                                var objDiv = document.getElementById("articlecomment");
                                objDiv.scrollTop = objDiv.scrollHeight;    

                       }
                    })
                       }
                    }
                    
                });
                </script>

					<c:choose>
						<c:when test="${result[0].id == sessionScope.loginId}">
							<br>
							<br>
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
							<br>
							<br>
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

		</div>




	</div>
</div>
<form id="fileForm">
<div class="modal fade" id="profileimage" tabindex="-1" role="dialog">
<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">프로필 이미지</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
         
        <div class="modal-body">
        <div style="max-height: 300px;">
          <input id="inputimg" name="inputimg" type='file' onchange="readURL(this);"/>
			<img id="profileimg" src="resources/images/Placeholder.png" alt="your image" />
		</div>
		<div class="dropdown-divider" ></div>
		
		<c:if test="${profileImg.size() > 1}">
		<div class="alert alert-success">
    		<strong>최근 프로필 사진</strong>
  		</div>
  		<div style="overflow-x: scroll; max-height:300px; display: flex;">
		<c:forEach items="${profileImg}" var="proimg">
		<c:if test="${proimg.is_selected eq 'n'}">
		<img onclick="updateImg('${proimg.system_file_name}')" id="profileimg" src="AttachedMedia/${proimg.system_file_name}" style="object-fit: cover; cursor: pointer;">
		</c:if>
		</c:forEach>
		</div>
		</c:if>
		</div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button id="savebtn" type="button" class="btn btn-primary">저장</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        <input id="hiddenimgname" type="hidden">
        <input id="hiddenid" type="hidden" value="${sessionScope.loginId}">
        
      </div>
    </div>
         </div>
             </form>
<%@ include file="include/bottom.jsp"%>
