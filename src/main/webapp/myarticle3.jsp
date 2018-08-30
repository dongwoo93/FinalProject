<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css"
	href="resources/css/myarticle.css">
<style>
.editableDivCommentSection {
	margin-left: 10px;
	text-align: left;
}
</style>
<script> var currentId = "${sessionScope.loginId}";
</script>
<script src="resources/js/top.js"></script>    
<script src="resources/js/myarticle.js"></script>


<script>

	function tag(e) {
		var search = $(e).html().split("#")[1]; 
		$(location).attr("href","search.bo?search="+search); 
	
	}

	function getCaretPosition(editableDiv) {
	    var caretPos = 0,
	        sel, range;
	    if (window.getSelection) {
	        sel = window.getSelection();
	        if (sel.rangeCount) {
	            range = sel.getRangeAt(0);
	
	            // console.log("childs: " + range.commonAncestorContainer.parentNode.parentNode.childNodes.length)
	            if (range.commonAncestorContainer.parentNode.parentNode == editableDiv) {
	                caretPos = range.endOffset;
	                // console.log("caretPos: " + caretPos)
	
	
	                var i = range.commonAncestorContainer.parentNode.parentNode.childNodes.length - 1;
	                var isEqualOrLower = false;
	                while (i >= 0) {
	                    if ($(range.commonAncestorContainer.parentNode.parentNode.childNodes[i]).text() !=
	                        $(range.commonAncestorContainer).text()) {
	                        i--;
	                        continue;
	                    } else {
	                        while (i >= 0) {
	                            var $impl = $(range.commonAncestorContainer.parentNode.parentNode.childNodes[i - 1])
	                            // console.log($impl.text());
	                            caretPos += $impl.text().length
	                            i--;
	                        }
	                        break;
	                    }
	                }
	
	            }
	        }
	
	    } else if (document.selection && document.selection.createRange) {
	        range = document.selection.createRange();
	        if (range.parentElement() == editableDiv) {
	
	            var tempEl = document.createElement("span");
	            editableDiv.insertBefore(tempEl, editableDiv.firstChild);
	            var tempRange = range.duplicate();
	            tempRange.moveToElementText(tempEl);
	            tempRange.setEndPoint("EndToEnd", range);
	            caretPos = tempRange.text.length;
	        }
	    }
	
	    return caretPos;
	}
	
	var update = function () {
	    $('#caretposition').val(getCaretPosition(this));
		console.log(getCaretPosition(this))
	    console.log(this)
	};	
	
	function placeCaretAtEnd(el) {
	    el.focus();
	    if (typeof window.getSelection != "undefined"
	            && typeof document.createRange != "undefined") {
	        var range = document.createRange();
	        range.selectNodeContents(el);
	        range.collapse(false);
	        var sel = window.getSelection();
	        sel.removeAllRanges();
	        sel.addRange(range);
	    } else if (typeof document.body.createTextRange != "undefined") {
	        var textRange = document.body.createTextRange();
	        textRange.moveToElementText(el);
	        textRange.collapse(false);
	        textRange.select();
	    }
	}
	
	// moved from myarticle.js
	function modComment(e) { 

		 var comment_seq = $(e).attr("value");
		 var board_seq = $(e).parent().attr("value");
		 var modstate = $("#modstate"+comment_seq).val();
		   
		 if(modstate == "1") {
			
			 $("#commentmod"+comment_seq).html("완료");
			 $("#commenttxt"+comment_seq).attr("contentEditable",true);
		  	 $("#commenttxt"+comment_seq).attr("style","border:0.5px solid lightgray");
		  	 $("#commenttxt"+comment_seq).focus();  
		  	 
		  	placeCaretAtEnd( document.getElementById("commenttxt"+comment_seq) );
		  	 
		  	 $("#modstate"+comment_seq).val("2");  
		  	 $("#del"+comment_seq).attr("style","color:#00B8D4");
			 $("#mod"+comment_seq).attr("style","color:#00B8D4");
		 }
		 
		 
		 else if(modstate=="2") {      
			
	  			 var txt = $("#commenttxt"+comment_seq).text();     
	     	 	 
	            	$.ajax({    
	                      type: "POST",    
	                      url: "commentmod.co",    
	                      data: {comment_seq:comment_seq, comment_contents:txt},   
	                      success : function() {
	                    	$("#commenttxt"+comment_seq).attr("contentEditable",false);
			                $("#commenttxt"+comment_seq).attr("style","border:none"); 
			                $("#commenttxt"+comment_seq).attr("style","background-color:#E1F5FE");
			                $("#modstate"+comment_seq).val("1");  
			                $("#ul"+comment_seq).hide().fadeIn(500);
			                $("#del"+comment_seq).attr("style",false);
			          		$("#mod"+comment_seq).attr("style",false);
			          		$("#commentmod"+comment_seq).html("수정");
	                      }  
	                 }); //ajax 
		 }
	  
	}



