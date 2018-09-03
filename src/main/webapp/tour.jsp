<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/tour.css">
<script src="resources/js/top.js"></script>
<script> var currentId = "${sessionScope.loginId}"; </script>
<script src="resources/js/timeline.js"></script>
	
	<script>    
	

	
	$(document).on("click","a[id*='tourmodal']",function() {

       
       var objDiv = document.getElementById("articlecomment");  
        objDiv.scrollTop = 0;               
       var board_seq = $(this).attr('id').replace("tourmodal", "");
       var prev_seq = $(this).prev().attr("value");
       var next_seq = $(this).next().attr("value");
       var isfirst =$(this).prev().attr("id");
       var islast =$(this).next().attr("id");
       alert(board_seq + " : " + prev_seq  + " : " + next_seq + " : " + isfirst + " : " + islast);       
//        if(${status.count != 1}) {
//        $("#prev").val(${result[status.index-1].board_seq});  }
//        if(${status.count != result.size()}) {
//        $("#next").val(${result[status.index+1].board_seq}); } 

		$("#prev").val(prev_seq);
		$("#next").val(next_seq);
       
      // $("#hidden").val(${result[status.index].board_seq}); 
    	  if(isfirst && islast) {
    	   $("#goPrev").hide();
           $("#goNext").hide();
      }
      else if(isfirst) {
           $("#goPrev").hide();
           $("#goNext").show();
        }
            else if(islast){
               $("#goNext").hide();
               $("#goPrev").show(); 
            } 
            else { 
               $("#goPrev").show(); 
               $("#goNext").show();
               
            }
          
       $.ajax({
           type: "POST",
           url: "boardView.bo",
           data: {seq:board_seq},
           success: function(data)         
           {      
        alert(data[5]);  
              $(".modalall").attr("style","flex-direction: row; height: auto; width:"+(data[5]+300)+"px;");         
              $(".modalmedia").attr("style", "height: auto; width:"+parseInt(data[5])+"px; min-width:400px;");  
              if(data[1].length == 1) {
              $("#carousel-prev").hide();
           $("#carousel-next").hide();  
              }else {
                 $("#carousel-prev").show();
                 $("#carousel-next").show();
              }
              $("#modalid1").text(data.id);   
              
              
//                $("#modalcontents").text(data.contents);  
     var txt = data[0].contents;
       var regex = /(#[^#\s,;<>. ]+)/gi;
       var dataContent0 = data[0].contents; 
       var newtxt = "";  
       if(txt != " ") {                                  
           newtxt = "<span class=fugue>" + dataContent0.replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" 
                 + "$1" + "</a><span class=fugue>") + "</span>";
           newtxt += "<kz></kz>"
       }        
      
               $("#modalcontents").html(newtxt);
          //  $("#modalcontents").html(data[0].contents);
               $("#seq").val(data[0].board_seq);
               $("#modalid2").text(data[0].id);

           $("#modalid2").click(function() {  
               $(location).attr("href", "board.bo?id="+data[0].id+"&cat=1");
           });
         
               $("#molikeit").val(data[0].board_seq);
               $("#molikecancel").val(data[0].board_seq); 
               $("#momark").val(data[0].board_seq);
               $("#momarkcancel").val(data[0].board_seq);
       
             
               $("#firstItem").append("<img class='first' src='AttachedMedia/"+data[1][0].system_file_name+"' alt=''>");
               for(var i = 1; i < data[1].length; i++) {
                  $("#carousel-indicators li:last-child").after("<li class='element' data-target='#demo' data-slide-to="+i+"></li>");
                  $("#carousel-inner div:last-child").after("<div class='carousel-item element'><img class='element' src='AttachedMedia/"+data[1][i].system_file_name+"' alt=''></div>");   
                    
               }
                   
               $(".commentline").remove(); 
               for(var i =0; i<data[2].length; i++){ 
                  var txt = data[2][i].comment_contents;   
                   var regex = /(#[^#\s,;<>. ]+)/gi;           
                   var newtxt = "<span class=fugue>" + txt.replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" 
                  + "$1" + "</a><span class=fugue>") + "</span>";  
                 newtxt += "<kz></kz>"
                 
                  
                  $("#articlecomment:last-child").append("<ul id='ul"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)'><li id='li1'><a href='board.bo?id="+data[2][i].id+"&cat=1' class='mr-2' id='commentid'>"+data[2][i].id+"</a></li><li id='li2'><div class='commenttxt txt' id='commenttxt"+data[2][i].comment_seq+"' style='word-wrap:break-word'>"+newtxt+"</div></li></ul>"
                        +"<ul id='ul2"+data[2][i].comment_seq+"' style='background-color:#E1F5FE; display:none;' class='commentline2 navbar-nav' onmouseover = 'commentover2(this)' onmouseleave='commentleave2(this)'><li id='li3' value='"+data[2][i].board_seq+"'><i class='far fa-trash-alt py-1 pointer' id='del"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='delComment(this)'></i></li><li id='li4' value='"+data[2][i].board_seq+"'><i class='fas fa-pencil-alt py-1 pl-3 pointer' id='mod"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='modComment(this)'></i><li></ul>"
                        +"<input type=hidden id='modstate"+data[2][i].comment_seq+"' value='1'>");          
               }
                        
               $("div[id*='commenttxt']").on("mousedown mouseup keydown keyup", update);
               $("div[id*='commenttxt']").keyup(function(e){
                // =================== 복붙 =================== 
                  if(e.keyCode === 32){
                     if (parseInt($('#caretposition').val()) == 0) {                         
                       } else if (parseInt($('#caretposition').val()) == $(this).text().length) {
                       } else {
                           return;
                       }

                       var regex = /(#[^#\s,;<>. ]+)/gi;
                       if (regex) {
                           var newtxt = "<span class=fugue>" + $(this).text()
                               .replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                                   "</a><span class=fugue>") + "</span>"

                           // console.log($('#editorDiv').text().length);   
                           // console.log(newtxt)   
                           newtxt += "<kz></kz>"
                           $(this).html(newtxt)
                           var el = this;
                           console.log("childNodes: " + el.childNodes.length);
                           var range = document.createRange();
                           var sel = window.getSelection();
                           range.setStart(el.lastChild, 0);
                           range.collapse(false);
                           sel.removeAllRanges();
                           sel.addRange(range);

                           $(this).focusout();
                           $(this).focus();
                           if (parseInt($('#caretposition').val()) == $(this).text().length) {

                           }

                       }
                  }    
                  
                  
               // =================== 복붙 =================== 
               })
              
           
               
               $("#molikeit").attr("style", "display:none;");
               $("#molikecancel").attr("style", "font-weight: bold; color: red; display:none; "); 
               if(data[3] != null) {   
                  $("#molikecancel").attr("style", "font-weight: bold; color: red; ");   
               }else {
                  $("#molikeit").attr("style", false);
               }
               
               
               $("#momark").attr("style", "display:none;");
               $("#momarkcancel").attr("style", "font-weight: bold; color: #00B8D4; display:none; ");   
               if(data[4] != null) { 
                  $("#momarkcancel").attr("style", "font-weight: bold; color: #00B8D4;");   
               }else {
                  $("#momark").attr("style", false);
               } 
                    
               var width = data[5]+300;  
               var width1 = parseInt(data[5]);
//                alert(width + " : " + width1)
               $(".modalmedia").attr("style", "flex-direction: row; height:600px; width:"+width+"px; min-width:600px;");  
              $(".modalmedia1").attr("style", "height:600px; width:"+width1+"px;");  
                   
              
              $(".modalslide").attr("style", " height:590px;");               
              }    
         }); 
        
          $("#boardmodal").modal();                      
    });

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	function tag(e) {
		var search = $(e).html().split("#")[1]; 
		$(location).attr("href","search.bo?search="+search);     
	
	}
