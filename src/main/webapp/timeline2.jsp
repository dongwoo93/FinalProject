<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/timeline.css">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script> var currentId = "${sessionScope.loginId}";
var globalThisCommentIsFocusedOnFirst = true;
</script>
<script src="resources/js/timeline.js"></script>

<!-- 달력cdn -->
<link href='resources/fullcalendar/fullcalendar.min.css'
	rel='stylesheet' />
<link href='resources/fullcalendar/fullcalendar.print.min.css'
	rel='stylesheet' media='print' />
<script src='resources/fullcalendar/lib/moment.min.js'></script>
<script src='resources/fullcalendar/fullcalendar.min.js'></script>
<script src='resources/fullcalendar/locale/ko.js'></script>
<script src='resources/fullcalendar/gcal.min.js'></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	
<!-- 달력cdn끝 -->
<script>


 



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

function follow(id1, id2, e) {
	   var id = id1; 
	   var targetId = id2; 
	   $.ajax({ 
	      url : "follow.do", 
	      type : "post", 
	      data : { 
	         id : id, 
	         targetId : targetId, 
	      }, 
	      success : function(resp) {
	    	  $(e).hide(); 
	         $(e).next().show(); 
	         
	          
	      }, 
	      error : function() { 
	         console.log("에러 발생!"); 
	         } 
	      }) 
	} 
	 
function unfollow(id1, id2, e) {
	   var id = id1; 
	   var targetId = id2; 
	   $.ajax({ 
	      url : "deletefollow.do", 
	      type : "post", 
	      data : { 
	         id : id, 
	         targetId : targetId, 
	      }, 
	      success : function(resp) {
	    	  $(e).hide(); 
	    	  $(e).prev().show(); 
	        
	          
	      }, 
	      error : function() { 
	         console.log("에러 발생!"); 
	         } 
	      }) 
	}

