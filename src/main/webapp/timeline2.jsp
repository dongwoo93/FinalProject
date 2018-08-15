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
    

    </script>
<div id="allwrapper">  
      <div class=""id="centerwrapper">
          <div class="container" id="contents">
        <div id="board" >
        
        <script>var num = 1;</script>
        
        <c:forEach var="tmp" items="${result}">
        
          <div class="py-2 my-5" data-aos="fade-up" data-aos-once="true" id="feed">   
            <div class="profile-image"> 	 
              <img class="ml-3 mr-2" src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
<%--               <h5 class="mt-1 idtxt">${tmp.id}</h5>  --%>
              <br><a class="mt-1 idtxt" id="id" href="board.bo?id=${tmp.id}">${tmp.id}<br>Dangsan.South Korea</a>
            </div>    
            <div class="mt-2" id="boardimg">
      
      <script>  
      var num = Math.floor((Math.random() * 4) + 1);
      var img = "timelineimg/"+num+".PNG"; 
      $("#boardimg:last-child").after("<img src='"+img+"' width='100%' class='boardimg'> ");
      </script> 
             </div>
             
             
            <div id="cont">
              <nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
                <div class="container">
                  <a class="navbar-brand">
               			 
                    <i value="${tmp.board_seq}" style="cursor: pointer;" id="likeit" class="far fa-heart icon mr-1" onclick="likeit(this)"></i>
                    <i value="${tmp.board_seq}" style="font-weight: bold; color: red; display: none; cursor: pointer;" id="likecancel" class="far fa-heart icon mr-1" onclick="unlikeit(this)"></i>
                    <i class="far fa-comment icon"></i>
                  </a>
                  <ul class="navbar-nav">
                    <i class="fas fa-circle dot1 "></i>&nbsp
                    <i class="fas fa-circle dot"></i>&nbsp
                    <i class="fas fa-circle dot"></i>&nbsp  
                  </ul>
                  <a class="btn navbar-btn ml-2 text-white ">
                    <i value="${tmp.board_seq}" id="mark" class="far fa-bookmark icon" onclick="markit(this)"></i>
                    <i value="${tmp.board_seq}" style="font-weight: bold; color: #28a745; display: none;" id="markcancel" class="far fa-bookmark icon" onclick="unmarkit(this)"></i>
                  </a> 
                </div>
              </nav> 
              
               
              <div id="contcenter" class="mt-2 mx-3 pb-2"> 
              <!-- 글내용자리 --> 
		<div class="navbar-nav">
		<a class="ml-1 idtxt" id="con" href="board.bo?id=${tmp.id}">${tmp.id}</a>  
	
		<div class='pl-3 mt-1 ' id="contdiv"></div> 
			<script>
			 var regex = /(#[^#\s,;]+)/gi  ;           
		  var txt = "${tmp.contents}";          
          var newtxt = txt.replace(regex, "<a href='search.bo?search="+"$1"+"' style='color:red'>"+"$1"+"</a>");        
          // $("#contdiv").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);           
		$("#contdiv").html(newtxt);         

		</script>          
		</div>    
<!-- 글내용자리 -->   
							     
						<p class="text-info pt-4 mb-1" id="myComment${tmp.board_seq}"></p>
						<div class="comment-contents" id="comment-contents${tmp.board_seq}">   
						  
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
						
						  
							<ul id="ul${comment.comment_seq}" class="commentline navbar-nav">       
							<li id='li1'><a href="board.bo?id=${comment.id}">${comment.id}</a></li>   
							<li id='li2'><input type=text id='commenttxt${comment.comment_seq}' class='commenttxt' value="${comment.comment_contents} " readonly></li> 
	
							<li id='li3'><a id='commentdel${comment.comment_seq}'></a> </li>
							<li id='li4'><a id='commentmod${comment.comment_seq}'></a> </li>    

							</ul>  
					
				       <c:choose>
				       <c:when test ="${sessionScope.loginId == comment.id}">
				        
				      				<script>  
				      				
				      				$("#ul${comment.comment_seq}").hover(function() {
				      					$("#ul${comment.comment_seq}").attr("style","background-color:#E1F5FE");
				      					$("#commenttxt${comment.comment_seq}").attr("style","background-color:#E1F5FE"); 
				      					$("#commentdel${comment.comment_seq}").html("삭제");   
				      					$("#commentmod${comment.comment_seq}").html("수정");
				      	 				
				      					
				      				})
				      				  
				      				$("#ul${comment.comment_seq}").mouseleave(function() {
				      					$("#ul${comment.comment_seq}").attr("style",false);  
				      					$("#commenttxt${comment.comment_seq}").attr("style",false); 
				      					$("#commentdel${comment.comment_seq}").html("");  
				      					$("#commentmod${comment.comment_seq}").html("");
				      				})
				      				
				      					$("#commentdel${comment.comment_seq}").click(function() {     
				                        	$.ajax({
				                                  type: "POST",  
				                                  url: "commentdel.co",      
				                                  data: {board_seq:${tmp.board_seq},comment_seq:${comment.comment_seq}},
				                                  success : function(cnt) {
				                                	  console.log(cnt);
				                                   $("#ul${comment.comment_seq}").remove();  
				                                   if(cnt>2){ 
					                                   $("#myComment${tmp.board_seq}").html("&nbsp&nbsp모두 "+cnt+"개의 댓글보기")}
					                                   else {
					                                	   $("#myComment${tmp.board_seq}").html("");  
					                                   }
				                                  }
				                                    
				                             }) //ajax 
				                          });
				                          
				                          var modnum = 0;
				      				
				                         $("#commentmod${comment.comment_seq}").click(function() {
				                        	 modnum++;
				                        	 if(modnum %2 != 0 ){  
				                        		 
				                        		 $("#commenttxt${comment.comment_seq}").attr("readonly",false);
						                    	 $("#commenttxt${comment.comment_seq}").attr("style","border:0.5px solid lightgray");
						                    	 $("#commenttxt${comment.comment_seq}").focus();  
		 				
				                        	 }
				                        	 else {  
				                        		 var txt = $("#commenttxt${comment.comment_seq}").val();
					                    	 	  
		 				                        	$.ajax({ 
		 				                                  type: "POST",    
		 				                                  url: "commentmod.co",    
		 				                                  data: {comment_seq:${comment.comment_seq}, comment_contents:txt},  
		 				                                  success : function() {
		 				                                	$("#commenttxt${comment.comment_seq}").attr("readonly",true);
		 								                    $("#commenttxt${comment.comment_seq}").attr("style","border:none"); 
		 								                   $("#commenttxt${comment.comment_seq}").attr("style","background-color:#E1F5FE");
		 				                                  }
						                                     
		 				                             }); //ajax 
				                        		 
				                        	 }
				                    	 	
				                     	}); 
				                         	
				      					</script>
				      				</c:when>
				      				<c:otherwise>
				      					<script>    
				      				
				      				$("#ul${comment.comment_seq}").hover(function() {     
				      					$("#ul${comment.comment_seq}").attr("style","background-color:#E1F5FE");
				      					$("#commenttxt${comment.comment_seq}").attr("style","background-color:#E1F5FE"); 
				      					
				      				})
				      				  
				      				$("#ul${comment.comment_seq}").mouseleave(function() {
				      					$("#ul${comment.comment_seq}").attr("style",false);  
				      					$("#commenttxt${comment.comment_seq}").attr("style",false); 
				      				})
				      				
				      					</script>
				      			</c:otherwise>
				      				</c:choose>
						    
		
						</c:forEach>
							</c:when>  
								</c:choose>
							
						</c:forEach>
					
					
						
						</div>


								</div>
								<!--               -->
								
								
								<div class="crecodiv py-2 navbar-nav">  
  

									<input type="hidden" id="board_seq" name="board_seq" value="${tmp.board_seq}"> &nbsp&nbsp&nbsp   
									<input type="text" placeholder="댓글 달기..." name="comment_contents${tmp.board_seq}" class="creco  ml-2 " id="comment${tmp.board_seq}"> 
									
									 <c:choose>
				<c:when test="${result[0].id == sessionScope.loginId}">

										<div class="btn-group bg-white">
											<i id="modalBoardBtn" class="fas fa-ellipsis-h btn mr-1" data-toggle="modal" >
											</i>
</div>
		
	         </c:when>
				<c:otherwise>  
					<div class="btn-group bg-white">
		          <i id="modalBoardBtn" class="fas fa-ellipsis-h btn mr-1 "> </i>
		           
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
	                                               $("#comment-contents${tmp.board_seq}").prepend("<ul id='ul"+seq+"'><li style='display: inline-block; width:14%'><a href='board.bo?id=${sessionScope.loginId}'>${sessionScope.loginId}</a></li><li style='display: inline-block; width:61%'><input type=text id='commenttxt"+seq+"' style='border:none; width:100%' value='"+text+"' readonly></li><li style='display: inline-block; width:12%'><a id='commentdel"+seq+"'></a> </li><li style='display: inline-block; width:12%'><a id='commentmod"+seq+"'></a></li></ul>")
	                                
	           									$("#ul"+seq).hover(function() {  
	           				      					$("#ul"+seq).attr("style","background-color:#E1F5FE");
	           				      					$("#commenttxt"+seq).attr("style","border:none; width:100%; background-color:#E1F5FE"); 
	           				      					$("#commentdel"+seq).html("삭제");   
	           				      					$("#commentmod"+seq).html("수정");
	           				      	 				
	           				      					 
	           				      				})
	           				      				  
	           				      				$("#ul"+seq).mouseleave(function() {
	           				      					$("#ul"+seq).attr("style",false);      
	           				      					$("#commenttxt"+seq).attr("style","border:none; width:100%"); 
	           				      					$("#commentdel"+seq).html("");  
	           				      					$("#commentmod"+seq).html("");
	           				      				})
	           				      				
	           				      			$("#commentdel"+seq).click(function() {     
					                        	$.ajax({
					                                  type: "POST",  
					                                  url: "commentdel.co",    
					                                  data: {comment_seq:seq},
					                                  success : function() {
					                                	
					                                   $("#ul"+seq).remove(); 
					                                  
					                                   
					                                  }
					                                    
					                             }) //ajax 
					                          })
					                          
					                          var modnum = 0;
					      				
					                         $("#commentmod"+seq).click(function() {
					                        	 modnum++;
					                        	 if(modnum %2 != 0 ){  
					                        		 
					                        		 $("#commenttxt"+seq).attr("readonly",false);
							                    	 $("#commenttxt"+seq).attr("style","width:100%; border:0.5px solid lightgray");
							                    	 $("#commenttxt"+seq).focus();  
			 				
					                        	 }
					                        	 else {  
					                        		 var txt = $("#commenttxt"+seq).val();
						                    	 	  
			 				                        	$.ajax({ 
			 				                                  type: "POST",    
			 				                                  url: "commentmod.co",    
			 				                                  data: {comment_seq:seq, comment_contents:txt},  
			 				                                  success : function() {
			 				                                	$("#commenttxt"+seq).attr("readonly",true);
			 								                    $("#commenttxt"+seq).attr("style","width:100%; border:none; background-color:#E1F5FE"); 
			 								                   
			 				                                  }
							                                     
			 				                             }); //ajax 
					                        		 
					                        	 }
					                    	 	
					                     	}); 
	          							  }
	                             
	                                     }) //ajax 
	                                   }    
	                                }
	                       
	                          
	                            }); 
							 
						
								
								
	                                    
	                                       	
	                              
						 		</script>
							</div> <!--cont  -->
						</div> <!-- feed -->
					</c:forEach>
				</div> <!-- board -->
	

        </div>  <!-- container -->
        <div class="col-md-6 align-self-center" id="side">
          <br> 
        </div>
      </div>  <!-- centerwrapper -->
      </div>  <!--  allwrapper-->
      
      <div class="modal fade" id="changeBoardModal" tabindex="-1"
												role="dialog">
												<div class="modal-dialog modal-dialog-centered"
													role="document">
													<c:choose>
      <c:when test="${result[0].id == sessionScope.loginId}">
													<div class="modal-content">


														<div class="modal-body">
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
  