/* 좋아요 Script */
function likeit1(e) {   
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

function unlikeit1(e) {
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

<div class="dropdown">
	<div class="dropdown-divider" id="tagmenu"></div>
		<label class="top" style="font-size: 12px;font-family: NANUMBARUNPENR !important;">
			<c:choose>
				<c:when test="${pageName eq '/tour.bo'}">
					둘러보기
				</c:when>
				<c:when test="${pageName eq '/search.bo'}">
					검색 결과: #${ param.search }
				</c:when>
				<c:otherwise>
					글쎄요.. 뭘까요?
				</c:otherwise>
			</c:choose>
		</label>
		<c:if test="${pageName eq '/tour.bo'}">
			<button class="btn btn-light text-dark dropdown-toggle down" type="button" id="dropdownMenuButton" 
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${category}</button>
			<div class="dropdown-divider" id="tagmenu"></div>
				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a href="tour.bo?cat=1" class="dropdown-item" style="cursor: pointer;font-family: NANUMBARUNPENR !important;font-size: 14px;width:150px;"><i class="fas fa-newspaper mr-1 pr-1 fa-1x"></i>최신글</a>
				<div class="dropdown-divider"></div>
				<a href="tour.bo?cat=2" class="dropdown-item" style="cursor: pointer;font-family: NANUMBARUNPENR !important;font-size: 14px;"><i class="fas fa-heart mr-1 pr-1 fa-1x"></i>좋아요</a>
				<div class="dropdown-divider"></div>
				<a href="tour.bo?cat=3" class="dropdown-item" style="cursor: pointer;font-family: NANUMBARUNPENR !important;font-size: 14px;"><i class="fas fa-tags mr-1 pr-1 fa-1x"></i>인기 태그 순</a>
				</div>
		</c:if>
		
</div>


<!-- 카드 DIV -->
<div id="contents">	

<c:choose>
<c:when test="${result.size() ==0}">    
	<h1 >검색 결과가 없습니다.</h1> 
</c:when>
<c:when test="${result.size() >4}"> 
	<div id=deck class="card-columns">
	<c:forEach var="result" items="${result}" varStatus="status">
		<div class="card" id="card">
			<h4 class="card-title" id="tourTop">
			         
							<c:choose>   
						<c:when test="${profile_pic.containsKey(result.id)}">
                  
                  			<img src="AttachedMedia/<c:out value='${profile_pic[result.id]}'/>" alt="Card image cap" width="30" height="30" class="rounded-circle">
                   
                   
                  </c:when>        
                  <c:otherwise>    
                     	<img src="resources/images/DefaultProfile.jpg" alt="Card image cap" width="30" height="30" class="rounded-circle">
                   
                  </c:otherwise>
					</c:choose>
			
			
			
	
					<a id="ids" href="board.bo?id=${result.id}&cat=1">${result.id}</a>
					<!-- 북마크 -->
						<c:choose> 
										<c:when test="${bookmark.containsKey(result.board_seq)}">

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" style="display: none;"
													onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4;" id="markcancel"
													class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>  

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4; display: none;"
													id="markcancel" class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:otherwise>
									    </c:choose>   
						<!-- 좋아요 -->
							<c:choose>
								<c:when test="${result3.containsKey(result.board_seq)}">
									<i value="${result.board_seq}" style="cursor: pointer; display: none;" 
										id="likeit" class="far fa-heart icon mr-1" onclick="likeit1(this)">
									</i>
									<i value="${result.board_seq}" style="color: red; cursor: pointer;" 
										id="likecancel" class="fas fa-heart" onclick="unlikeit1(this)">
									</i>
									<!-- 좋아요 카운트 -->
									<c:choose>
										<c:when test="${result4[result.board_seq] != null}">
											<p id="p">
												<i value="${result.board_seq}" id="count${result.board_seq}">
												<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다</i>
											</p>
										</c:when>
											<c:otherwise>
												<p id="p">
													<i value="${result.board_seq}" id="count${result.board_seq}">
													<c:out value="${result4[result.board_seq]}"/></i>
												</p>
											</c:otherwise>
									</c:choose>
								</c:when>
									<c:otherwise>   
										<i value="${result.board_seq}" style="cursor: pointer;" 
											id="likeit" class="far fa-heart icon mr-1" 
											onclick="likeit1(this)">
										</i>
			                   			<i value="${result.board_seq}" style="color: red; display: none; cursor: pointer;" 
			                   				id="likecancel" class="fas fa-heart" 
			                   				onclick="unlikeit1(this)">
			                   			</i>
										<!-- 좋아요 카운트 -->
										<c:choose>
											<c:when test="${result4[result.board_seq] != null}">
												<p id="p">
													<i value="${result.board_seq}" id="count${result.board_seq}">
													<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다</i>
												</p>
											</c:when>
												<c:otherwise>
													<p id="p">
														<i value="${result.board_seq}" id="count${result.board_seq}">
														<c:out value="${result4[result.board_seq]}"/></i>
													</p>
												</c:otherwise>
										</c:choose>
									</c:otherwise>
							</c:choose>	
			</h4> <div class="dropdown-divider"  id="modifydiv"></div>
				<!-- 태그,글 보이기 -->
					<div class="hidden" style="padding-left: 5px" id="hidden${result.board_seq}">
						<script> $("#myContents${result.board_seq}").attr("style","overflow:visible"); </script>
							<p id="myContents${result.board_seq}">${result.contents}</p>
								<script>    
									var text = $("#myContents${result.board_seq}").text();  
									var regex = /(#[^#\s,;]+)/gi  ;              
									var newtxt;
	  								if(text != null) {
	  									 newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
	  								}        
  							        $("#myContents${result.board_seq}").html(newtxt);  
								</script>
					</div>
			<!-- 이미지 -->
			<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
		<c:choose>
								<c:when test="${status.first}">
								<input type=hidden value='' id="${status.first}">
								</c:when>
								<c:otherwise>
								<input type=hidden value='${result[status.index-1].board_seq}' id="${status.first}">
								</c:otherwise>
								</c:choose>
									<a id='tourmodal${result.board_seq}'><!--src='AttachedMedia/${media.system_file_name}'-->
										<img class="card-img-top" 
						id="card" src='AttachedMedia/${media.system_file_name}'
						alt="해당 게시글로 바로가기">
									</a>
									
										<c:choose>
								<c:when test="${status.last}">
								<input type=hidden value='' id="${status.last}">
								</c:when>
								<c:otherwise>
									<input type=hidden value='${result[status.index+1].board_seq}' id="${status.last}">
								</c:otherwise>
								</c:choose>
								
			</c:forEach>
		</div>
	</c:forEach>
	
	      
	</div>
</c:when>

<c:otherwise>  
<div class="row">
<c:forEach var="result" items="${result}" varStatus="status">

<div class="col-md-4">            
					<div class="card" id="card">
						<h4 class="card-title"  id="tourTop">  
						
						
						
							<c:choose>   
						<c:when test="${profile_pic.containsKey(tmp.id)}">
                  
                  			<img src="AttachedMedia/<c:out value='${profile_pic[tmp.id]}'/>" alt="Card image cap" width="30" height="30" class="rounded-circle">
                   
                   
                  </c:when>        
                  <c:otherwise>        
                     	<img src="resources/images/DefaultProfile.jpg" alt="Card image cap" width="30" height="30" class="rounded-circle">
                   
                  </c:otherwise>
					</c:choose>
						
						
						   
							
								<a id="ids" href="board.bo?id=${result.id}&cat=1">${result.id}</a>
									<!-- 북마크 -->  
								<c:choose> 
										<c:when test="${bookmark.containsKey(result.board_seq)}">

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" style="display: none;"
													onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4;" id="markcancel"
													class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>  

												<i value="${result.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" onclick="markit(this)"></i>
												<i value="${result.board_seq}"
													style="font-weight: bold; color: #00B8D4; display: none;"
													id="markcancel" class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:otherwise>
									    </c:choose>   
									
									<!-- 좋아요 -->
									<c:choose>
										<c:when test="${result3.containsKey(result.board_seq)}">
											<i value="${result.board_seq}" style="cursor: pointer; display: none;" 
												id="likeit" class="far fa-heart icon mr-1 lk" onclick="likeit1(this)"></i>
											<i value="${result.board_seq}" style="color: red; cursor: pointer;" 
												id="likecancel" class="fas fa-heart lkc" onclick="unlikeit1(this)"></i>
											<!-- 좋아요 카운트 -->
											<c:choose>
												<c:when test="${result4[result.board_seq] != null}">
													<p id="p">
														<i value="${result.board_seq}" id="count${result.board_seq}">
															<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다
														</i>
													</p>
												</c:when>
													<c:otherwise>
														<p id="p">
															<i value="${result.board_seq}" id="count${result.board_seq}">
																<c:out value="${result4[result.board_seq]}"/>
															</i>
														</p>
													</c:otherwise>
											</c:choose>
										</c:when>
											<c:otherwise>   
												<i value="${result.board_seq}" style="cursor: pointer;" id="likeit" 
													class="far fa-heart icon mr-1 lk" 
													onclick="likeit1(this)"></i>
			                   					<i value="${result.board_seq}" style="color: red; display: none; cursor: pointer;" 
			                   						id="likecancel" class="fas fa-heart lkc" 
			                   						onclick="unlikeit1(this)"></i>
												<!-- 좋아요 카운트 -->
												<c:choose>
													<c:when test="${result4[result.board_seq] != null}">
														<p id="p">
															<i value="${result.board_seq}" id="count${result.board_seq}">
																<c:out value="${result4[result.board_seq]}"/>명이 좋아합니다
															</i>
														</p>
													</c:when>
														<c:otherwise>
															<p id="p"> 
																<i value="${result.board_seq}" id="count${result.board_seq}">
																	<c:out value="${result4[result.board_seq]}"/>
																</i>
															</p>
														</c:otherwise>
												</c:choose>
											</c:otherwise>
									</c:choose>	 
							</h4> <div class="dropdown-divider"  id="modifydiv"></div>
								<!-- 태그,글 보이기 -->
								<div class="hidden" style="padding-left: 5px" id="hidden${result.board_seq}">
									<script> $("#myContents${tmp.board_seq}").attr("style","overflow:visible"); </script>
										<p id="myContents${result.board_seq}">${result.contents}</p>
											<script>    
											var text = $("#myContents${result.board_seq}").text(); 
											var regex = /(#[^#\s,;]+)/gi  ;             
												var newtxt;
				  								if(text != null) {
				  									 newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
				  								}        
			  							        $("#myContents${result.board_seq}").html(newtxt);
											</script>
								</div>
									<!-- 이미지 -->
								<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
								<c:choose>
								<c:when test="${status.first}">
								<input type=hidden value='' id="${status.first}">
								</c:when>
								<c:otherwise>
								<input type=hidden value='${result[status.index-1].board_seq}' id="${status.first}">
								</c:otherwise>
								</c:choose>
									<a id='tourmodal${result.board_seq}'><!--src='AttachedMedia/${media.system_file_name}'-->
										<img class="card-img-top" 
						id="card" src='AttachedMedia/${media.system_file_name}'
						alt="해당 게시글로 바로가기">
									</a>
									
										<c:choose>
								<c:when test="${status.last}">
								<input type=hidden value='' id="${status.last}">
								</c:when>
								<c:otherwise>
									<input type=hidden value='${result[status.index+1].board_seq}' id="${status.last}">
								</c:otherwise>
								</c:choose>
								
								
								
								
								
								
								
								</c:forEach>
					</div> 
					</div>
					   
		    
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
	     <script>
               
       
//     ////////////////////////////////////////                 
                     
             				</script>
				</c:forEach>
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


		<div class="modal-content view modalall">

			<!-- 			<div class="modal-content view" style="width: 70%; height: auto;"> -->

			<!-- 					<div id="demo" class="carousel slide" data-ride="carousel" -->
			<!-- 						data-interval="false"> -->
			<!-- 						<ul id="carousel-indicators" class="carousel-indicators"> -->
			<!-- 							<li id="firstli" data-target="#demo" data-slide-to="0" -->
			<!-- 								class="active"></li> -->
			<!-- 						</ul> -->
			<!-- 						<div id="carousel-inner" class="carousel-inner" style="background-color:black;"> -->
			<!-- 							<div id="firstItem" class="carousel-item active"></div> -->
			<!-- 						</div> -->
			<!-- 						<a id="carousel-prev" class="carousel-control-prev" href="#demo" -->
			<!-- 							data-slide="prev"> <span class="carousel-control-prev-icon"></span> -->
			<!-- 						</a> <a id="carousel-next" class="carousel-control-next" href="#demo" -->
			<!-- 							data-slide="next"> <span class="carousel-control-next-icon"></span> -->
			<!-- 						</a> -->
			<!-- 					</div> -->
			<!-- 					<a id="carousel-prev" class="carousel-control-prev" href="#demo" -->
			<!-- 						data-slide="prev"> <span class="carousel-control-prev-icon"></span> -->
			<!-- 					</a> <a id="carousel-next" class="carousel-control-next" href="#demo" -->
			<!-- 						data-slide="next"> <span class="carousel-control-next-icon"></span> -->
			<!-- 					</a> -->
			<!-- 				</div> -->



			<div class="modal-content view modalmedia" >

				<div id="demo" class="carousel slide" data-ride="carousel"
					data-interval="false">
					<ul id="carousel-indicators" class="carousel-indicators">
						<li id="firstli" data-target="#demo" data-slide-to="0"
							class="active"></li>
					</ul>
					<div id="carousel-inner" class="carousel-inner"
						style="background-color: black;">
						<div id="firstItem" class="carousel-item active"></div>
					</div>
					<a id="carousel-prev" class="carousel-control-prev" href="#demo"
						data-slide="prev"> <span class="carousel-control-prev-icon"></span>
					</a> <a id="carousel-next" class="carousel-control-next" href="#demo"
						data-slide="next"> <span class="carousel-control-next-icon"></span>
					</a>
				</div>


			</div>


			<div class="modal-content view" style="width: 300px; height: auto;">


				<div class="hidden" id="hidden"></div>
				<div class="hidden" id="prev"></div>
				<div class="hidden" id="next"></div>


				<div id="board" class="bg-white">
					<br>
					<div class="profile-image">
						<img class="ml-3 mr-2"
							src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
						<div class="pointer" id="modalid2" style="font-size: 16px;"></div>
					</div>


					<br> <br> <input id="seq" type=hidden name=board_seq
						style="word-wrap: break-word; word-break: break-all">


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
						href="#"> <i id="molikeit" style="display: none;"
						class="far fa-heart icon mr-1 pointer" onclick="likeit(this)"></i>
						<i style="font-weight: bold; color: red; display: none;"
						id="molikecancel" class="far fa-heart icon mr-1 pointer"
						onclick="unlikeit(this)"></i>


					</a> <a class="navbar-brand " href="#"> <i
						class="far fa-comment icon"></i>
					</a> <a class="navbar-brand " href="#"> <i id="momark"
						class="far fa-bookmark icon pointer" style="display: none;"
						onclick="markit(this)"></i> <i
						style="font-weight: bold; color: #00B8D4; display: none;"
						id="momarkcancel" class="far fa-bookmark icon pointer"
						onclick="unmarkit(this)"></i>


					</a>
				</div>





				<div class="py-2 bg-white text-right">

					<!-- <input type="text" placeholder="댓글 달기..." class="creco" id="comment">  -->
					<div contenteditable="true" class="editableDivCommentSection"
						class="creco insertfield" id="comment">
						<span class=text-muted>댓글 달기...</span>
					</div>
					<input type=hidden id="caretposition" value="0">


					<script>
					
				
					
				
				  /* ========================= 댓글달기 ========================= */
				
                $('#comment').keypress(function(event){
                   var seq = $("#seq").val();
                   /* var comment_contents = $("#comment").val(); */
                   var comment_contents = $("#comment").text();
                     
                    var keycode = (event.keyCode ? event.keyCode : event.which);
                    if(keycode == '13'){ 
                       
                       /* var text = $("#comment${tmp.board_seq}").val(); */
                       if(comment_contents == ""){
                          alert("댓글을 입력해주세요");
                       }  
                       else {     
                          $.ajax({
                               type: "POST",  
                               url: "comment.co",    
                               data: {board_seq:seq, comment_contents : comment_contents},
                               success : function(comment_seq) {
                            	   var board_seq = $("#seq").val();
                                /* $("#comment").val(""); */
                                $("#comment").html("");
                                
                                var regex = /(#[^#\s,;<>. ]+)/gi;            
                                var newtxt = "<span class=fugue>" + comment_contents.replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" 
											 + "$1" + "</a><span class=fugue>") + "</span>";          
									newtxt += "<kz></kz>"
                                    
                                
                                $("#articlecomment:last-child").append("<ul id='ul"+comment_seq+"' value='"+comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)' ><li id='li1'><a href='' class='mr-2'>${sessionScope.loginId}</a></li><li id='li2'><div id='commenttxt"+comment_seq+"' class='commenttxt txt' style='word-wrap:break-word'>"+newtxt+"</div></li></ul>"
                                		+"<ul id='ul2"+comment_seq+"' style='background-color:#E1F5FE; display:none;' class='commentline2 navbar-nav' onmouseover = 'commentover2(this)' onmouseleave='commentleave2(this)'><li id='li3' value='"+board_seq+"'><i class='far fa-trash-alt py-1 pointer' id='del"+comment_seq+"' value='"+comment_seq+"' onclick='delComment(this)'></i></li><li id='li4' value='"+board_seq+"'><i class='fas fa-pencil-alt py-1 pl-3 pointer' id='mod"+comment_seq+"' value='"+comment_seq+"' onclick='modComment(this)'></i><li></ul>"
                          			  +"<input type=hidden id='modstate"+comment_seq+"' value='1'>");     
                                  
                                $("#ul"+comment_seq).hide().fadeIn(500);     
                                
                                $("div[id*='commenttxt']").on("mousedown mouseup keydown keyup", update);
                                $("div[id*='commenttxt']").keyup(function(e){
                                	// =================== 복붙 =================== 
                               	   if(e.keyCode === 32){
                               		   if (parseInt($('#caretposition').val()) == 0) {                     	 
                                          } else if (parseInt($('#caretposition').val()) == $(this).text().length) {
                                          } else {
                                              return;
                                          }

                                          var regex = /(#[^#\s,;<>. ]+)/gi;
                                          if (regex) {
                                              var newtxt = "<span class=fugue>" + $(this).text()
                                                  .replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                                                      "</a><span class=fugue>") + "</span>"

                                              // console.log($('#editorDiv').text().length);   
                                              // console.log(newtxt)   
                                              newtxt += "<kz></kz>"
                                              $(this).html(newtxt)
                                              var el = this;
                                              console.log("childNodes: " + el.childNodes.length);
                                              var range = document.createRange();
                                              var sel = window.getSelection();
                                              range.setStart(el.lastChild, 0);
                                              range.collapse(false);
                                              sel.removeAllRanges();
                                              sel.addRange(range);

                                              $(this).focusout();
                                              $(this).focus();
                                              if (parseInt($('#caretposition').val()) == $(this).text().length) {

                                              }

                                          }
                               	   } 
                               	   
                               	   
                               	// =================== 복붙 =================== 
                                  })
  
                                var objDiv = document.getElementById("articlecomment");
                                objDiv.scrollTop = objDiv.scrollHeight;    

                       }
                    })
                       }
                    }
                    
                });
                
          

                </script>

					<c:choose>
						<c:when test="${pageid == sessionScope.loginId}">
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


    
    
    
    

<!-- 무한스크롤 -->
<script>
	var globalAjaxUrl = "";
	var globalStartNum = 16;
	var globalCat = "";
	var globalSearch = "";
	console.log("${pageName}")
	console.log("${pageName}" == "/search.bo")
	if("${pageName}" == "/tour.bo"){
		globalAjaxUrl = "tourForJson.ajax"
		globalStartNum = ${TOUR_PER_PAGE + 1}
		
		if("${param.cat}" == ""){
			console.log("param cat 값 없음")
			globalCat = "1"
		} else {
			globalCat = "${param.cat}"
		}
		
	} else if("${pageName}" == "/search.bo") {
		globalAjaxUrl = "searchForJson.ajax"
		globalStartNum = ${SEARCH_PER_PAGE + 1};
		globalSearch = "${param.search}"
	}
	
	$(window).scroll(function(){
		if ($(window).scrollTop() >= $(document).height() - $(window).height()) {
			console.log('xcccccx');
			$.ajax({
	            url: globalAjaxUrl, // 처리할 페이지(서블릿) 주소
	            type: "get",
	            data: {start: globalStartNum, cat: globalCat, search: globalSearch},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
	            success: function(r) {
	            
	        		console.log(r);
	        		console.log("cat: ${param.cat}")
	        		console.log("search: ${param.search}")
	           		if(r.isAvailableMoreData){	// 가져올 게시글이 더 있나요?           		
	            		var c = "";
	           			// c += "<div class='card-columns'>"
	           			
	           			for(ele = 0; ele < r.result.length; ele++){
	           				// console.log(r.result[ele]);
		           			c += "<div class='card' id='card'>"
		           			c += "<h4 class='card-title' id='tourTop'>"
		           			
		           			if(r.profile_pic[r.result.id] != null) {
		           				c += "<img src='"+r.profile_pic[r.result.id]+"' alt='Card image cap' width='30' height='30' class='rounded-circle'>"
		           			}
		           			else{     
		           			
		           			c += "<img src='resources/images/DefaultProfile.jpg' alt='Card image cap' width='30' height='30' class='rounded-circle'>"	
		           			
		           			}
		           			// ★★  이 부분 사진 주소 수정
		           		 	c += "<a id='ids' href='board.bo?id=" + r.result[ele].id + "&cat=1'>" + r.result[ele].id + "</a>"	   
		           		 	
		           		 	// test='bookmark.containsKey(result.board_seq)'
		           		 	var boardSeq = r.result[ele].board_seq
		           		 	// console.log(r.mapmark[boardSeq])
		           		 	if( typeof r.mapmark[boardSeq] != "undefined" ){
			           		 	c += "<i value='" + boardSeq + "' id='mark' class='far fa-bookmark icon pointer' style='display: none;' onclick='markit(this)'></i>"
								c += "<i value='" + boardSeq + "' style='font-weight: bold; color: #00B8D4;' id='markcancel' class='far fa-bookmark icon pointer' onclick='unmarkit(this)'></i>"							
		           		 	} else {
		           		 		c += "<i value='" + boardSeq + "' id='mark' class='far fa-bookmark icon pointer' onclick='markit(this)'></i>"
								c += "<i value='" + boardSeq + "' style='font-weight: bold; color: #00B8D4; display: none;' id='markcancel'" 
								c += "class='far fa-bookmark icon pointer' onclick='unmarkit(this)'></i>"
		           		 	}
		           		 	
		           		 	// 좋아요
		           		 	// if: result3(map).containsKey(result.board_seq)
		           		 	if( typeof r.map[boardSeq] != "undefined" ){
		           		 		c += "<i value='" + boardSeq + "' style='cursor: pointer; display: none;'" 
		           		 		c += "id='likeit' class='far fa-heart icon mr-1' onclick='likeit1(this)'></i>"
								c += "<i value='" + boardSeq + "' style='color: red; cursor: pointer;' id='likecancel'"
								c += "class='fas fa-heart' onclick='unlikeit1(this)'></i>"
								
								// if: countlike[result.board_seq] != null  
									c += "<p id='p'><i value='" + boardSeq + "' id='count" + boardSeq + "'>" +r.countlike[board_seq] + "명이 좋아합니다." + "</i></p>"
								} else {
									c += "<p id='p'><i value='" + boardSeq + "' id='count" + boardSeq + "'></i></p>"
								}								
		           		 	} else {
		           		 		c += "<i value='" + boardSeq + "' style='cursor: pointer;' id='likeit' "
		           		 		c += "class='far fa-heart icon mr-1' onclick='likeit1(this)'></i><i value='" + boardSeq + "' " 
		           		 		c += "style='color: red; display: none; cursor: pointer;' id='likecancel' class='fas fa-heart'  "
		                   		c += "onclick='unlikeit1(this)'></i>"
		                   		// if: countlike[result.board_seq] != null
									if(typeof r.countlike[board_seq] != "undefined" && r.countlike[board_seq] != null){
										c += "<p id='p'><i value='" + boardSeq + "' id='count" + boardSeq + "'>"
										c += r.countlike[board_seq] + "명이 좋아합니다." + "</i></p>"
									} else {
										c += "<p id='p'><i value='" + boardSeq + "' id='count" + boardSeq + "'></i></p>"
									}	
		           		 	}
		           					
		           			c += "</h4>" 
		           			
	           				c += "<div class='dropdown-divider'  id='modifydiv'></div>"
		           		 	c += "<div class='hidden' style='padding-left: 5px' id='hidden" + boardSeq + "'>"
		           		 	// == pure == 
		           			$('#myContents' + boardSeq).attr('style','overflow:visible');		           			
		           			var text = r.result[ele].contents
							var regex = /(#[^#\s,;<>.]+)/gi;              
							var newtxt = "<span class=text-muted>(내용없음)</span>";
								if(text != null || typeof text != "undefined" ) {
									 newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>" + "$1" + "</a>");
								}   
		           			c += "<p id='myContents" + boardSeq + "'>" + newtxt + "</p>"
		           			
		           			// forEach begin='0' end='0' var='media' items=result2[status.index]
		           			
	           				// c += "<a href='#' >"
	           				try {
	           					c += "<a id='tourmodal" + boardSeq + "'><img class='card-img-top' id='card' src='AttachedMedia/"+ r.media[ele][0].system_file_name + "' alt='해당 게시글로 바로가기'></a>"
							}
							catch(e) {
								console.log(e)
							}
	           				
	           				// c += "</a>"
		           		 	c += "</div>"	// hidden div 끝
		           		 	c += "</div>"	// modifydiv 끝
		           			c += "</div>"	// card div 끝
	           			}  			
	           			
	           			
	           			// c += "</div>"	// card-columns 끝
	           			$("#deck").append(c)
	           			
	            		globalStartNum = parseInt(r.nextStartNum);
	            	} else {
	            		console.log(false);
	            		return false;
	            	} 

	            },
	            error: function() {
	                console.log("에러 발생");
	            },
	            complete: function(){
	            	console.log("완료");
	            }
	        });
			
	    
		}
		else{
			console.log("짧음")
		}
	}); // window scroll 끝


</script>

<%@ include file="include/bottom.jsp"%>