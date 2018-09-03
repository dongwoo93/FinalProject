<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<script src="resources/js/top.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/oneboard.css">
<style>
.pic{
	width : 30px;
	height : 30px;   
}
</style>
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


function commentover(e){   
	var comment_seq = $(e).attr("value");
	var writerId = $("#writerId"+comment_seq).html();
	
	console.log(writerId);
	$(e).attr("style","background-color:#E1F5FE");
	$("#commentSection"+comment_seq).attr("style","background-color:#E1F5FE");
	var id = $("#sessionid").val();  
	if(id==writerId){  
	
	$("#commentdel"+comment_seq).html("삭제");
	
	
	$("#commentmod"+comment_seq).html("수정");           
	
	} 
	
}
function commentleave(e){
	var comment_seq = $(e).attr("value");
	$(e).attr("style",false);   
	$("#commentSection"+comment_seq).attr("style",false);  
	$("#commentdel"+comment_seq).html("");
	$("#commentmod"+comment_seq).html("");
} 


function delComment(e){
	
	var comment_seq = $(e).parent().parent().attr("value"); 
	
	$.ajax({
		type : "post",
		data : { board_seq:${b.board_seq} , comment_seq : comment_seq },
		url : "commentdel.co",
		success: function(resp){
			$(e).parent().parent().fadeOut(400,function() { $(this).remove(); }); 
		
		}
			
		
	});
	
}

function markit(e){
	$.ajax({
		
		type: "post",
		data: { board_seq:${b.board_seq} , is_marked : "y" },
		url : "bookmark.bo",
		success: function(resp){
			$("#markcancel").show();
			$("#mark").hide();
		}
		
	});
}

function unmarkit(e){
	$.ajax({
		
		type: "post",
		data: { board_seq:${b.board_seq} , is_marked : "n" },
		url : "bookmark.bo",
		success: function(resp){
			$("#markcancel").hide();
			$("#mark").show();
		}
		
	});
}
  

function likeit(e){
	$.ajax({
		
		type : "post",
		data : { board_seq:${b.board_seq} , is_liked : "y" },
		url : "like.bo",
		success: function(resp){
			$("#likecancel").show();
			$("#likeit").hide();   
			
		}
	});
	
	   
} 
function unlikeit(e){
	$.ajax({
		
		type : "post",
		data : { board_seq:${b.board_seq} , is_liked : "n" },
		url : "like.bo",
		success: function(resp){
			$("#likecancel").hide();
			$("#likeit").show();   
			
		}
	});
	
	
}


function modComment(e){   
	
	var comment_seq = $(e).parent().parent().attr("value"); 
	/* $("#commentSection"+comment_seq).prop('readonly', false); */
	$("#commentSection"+comment_seq).attr('contenteditable', true)
	
	$("#commentSection"+comment_seq).focus();
	
	placeCaretAtEnd( document.getElementById("commentSection"+comment_seq) );
	
	$("#commentmod"+comment_seq).click(function(){
		var comment = $("#commentSection"+comment_seq).text();
		
		if(comment==""){
			alert("댓글을 입력해 주세요");
			comment.focus();
			
		}else{

			$.ajax({
				type : "post",
				data : { comment_contents : comment , comment_seq : comment_seq },
				url : "commentmod.co",
				success: function(resp){
					
					/* $("#commentSection"+comment_seq).prop('readonly', true); */
					$("#commentSection"+comment_seq).attr('contenteditable', false)
					
				}
					
				
			});
		}
		
	});
	
	$("#commentSection"+comment_seq).keypress(function(event){
  
		var keycode=(event.keyCode ? event.keyCode : event.which);
		if(keycode=='13'){
			var comment = $("#commentSection"+comment_seq).text();	// val -> text

			
			if(comment==""){
				alert("댓글을 입력해 주세요");
				comment.focus();
				
			}else{

				$.ajax({
					type : "post",
					data : { comment_contents : comment , comment_seq : comment_seq },
					url : "commentmod.co",
					success: function(resp){
						
						/* $("#commentSection"+comment_seq).prop('readonly', true); */
						$("#commentSection"+comment_seq).attr('contenteditable', false)
						
					}
						
					
				});
			}
		}
		
	});
	

	
}