$(document).ready(function(){
	
	var globalThisCommentIsFocusedOnFirst = true;
	
    /* ========================= editable div에 태그 적용 시작 ========================= */
    
    
    $('#comment').focus(function() {
    	if(globalThisCommentIsFocusedOnFirst){
    		$("#comment").html("");
        	globalThisCommentIsFocusedOnFirst = false;
    	}
    	
    });
    
    $('#comment').focusout(function() {
    	if($('#comment').text() == ""){
    		$("#comment").html("<span class=text-muted>댓글 달기...</span>");
    		globalThisCommentIsFocusedOnFirst = true;
    	}
    })

    var map = {
        16: false,
        32: false
    };
    
    function makeupHashtag (e) {

        if ((e.keyCode === 32)) {
            map[e.keyCode] = true;
            
            if(parseInt($('#caretposition').val()) == 0){
           	 //                        	 
            } else if (parseInt($('#caretposition').val()) == $(this).text().length){
           	 // 
            } else {
           	 // 
           	 return;
            }
            

            var regex = /(#[^#\s,;<>.]+)/gi;
            if (regex) {
                var newtxt = "<span class=fugue>" + $(this).text()
                    .replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                        "</a><span class=fugue>") + "</span>"

                console.log($(this).text().length);   
                console.log(newtxt)   
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


            }
        }
    }
    
    $('#comment').on("mousedown mouseup keydown keyup", update);
    $("div[id*='commenttxt']").on("mousedown mouseup keydown keyup", update);
    $('#modalcontents').on("mousedown mouseup keydown keyup", update);
    $('#comment').keyup(makeupHashtag)
    $("div[id*='commenttxt']").keyup(makeupHashtag)
	$('#modalcontents').keyup(makeupHashtag)
    /* ========================= editable div에 태그 적용 끝 ========================= */
	
	

    $("#cancelFollow").click(function() {

      $("#exampleModalCenter").modal();                             
                    });
      
    $(document).on('click', '.imgdel', function() {
    	var fileName = $(this).attr('id');
    	alert(fileName);
    	var element = this;
    	$.ajax({ 
		      url : "deleteImg.profile", 
		      type : "post", 
		      data : { 
		    	  system_file_name : fileName
		      }, 
		      success : function(resp) {
		    	  $(element).parent().remove();    
		      }, 
		      error : function() { 
		         console.log("에러 발생!"); 
		         } 
		      }) 
        
    });
  
})

								
	function articleover(e) {
	var seq = $(e).attr("value");
	$("#divinfo"+seq).attr("style",false);
		}  
	function articleleave(e) {
		var seq = $(e).attr("value"); 
		$("#divinfo"+seq).attr("style","display:none;");
		
																$("#modifysubmitbtn").click(function(){
																	var board_seq = $("#seq").val();
																	var contents = $("#modalcontents").html();
																	var contentsToText = $("#modalcontents").text()
														
																	$.ajax({
																		type:"POST",
																		url:"boardModify.bo",
																		data: {board_seq:board_seq, contents:contentsToText},
																		success: function(data)
																		{
																			if(data == 1){
																				$("#modalcontents").html(contents);
																				$("#modalcontents").attr("contentEditable","false");
														
																			}else {
																				alert("다시 시도해주세요");
																			}
														
																		}
																	});
																})
															}
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


				<c:choose>
					<c:when test="${profileImg.size() > 0}">
						<c:forEach items="${profileImg}" var="proimg">
							<c:if test="${proimg.is_selected eq 'y'}">

								<c:choose>
									<c:when test="${sessionScope.loginId == pageid}">
										<a data-target="#profileimage" data-toggle="modal"
											style="cursor: pointer;"> <img
											src="AttachedMedia/${proimg.system_file_name}" width="152px"
											height="152px" style="object-fit: cover;"></a>
									</c:when>
									<c:otherwise>
										<img src="AttachedMedia/${proimg.system_file_name}"
											width="152px" height="152px" style="object-fit: cover;">
									</c:otherwise>
								</c:choose>

							</c:if>
						</c:forEach>
					</c:when>

					<c:otherwise>
						<c:choose>
							<c:when test="${sessionScope.loginId == pageid}">
								<a data-target="#profileimage" data-toggle="modal"
									style="cursor: pointer;"> <img
									src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces"
									width="152px" height="152px" style="object-fit: cover;"></a>
							</c:when>
							<c:otherwise>
								<img
									src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces"
									width="152px" height="152px" style="object-fit: cover;">
							</c:otherwise>
						</c:choose>

					</c:otherwise>
				</c:choose>

			</div>


			<c:choose>
				<c:when test="${pageid == sessionScope.loginId}">

					<div class="profile-user-settings">
						<h2 class="profile-user-name">${pageid}</h2>
						<div class="profile-edit-btn" id="toMy">프로필 편집</div>
						<div class="profile-edit-btn" id="myRoom"><a href="myroom.jsp"style="color: #151515;">나의게시판</a></div>
						<i class="fas fa-user-cog" data-toggle="modal"
							data-target="#settingModal"
							style="font-size: 20px; margin-left: 15px; cursor: pointer;"></i>

					</div>

				</c:when>

				<c:when test="${isFollow}">

					<div class="profile-user-settings">
						<h2 class="profile-user-name">${pageid}</h2>
						<div class="profile-edit-btn" id="cancelFollow">팔로잉</div>
						<div class="profile-edit-btn btn btn-info"
							onclick="follow('${sessionScope.loginId}', '${pageid}')"
							id="follow" style="background-color: #f3f3f3; display: none;">팔로우&nbsp;<i class="fas fa-plus"></i></div>
						<div class="profile-settings-btn">
							<i class="fas fa-undo-alt"></i>
						</div>

					</div>

				</c:when>

				<c:otherwise>

					<div class="profile-user-settings">
						<h2 class="profile-user-name">${pageid}</h2>
						<div class="profile-edit-btn" id="cancelFollow"
							data-toggle="modal" data-target="#exampleModalCenter"
							style="display: none;">팔로잉</div>
						<div class="profile-edit-btn btn btn-info"
							onclick="follow('${sessionScope.loginId}', '${pageid}')"
							id="follow" style="background-color: #f3f3f3;">팔로우&nbsp;<i class="fas fa-plus"></i></div>
						<div class="profile-settings-btn">
							<i class="fas fa-undo-alt"></i>
						</div>

					</div>

				</c:otherwise>
			</c:choose>





			<!-- Modal -->
			<div class="modal fade" id="exampleModalCenter" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalCenterTitle"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document" style="font-family: NANUMBARUNPENR !important;font-size: 14px;">
					<div class="modal-content" style="border:5px solid #eff1f4;">
						<div class="modal-header">

							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body text-center" style="border:5px solid #eff1f4;font-weight:bold;font-family:NANUMBARUNPENR !important;font-size: 14px;">
								<h4 class="modal-title"
						style="font-family: NANUMBARUNPENR !important;font-weight:bold;font-size: 14px;">
						정말 팔로우를 취소하시겠습니까?</h4>
						</div>
						<div class="modal-footer">
							<button type="button" style="font-family: NANUMBARUNPENR !important;font-size: 14px;width:80px;" class="btn btn-light text-dark"
								data-dismiss="modal" id="yes"
								onclick="unfollow('${sessionScope.loginId}', '${pageid}')">YES</button>
							<button type="button" style="font-family: NANUMBARUNPENR !important;font-size: 14px;width:80px;" class="btn btn-light text-dark"
								data-dismiss="modal">Close</button>

						</div>
					</div>
				</div>
			</div>
			
			
			
			



			<div class="profile-stats">

				<ul id="prostat">
					<li><span class="profile-stat-count">${boardCount}</span> 게시글</li>
					<li id="follower"><span class="profile-stat-count"
						id="follower">${followerCount}</span> 팔로워</li>
					<li id="follown"><span class="profile-stat-count" id="follown">${followingCount}</span>
						팔로우</li>
				</ul>
			</div>

			<script>
		  document.getElementById("follower").onclick = function() {
		         location.href = "followerlist.do?id=${pageid}&cat=1";
		 }
		 
		  document.getElementById("follown").onclick = function() {
		         location.href = "followlist.do?id=${pageid}&cat=1";
		 }
			
		</script>

			<div class="profile-bio">
				<p>
					<span class="profile-real-name">${memNick}</span>&nbsp;&nbsp;${memIntro}

				</p>
			</div>
		</div>
	</div>


	<c:choose>
		<c:when
			test="${(pageid != sessionScope.loginId) && isBlock || isNotPublic}">
			<div class="block container">
				<br> <br> <br> <br>
				<h2>비공개 계정입니다</h2>
				<br>
				<h4>사진 및 동영상을 보려면 팔로우하세요</h4>
				<br> <br> <br> <br>
			</div>


		</c:when>

		<c:otherwise>

			<c:choose>
				<c:when test="${pageid == sessionScope.loginId}">
					<div class="tagmenu">
						<div class="row">
							<div class="col-md-12">
								<table class="table">
									<thead>
										<tr>
											<th class="text-center" style="font-family: NANUMBARUNPENR !important;box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.2), 0 1px 1px 0 rgba(0, 0, 0, 0.19);"><a
												href="board.bo?id=${pageid}&cat=1" style="font-family: NANUMBARUNPENR !important;color:#4f70ce;font-size:14px;">게시물</a></th>
											<th class="text-center" style="font-family: NANUMBARUNPENR !important;box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.2), 0 1px 1px 0 rgba(0, 0, 0, 0.19);"><a
												href="board.bo?id=${pageid}&cat=2" style="font-family: NANUMBARUNPENR !important;color:#4f70ce;font-size:14px;">찜콕됨</a></th>
											<th class="text-center" style="font-family: NANUMBARUNPENR !important;box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.2), 0 1px 1px 0 rgba(0, 0, 0, 0.19);"><a 
												href="board.bo?id=${pageid}&cat=3" style="font-family: NANUMBARUNPENR !important;color:#4f70ce;font-size:14px;">태그됨</a></th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>

				</c:when>

				<c:otherwise>
					<div class="tagmenu">
						<div class="row">
							<div class="col-md-12">
								<table class="table">
									<thead>
										<tr>
											<th class="text-center"  style="font-family: NANUMBARUNPENR !important;box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.2), 0 1px 1px 0 rgba(0, 0, 0, 0.19);"><a href="" style="font-family: NANUMBARUNPENR !important;color:#4f70ce;font-size:14px;">게시물</a></th>

										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