function likeit(e) {   
	 var board_seq = $(e).attr("value");

	    
   $.ajax({  
      url : "like.bo",
      type : "get",
      data : {
         board_seq : board_seq,
         id : currentId,
         is_liked : "y"
      },
      success : function(resp) {
    
    	  ws.send("like:"+resp[1]); 
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
         id : currentId,
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

/////////// like & unlike + real time alert


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
	
	
	   
	function hide(e){ 
		var seq = $(e).attr("value");
		     
		$("#contdiv"+seq).attr("style","word-wrap: break-word; word-break: break-all;  overflow: hidden; text-overflow: ellipsis;white-space: nowrap;  width: 350px ; height: 20px;"); 
		$("#contplus"+seq).attr("style","color:gray;");        
		$(e).remove();   
		     	    
		
	}
	
	
	
	$(document).on('mousedown mouseup keydown keyup',"div[id*='comment'].insertfield",update);
	$(document).on('mousedown mouseup keydown keyup',"div[id*='commenttxt']",update);
	
	

	$(document).on('keyup',"div[id*='comment'].insertfield",makeupHashtag);
	$(document).on('keyup',"div[id*='commenttxt']",makeupHashtag);
	
	$(document).on('keypress',"div[id*='commenttxt']",function(e){   
		if(e.keyCode === 13) { 
			 e.preventDefault();
		modComment(this);
	 } 
	});   
	

	$(document).on('focus',"div[id*=comment].insertfield",function(){   
		if(globalThisCommentIsFocusedOnFirst){             
			$(this).html("");
	    	globalThisCommentIsFocusedOnFirst = false;
		}   
	});   
	
	$(document).on('focusout',"div[id*=comment].insertfield",function(){   
		if($(this).text() == ""){
			$(this).html("<span class=text-muted>댓글 달기...</span>");
			globalThisCommentIsFocusedOnFirst = true; 
		}
	});   
	
	
	
	


	

$(document).on('keypress',"div[id*='comment'].insertfield",function(event){   
	    
	    var keycode = (event.keyCode ? event.keyCode : event.which);  
	    var obj = this
	    var toBoardSeq = parseInt($(this).attr('id').replace("comment", ""))
	    if(keycode == '13'){ 
	    	
	       var text = $(this).text();
	       if(text == ""){
	          alert("댓글을 입력해주세요");
	       }
       		else { 
       			event.preventDefault();     
           $.ajax({ 
                  type: "POST",  
                  url: "comment.co",    
                  data: {board_seq : toBoardSeq, comment_contents : text},
                  success : function(resp) {

                	  ws.send("comment:" + resp[1]);
                	 
                	  $(obj).html("");  
                  /*  $("#comment${tmp.board_seq}").val("");   */  
                  var regex = /(#[^#\s,;<>.]+)/gi;               
               // var newtxt = text.replace(regex, "<a onclick='tag(this)'; cursor: pointer;' class=text-danger>"+"$1"+"</a>");
                var newtxt = "<span class=fugue>" + text.replace(
  			                    		regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
										"</a><span class=fugue>") + "</span>";
					newtxt += "<kz></kz>";	            	
                  
                   $("#comment-contents" + toBoardSeq).prepend("<ul class='navbar-nav commentline co" + toBoardSeq + "' id='ul"+resp[0]+"' value='"+resp[0]+"' onmouseover='commentover(this)' onmouseleave='commentleave(this)'><li id='li1' ><a href='board.bo?id=${sessionScope.loginId}'>${sessionScope.loginId}</a></li><li id='li2'><div id='commenttxt"+resp[0]+"' style='word-wrap: break-word; word-break:break-all' class='commenttxt'>"+newtxt+"</div></li><li id='li3'><a id='commentdel"+resp[0]+"' onclick='delComment(this)' value='"+toBoardSeq+":"+resp[0]+"' class='pointer'></a> </li><li id='li4'><a id='commentmod"+resp[0]+"' value='"+resp[0]+"' onclick='modComment(this)'  class='pointer'></a></li></ul>"
                		   +"<input type=hidden id='modstate"+resp[0]+"' value='1'>");
                   $("#ul"+resp[0]).hide().fadeIn(500);  
                   //&nbsp&nbsp모두 commenttmp.value.size()개의 댓글보기
                   /* var commentText = $("#myComment" + seq).text();
                   alert(commentText)
    */                $("#myComment" + resp[0]).text();
                   
                   $("#commenttxt" + resp[0]).keyup(function(e){
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
                   });
                   
                   $("#commenttxt" + resp[0]).keypress(function(e){
						if(e.keyCode === 13) {
							 e.preventDefault();
						modComment(this);
					 }
					});
                    
				  },
                  error: function(){
                      console.log("에러 발생");
                  }
             }); //ajax 
           }    
        }  
    });
	
	  
	
 	
// 	$(document).on("focus","div[id*=comment].insertfield", function() {  
    	
//     		$(this).html("");
    	
//     });
          
//     $(document).on("focusout","div[id*=comment].insertfield", function() { 
//     	if($(this).text() == ""){
//     		$(this).html("<span class=text-muted>댓글 달기...</span>");
    		     
//     	}
//     });         
	
	
	
    $(document).ready(function(){
    	AOS.init();
    	
    	var widget1 = $("#widget1").val();
    	var widget2 = $("#widget2").val();
    	
    	if(widget1 == "memo"){
    		$("#carouselExampleControls").show();
    		$("#"+widget2).show();
    	}
    	else if(widget2 == "memo"){
    		$("#carouselExampleControls").show();
    		$("#"+widget1).show();
    	}
    	else{
    		$("#"+widget1).show();
        	$("#"+widget2).show();
    	}
//         $("div[id*=comment].insertfield").focus(function() {
//         	if(globalThisCommentIsFocusedOnFirst){
//         		$(this).html("");
//             	globalThisCommentIsFocusedOnFirst = false;
//         	}
        	
//         });   
        
//         $("div[id*=comment].insertfield").focusout(function() {
//         	if($(this).text() == ""){
//         		$(this).html("<span class=text-muted>댓글 달기...</span>");
//         		globalThisCommentIsFocusedOnFirst = true;
//         	}
//         })
    	

    	////////////////////////////////////////////////
//     	$("div[id*='comment'].insertfield").on("mousedown mouseup keydown keyup", update);
//     	$("div[id*='commenttxt']").on("mousedown mouseup keydown keyup", update);
    	
//     	$("div[id*='comment'].insertfield").keyup(makeupHashtag)
//     	$("div[id*='commenttxt']").keyup(makeupHashtag)  	
    
//     	$("div[id*='commenttxt']").keypress(function(e){
// 			if(e.keyCode === 13) { 
// 				 e.preventDefault();
// 			modComment(this);
// 		 } 
// 		})
		
// 		$("div[id*='comment'].insertfield").keypress(function(event){
// 		    var keycode = (event.keyCode ? event.keyCode : event.which);
// 		    var obj = this
// 		    var toBoardSeq = parseInt($(this).attr('id').replace("comment", ""))
// 		    if(keycode == '13'){ 
		    	
// 		       var text = $(this).text();
// 		       if(text == ""){
// 		          alert("댓글을 입력해주세요");
// 		       }
// 	       		else { 
	    	   
// 	           $.ajax({ 
// 	                  type: "POST",  
// 	                  url: "comment.co",    
// 	                  data: {board_seq : toBoardSeq, comment_contents : text},
// 	                  success : function(seq) {
	                	 
// 	                	  $(obj).html("");
// 	                  /*  $("#comment${tmp.board_seq}").val("");   */  
// 	                  var regex = /(#[^#\s,;<>.]+)/gi;               
// 	               // var newtxt = text.replace(regex, "<a onclick='tag(this)'; cursor: pointer;' class=text-danger>"+"$1"+"</a>");
// 	                var newtxt = "<span class=fugue>" + text.replace(
// 	  			                    		regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
// 											"</a><span class=fugue>") + "</span>";
// 						newtxt += "<kz></kz>";	            	
	                  
// 	                   $("#comment-contents" + toBoardSeq).prepend("<ul class='navbar-nav commentline co" + toBoardSeq + "' id='ul"+seq+"' value='"+seq+"' onmouseover='commentover(this)' onmouseleave='commentleave(this)'><li id='li1' ><a href='board.bo?id=${sessionScope.loginId}'>${sessionScope.loginId}</a></li><li id='li2'><div id='commenttxt"+seq+"' style='word-wrap: break-word; word-break:break-all' class='commenttxt'>"+newtxt+"</div></li><li id='li3'><a id='commentdel"+seq+"' onclick='delComment(this)' value='"+toBoardSeq+":"+seq+"' class='pointer'></a> </li><li id='li4'><a id='commentmod"+seq+"' value='"+seq+"' onclick='modComment(this)'  class='pointer'></a></li></ul>"
// 	                		   +"<input type=hidden id='modstate"+seq+"' value='1'>");
// 	                   $("#ul"+seq).hide().fadeIn(500);  
// 	                   //&nbsp&nbsp모두 commenttmp.value.size()개의 댓글보기
// 	                   /* var commentText = $("#myComment" + seq).text();
// 	                   alert(commentText)
// 	    */                $("#myComment" + seq).text();
	                   
// 	                   $("#commenttxt" + seq).keyup(function(e){
// 	                	   // =================== 복붙 =================== 
// 	                	   if(e.keyCode === 32){
// 	                		   if (parseInt($('#caretposition').val()) == 0) {                     	 
// 	                           } else if (parseInt($('#caretposition').val()) == $(this).text().length) {
// 	                           } else {
// 	                               return;
// 	                           }

// 	                           var regex = /(#[^#\s,;<>. ]+)/gi;
// 	                           if (regex) {
// 	                               var newtxt = "<span class=fugue>" + $(this).text()
// 	                                   .replace(regex, "</span><span class=text-danger>" + "$1" +
// 	                                       "</span><span class=fugue>") + "</span>"

// 	                               // console.log($('#editorDiv').text().length);   
// 	                               // console.log(newtxt)   
// 	                               newtxt += "<kz></kz>"
// 	                               $(this).html(newtxt)
// 	                               var el = this;
// 	                               console.log("childNodes: " + el.childNodes.length);
// 	                               var range = document.createRange();
// 	                               var sel = window.getSelection();
// 	                               range.setStart(el.lastChild, 0);
// 	                               range.collapse(false);
// 	                               sel.removeAllRanges();
// 	                               sel.addRange(range);

// 	                               $(this).focusout();
// 	                               $(this).focus();
// 	                               if (parseInt($('#caretposition').val()) == $(this).text().length) {

// 	                               }

// 	                           }
// 	                	   } 
	                	   
	                	   
// 	                	// =================== 복붙 =================== 
// 	                   });
	                   
// 	                   $("#commenttxt" + seq).keypress(function(e){
// 							if(e.keyCode === 13) {
// 								 e.preventDefault();
// 							modComment(this);
// 						 }
// 						});
	                    
// 					  },
// 	                  error: function(){
// 	                      console.log("에러 발생");
// 	                  }
// 	             }); //ajax 
// 	           }    
// 	        }  
// 	    });
    	
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
						  
						<c:choose>
						<c:when test="${profile_pic.containsKey(tmp.id)}">
                  
                  
                     <img class="ml-3 mr-2 pic"
                        src="AttachedMedia/<c:out value='${profile_pic[tmp.id]}'/>">
                   
                  </c:when>
                  <c:otherwise>
                     <img class="ml-3 mr-2 pic"
                        src="resources/images/DefaultProfile.jpg">
                  </c:otherwise>
					</c:choose>
							
							<br> 
							<c:choose>
								<c:when test="${tmp.thisArticleForAd eq 1}">
									<a class="mt-1 idtxt" id="id"
										href="board.bo?id=${tmp.id}&cat=1" style="color:#4f70ce;font-weight:bold;">${ membersNick[status.index] }<br><span class="text-warning">Sponsored</span>
									</a>
								</c:when>
								<c:otherwise>
								<a class="mt-1 idtxt" id="id"
                              href="board.bo?id=${tmp.id}&cat=1" style="color:#12bbad;font-weight:bold;font-size:17px;">${tmp.id}<span style="margin-left:10px;font-size:10px;color: #6c757d;">${map[status.index].location_name}</span>
                           </a>
								</c:otherwise>
							</c:choose>
							
						</div>
						<div class="mt-2" id="boardimg">
							


							<div id="myCarousel${status.index}" class="carousel slide"
								data-ride="carousel" data-interval="false" style="z-index: 5;">
								<ul id="carousel-indicators" class="carousel-indicators" >
									<li id="firstli" data-target="#myCarousel${status.index}"
										data-slide-to="0" class="active"></li>
									<c:forEach begin="1" var="media"
										items="${result2[status.index]}" varStatus="status2">
										<li data-target="#myCarousel${status.index}"
											data-slide-to="${status2.index}"></li>
									</c:forEach>
								</ul>  
								<div id="carousel-inner" class="carousel-inner" 
								style="height:${maxImgHeight[status.index]}px; max-height:700px; min-height:200px; display:table;">
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

						<c:if test="${ tmp.thisArticleForAd eq 1 }">
							<div class=row style="z-index: 199; position: relative;">
								<div class=col-12>
									<div class="btn btn-secondary btn-lg btn-block">
										<c:forEach var="ad" items="${ adList }">
										  
											<c:if test="${ Math.abs(ad.boardSeq) eq Math.abs(tmp.board_seq) }">
											
												<c:choose>
													<c:when test="${ ad.moreInfoWebsite eq null }">
														<a href="board.bo?id=${tmp.id}&cat=1" class="text-light">SocialWired Profile 가기</a>
													</c:when>
													<c:when test="${ ad.isWebsitePurposeOfPurchase eq 'y'}">
														<a href="redirectAdUrl?r=${ ad.moreInfoWebsite }&bizseq=${ad.boardBizSeq}" class="text-light">구매하러 가기</a>
													</c:when>
													<c:otherwise>
														<a href="redirectAdUrl?r=${ ad.moreInfoWebsite }&bizseq=${ad.boardBizSeq}" class="text-light">더 알아보기</a>
													</c:otherwise>
												</c:choose>
											</c:if> 
										</c:forEach>
									</div>
								</div>
							</div>
						</c:if> 


						<div id="cont">
							<nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
								<div class="container">
									<a class="navbar-brand"> 
									<c:choose>     
											<c:when test="${like.containsKey( Math.abs(tmp.board_seq) )}">
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
										</c:choose>  
										 <i class="far fa-comment icon"></i>
									</a> <a class="btn navbar-btn ml-2 text-white "> <c:choose>  
											<c:when test="${bookmark.containsKey( Math.abs(tmp.board_seq))}">

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
										href="board.bo?id=${tmp.id}&cat=1" style="font-weight:bold;font-size: 14px;color: #12bbad;">${tmp.id}</a>
    
									<div class='pl-3 contdiv pr-2' id="contdiv${tmp.board_seq}"
										style="word-wrap: break-word; word-break: break-all;  overflow: hidden; text-overflow: ellipsis;white-space: nowrap;  width: 350px ; height: 20px;">
										  </div>     
									<a id="contplus${tmp.board_seq}" class='pointer' style="color:gray; display:none;">더보기</a>   
									<%-- <c:set var="crcn" value="\r\n" />
									<c:set var="unis" value="르르르" /> --%>
									
									<script> 							 
									
									
							  var txt = "${tmp.contents}";
							  var regex = /(#[^#\s,;<>.]+)/gi  ; 
					          var newtxt = txt.replace("\n", "<br>").replace(regex, "<a onclick='tag(this)' style='cursor: pointer;' class=text-danger>"+"$1"+"</a>");          
					          // $("#contdiv").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);           
							$("#contdiv${tmp.board_seq}").html(newtxt);   
							      
						
							function tag(e) {
								var search = $(e).html().split("#")[1]; 
								$(location).attr("href","search.bo?search="+search); 
					
							}
							
							<!-- 더보기-->   
							  console.log(txt.length);     
							if(txt.length > 48) {  
								 $("#contplus${tmp.board_seq}").attr("style","color:gray;");   
							 }
							$("#contplus${tmp.board_seq}").click(function() {     
								$("#contdiv${tmp.board_seq}").attr("style","word-wrap: break-word; word-break: break-all;"); 
								$("#contplus${tmp.board_seq}").attr("style","color:gray; display:none;");     
								       
								$("#contdiv${tmp.board_seq}").append("<a id='conthide${tmp.board_seq}' value = '${tmp.board_seq}' onclick='hide(this)' class='pointer pl-2' style='color:gray;'>접기</a>");     	    
								
							})
						
  
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
									<span class='text-muted ml-1'>댓글 달기...</span>
								</div>

								<div class="btn-group bg-white">
									<i id="modalBoardBtn${tmp.board_seq}"
										value="${tmp.board_seq}:${tmp.id}" onclick="modal(this)"
										class="fas fa-ellipsis-h btn mr-1" data-toggle="modal"> </i>
								</div>


							</div>

<!-- 여기다 그 스크립트 -->
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
			 		<input type="hidden" value="${widget1 }" id="widget1">
			 		<input type="hidden" value="${widget2 }" id="widget2">
					<div class="container float" id="follow"
						style="width: 300px; margin-top: 55px; margin-left: 30px; display:none;">
					  
						
<!-- 			<hr class="_5mToa"> -->
			<br>	
			<p class="" style="font-weight:bold;font-family:NANUMBARUNPENR !important;font-size: 15px;">
					추천 Follow를 추가하세요
				</p>
				<hr class="_5mToa">
				<c:if test="${result3.size() > 0}">  
				<div style="overflow-y:auto; height:230px; font-family:NANUMBARUNPENR !important;font-size: 14px;">    		
		<c:forEach var="followtmp" items="${result3}" varStatus="status">
					<div class="container py-1">  
					<ul class="navbar-nav" style="font-family:NANUMBARUNPENR !important;font-size: 14px;">  
					   <li>
                 
                  <c:choose>
                  <c:when test="${profile_pic.containsKey(followtmp.id)}">
                  
                  
                     <img class="ml-3 mr-2 pic"
                        src="AttachedMedia/<c:out value='${profile_pic[followtmp.id]}'/>" style="width:40px; height:40px;">
                   
                  </c:when>
                  <c:otherwise>
                     <img class="ml-3 mr-2 pic"  
                        src="resources/images/DefaultProfile.jpg" style="width:40px; height:40px;">
                  </c:otherwise>
               </c:choose></li> 
					
					
					<li class="pt-2" style="width:45%;font-family:NANUMBARUNPENR !important;font-size: 14px;">	<a class="idtxt"            
								style="font-size: 14px; font-family:NANUMBARUNPENR !important;font-size: 14px;"     
								href="board.bo?id=${followtmp.id}&cat=1">${followtmp.id}</a></li>
					<li onclick="follow('${sessionScope.loginId}', '${followtmp.id}', this)" id="follow${status.index}" class="pt-2">
						<h5 class="text-center mt-1" style="cursor:pointer;color:#4f70ce;font-weight:bold;font-family: NANUMBARUNPENR !important;">팔로우 <i class="fas fa-plus"></i></h5></li>
					<li onclick="unfollow('${sessionScope.loginId}', '${followtmp.id}', this)" id="cancelFollow${status.index}" style="display:none " class="pt-2">
						<h5 class="text-center mt-1" style="cursor:pointer;background-color: rgba(255, 255, 255, 0.15);color:#4f70ce;font-weight:bold;font-family: NANUMBARUNPENR !important;">팔로잉</h5></li>        	  
					
					
					</ul>   
			</div>
		  
				</c:forEach>
			   	</div>
				</c:if>
				<hr class="_5mToa">
				<br>
			</div>
			 
			
			  
			<div class="container float" id="trend"    
						style="width: 300px; margin-top: 20px; margin-left: 30px;  display:none;">
					
<!-- 			<hr class="_5mToa"> -->
				<br>
				<p class=""  style="font-weight:bold;font-family:NANUMBARUNPENR !important;font-size: 15px;">
					실시간 #트랜드     
				</p>
				<hr class="_5mToa">
				<c:if test="${trend.size() > 0}">  
		  
		  	<div style="overflow-y:auto; height:230px;">    		
			<c:forEach var="trend" items="${trend}" varStatus="status" >
		
					<div class="container" >     
					<ul class="navbar-nav pointer text-left" value="${trend}" onclick="trendsearch(this)" style="font-family:NANUMBARUNPENR !important;font-size: 14px;">  
					
					<li class="pt-2" style="width:40%;font-family:NANUMBARUNPENR !important;font-size: 14px;">	<a class="trendrank"            
								style="font-size: 14px;font-family:NANUMBARUNPENR !important;font-size: 14px;color:#212529;"     
								href="">${status.count}</a></li>  
					<li class="pt-2"><a id="keywordlink" style="color:#12bbad;font-family:NANUMBARUNPENR !important;font-size: 14px;">#${trend}</a></li>           	  
					</ul>   
			</div>
			<script>
			function trendsearch(e){   
				var keyword = $(e).attr("value");  
				$(location).attr("href","search.bo?search="+keyword);   
			}
			
			</script>
		  
				</c:forEach>
			   	</div>
		  
		  
				</c:if><hr class="_5mToa">
			</div>
<!-- 			나의지도 -->
 			<div id="map" class="container" style="width: 300px; margin-top: 30px; margin-left: 30px; height:400px;  display:none;">
	
			</div>  

			<script>      
				var pin = [];
				var mypin = "${mymap.pinimg}";
				var mycluster = "${mymap.clusterimg}";
			</script>
			<c:forEach var="p" items="${pin}" varStatus="status">
				<script>
					var lat = parseFloat("${p.location_latitude}");
					var lng = parseFloat("${p.location_longitude}");
					var place = "${p.location_name}";
					var index = parseInt("${status.index}");
					var board_seq = "${p.board_seq}";
					
					pin.push([place,lat,lng,board_seq]);
				</script>
			</c:forEach>
			
			<script>
				var map;
				var markers = [];
				var marker;
				var mapOptions;
				var clusterStyles;
				
				function initMap() {
					var infowindow = new google.maps.InfoWindow();
					
					
					var image = {
					          url: mypin,
					};

					mapOptions = {
							  center: {lat: 36.082402, lng: 128.088226},
					          zoom: 6,   
					          mapTypeControl: false,
					          streetViewControl: false,
					          fullscreenControl: false
			            };
					map = new google.maps.Map(document.getElementById('map'), mapOptions);
					clearMarkers();
					
			        for (var i = 0; i < pin.length; i++) {
			        	if(mypin == "resources/images/pin/basicpin1.png"){
			        		marker = new google.maps.Marker({
				                position: new google.maps.LatLng(pin[i][1], pin[i][2]),
				                map: map,
				                title: pin[i][0],
					            animation: google.maps.Animation.DROP
				              });
			        	}else{
			        		marker = new google.maps.Marker({
				                position: new google.maps.LatLng(pin[i][1], pin[i][2]),
				                map: map,
				                title: pin[i][0],
				                icon:image,
					            animation: google.maps.Animation.DROP
				              });
			        	}
			        	markers.push(marker);

			            google.maps.event.addListener(marker, 'click', (function(marker, i) {
			                return function() {
			                	$.ajax({
					                url: "getBoard.do", 
					                type: "get",
					                data: {id:"${sessionScope.loginId}",lat:pin[i][1],lng:pin[i][2]},    
					                success: function(response) {
					                	var content = "<ul class='list-group' style='width:200px; font-weight:bold;font-family: NANUMBARUNPENR !important;font-size: 9px;'><li class='list-group-item' style='background-color:#f3f3f3; '>"+pin[i][0]+"</li>";
					                	for(var k = 0 ; k<response[0].length;k++){
					                		
					                		if(typeof response[0][k].contents == "undefined"){
					                			response[0][k].contents = "내용없음";
					                		}
					                		
					                		content  = content + "<a href='oneBoard.do?board_seq="+response[0][k].board_seq+"'><li class='list-group-item d-flex justify-content-between align-items-center'><p id='list' class='mb-0'>" + response[0][k].contents+"</p><span class='badge badge-pill'><img src='AttachedMedia/"+response[1][k]+"' style='width:30px; height:30px; margin-left:50px;'></span><div style=''>"+response[0][k].writedate.split(" ")[0]+"</div></li></a>";
					                		
					                	}
					                	content = content + "</ul>";  
					                	infowindow.setContent(content);  
						                infowindow.open(map, marker);  
					                },
					                error: function() { 
					                    console.log("에러 발생");
					                },
					                complete: function(){
					                    console.log("AJAX 종료");
					                }
					            });
			                  
			                }
			            })(marker, i));
			            
			        }
			       
			        if(mycluster == "https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m"){
						 var markerCluster = new MarkerClusterer(map,markers,{imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
					}
					else {
						clusterStyles = [
							  { 
							    textColor: 'black',   
							    url: mycluster,
							    height: 50,
							    width: 50
							  } 
							];
						var mcOptions = {
							    gridSize: 50,
							    styles: clusterStyles,
							    maxZoom: 15
							}; 
						 var markerCluster = new MarkerClusterer(map,markers,mcOptions);
					}
					
			       
			    }

			      function clearMarkers() {
			        for (var i = 0; i < markers.length; i++) {
			          markers[i].setMap(null);
			        }
			        markers = [];
			      }
			      
			      $("#sharebt").click(function(){
			    	  Export();
			    	  
			    	  $("body").attr("style","opacity:0.3;");
			 
			    	  setTimeout(function(){
			    		  $("body").attr("style","");
			    	  },200);       
			    	  
			    	  $('#exampleModal').modal('show'); 
			      })
			      
			      function Export() {
			            var staticMapUrl = "https://maps.googleapis.com/maps/api/staticmap";
			 
			            staticMapUrl += "?center=" + map.center.lat() + "," + map.center.lng();
			 
			            staticMapUrl += "&size=1110x700";
			 
			            staticMapUrl += "&zoom=" + map.zoom;
			            
			            staticMapUrl += "&maptype=" + mapOptions.mapTypeId;
			            
			            for (var i = 0; i < markers.length; i++) {   
			            	console.log(markers[i].getPosition());   
			                staticMapUrl += "&markers=color:red|" + markers[i].getPosition().lat()+ "," + markers[i].getPosition().lng();
			            }
			 			      
			            staticMapUrl += "&key=AIzaSyC3SwWm3c4UTbg1SPZD4hHj4E9tz30W2eY"; 
			            $("#mapimg").attr("src",staticMapUrl);
			        }
			      
			      $("#setup").click(function(){
			    	  $('#setupModal').modal('show'); 
			      })
			      
			</script>
			<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3SwWm3c4UTbg1SPZD4hHj4E9tz30W2eY&libraries=places&callback=initMap" async defer></script>
<!-- 나의지도 끝 -->

<!-- 나의 메모 -->  

	 <div id="carouselExampleControls" class="carousel container memowrapper" data-ride="carousel" style="width: 300px; margin-top: 20px; height:300px; margin-left:30px;  display:none;">
	  <div class="carousel-inner" style="height:100%;">
		<ul class="memoul pl-0">  
		<i class="fas fa-thumbtack fa-2x mt-2"></i>
	  <c:choose>
	   <c:when test="${memo.size() > 0}">
	   		<div class="carousel-item active" style="height:250px; width:250px; cursor:pointer;" onclick="gomymemo()">  
			     	<li class="memoli">
			     	<a id="memoa">
						<h2 id="title1" class="memotitle">${memo[0].title}</h2>
						<div class="memocontent">${memo[0].content}</div>  
					</a>
					</li>
			</div>
			<c:forEach var="memo" begin="1" items="${memo}" varStatus="status">
			    <div class="carousel-item" style="height:250px; width:250px; cursor:pointer;" onclick="gomymemo()">
			     	<li class="memoli">
			     	<a id="memoa">
						<h2 id="title1" class="memotitle">${memo.title}</h2>
						<div class="memocontent">${memo.content}</div>
					</a>
					</li>
			    </div>
		    </c:forEach>
		    <script>
		    	function gomymemo(){
		    		$(location).attr("href","goNote.memo");
		    	}
		    </script>
		</c:when>
		
		<c:otherwise>
			<li class="memoli">메모가 없습니다.</li>
		</c:otherwise>
			
		</c:choose>
		</ul>
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

<!-- 나의 메모 끝-->

<!-- 나의 달력 -->
	<div id='calendar' class="container" style="width: 300px; margin-top: 20px; margin-left: 30px; height:400px;  display:none;"></div>
	
	<script>
$(function() {
  $('input[name="datetimes"]').daterangepicker({
	timePicker: true,
    startDate: moment().startOf('hour'),
    endDate: moment().startOf('hour').add(32, 'hour'),
    locale: {
      format: 'YYYY-MM-DD HH:mm',
      "daysOfWeek": [
          "일",
          "월",
          "화",
          "수",
          "목",
          "금",
          "토"
      ],
      "monthNames": [
          "1월",
          "2월",
          "3월",
          "4월",
          "5월",
          "6월",
          "7월",
          "8월",
          "9월",
          "10월",
          "11월",
          "12월"
      ]
    }
  });
});

$(document).on('show.bs.modal', '.modal', function () {
    var zIndex = 1040 + (10 * $('.modal:visible').length);
    $(this).css('z-index', zIndex);
    setTimeout(function() {
        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
    }, 0);
});
function showmodimodal(e) {
	var currentEv = $("#calTitle").text();
	var start = $("#hiddenStart").text();
	var end = $("#hiddenEnd").text();
	$("#modifyEventModal").modal();
	$("#eventName2").val(currentEv);
	$("#eventDueDate2").val("");
}

function myAlertBottom(msg){
	$("#alertmsg").text(msg);
	  $(".myAlert-bottom").fadeIn();
	  setTimeout(function(){
	    $(".myAlert-bottom").fadeOut(); 
	  }, 2000);
	}

function deleteEvent() {
	var id = $('#hiddenid').val();
	$.ajax({
        url : "delete.cal",
        type : "post",
        data : {
           id : id
        },
        success : function(resp) {
        	if(resp == 0) {
        		alert("삭제에 실패 하였습니다");
        		$('#calendar').fullCalendar('unselect');
        	}else {
        		$("#calModal").modal("hide");
        		$('#calendar').fullCalendar('removeEvents', id);
        		myAlertBottom("일정이 삭제 되었습니다");
        	}
        },
        error : function() {
           console.log("에러 발생!");
           }
        })
}

  $(document).ready(function() {
	  $('#submitButton').on('click', function(e){
		  var content = $('#eventName').val();
		  if(content == "") {
			  alert("내용을 입력해주세요");
			  return;
		  }
          // We don't want this to act as a link so cancel the link action
          e.preventDefault();

          doSubmit();
        });
	  
	  $('#submitButton2').on('click', function(e){
		  var content = $('#eventName2').val();
		  if(content == "") {
			  alert("내용을 입력해주세요");
			  return;
		  }
          // We don't want this to act as a link so cancel the link action
          e.preventDefault();

          doSubmit2();
        });

    function doSubmit(){
    	var content = $('#eventName').val();
    	var startEnd = $("#eventDueDate").val();
    	var startTime = startEnd.split(' - ')[0];
    	var endTime = startEnd.split(' - ')[1];
    	$.ajax({
            url: 'insert.cal',
            type: 'post',
            data : {
            	date_start : startTime,
            	date_end : endTime,
            	content : content
             },
            success: function (data) {
            	if(data.result == 0) {
            		alert("등록에 실패 하였습니다");
            		$('#calendar').fullCalendar('unselect');
            	}else {
            		$("#calendar").fullCalendar('renderEvent',
            		          {
            						id: data.seq,
            		              title: content,
            		              start: new Date(startTime),
            		              end: new Date(endTime)
            		          },
            		          true);
            		myAlertBottom("일정이 등록 되었습니다");
            	}
            },
            error : function() {
                console.log("에러 발생!");
                }
        });
      $("#createEventModal").modal('hide');
      
     }
    
    function doSubmit2(){
    	var seq = $("#hiddenid").val();
    	var content = $('#eventName2').val();
    	var startEnd = $("#eventDueDate2").val();
    	var startTime = startEnd.split(' - ')[0];
    	var endTime = startEnd.split(' - ')[1];
    	var eventData;
    	$.ajax({
            url: 'update.cal',
            type: 'post',
            data : {
            	seq : seq,
            	date_start : startTime,
            	date_end : endTime,
            	content : content
             },
            success: function (data) {
            	if(data == 0) {
            		alert("등록에 실패 하였습니다");
            	}
            	eventData = {
        				id: seq,
        	            title: event.title,
        	            start: event.start,
        	            end: event.end
        	          };
            	$('#calendar').fullCalendar('removeEvents', seq);
            	$("#calendar").fullCalendar('renderEvent',
      		          {
      						id: seq,
      		              title: content,
      		              start: new Date(startTime),
      		              end: new Date(endTime)
      		          },
      		          true);
            	$("#modifyEventModal").modal("hide");
            	$("#calModal").modal('hide');
              	myAlertBottom("일정이 변경 되었습니다");
            },
            error : function() {
                console.log("에러 발생!");
                }
        });
      $("#createEventModal").modal('hide');
      
     }

    $('#calendar').fullCalendar({
    	customButtons: {
    	    myCustomButton: {
    	      text: '일정 추가',
    	      click: function() {
    	    	  $('#createEventModal').modal('show');
    	      }
    	    }
    	  },
      header: {
      },
      footer: {
      },
      slotDuration: '00:10:00',
      slotLabelFormat: 'a h:mm',
      themeSystem: 'bootstrap4',
      nowIndicator: true,
      now: new Date(),
      defaultDate: new Date(),
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectHelper: true,
      select: function(start, end) {
        var title = prompt('일정을 입력하세요:');
        var eventData;
        if (title) {
        $.ajax({
            url: 'insert.cal',
            type: 'post',
            data : {
            	date_start : start.format(),
            	date_end : end.format(),
            	content : title
             },
            success: function (data) {
            	if(data.result == 0) {
            		alert("등록에 실패 하였습니다");
            		$('#calendar').fullCalendar('unselect');
            	}else {
            		eventData = {
            				id: data.seq,
            	            title: title,
            	            start: start,
            	            end: end
            	          };
            		$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
            		myAlertBottom("일정이 등록 되었습니다");
            	}
            },
            error : function() {
                console.log("에러 발생!");
                }
        });
        
        }
        $('#calendar').fullCalendar('unselect');
      },
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      eventClick: function(event) {
    	  $(".fc-event").removeAttr("href");
    	  if($(this).css("background-color")== "rgb(255, 0, 0)") {
    		  $("#calHeader2").css("background-color", "red");
        	  $("#calTitle2").text(event.title);
        	  $("#hiddenStart2").text(event.start.format());
        	  $("#hiddenEnd2").text(event.end.format());
        	  $("#timecontent2").text(event.start.format("YYYY년 MM월 DD일, a hh:mm")+' ~ ' +event.end.format("YYYY년 MM월 DD일, a hh:mm"));
        	  $("#calModal2").modal("show");
        	  
    	  }else {
    		  //$("#calHeader").css("background-color", "#3a87ad");
    		  $("#hiddenid").val(event.id);
        	  $("#calTitle").text(event.title);
        	  $("#hiddenStart").text(event.start.format());
        	  $("#hiddenEnd").text(event.end.format());
        	  $("#timecontent").text(event.start.format("YYYY년 MM월 DD일, a hh:mm")+' ~ ' +event.end.format("YYYY년 MM월 DD일, a hh:mm"));
        	  $("#calModal").modal("show");
    	  }
    	  
    	  
    	    
    	  },
      eventDrop: function(event, delta, revertFunc) {
    	    if (!confirm("일정을 변경 하시겠습니까?")) {
    	      revertFunc();
    	    }else {
    	    	$.ajax({
    	            url: 'update.cal',
    	            type: 'post',
    	            data : {
    	            	seq: event.id,
    	            	date_start : event.start.format(),
    	            	date_end : event.end.format(),
    	            	content : event.title
    	             },
    	            success: function (data) {
    	            	if(data == 0) {
    	            		alert("등록에 실패 하였습니다");
    	            		revertFunc();
    	            	}
    	            	myAlertBottom("일정이 변경 되었습니다");
    	            },
    	            error : function() {
    	                console.log("에러 발생!");
    	                }
    	        });
    	    }

    	  },

      eventResize: function(event, delta, revertFunc) {

    	    if (!confirm("일정을 변경 하시겠습니까?")) {
    	      revertFunc();
    	    }else {
    	    	$.ajax({
    	            url: 'update.cal',
    	            type: 'post',
    	            data : {
    	            	seq: event.id,
    	            	date_start : event.start.format(),
    	            	date_end : event.end.format(),
    	            	content : event.title
    	             },
    	            success: function (data) {
    	            	if(data == 0) {
    	            		alert("등록에 실패 하였습니다");
    	            		revertFunc();
    	            	}
    	            	myAlertBottom("일정이 변경 되었습니다");
    	            },
    	            error : function() {
    	                console.log("에러 발생!");
    	                }
    	        });
    	    }

    	  },
      googleCalendarApiKey: 'AIzaSyBLzmfo25SUyDaDRjI7wrhI1cyIhs6sYAc',
      eventSources : [
    	  	{
    	  		 events: [
    	  		<c:forEach var='event' items='${calendar}'>
    	  	    { 	id: '${event.seq}',
    	  	    	title: '${event.content}',
    	  	    	start: '${event.date_start}',
    	  	    	end: '${event.date_end}'
    	  	    },
    	  	  </c:forEach>
    	  	    	{}
    	  	]
    	  	},
          	{
            	googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
            	color: 'red',
            editable: false
            }
          	
      ]
      
    });

  });

</script>
<!-- 나의달력 끝 -->

<!-- 			<div class="pt-4 pb-3" id="footer" style="font-size: 5px; margin-left: 20px;"> -->
			<div class="pt-4 pb-3" style="font-size: 5px; margin-left: 20px;"> 
				<div class="container">
					<div class="row">
						<div class="col-md-10">
							<a href="footinfo.jsp"><p style="color:#212529;font-weight:bold;"><i class="far fa-copyright"></i>SocialWired about정보.채용<br>개인정보처리방침 .약관.플랫폼</p></a>
						
							<p><i class="far fa-copyright"></i>2018SocialWired</p>
						</div>
					</div>
				</div>
		<!-- 			</div> -->

		<!-- container -->

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
</div>
</div>
												

 
<script>

var globalStartNum = ${NAV_COUNT_PER_PAGE + 1};



$(window).scroll(function(){
	// 486 ~ 851
	if ($(window).scrollTop() >= $(document).height() - $(window).height()) {
		// 내용
		/* http://wjheo.tistory.com/entry/Spring-%ED%8E%98%EC%9D%B4%EC%A7%80-%EB%AC%B4%ED%95%9C%EC%8A%A4%ED%81%AC%EB%A1%A4 */
		console.log('1111111');
		$.ajax({
            url: "feedForJson.ajax", // 처리할 페이지(서블릿) 주소
            type: "get",
            data: {start: globalStartNum},    // 리퀘스트 parameter 보내기 {키값, 변수명(value)}
            success: function(r) {
            	
        		/* 123456
        		 * 	list, media, maplike, mapmark, commentlist, getAllProfilePic, 
        		 *  follow_list, follow_list.size_div_five, nextStartNum, maxImgHeight
        		 *  isAvailableMoreData
        		 *	Array: list, media, maxImgHeight
        		 *	Object(map): maplike, mapmark, commentlist, getAllProfilePic,
        		 *	Primitive: 7, 8, 10
        		 */
        		console.log(r);
           		if(r.isAvailableMoreData){	// 가져올 게시글이 더 있나요?  
           			/* $('#board').append(true); 			            		
            		for(i in response.list){
            			for(item in response.list[i]){
            				$('#board').append(response.list[i][item]); 
            			}
            			$('#board').append("<br>");
            			for(j in response.media){
            				for(k in response.media[j]){
            					for(l in response.media[j][k]){
            						$('#board').append(response.media[j][k][l]);
            					}
            						
            				}
            			}
            			$('#board').append("<br>");
            			$('#board').append("<hr>");
            		}  */
            		
            		copyStartOfNum = globalStartNum
            		var kn = 0;
            		for(i in r.list){
            			var id = r.list[i].id
            			var boardSeq = r.list[i].board_seq;
            			console.log(id)     
            			console.log(boardSeq + " :::::::" + r.maxmap[boardSeq]);  
            			
	            		var divStr = "<div class='py-2 my-5' data-aos='fade-up' data-aos-once='true' id='feed'>" 
	            		+ "<div class='profile-image'>"
	            		+ "<img class='ml-3 mr-2 pic' src='AttachedMedia/" + r.getAllProfilePic[id] + "'>"
	            		+ "<br> <a class='mt-1 idtxt' id='id'	href='board.bo?id=" + id + "&cat=1'>" + id + "<br>Dangsan.South Korea</a>"
	            		+ "</div>"	// 프로필 이미지 div 끝
	            				
	            		+	"<div class='mt-2' id='boardimg'>"
	            		+		"<div id='myCarousel" + copyStartOfNum + "' class='carousel slide' data-ride='carousel' data-interval='false'>"
	            		+			"<ul id='carousel-indicators' class='carousel-indicators'>"
	            		+				"<li id='firstli' data-target='#myCarousel" + copyStartOfNum + "' data-slide-to='0' class='active'></li>"
	            		
	            		for(ix = 1; ix < r.media[kn].length; ix++){
	            			divStr += "<li data-target='#myCarousel" + copyStartOfNum + "' data-slide-to='" + ix + "'></li>"
	            		}  
	            		divStr += "</ul>"        
	            			            		//// ///////////////////////////////////////////////////여기에 숫자    
	            		        
	            		divStr += "<div id='carousel-inner' class='carousel-inner' style='height:"+r.maxmap[boardSeq]+"px; max-height:700px; min-height:200px; display:table;'>"
					            		+ "<div id='firstItem' class='carousel-item active'>"
					            				+ "<img class='boardimg' width='100%' src='AttachedMedia/" + r.media[kn][0].system_file_name + "' alt=''>"
			            				+ "</div>"	// firstItem의 끝
	            		
	            		for(ix = 1; ix < r.media[kn].length; ix++ ){
	            			divStr += "<div class='carousel-item'>"
	            			+ "<img class='boardimg' width='100%' src='AttachedMedia/" + r.media[kn][ix].system_file_name + "' alt=''>"
	            			+ "</div>"
	            		}
			            				
			           	divStr += "</div>"	// divInner의 끝
	            		
	            		if(r.media[kn].length > 1){
	            			divStr += "<a id='carousel-prev" + copyStartOfNum + "' class='carousel-control-prev' href='#myCarousel" + copyStartOfNum + "' data-slide='prev'> <span class='carousel-control-prev-icon'></span></a>" 
				           	divStr += "<a id='carousel-next" + copyStartOfNum + "' class='carousel-control-next' href='#myCarousel" + copyStartOfNum + "' data-slide='next'> <span class='carousel-control-next-icon'></span></a>"
	            		}
			           	
                        
                        divStr += "</div>"	// myCarousel div 의 끝
	            		
	            		divStr += "</div>"	// boardImg의 끝
	            		
	            		divStr += "<div id='cont'>"
	            		+ "<nav class='navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1'>"
	            		+ "<div class='container'>"
	            		+ "<a class='navbar-brand'>"
						
	            		/* console.log(r.maplike)
	            		console.log(boardSeq + ": " + r.maplike.hasOwnProperty(boardSeq)) */
	            		if(r.maplike.hasOwnProperty(boardSeq)){
	            			divStr += "<i value='" + boardSeq + "' style='display: none;' id='likeit' class='far fa-heart icon mr-1 pointer' onclick='likeit(this)'></i>" 
	            			+ "<i value='" + boardSeq + "' style='font-weight: bold; color: red;' id='likecancel' class='far fa-heart icon mr-1 pointer' onclick='unlikeit(this)'></i>"
	            		} else {
	            			divStr += "  <i value='" + boardSeq + "' id='likeit' class='far fa-heart icon mr-1 pointer' onclick='likeit(this)'></i>"
	                            	+ "<i value='" + boardSeq + "' style='font-weight: bold; color: red; display: none;' id='likecancel' class='far fa-heart icon mr-1 pointer' onclick='unlikeit(this)'></i>"
	            		}
	            		divStr += "<i class='far fa-comment icon'></i> "
	            		divStr += "</a>"
	            		
	            		divStr += "<a class='btn navbar-btn ml-2 text-white '>"
	            		
	            		if(r.mapmark.hasOwnProperty(boardSeq)){
	            			divStr +=  "<i value='" + boardSeq + "' id='mark' class='far fa-bookmark icon pointer' style='display: none;' onclick='markit(this)'></i>"
	            			+ "<i value='" + boardSeq + "' style='font-weight: bold; color: #00B8D4;' id='markcancel' class='far fa-bookmark icon pointer' onclick='unmarkit(this)'></i>"
	            		} else {
	            			divStr += "<i value='" + boardSeq + "' id='mark' class='far fa-bookmark icon pointer' onclick='markit(this)'></i>"
	                            	+ "<i value='" + boardSeq + "' style='font-weight: bold; color: #00B8D4; display: none;' id='markcancel' class='far fa-bookmark icon pointer' onclick='unmarkit(this)'></i>"
	            		}
	            		
	            		divStr += "</a>"
	            
	            		divStr += "</div>"	// container div의 끝
	            		+ "</nav>"
	            		
	            		divStr += "<div id='contcenter' class='mt-2 mx-3 pb-2'>"
	            		+ "<div class='navbar-nav'>"////////////////////////////
	            		+ "<a class='ml-1 idtxt' id='con" + boardSeq +"' href='board.bo?id="+id+"&cat=1' style='font-size: 14px;'>" + id + "</a>"
	            		
	            		///////////////////////용까지////////////////
	            	
	            		var regex = /(#[^#\s,;<>.]+)/gi;
	            		var txt = r.list[i].contents
	            		if(txt != null){    
	            			var newContent = txt.replace(regex, "<a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + '$1' + '</a>');
	            			divStr += "<div class='pl-3 contdiv pr-2' id='contdiv" + boardSeq + "' style='word-wrap: break-word; word-break: break-all; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 350px; height: 20px;'>" + newContent + "</div>"
	            			divStr += "<a id='contplus"+boardSeq+"' class='pointer' style='color: gray; display: none'>더보기</a>"
	            		
	            		} else {
	            			divStr += "<div class='pl-3 contdiv pr-2' id='contdiv" + boardSeq + "' style='word-wrap: break-word; word-break: break-all; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 350px; height: 20px;'></div>"
	            			
	            		
	            		}
	            		
	            		
	            		function tag(e) {
	                        var search = $(e).html().split('#')[1];
	                        $(location).attr('href', 'search.bo?search=' + search);

	                    }
	            		
	            		divStr += "</div>"	// navbar-nav div의 끝
	            		divStr += "<p class='text-info pointer pt-4 mb-1' id='myComment" + boardSeq + "' onclick='commentdisplay(this)'>"
	            		   
	            		if(r.commentcnt[boardSeq] > 2){      
	            		divStr += "모두 " + r.commentcnt[boardSeq]  + " 개의 댓글보기"
	            		}
	            		
	            		divStr += "</p>"   
	            		divStr += "<input type=hidden value='" + boardSeq + "'>"   
	            		
	            		divStr += "<div class='comment-contents' id='comment-contents" + boardSeq + "'>" 		
	            		
	            		
						for(item in r.commentlist){
							if(item == boardSeq) {	
								
// 								//  보완 test='${commenttmp.value.size() > 2 }'
// 								if(r.commentlist[item].length > 2){
// 									// pure script
// 									$('#myComment' + boardSeq).html("&nbsp&nbsp모두 " + r.commentlist[item].length + "개의 댓글보기")
// 										var num = 0;
// 									/* $(document).ready(function(){
// 										$('#myComment' + boardSeq).html("&nbsp&nbsp모두 " + r.commentlist[item].length + "개의 댓글보기")
// 										var num = 0;
// 									}) */
									
// 								}
								
								for(elem in r.commentlist[item]){
									console.log(r.commentlist[item][elem])
									var commentSeq = r.commentlist[item][elem].comment_seq;
									var commentId = r.commentlist[item][elem].id;
									var commentContent = r.commentlist[item][elem].comment_contents;
									console.log("comc: " + commentContent)
									      
									
									if(elem < 2) {   
										divStr += "<ul id='ul" + commentSeq + "' style='' value='" + commentSeq + "' onmouseover='commentover(this)' onmouseleave='commentleave(this)' class='commentline navbar-nav co" + boardSeq + "'>"
									}else{
										// display: none
										divStr += "<ul id='ul" + commentSeq + "' style='display: none;' value='" + commentSeq + "' onmouseover='commentover(this)' onmouseleave='commentleave(this)' class='commentline navbar-nav co" + boardSeq + "'>"
									}
									
									divStr += "<li id='li1'><a href='board.bo?id=" + commentId + "&cat=1'>" + commentId + "</a></li>"
									divStr += "<li id='li2'>"
									var newComment = '<span class=fugue>' 
										+ commentContent.replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + '$1' + '</a><span class=fugue>');
									newComment += '<kz></kz>';
									divStr += "<div id='commenttxt" + commentSeq + "' class='commenttxt txt" + boardSeq + "' style='word-wrap: break-word; word-break: break-all'>" + newComment + "</div>"
									divStr += "</li>"
									divStr += "<li id='li3'><a id='commentdel" + commentSeq + "' value='" + boardSeq + ":" + commentSeq + "' onclick='delComment(this)' class='pointer'></a></li>"
									divStr += "<li id='li4'><a id='commentmod" + commentSeq + "' value='" + commentSeq + "' onclick='modComment(this)' class='pointer'></a></li>"
                                    
									divStr += "</ul><input type=hidden id='modstate"+commentSeq+"' value='1'>"
									
									// pure script
									/* $('#ul' + r.commentlist[item][0].comment_seq).attr('style', false);
                                    $('#ul' + r.commentlist[item][1].comment_seq).attr('style', false); */
                                    
                                    
								}
									    
							}  
						}      
	            		 divStr += "<p class='text-info pointer pt-3 pl-1' id='commenthide" + boardSeq + "' onclick='commenthide(this)'></p>"
	                      divStr  += "<input type=hidden value='" + boardSeq + "'>"   
	            		divStr += "</div>"	// comment-content div의 끝
	                       
	                        
	            		divStr += "</div>"	// div contcenter의 끝
	            		
	            		divStr += "<div class='crecodiv pl-2 py-2 navbar-nav'>"
		            		divStr += "<div contenteditable=true class='creco ml-2 insertfield'  id='comment" + boardSeq + "'>"
		            		divStr += "<span class='text-muted ml-1'>댓글 달기...</span>"
		            		divStr += "</div>"
		            		
		            		divStr += "<div class='btn-group bg-white'>"
		            		divStr += "<i id='modalBoardBtn" + boardSeq + "' value='" + boardSeq + ":" + id + "' onclick='modal(this)' class='fas fa-ellipsis-h btn mr-1' data-toggle='modal'> </i>"
		            		divStr += "</div>"   
		            	divStr += "</div>"	// crecodiv pl-2 py-2 navbar-nav div의 끝
		            	
	            		
	            		divStr += "</div>" // div cont의 끝
	            		divStr += "</div>"	// feed의 끝 (전체 끝)
	            		
	            		
	            		copyStartOfNum++;
	            		kn++;
	            		$('#board').append(divStr);
            		}      
            		
            		globalStartNum = parseInt(r.nextStartNum);
            		return true;
            	} else {
            		console.log(false);
            		return false;
            	} 

            },
            error: function() {
                console.log("에러 발생");
            },
            complete: function(){
            }
        });
		
    	var globalThisCommentIsFocusedOnFirstSpecial = true;
    	
        $("div[id*=comment].insertSpecialField").focus(function() {
        	if(globalThisCommentIsFocusedOnFirstSpecial){
        		$(this).html("");
            	globalThisCommentIsFocusedOnFirstSpecial = false;
        	}
        	
        });
        
        $("div[id*=comment].insertSpecialField").focusout(function() {
        	if($(this).text() == ""){
        		$(this).html("<span class=text-muted>댓글 달기...</span>");
        		globalThisCommentIsFocusedOnFirstSpecial = true;
        	}
        })
        


		$("div[id*='comment'].insertSpecialField").keydown(function(event){
		    var keycode = (event.keyCode ? event.keyCode : event.which);
		    var obj = this
		    var toBoardSeq = parseInt($(this).attr('id').replace("comment", ""))
		    if(keycode == '13'){
		       var text = $(this).text();
		       if(text == ""){
		          alert("댓글을 입력해주세요");
		       }
		   		else { 
			   
		       $.ajax({ 
		              type: "POST",  
		              url: "comment.co",    
		              data: {board_seq : toBoardSeq, comment_contents : text},
		              success : function(resp) { 
		            	  ws.send("comment:" + resp.bid);
		            	  $(obj).html("");
		              /*  $("#comment${tmp.board_seq}").val("");   */  
		              var regex = /(#[^#\s,;<>.]+)/gi;            
		           // var newtxt = text.replace(regex, "<a onclick='tag(this)'; cursor: pointer;' class=text-danger>"+"$1"+"</a>");
		            var newtxt = "<span class=fugue>" + text.replace(
					                    		regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
											"</a><span class=fugue>") + "</span>";
						newtxt += "<kz></kz>";	            	
		            
						console.log($("#comment-contents" + toBoardSeq))  
		               $("#comment-contents" + toBoardSeq).prepend("<ul class='navbar-nav commentline co" + toBoardSeq + "' id='ul"+resp.seq+"' value='"+resp.seq+"' onmouseover='commentover(this)' onmouseleave='commentleave(this)'><li id='li1' ><a href='board.bo?id=${sessionScope.loginId}'>${sessionScope.loginId}</a></li><li id='li2'><div id='commenttxt"+resp.seq+"' style='word-wrap: break-word; word-break:break-all' class='commenttxt'>"+newtxt+"</div></li><li id='li3'><a id='commentdel"+resp.seq+"' onclick='delComment(this)' value='"+toBoardSeq+":"+resp.seq+"' class='pointer'></a> </li><li id='li4'><a id='commentmod"+resp.seq+"' value='"+resp.seq+"' onclick='modComment(this)'  class='pointer'></a></li></ul>"
		            		   +"<input type=hidden id='modstate"+resp.seq+"' value='1'>");
		               $("#ul"+resp.seq).hide().fadeIn(500);  
		               
		               $("#commenttxt" + resp.seq).keyup(function(e){
		            	   // =================== 복붙 =================== 
		            	   if(e.keyCode === 32){
		            		   if (parseInt($('#caretposition').val()) == 0) {                     	 
		                       } else if (parseInt($('#caretposition').val()) == $(this).text().length) {
		                       } else {
		                           return;
		                       }

		                       var regex = /(#[^#\s,;<>.]+)/gi;
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
		               });
		               
		               $("#commenttxt" + resp.seq).keypress(function(e){
							if(e.keyCode === 13) {
								e.preventDefault();      
							modComment(this);
						 }
						});
		                return;
					  },
		              error: function(){
		                  console.log("에러 발생");
		              }
		         }); //ajax   
		       }    
		    }  
		});
        $("div[id*='comment'].insertSpecialField").on("mousedown mouseup keydown keyup", update);
	}
});

</script>

<%@ include file="include/directMessage.jsp" %>
<%@ include file="include/bottom2.jsp"%>