$(document).ready(function(){
		

$("#comment").keypress(function(event){

	var keycode=(event.keyCode ? event.keyCode : event.which);
	
	if(keycode=='13'){
		var comment = $("#comment").text();
		var session = $("#sessionid").val();	
		if(comment==""){
			alert("댓글을 입력해 주세요");
			$('#comment').focus();
			
		}else{
			$.ajax({
				type : "post",
				data : {board_seq : ${b.board_seq}, comment_contents : comment },
				url : "insertComment.co",
				success: function(seq){
					
					var regex = /(#[^#\s,;<>.]+)/gi;
					var newtxt = "<span class=fugue>" + comment.replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                        "</a><span class=fugue>") + "</span>"
                        newtxt += "<kz></kz>"
					    
					var start = $("#comment-contents");					
					start.append('<ul class="commentline navbar-nav" id="ul'+seq+'" + onmouseover="commentover(this)" value="'
							+ seq + '" onmouseleave="commentleave(this)"><li id="li1"><a href="#" id="writerId' + seq 
							+'">'+session+'</a></li><li id="li2">' 
							+ '<div contenteditable=false id="commentSection' + seq + '" readonly class="commenttxt">' + newtxt
							+ '</div></li><li id="li3"><a style="cursor:pointer;" onclick="delComment(this)"  id="commentdel' 
							+ seq + '"></a></li><li id="li4"><a style="cursor:pointer;" onclick="modComment(this)" id="commentmod' 
							+ seq + '"></a></li></ul>');
					$('#comment').html("");
				    $("#ul"+seq).hide().fadeIn(500); 
					$("#commentSection" + seq).keyup(function(e){
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
				}   

			});
			
			
		}  
	 }
	  
	});
	
									
									/* ========================= editable div에 태그 적용 시작 ========================= */
									var globalThisCommentIsFocusedOnFirst = true;
									
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
									};
									
									
									$('#comment').on("mousedown mouseup keydown keyup", update);
									$("#comment").keyup(makeupHashtag)
									$("div[id*='commentSection']").on("mousedown mouseup keydown keyup", update);
									$("div[id*='commentSection']").keyup(makeupHashtag)
									
									var map = {
									    16: false,
									    32: false
									};
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
									}
									/* .keyup(function(e){   
									                    if(e.keyCode === 32){   
									                       map[e.keyCode] = false;             
									   
									                      }
									                    console.log($('#comment').text().length);
									   
									                 }); */
									/* ========================= editable div에 태그 적용 끝 ========================= */
	
})
</script>


<div id="allwrapper">
	
	<div class="" id="centerwrapper">
		<div class="container" id="contents">
		
		<div id="board">
		<div class="py-2 my-5" id="feed">
                  <div class="profile-image">
                  <c:set var="oneboard" value="${b}"/>
                     <c:choose>
						<c:when test="${profile_pic.containsKey(oneboard.id)}">
                  
                  
                     <img class="ml-3 mr-2 pic"
                        src="AttachedMedia/<c:out value='${profile_pic[oneboard.id]}'/>">
                   
                  </c:when>
                  <c:otherwise>
                     <img class="ml-3 mr-2 pic"
                        src="resources/images/DefaultProfile.jpg">
                  </c:otherwise>
					</c:choose>
                    	 <%--               <h5 class="mt-1 idtxt">${tmp.id}</h5>  --%>
                     <br> 
                     <a class="mt-1 idtxt" id="id" href="board.bo?id=${b.id}&cat=1" style="color:#12bbad;font-weight:bold;font-size:16px;">
                    
						${b.id}
						
                     
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
										<img class='boardimg ${result2[0][0].filterName}' width='100%' src='AttachedMedia/${result2[0][0].system_file_name}' alt=''>
									</div> 
									<c:forEach begin="1" var="media"
										items="${result2[0]}">
										<div class="carousel-item">
											<img class='boardimg ${media.filterName}' width='100%'
												src="AttachedMedia/${media.system_file_name}" alt="">
										</div>
									</c:forEach>

								</div>
								
								<c:if test="${result2[0].size() > 1}">
								<a id="carousel-prev0" class="carousel-control-prev" href="#myCarousel0"
									data-slide="prev"> <span class="carousel-control-prev-icon"></span>
								</a> <a id="carousel-next0" class="carousel-control-next"
									href="#myCarousel0" data-slide="next"> <span
									class="carousel-control-next-icon"></span>
								</a>
								</c:if>
							</div>

						</div>
		
		<div id="cont">
		
		<nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
                        <div class="container">
                           <a class="navbar0-brand"> 
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
                                    &nbsp;<i  id="mark"
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
                              href="board.bo?id=${b.id}&cat=1" style="color:#12bbad;font-weight:bold;">${b.id}</a>

                           <div class='pl-3' id="contdiv">
                           <%-- ${b.contents} --%>
                           	<script>
                        		  var regex = /(#[^#\s,;<>. ]+)/gi;
                        		  var originalText = "${b.contents}";
                        		  var innerCode = ""
                                  if (regex) {
                                      innerCode = "<span class=fugue>" + originalText
                                          .replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                                              "</a><span class=fugue>").replace("\n", "<br>")  + "</span>"
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
                       
                        <c:forEach var="item" items="${result}">
                          
                        <ul class="commentline navbar-nav"  onmouseover="commentover(this)" value="${item.comment_seq}" onmouseleave="commentleave(this)">
                        <li id="li1"><a href="board.bo?id=${item.id}&cat=1" id="writerId${item.comment_seq}">${item.id}</a></li>
                        <li id="li2">
                        	<%-- <input type=text id="commentSection${item.comment_seq}" value="${item.comment_contents}" readonly="readonly" class='commenttxt'> --%>

                        	<div contenteditable=false id="commentSection${item.comment_seq}" class='commenttxt'>
                        		<script>
                        		  var regex = /(#[^#\s,;<>. ]+)/gi;
                        		  var originalText = "${item.comment_contents}"
                        		  var innerCode = ""
                                  if (regex) {
                                      innerCode = "<span class=fugue>" + originalText
                                          .replace(regex, "</span><a onclick='tag(this)' style='cursor: pointer;' class=text-danger>" + "$1" +
                                              "</a><span class=fugue>").replace("\n", "<br>") + "</span>"
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
                        </c:forEach>
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
		
		</div> <!-- id board -->
		
      </div>
      <!-- container -->
      
     
      
   </div>
   <!-- centerwrapper -->
   
</div>
<!--  allwrapper-->
										
      <%@ include file="include/bottom.jsp"%>