</div>
</c:otherwise>
</c:choose>
<div class="container my ">

	<div class="row">
		<c:if test="${result.size() != 0}">

			<c:forEach var="tmp" items="${result}" varStatus="status">

				<div class="col-md-4 divitem pt-4" id="${tmp.board_seq}"
					value="${tmp.board_seq}" onmouseover="articleover(this)"
					onmouseleave="articleleave(this)">
					<img src="AttachedMedia/${result2[status.index].system_file_name}"
						class="divimg pointer">

					<div class="divinfo divimg" id="divinfo${tmp.board_seq}"
						style="display: none;">
						<ul>
							<li class="divicons"><i class="fas fa-heart"></i> <c:out
									value="${likecount[tmp.board_seq]}" /></li>
							<li class="divicons"><i class="fas fa-comment"></i> <c:out
									value="${commentcount[tmp.board_seq]}" /></li>
						</ul>
					</div>



					<script>
               
       
                       $("#${tmp.board_seq}").click(function() { 
                    	    
                    	   var objDiv = document.getElementById("articlecomment");
                           objDiv.scrollTop = 0;            
                          var seq = "${tmp.board_seq}";
                          if(${status.count != 1}) {
                          $("#prev").val(${result[status.index-1].board_seq});  }
                          if(${status.count != result.size()}) {
                          $("#next").val(${result[status.index+1].board_seq}); } 
                          
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
                                 
                                 
//                                   $("#modalcontents").text(data.contents);  
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

                     
             				</script>
				</div>
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


<form id="fileForm">
	<div class="modal fade" id="profileimage" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered modal-lg"
			role="document">
			<div class="modal-content"
				style="font-family: NANUMBARUNPENR !important; font-size: 14px;">

				<!-- Modal Header -->
				<div class="modal-header"
					style="font-family: NANUMBARUNPENR !important; font-size: 14px;">
					<h4 class="modal-title"
						style="font-family: NANUMBARUNPENR !important; font-size: 14px;">프로필
						이미지 등록하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->

				<div class="modal-body" 
					style="border: 5px solid #eff1f4; font-family: NANUMBARUNPENR !important; font-size: 14px;">
					<div style="max-height: 300px; border: 5px solid #eff1f4;">
						<input id="inputimg" name="inputimg" type='file'
							onchange="readURL(this);"> <img id="profileimg"
							src="resources/images/Placeholder.png" alt="your image" />

					</div>
					<div class="dropdown-divider"></div>

					<c:if test="${profileImg.size() > 1}">
						<div class="alert alert-success">
							  <strong
								style="font-family: NANUMBARUNPENR !important; font-size: 14px;">최근
								프로필 사진</strong>
						</div>
						<div style="overflow-x: scroll; max-height: 300px; display: flex;">
							<c:forEach items="${profileImg}" var="proimg">
								<c:if test="${proimg.is_selected eq 'n'}">
									<div class="imgbtnwrap">
										<img onclick="updateImg('${proimg.system_file_name}')"
											id="profileimg"
											src="AttachedMedia/${proimg.system_file_name}"
											style="object-fit: cover; cursor: pointer;">
										<button id="${proimg.system_file_name}" type="button" class="close imgdel" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">

					<button type=button class="btn btn-light text-dark" id="savebtn"
						style="font-weight: bold; width: 100px;">저장</button>
					<button type=button class="btn btn-light text-dark"
						data-dismiss="modal" style="font-weight: bold; width: 100px;">닫기</button>

				</div>
				<input id="hiddenimgname" type="hidden"> <input
					id="hiddenid" type="hidden" value="${sessionScope.loginId}">

			</div>
		</div>
	</div>
</form>



<div class="modal fade" id="settingModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm modal-dialog-centered"
		role="document">
		<input type=hidden id=modalseq>
		<div class="modal-content cons">
			<div class="modal-body">
				<a class="dropdown-item mo1" href="profile.member?cat=1">비밀번호 변경</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo1" href="profile.member?cat=2">이메일 및
					SMS</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo1" href="profile.member?cat=3">공개 범위 및
					보안</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo1" href="profile.member?cat=4">비즈니스
					프로필</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo1" href="logout.do">로그아웃</a>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-info footertbtn"
					data-dismiss="modal">Close</button>

			</div>
		</div>

	</div>
</div>



<%@ include file="include/bottom.jsp"%>
