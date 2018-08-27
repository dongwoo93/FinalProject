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
			var message = msg.data.split("뇽뇽뇽뇽321뇽뇽뇽뇽")[0];
			var sender = msg.data.split("뇽뇽뇽뇽321뇽뇽뇽뇽")[1];
			var receivernickname = $("#dmnickname").text();
			var receiverId = $("#userId").val();
			if(receiverId == sender){
		    	$("#messagebox").append("<div class='message-box-holder'><div class='message-sender'><a>"+receivernickname+"</a></div><div class='message-box message-partner'>"+message+"</div></div>");
		    	var objDiv = document.getElementById("messagebox");
		    	objDiv.scrollTop = objDiv.scrollHeight;
		    	setRead(receiverId);
			}
			else{
				$("#alertsender").text(sender);
				$("#alertmsg").html(message);
				 
				$("#alertmessenger").fadeIn(2000);
				setTimeout(function(){
					$("#alertmessenger").fadeOut(2000);
				},4000); 
				reloadMessengerlist();
			}
		};
		
	    ws.onclose = function (event) {
	    	$("#userId").val("");
	    };
	    
	    $("#sendDm").keydown(function(key) {
			var message = $("#sendDm").val(); 
			var receiver = $("#userId").val();
			if (key.keyCode == 13) {
				$("#sendDm").val("");
				sendMsg(message,receiver);
			}
		});
	    
	    $(".imoticon").dblclick(function(){
	    	var url = $(this).attr("src");
	    	var message = "<img src="+url+" class='imoticon'>"
	    	var receiver = $("#userId").val();
	    	sendMsg(message,receiver);
	    });
	    
	    $("#dmSearch").keyup(function(){
			console.log("늘림");
        	 var searchtext = $(this).val();
        	 reloadFriendlist(searchtext);
        });
	    
	    function sendMsg(message,receiver){
	    	$.ajax({
                url: "insertMessage.do", // 처리할 페이지(서블릿) 주소
                type: "get",
                data: {message:message,receiver:receiver,sender:"${sessionScope.loginId}"}, 
                success: function(response) {
                	console.log(response);
                	if(response == "전송실패"){
                		   alert("전송실패");
                	}
                	else{
                		var date = response.split("#")[0];
                		var time = response.split("#")[1];
                		var objDiv = document.getElementById("messagebox");
                		var lastdate = $(".dmdate").last().text();
                		ws.send(receiver+"뇽뇽뇽뇽123뇽뇽뇽뇽"+message+"뇽뇽뇽뇽321뇽뇽뇽뇽${sessionScope.loginId}");
                		console.log(lastdate);
                		if(lastdate != date){
                			
		                $("#messagebox").append("<div class='message-box-holder text-center dmdate' style='display:inline;'>"+date+"</div>");
                		}
	                	$("#messagebox").append("<div class='message-box-holder'><div class='message-box'>"+message+"</div><div class='mt-2'>"+time+"</div></div>");
                        objDiv.scrollTop = objDiv.scrollHeight;
                        reloadMessengerlist();
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
	
	$(document).ready(function(){
		$('.chatbox').hide();
		
		$("#allwrapper").click(function(){
			closeDm();
		});
	});
  
    AOS.init();
    
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
	var modstate = $("#modstate"+seq).val();    
	
		$("#ul"+seq).attr("style","background-color:#E1F5FE");
		$("#commenttxt"+seq).attr("style","word-wrap: break-word; word-break:break-all background-color:#E1F5FE"); 
		
		if(sessionid == boardid) {       
		$("#commentdel"+seq).html("삭제"); 
		
		if(modstate == "1") {
			$("#commentmod"+seq).html("수정");
		} 
		else if(modstate =="2") {  
			$("#commentmod"+seq).html("완료");
		}
		
		}  
	
    }
    
    function commentleave(e) {
    	var seq = $(e).attr("value"); 
		 
		$("#ul"+seq).attr("style",false);            
		$("#commenttxt"+seq).attr("style","word-wrap: break-word; word-break:break-all"); 
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
                   $("#ul"+comment_seq).fadeOut(400,function() { $(this).remove(); });   
                   if(cnt>2){ 
                       $("#myComment"+board_seq).html("&nbsp&nbsp모두 "+cnt+"개의 댓글보기")}
                       else {
                    	   $("#myComment"+board_seq).html("");  
                       }
                  }
                    
             }) //ajax 
    }

    function modComment(e) { 
      	 var comment_seq;
      	 if($(e).attr("value") != null){
      		comment_seq = $(e).attr("value"); 
      	 } else {
      		 comment_seq = $(e).attr("id").replace("commenttxt", "");
      	 }
      	 
      	 var modstate = $("#modstate"+comment_seq).val();   
		
		
		if(modstate == "1") {	// 수정중
			$("#commentmod"+comment_seq).html("완료");
			 $("#commenttxt"+comment_seq).attr("contentEditable",true);	
			 
          	 $("#commenttxt"+comment_seq).attr("style","border:0.5px solid lightgray");
          	 $("#commenttxt"+comment_seq).focus();  
          	 
          	 placeCaretAtEnd( document.getElementById("commenttxt"+comment_seq) );
			 
          	
          	 $("#modstate"+comment_seq).val("2");    

		}
		else if(modstate=="2") {	// 수정 완료하고 싶을 때
			$("#commentmod"+comment_seq).html("수정");   
			 var txt = $("#commenttxt"+comment_seq).text();
  			 if(txt == ""){
                 alert("댓글을 입력해주세요");
              }
              else {  
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
		                   
                      }  
                 }); //ajax 
                 }
			
		}
      
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
    
    $(document).ready(function(){
    	
    	var globalThisCommentIsFocusedOnFirst = true;
    	
        $("div[id*=comment].insertfield").focus(function() {
        	if(globalThisCommentIsFocusedOnFirst){
        		$(this).html("");
            	globalThisCommentIsFocusedOnFirst = false;
        	}
        	
        });
        
        $("div[id*=comment].insertfield").focusout(function() {
        	if($(this).text() == ""){
        		$(this).html("<span class=text-muted>댓글 달기...</span>");
        		globalThisCommentIsFocusedOnFirst = true;
        	}
        })
    	

    	function makeupHashtag (e) {

            if ((e.keyCode === 32)) {

                if (parseInt($('#caretposition').val()) == 0) {
                    // alert('뭐?')                        	 
                } else if (parseInt($('#caretposition').val()) == $(this).text().length) {
                    // alert( parseInt($('#caretposition').val()) + ":" +  $('#editorDiv').text().length);
                } else {
                    // alert('임마?')
                    return;
                }

                var regex = /(#[^#\s,;<>. ]+)/gi;
                if (regex) {
                    var newtxt = "<span class=fugue>" + $(this).text()
                        .replace(regex, "</span><span class=text-danger>" + "$1" +
                            "</span><span class=fugue>") + "</span>"

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
        }
    	
    	$("div[id*='comment'].insertfield").on("mousedown mouseup keydown keyup", update);
    	$("div[id*='commenttxt']").on("mousedown mouseup keydown keyup", update);
    	
    	$("div[id*='comment'].insertfield").keyup(makeupHashtag)
    	$("div[id*='commenttxt']").keyup(makeupHashtag)  	
    
    	$("div[id*='commenttxt']").keypress(function(e){
			if(e.keyCode === 13) {
			modComment(this);
		 }
		})
    	
    });
</script>

<div class="" id="allwrapper">
	<input type="hidden" id=caretposition>
	<div class="" id="centerwrapper">

		<div class="container " id="contents">

			<div id="board">

				<script>var num = 1;</script>

				<c:forEach var="tmp" items="${result}" varStatus="status">

					<div class="py-2 my-5" data-aos="fade-up" data-aos-once="true"
						id="feed">
						<div class="profile-image">
							<img class="ml-3 mr-2 pic"
								src="AttachedMedia/<c:out value='${profile_pic[tmp.id]}'/>">
							<%--               <h5 class="mt-1 idtxt">${tmp.id}</h5>  --%>
							<br> <a class="mt-1 idtxt" id="id"
								href="board.bo?id=${tmp.id}&cat=1">${tmp.id}<br>Dangsan.South
								Korea
							</a>
						</div>
						<div class="mt-2" id="boardimg">
							<%-- 						  	<input type=hidden id="maxheight${status.index}" value="0"> --%>


							<%-- 						<c:forEach var="media" items="${result2[status.index]}" varStatus="status3"> --%>

							<%-- 											<img class='boardimg' id="feedimg${status.index}a${status3.index}" width='100%' style="display:none;" --%>
							<%-- 												src="AttachedMedia/${media.system_file_name}" alt=""> --%>

							<script>      
										
// 										var height= $("#feedimg${status.index}a${status3.index}").height()
										
// 										var maxheight = $("#maxheight${status.index}").val();
										
										
// 										if(parseInt(maxheight) < height){
											
// 										$("#maxheight${status.index}").val(height);
  
// 										var realmax= $("#maxheight${status.index}").val();   
										 
										
// 										}     
										
// 										var realmax= $("#maxheight${status.index}").val(); 
// 										$("#myCarousel${status.index}").attr("style"," height:"+realmax+"px;");  
										
										</script>
							<%-- 									</c:forEach> --%>



							<div id="myCarousel${status.index}" class="carousel slide"
								data-ride="carousel" data-interval="false">
								<ul id="carousel-indicators" class="carousel-indicators">
									<li id="firstli" data-target="#myCarousel${status.index}"
										data-slide-to="0" class="active"></li>
									<c:forEach begin="1" var="media"
										items="${result2[status.index]}" varStatus="status2">
										<li data-target="#myCarousel${status.index}"
											data-slide-to="${status2.index}"></li>
									</c:forEach>
								</ul>
								<div id="carousel-inner" class="carousel-inner">
									<div id="firstItem" class="carousel-item active">
										<img class='boardimg' width='100%'
											src='AttachedMedia/${result2[status.index][0].system_file_name}'
											alt=''>
									</div>
									<c:forEach begin="1" var="media"
										items="${result2[status.index]}" varStatus="status3">
										<div class="carousel-item">
											<img class='boardimg' width='100%'
												src="AttachedMedia/${media.system_file_name}" alt="">
										</div>

									</c:forEach>

								</div>

								<a id="carousel-prev${status.index}"
									class="carousel-control-prev" href="#myCarousel${status.index}"
									data-slide="prev"> <span class="carousel-control-prev-icon"></span>
								</a> <a id="carousel-next${status.index}"
									class="carousel-control-next" href="#myCarousel${status.index}"
									data-slide="next"> <span class="carousel-control-next-icon"></span>
								</a>
							</div>

						</div>


						<div id="cont">
							<nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
								<div class="container">
									<a class="navbar-brand"> <c:choose>
											<c:when test="${like.containsKey(tmp.board_seq)}">
												<i value="${tmp.board_seq}" style="display: none;"
													id="likeit" class="far fa-heart icon mr-1 pointer"
													onclick="likeit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: red;" id="likecancel"
													class="far fa-heart icon mr-1 pointer"
													onclick="unlikeit(this)"></i>
											</c:when>
											<c:otherwise>
												<i value="${tmp.board_seq}" id="likeit"
													class="far fa-heart icon mr-1 pointer"
													onclick="likeit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: red; display: none;"
													id="likecancel" class="far fa-heart icon mr-1 pointer"
													onclick="unlikeit(this)"></i>

											</c:otherwise>
										</c:choose> <i class="far fa-comment icon"></i>
									</a> <a class="btn navbar-btn ml-2 text-white "> <c:choose>
											<c:when test="${bookmark.containsKey(tmp.board_seq)}">

												<i value="${tmp.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" style="display: none;"
													onclick="markit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: #00B8D4;" id="markcancel"
													class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>

												<i value="${tmp.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" onclick="markit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: #00B8D4; display: none;"
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
										href="board.bo?id=${tmp.id}&cat=1" style="font-size: 14px;">${tmp.id}</a>

									<div class='pl-3' id="contdiv${tmp.board_seq}"
										style="word-wrap: break-word; word-break: break-all"></div>
									<script>
							           
							  var txt = "${tmp.contents}"; 
							  var regex = /(#[^#\s,;<>.]+)/gi  ; 
					          var newtxt = txt.replace(regex, "<a onclick='tag(this)' style='cursor: pointer;' class=text-danger>"+"$1"+"</a>");        
					          // $("#contdiv").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);           
							$("#contdiv${tmp.board_seq}").html(newtxt);    
							  
							function tag(e) {
								var search = $(e).html().split("#")[1]; 
								$(location).attr("href","search.bo?search="+search); 
					
							}

		</script>
								</div>
								<!-- 글내용자리 -->

								<p class="text-info pointer pt-4 mb-1"
									id="myComment${tmp.board_seq}" onclick="commentdisplay(this)"></p>
								<input type=hidden value="${tmp.board_seq}">
								<div class="comment-contents"
									id="comment-contents${tmp.board_seq}">

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

													<ul id="ul${comment.comment_seq}" style="display: none"
														value="${comment.comment_seq}"
														onmouseover="commentover(this)"
														onmouseleave="commentleave(this)"
														class='commentline navbar-nav co${tmp.board_seq}'>
														<li id='li1'><a
															href="board.bo?id=${comment.id}&cat=1">${comment.id}</a></li>
														<li id='li2'><div
																id='commenttxt${comment.comment_seq}'
																class='commenttxt txt${tmp.board_seq}'
																style='word-wrap: break-word; word-break: break-all'>${comment.comment_contents}</div></li>

														<li id='li3'><a id='commentdel${comment.comment_seq}'
															value="${tmp.board_seq}:${comment.comment_seq}"
															onclick="delComment(this)" class="pointer"></a></li>
														<li id='li4'><a id='commentmod${comment.comment_seq}'
															value="${comment.comment_seq}" onclick="modComment(this)"
															class="pointer"></a></li>

													</ul>
													<script>
	                                        var text = $("#commenttxt${comment.comment_seq}").text();  
	                           				var regex = /(#[^#\s,;<>.]+)/gi;            
	                              			// var newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red; cursor: pointer;'>"+"$1"+"</a>");
	                              			var newtxt = "<span class=fugue>" + text.replace(
	                              			                    		regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                            "</a><span class=fugue>") + "</span>";
                            				newtxt += "<kz></kz>";
	                               			$("#commenttxt${comment.comment_seq}").html(newtxt);
                           				</script>

													<input type=hidden id='modstate${comment.comment_seq}'
														value="1">
													<script>
							$("#ul${commenttmp.value[0].comment_seq}").attr("style",false);
							$("#ul${commenttmp.value[1].comment_seq}").attr("style",false);
							</script>

												</c:forEach>

											</c:when>
										</c:choose>

									</c:forEach>
								</div>
								<p class="text-info pointer pt-3 pl-1"
									id="commenthide${tmp.board_seq}" onclick="commenthide(this)"></p>
								<input type=hidden value="${tmp.board_seq}">
							</div>



							<!--               -->


							<div class="crecodiv pl-2 py-2 navbar-nav">



								<%-- 								<input type="text" placeholder="댓글 달기..."
									name="comment_contents${tmp.board_seq}" class="creco ml-2 "
									id="comment${tmp.board_seq}"> --%>

								<div contenteditable=true class="creco ml-2 insertfield"
									id="comment${ tmp.board_seq }">
									<span class=text-muted>댓글 달기...</span>
								</div>

								<div class="btn-group bg-white">
									<i id="modalBoardBtn${tmp.board_seq}"
										value="${tmp.board_seq}:${tmp.id}" onclick="modal(this)"
										class="fas fa-ellipsis-h btn mr-1" data-toggle="modal"> </i>
								</div>


							</div>

							<script>
						
					
								$('#comment${tmp.board_seq}').keypress(function(event){
	                                var keycode = (event.keyCode ? event.keyCode : event.which);
	                                if(keycode == '13'){
	                                   var text = $("#comment${tmp.board_seq}").text();
	                                   if(text == ""){
	                                      alert("댓글을 입력해주세요");
	                                   }
	                                   else {  
	                                      $.ajax({ 
	                                              type: "POST",  
	                                              url: "comment.co",    
	                                              data: {board_seq:${tmp.board_seq}, comment_contents : text},
	                                              success : function(seq) {       
	                                            	  $('#comment${tmp.board_seq}').html("");
	                                              /*  $("#comment${tmp.board_seq}").val("");   */  
	                                              var regex = /(#[^#\s,;<>.]+)/gi;            
                                                  // var newtxt = text.replace(regex, "<a onclick='tag(this)'; cursor: pointer;' class=text-danger>"+"$1"+"</a>");
                                                   var newtxt = "<span class=fugue>" + text.replace(
	                              			                    		regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                          												"</a><span class=fugue>") + "</span>";
                            						newtxt += "<kz></kz>";
                                            
                                                   
	                                               $("#comment-contents${tmp.board_seq}").prepend("<ul class='navbar-nav commentline co${tmp.board_seq}' id='ul"+seq+"' value='"+seq+"' onmouseover='commentover(this)' onmouseleave='commentleave(this)'><li id='li1' ><a href='board.bo?id=${sessionScope.loginId}'>${sessionScope.loginId}</a></li><li id='li2'><div id='commenttxt"+seq+"' style='word-wrap: break-word; word-break:break-all' class='commenttxt'>"+newtxt+"</div></li><li id='li3'><a id='commentdel"+seq+"' onclick='delComment(this)' value='${tmp.board_seq}:"+seq+"' class='pointer'></a> </li><li id='li4'><a id='commentmod"+seq+"' value='"+seq+"' onclick='modComment(this)'  class='pointer'></a></li></ul>"
	                                            		   +"<input type=hidden id='modstate"+seq+"' value='1'>");
	                                               $("#ul"+seq).hide().fadeIn(500);  
	                                               
	                                               $("#commenttxt" + seq).keyup(function(e){
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
	                                                               .replace(regex, "</span><span class=text-danger>" + "$1" +
	                                                                   "</span><span class=fugue>") + "</span>"

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
	                                               
	                                               $("#commenttxt" + seq).keypress(function(e){
														if(e.keyCode === 13) {
														modComment(this);
													 }
													})
	                                               
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






			<div style="position: fixed; border-radius: 1px;">
				<c:forEach var="tmp" items="${result}" varStatus="status" begin="1"
					end="1">
					<div class="container" id="float"
						style="width: 300px; margin-top: 55px; margin-left: 30px;">
						<br>
						<div class="profile-image">
							<img class="ml-3 mr-2 pic"
								src="AttachedMedia/<c:out value='${profile_pic[sessionScope.loginId]}'/>">
							<a class="mt-6 idtxt"
								style="font-size: 16px; font-family: 'HelveticaNeue', 'Arial', sans-serif;"
								href="board.bo?id=${sessionScope.loginId}&cat=1">${sessionScope.loginId}</a>

						</div>
				</c:forEach>


				<hr class="_5mToa">
				<p class="text-center"
					style="font-family: 'HelveticaNeue', 'Arial', sans-serif; font-size: 15px;">
					<i class="far fa-arrow-alt-circle-left" style="font-size: 15px;"></i>&nbsp;&nbsp;&nbsp;&nbsp;추천
					Follow를 추가하세요!!&nbsp;&nbsp;&nbsp;&nbsp;<i
						class="far fa-arrow-alt-circle-right" style="font-size: 15px;"></i>
				</p>
				<hr class="_5mToa">
				<c:forEach var="followtmp" items="${result3}" varStatus="status"
					begin="0" end="4">

					<div class="container">

						<div class="profile-image">
							<img class="ml-3 mr-2 pic"
								src="AttachedMedia/<c:out value='${profile_pic[followtmp.id]}'/>">
							<a class="mt-6 idtxt"
								style="font-size: 16px; font-family: 'HelveticaNeue', 'Arial', sans-serif;"
								href="board.bo?id=${followtmp.id}&cat=1">${followtmp.id}</a>
						</div>

					</div>

				</c:forEach>
				<hr class="_5mToa">


			</div>

			<div class="pt-4 pb-3  " id="footer"
				style="font-size: 5px; margin-left: 20px;">
				<div class="container">
					<div class="row">
						<div class="col-md-10">
							<p>SocialWired.정보.지원.홍보.채용</p>
							<p>정보개인정보처리방침 .약관.디렉터리.프로필.해시태그언어</p>
							<p>@2018SocialWired</p>
						</div>
					</div>
				</div>
			</div>

		</div>


	</div>
	<!-- container -->

</div>
<!-- centerwrapper -->
</div>
<!--  allwrapper-->


<div class="modal fade" id="changeBoardModal" tabindex="-1"
	role="dialog"></div>

<div class="modal" id="changeBoardModal2" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<input type=hidden id=modalseq>
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">신고</h4>
			</div>
			<div class="modal-body">
				<a class="dropdown-item mo" onclick="">폭력 또는 폭력 위협</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo" onclick="">마약 판매 및 홍보</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo" onclick="">괴롭힘 및 따돌림</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo" onclick="">지적 재산권 침해</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo" onclick="">스스로 신체적 상해를 입히는 행위</a>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
					<p style="color: #262626; font-weight: 600; margin-bottom: 8px;">편파적
						발언 또는 상징으로 신고할까요?</p>
					<p style="margin-bottom: 8px;">삭제 대상:</p>
					<ul style="list-style-type: disc; margin: 0 0 8px 0;">
						<li style="margin-bottom: 8px;">나치 상징(하켄크로이츠)이나 백인 우월주의를 나타내는
							손 모양 등 편파적 발언 또는 상징에 관한 사진</li>
						<li style="margin-bottom: 8px;">폭력을 조장하거나 사람의 정체성을 바탕으로 공격하는
							내용의 게시물</li>
						<li style="margin-bottom: 8px;">신체적 상해, 절도 또는 기물 파손에 대한 협박</li>
					</ul>
					<p style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는
						공개되지 않습니다.</p>
					<p style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급
						서비스 기관에 연락하세요.</p>
					<button type="button" class="btn btn-primary" style="width: 100%">제출</button>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>
												
					<!--                                  DM -->
					<script>
					function openDm() {
						reloadFriendlist("");
						reloadMessengerlist();
					    document.getElementById("dm").style.width = "17%";
					    document.getElementById("allwrapper").style.marginLeft = "17%";
					    document.getElementById("footer").style.marginLeft = "17%";
					}
					
					function setRead(friendid){
						$.ajax({
			                url: "setRead.do", // 처리할 페이지(서블릿) 주소
			                type: "get",
			                data: {friendid:friendid,id:"${sessionScope.loginId}"},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
			                success: function(response) {
			                	if(response.length != 0){
			                		reloadMessengerlist();
			                	}
			                },
			                error: function() {
			                    console.log("에러 발생");
			                },
			                complete: function(){
			                    console.log("AJAX 종료");
			                }
			            });
					}
					
					function reloadFriendlist(text){
						$("#offlinefriendlist *").remove();
						$("#onlinefriendlist *").remove();
						$.ajax({
			                url: "dmfriendlist.do", // 처리할 페이지(서블릿) 주소
			                type: "get",
			                data: {searchtext: text},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
			                success: function(response) {
			                	$("#onlinecount").text(response[0].length);
			                	$("#offlinecount").text(response[1].length);
			                	for(var i=0;i<response.length;i++){
			                		if(i==0){
			                			for(var k=0;k<response[0].length;k++){
			                				$("#onlinefriendlist").append("<li onclick='openmessage(this)'><img src='루이.jpg' class='dmimg'>"+response[0][k].nickname+"<input type='hidden' id='usernickname' value='"+response[0][k].nickname+"'><a class='favorite'><i class='fas fa-circle onlineicon'></a></li>");
			                			}
			       
			                		}
			                		else{
			                			for(var k=0;k<response[1].length;k++){
			                				console.log(response[1][k]);
			                				$("#offlinefriendlist").append("<li onclick='openmessage(this)'><img src='루이.jpg' class='dmimg'>"+response[1][k].nickname+"<input type='hidden' id='usernickname' value='"+response[1][k].nickname+"'><a class='favorite'><i class='fas fa-circle'></a></li>");
			                			}
			                			
			                		}
			                	}
			                },
			                error: function() {
			                    console.log("에러 발생");
			                },
			                complete: function(){
			                    console.log("AJAX 종료");
			                }
			            });
					}
					
					function reloadMessengerlist(){
						$("#currentmessenger *").remove();
						var notreadcount=0;
						$.ajax({
			                url: "currentMessenger.do",
			                type: "get",
			                data: {id:"${sessionScope.loginId}"}, 
			                success: function(response) {
			                	for (var key in response) {
			                		if(response[key].read == 0){
				                	    $("#currentmessenger").append("<li onclick='openmessage(this)' onmouseover='showdelete(this)' onmouseleave='hidedelete(this)' style='font-size:13px;'>"+response[key].receiver+"<input type='hidden' id='usernickname' value='"+response[key].receiver+"'><span style='float:right;' class='mr-3'>"+response[key].message_date.split(" ")[0]+"</span><p class='ml-3' style='width: 200px;'>"+response[key].message+"</p><div onclick='deletemessenger(this)' id='"+response[key].sender+"' class='messengerdelete' style='display:none;'>삭제하기<input type='hidden' id='hiddennick' value='"+response[key].receiver+"''></div></li>");
			                		}
			                		else{
				                	    $("#currentmessenger").append("<li onclick='openmessage(this)' onmouseover='showdelete(this)' onmouseleave='hidedelete(this)' style='font-size:13px;'>"+response[key].receiver+"<input type='hidden' id='usernickname' value='"+response[key].receiver+"'><span style='float:right;' class='mr-3'>"+response[key].message_date.split(" ")[0]+"</span><p class='ml-3 currentmessage' style='width: 250px;'>"+response[key].message+"<span class='notreadcount'>"+response[key].read+"</span></p><div onclick='deletemessenger(this)' id='"+response[key].sender+"' class='messengerdelete' style='display:none;'>삭제하기<input type='hidden' id='hiddennick' value='"+response[key].receiver+"''></div></li>");
				                	    notreadcount = notreadcount + response[key].read;
			                		}
			                		$("#currentmessenger li p img").attr("class","imoticonsm");
			                		if(notreadcount != 0){
			                			$("#totalreadcount").text(notreadcount);
			                			$("#totalreadcount").show();
			                		}
			                		else{
			                			$("#totalreadcount").hide();
			                		}
			                	}
			                },
			                error: function() {
			                    console.log("에러 발생");
			                },
			                complete: function(){ 
			                    console.log("AJAX 종료");
			                }
			            });
					}
					
					function showdelete(e){
						$(e).find(".messengerdelete").attr("style","");
					}
					
					function hidedelete(e){
						$(e).find(".messengerdelete").attr("style","display:none;");
					}
					
					function deletemessenger(e){
						event.stopPropagation();

						var check = confirm("모든 대화가 삭제됩니다.");
						if(check){
							var id = $(e).attr("id");
							var nickname1 = $(e).find("#hiddennick").val();
							$.ajax({
				                url: "deleteMessenger.do",
				                type: "get",
				                data: {id:"${sessionScope.loginId}",friendid:id}, 
				                success: function(response) {
				                	console.log(response);
				                	if(response > 0){
				                		alert("삭제가 완료되었습니다.");
				                		reloadMessengerlist();
				                		console.log(nickname1);
				                		var nickname2 = $("#dmnickname").text();
				                		if(nickname1 == nickname2){
				                			$(".chatbox").hide(); 
				                		}
				                	}
				                	else{
				                		alert("삭제실패");
				                	}
				                },
				                error: function() {
				                    console.log("에러 발생");
				                },
				                complete: function(){ 
				                    console.log("AJAX 종료");
				                }
				            });
						}
					}
					

					function closeDm() {
					    document.getElementById("dm").style.width = "0";
					    document.getElementById("allwrapper").style.marginLeft= "0";
					    document.getElementById("footer").style.marginLeft = "0";
					}
					
					function openmessage(e){
						var nickname = $(e).find("#usernickname").val();
						$("#dmnickname").text(nickname);
						$("#messagebox *").remove(); 
						
						$.ajax({
			                url: "selectUserId.do",
			                type: "get",
			                data: {nickname: nickname}, 
			                success: function(response) {
			                	$('.chatbox').show();
			                	$("#userId").val(response);
			                	setRead(response);
			                	var receiver = $("#userId").val();
			                	$.ajax({
					                url: "selectmessenger.do",
					                type: "get",
					                data: {receiver: receiver,sender:"${sessionScope.loginId}"},    
					                success: function(response) {
					                	if(response.length != 0){
						                	 var date = response[0].message_date.split("#")[0];
						                	 $("#messagebox").append("<div class='message-box-holder text-center dmdate' style='display:inline;'>"+date+"</div>");
						                	 for(var i=0;i<response.length;i++){
						                		 if(response[i].message_date.split("#")[0] != date){
						                			 date = response[i].message_date.split("#")[0];
						                			 $("#messagebox").append("<div class='message-box-holder text-center dmdate' style='display:inline;'>"+date+"</div>");
						                		 }
						                		 if(response[i].sender == "${sessionScope.loginId}"){
						                			 $("#messagebox").append("<div class='message-box-holder'><div class='message-box'>"+response[i].message+"</div><div class='mt-2'>"+response[i].message_date.split("#")[1]+"</div></div>");
						                		 }
						                		 else{
						                			 $("#messagebox").append("<div class='message-box-holder'><div class='message-sender'><a>"+nickname+"</a></div><div class='message-box message-partner'>"+response[i].message+"</div><div class='mt-2' style='align-self:flex-start;'>"+response[i].message_date.split("#")[1]+"</div></div>")
						                		 }
						                	 }
						                	 var objDiv = document.getElementById("messagebox");
					                         objDiv.scrollTop = objDiv.scrollHeight;  
					                	}
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
				            <div>
				                <input type="text" id="dmSearch" class="form-control" placeholder="Search" >
				            </div>
					  
					        <div class="menu-list">
					  
					            <ul id="menu-content" class="menu-content collapse out">
					         
					                <li data-toggle="collapse" data-target="#currentmessenger" class="collapsed">
					                  <a><i class="fab fa-fort-awesome-alt fa-lg"></i>최근 목록</a>
					                </li>  
					                <ul class="sub-menu collapse" id="currentmessenger">

					                </ul>
					                
					            </ul>
					            <li>
					                  <a><i class="fas fa-circle onlineicon"></i>온라인 친구<span class="ml-2" id="onlinecount"></span></a>
					                </li>
					                <ul id="onlinefriendlist">

					                </ul> 
					                <li>
					                  <a><i class="fas fa-circle"></i>오프라인 친구<span class="ml-2" id="offlinecount"></span></a>
					                </li>
					                <ul id="offlinefriendlist">
					    	 			 
					    		    </ul>
					    	 </div>
					    	 
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
    
    <div class="attachment-panel" style='overflow-x:scroll; white-space:nowrap'>
    	<img src="/resources/images/imoticon/1.png" class="imoticon">
    	<img src="/resources/images/imoticon/2.png" class="imoticon">
    	<img src="/resources/images/imoticon/3.png" class="imoticon">
    	<img src="/resources/images/imoticon/4.png" class="imoticon">
    	<img src="/resources/images/imoticon/5.png" class="imoticon">
    	<img src="/resources/images/imoticon/6.png" class="imoticon">
    	<img src="/resources/images/imoticon/7.png" class="imoticon">
    	<img src="/resources/images/imoticon/8.png" class="imoticon">
    	<img src="/resources/images/imoticon/9.png" class="imoticon">
    	<img src="/resources/images/imoticon/10.png" class="imoticon">
    	<img src="/resources/images/imoticon/11.png" class="imoticon">
    	<img src="/resources/images/imoticon/12.png" class="imoticon">
    	<img src="/resources/images/imoticon/13.png" class="imoticon">
    	<img src="/resources/images/imoticon/14.png" class="imoticon">
    	<img src="/resources/images/imoticon/15.png" class="imoticon">
    	<img src="/resources/images/imoticon/16.png" class="imoticon">
    	<img src="/resources/images/imoticon/17.png" class="imoticon">
    	<img src="/resources/images/imoticon/18.png" class="imoticon">
    	<img src="/resources/images/imoticon/19.png" class="imoticon">
    	<img src="/resources/images/imoticon/20.png" class="imoticon">
    	<img src="/resources/images/imoticon/21.png" class="imoticon">
    	<img src="/resources/images/imoticon/22.png" class="imoticon">
    	<img src="/resources/images/imoticon/23.png" class="imoticon">
    	<img src="/resources/images/imoticon/24.png" class="imoticon">
    	<img src="/resources/images/imoticon/25.png" class="imoticon">
    	<img src="/resources/images/imoticon/26.png" class="imoticon">
    	<img src="/resources/images/imoticon/27.png" class="imoticon">
    </div>
  </div>
</div>

	<div class="chatbox-holder row" style='display:none;' id='alertmessenger'>
		<div class="alert alert-secondary alert-dismissible" role="alert">
		  <button type="button" onclick="this.parentNode.parentNode.removeChild(this.parentNode);" class="close" data-dismiss="alert"><span aria-hidden="true" class='mr-2'>×</span><span class="sr-only">Close</span></button>
		  <i class="far fa-envelope mr-2"></i><strong id="alertsender"></strong> 
		  <marquee><p class="mt-2 alertmsg" style="font-family: Impact; font-size: 14pt" id='alertmsg'></p></marquee>
		</div>
	</div>
 
<script>
$(function(){
	  $('.fa-minus').click(function(){    
		  $(this).closest('.chatbox').toggleClass('chatbox-min');
	  });
	  $('.fa-close').click(function(){
	    $(this).closest('.chatbox').hide();
	    $("#userId").val("");
	    $("#dmnickname").text("");
	  });
});
</script>
                      
                        
      <%@ include file="include/bottom.jsp"%>
      
      
  