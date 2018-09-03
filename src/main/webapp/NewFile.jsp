<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<script src="resources/js/top.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/search.css">
<script> var list= []; </script>
<c:forEach var="tmp" items="${result}" varStatus="status">
		<script>    
         list.push("${tmp.board_seq}");    
         </script>
	</c:forEach>
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

function commentover(e) {    
	
	var comment_seq = $(e).attr("value");           
	var sessionid = $("#sessionid").val();
	var commentid = $(e).children().children().html();    
	$(e).attr("style","background-color:#E1F5FE");
	$("#commenttxt"+comment_seq).attr("style","word-wrap: break-word; background-color:#E1F5FE"); 
		 
		if(sessionid == commentid) {   
			$(e).next().attr("style", "background-color:#E1F5FE;"); 
		}  
	
    }

function commentleave(e) {   
	var comment_seq = $(e).attr("value"); 
	 
	$("#ul"+comment_seq).attr("style",false);            
	$("#commenttxt"+comment_seq).attr("style","word-wrap: break-word;");
	$(e).next().attr("style", "display:none; background-color:#E1F5FE;"); 
}

function commentover2(e) {             
	
	var comment_seq = $(e).prev().attr("value");           
	var sessionid = $("#sessionid").val();
	var commentid = $(e).prev().children().children().html();    
	$(e).prev().attr("style","background-color:#E1F5FE");
	$("#commenttxt"+comment_seq).attr("style","word-wrap: break-word; background-color:#E1F5FE"); 
	 var modstate = $("#modstate"+comment_seq).val();
	   
	 if(modstate == "2"){     
		 $("#del"+comment_seq).attr("style","color:#00B8D4");
		 $("#mod"+comment_seq).attr("style","color:#00B8D4");
	 }else if(modstate =="1") {
		 $("#del"+comment_seq).attr("style",false);
		 $("#mod"+comment_seq).attr("style",false);
		 
	 }
		if(sessionid == commentid) {     
			$(e).attr("style", "background-color:#E1F5FE;"); 
			
		}  
	
    }

function commentleave2(e) {   
	var comment_seq = $(e).prev().attr("value"); 
	 
	$("#ul"+comment_seq).attr("style",false);            
	$("#commenttxt"+comment_seq).attr("style","word-wrap: break-word;");
	$(e).attr("style", "display:none; background-color:#E1F5FE;"); 
}    

   

function likeit(e) { 
	var location = "modal";
	var board_seq = $(e).val();
	if(board_seq == "") {
		board_seq = $(e).attr("value");
		location = "search";
	}
	
	var sessionid = $("#sessionid").val();
	  
	$.ajax({  
		url : "like.bo",
		type : "get",  
		data : {
			board_seq : board_seq,
			id : sessionid,
			is_liked : "y"
		},
		success : function(resp) {
			if(location == "modal") {
				$(e).next().show();
				$(e).hide();
				$("#likeit"+board_seq).hide();
				$("#likecancel"+board_seq).show();
			}else {
				$(e).next().show();
				$(e).hide();
			}
			
		},
		error : function() {
			console.log("에러 발생!");
			}
		})
}

function unlikeit(e) {
	var location = "modal";
	var board_seq = $(e).val();
	if(board_seq == "") {
		board_seq = $(e).attr("value");
		location = "search";
	}
	var sessionid = $("#sessionid").val();   
	$.ajax({
		url : "like.bo",
		type : "get",
		data : {
			board_seq : board_seq,
			id : sessionid,
			is_liked : "n"
		},  
		success : function(resp) {
			if(location == "modal") {
				$(e).prev().show();
				$(e).hide();
				$("#likeit"+board_seq).show();
				$("#likecancel"+board_seq).hide();
			}else {
				$(e).prev().show();
				$(e).hide();
			}
			
		},
		error : function() {
			console.log("에러 발생!");
			}
		})
}


function markit(e) {
	var board_seq = $(e).val();
	var sessionid = $("#sessionid").val();
	$.ajax({
		url : "bookmark.bo",
		type : "get",
		data : {
			board_seq : board_seq,    
			id : "sessionid",
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
	var board_seq = $(e).val();            
	var sessionid = $("#sessionid").val();
	$.ajax({
		url : "bookmark.bo",
		type : "get",
		data : {
			board_seq : board_seq,
			id : "sessionid",
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

function delComment(e) {
	var board_seq = $(e).parent().attr("value");
	var comment_seq = $(e).attr("value");
	$.ajax({
          type: "POST",  
          url: "commentdel.co",      
          data: {board_seq:board_seq,comment_seq:comment_seq},
          success : function(cnt) {
        	  console.log(cnt);      
        	  $("#ul"+comment_seq).fadeOut(400,function() { $("#ul"+comment_seq).remove(); }); 
        	  $("#ul2"+comment_seq).fadeOut(400,function() { $("#ul2"+comment_seq).remove(); });   
        	      
          }  
               
     }); //ajax 
}
$(document).ready(function() {
	$('#boardmodal').on('hidden.bs.modal', function () {
		$(".first").remove();
		$("#firstli").attr('class', 'active');
		$("#firstItem").attr('class', 'carousel-item active');
		if($("#carousel-indicators li:nth-child(2)").length) {
			$(".element").remove();
		}
	});
	
	$("#goNext").click(function() {
		$(".first").remove();
		$("#firstli").attr('class', 'active');
		$("#firstItem").attr('class', 'carousel-item active');
		if($("#carousel-indicators li:nth-child(2)").length) {
			$(".element").remove();
		}  	
		var seq = $("#next").val();
		
	    $("#molikeit").val(seq);
        $("#molikecancel").val(seq); 
        $("#momark").val(seq);
        $("#momarkcancel").val(seq);
		var prevSeq;
		var nextSeq;
		for(var i = 0; i<list.length; i++) {
			if(seq == list[i]) {
				if(i==0) {
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
				prevSeq = list[i-1];
				nextSeq = list[i+1];
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
				$("#modalid").text(data[0].id);	        	   
				var txt = data[0].contents;
					var regex = /(#[^#\s,;]+)/gi  ;  
					var newtxt = data[0].contents;
					if(txt != null) {
						newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
					}
	         
               $("#modalcontents").html(newtxt);
				$("#seq").val(data[0].board_seq);
				 $("#molikeit").val(data[0].board_seq);
			        $("#molikecancel").val(data[0].board_seq); 
			        $("#momark").val(data[0].board_seq);
			        $("#momarkcancel").val(data[0].board_seq);     
				$("#modalid2").text(data[0].id);	   
				$("#prev").val(prevSeq); 
				$("#next").val(nextSeq);
				$("#firstItem").append("<img class='first' src='AttachedMedia/"+data[1][0].system_file_name+"' alt=''>");
				for(var i = 1; i < data[1].length; i++) {
					$("#carousel-indicators li:last-child").after("<li class='element' data-target='#demo' data-slide-to="+i+"></li>");
					$("#carousel-inner div:last-child").after("<div class='carousel-item element'><img class='element' src='AttachedMedia/"+data[1][i].system_file_name+"' alt=''></div>");

				}
				    
                $(".commentline").remove();        
                for(var i =0; i<data[2].length; i++){       
                	
                 	
              	  var txt = data[2][i].comment_contents;   
                    var regex = /(#[^#\s,;]+)/gi  ;            
                    var newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");        
                	  
              	  $("#articlecomment:last-child").append("<ul id='ul"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)'><li id='li1'><a href='' class='mr-2' id='commentid'>"+data[2][i].id+"</a></li><li id='li2'><div class='commenttxt txt' id='commenttxt"+data[2][i].comment_seq+"' style='word-wrap:break-word'>"+newtxt+"</div></li></ul>"
              			 +"<ul id='ul2"+data[2][i].comment_seq+"' style='background-color:#E1F5FE; display:none;' class='commentline2 navbar-nav' onmouseover = 'commentover2(this)' onmouseleave='commentleave2(this)'><li id='li3' value='"+data[2][i].board_seq+"'><i class='far fa-trash-alt py-1 pointer' id='del"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='delComment(this)'></i></li><li id='li4' value='"+data[2][i].board_seq+"'><i class='fas fa-pencil-alt py-1 pl-3 pointer' id='mod"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='modComment(this)'></i><li></ul>");     
                }

                
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
                
                var objDiv = document.getElementById("articlecomment");
                objDiv.scrollTop = 0;

			}
		});
	})    
         
	$("#goPrev").click(function() {
	  
		$(".first").remove();
		$("#firstli").attr('class', 'active');
		$("#firstItem").attr('class', 'carousel-item active');
		if($("#carousel-indicators li:nth-child(2)").length) {
			$(".element").remove();
		}
		var seq = $("#prev").val();
		
		var prevSeq;
		var nextSeq;
		for(var i =0; i<list.length; i++) {
			if(seq == list[i]) {
				if(i==0) {
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
				prevSeq = list[i-1];
				nextSeq = list[i+1];
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
				$("#modalid").text(data[0].id);	 
				var txt = data[0].contents;
				var regex = /(#[^#\s,;]+)/gi;
				var newtxt = data[0].contents;     
				if(txt != null) {
					newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
				}
	          
               $("#modalcontents").html(newtxt);   
			
				$("#seq").val(data[0].board_seq);   
				 $("#molikeit").val(data[0].board_seq);
			        $("#molikecancel").val(data[0].board_seq);   
			        $("#momark").val(data[0].board_seq);
			        $("#momarkcancel").val(data[0].board_seq);  
				$("#modalid2").text(data[0].id);	 
				$("#prev").val(prevSeq); 
				$("#next").val(nextSeq);
				$("#firstItem").append("<img class='first' src='AttachedMedia/"+data[1][0].system_file_name+"' alt=''>");
				for(var i = 1; i < data[1].length; i++) {
					$("#carousel-indicators li:last-child").after("<li class='element' data-target='#demo' data-slide-to="+i+"></li>");
					$("#carousel-inner div:last-child").after("<div class='carousel-item element'><img class='element' src='AttachedMedia/"+data[1][i].system_file_name+"' alt=''></div>");

				}
				   
                $(".commentline").remove();       
                for(var i =0; i<data[2].length; i++){  
                	
                	  var txt = data[2][i].comment_contents;   
                      var regex = /(#[^#\s,;]+)/gi  ;            
                      var newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");          
                	
              	  $("#articlecomment:last-child").append("<ul id='ul"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)'><li id='li1'><a href='' class='mr-2' id='commentid'>"+data[2][i].id+"</a></li><li id='li2'><div class='commenttxt txt' id='commenttxt"+data[2][i].comment_seq+"' style='word-wrap:break-word'>"+newtxt+"</div></li></ul>"
              			 +"<ul id='ul2"+data[2][i].comment_seq+"' style='background-color:#E1F5FE; display:none;' class='commentline2 navbar-nav' onmouseover = 'commentover2(this)' onmouseleave='commentleave2(this)'><li id='li3' value='"+data[2][i].board_seq+"'><i class='far fa-trash-alt py-1 pointer' id='del"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='delComment(this)'></i></li><li id='li4' value='"+data[2][i].board_seq+"'><i class='fas fa-pencil-alt py-1 pl-3 pointer' id='mod"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' onclick='modComment(this)'></i><li></ul>");      
                }
                   
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
                
                var objDiv = document.getElementById("articlecomment");
                objDiv.scrollTop = 0;
            

			}
		});
	})
});

</script>
<input type=hidden id='sessionid' value="${sessionScope.loginId}">
<div id="allwrapper">
	<div id="centerwrapper">
		<div class="container" id="contents">

<c:choose>
<c:when test="${result.size() <0}">
	<h1>검색 결과가 없습니다.</h1>
</c:when>
<c:when test="${result.size() >4 }">
		<div class="card-columns">
<c:forEach var="tmp" items="${result}" varStatus="status">
					<div class="card" id="card">
						<h4 class="card-title" id="searchTop">
							<img src="루이.jpg" alt="Card image cap" width="30" height="30" class="rounded-circle">
								<a id="ids" href="board.bo?id=${tmp.id}&cat=1">${tmp.id}</a>
									<!-- 북마크 -->  
								<c:choose> 
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
									
									<!-- 좋아요 -->
									<c:choose>
										<c:when test="${result3.containsKey(tmp.board_seq)}">
											<i value="${tmp.board_seq}" style="cursor: pointer; display: none;" 
												id="likeit${tmp.board_seq}" class="far fa-heart icon mr-1 lk" onclick="likeit(this)"></i>
											<i value="${tmp.board_seq}" style="color: red; cursor: pointer;" 
												id="likecancel${tmp.board_seq}" class="fas fa-heart lkc" onclick="unlikeit(this)"></i>
											<!-- 좋아요 카운트 -->
											<c:choose>
												<c:when test="${result4[tmp.board_seq] != null}">
													<p id="p">
														<i value="${tmp.board_seq}" id="count${tmp.board_seq}">
															<c:out value="${result4[tmp.board_seq]}"/>명이 좋아합니다
														</i>
													</p>
												</c:when>
													<c:otherwise>
														<p id="p">
															<i value="${tmp.board_seq}" id="count${tmp.board_seq}">
																<c:out value="${result4[tmp.board_seq]}"/>
															</i>
														</p>
													</c:otherwise>
											</c:choose>
										</c:when>
											<c:otherwise>   
												<i value="${tmp.board_seq}" style="cursor: pointer;" id="likeit${tmp.board_seq}" 
													class="far fa-heart icon mr-1 lk" 
													onclick="likeit(this)"></i>
			                   					<i value="${tmp.board_seq}" style="color: red; display: none; cursor: pointer;" 
			                   						id="likecancel${tmp.board_seq}" class="fas fa-heart lkc" 
			                   						onclick="unlikeit(this)"></i>
												<!-- 좋아요 카운트 -->
												<c:choose>
													<c:when test="${result4[tmp.board_seq] != null}">
														<p id="p">
															<i value="${tmp.board_seq}" id="count${tmp.board_seq}">
																<c:out value="${result4[tmp.board_seq]}"/>명이 좋아합니다
															</i>
														</p>
													</c:when>
														<c:otherwise>
															<p id="p">
																<i value="${tmp.board_seq}" id="count${tmp.board_seq}">
																	<c:out value="${result4[tmp.board_seq]}"/>
																</i>
															</p>
														</c:otherwise>
												</c:choose>
											</c:otherwise>
									</c:choose>	
							</h4> <div class="dropdown-divider"  id="modifydiv"></div>
								<!-- 태그,글 보이기 -->
								<div class="hidden" style="padding-left: 5px" id="hidden${tmp.board_seq}">
									<script> $("#myContents${tmp.board_seq}").attr("style","overflow:visible"); </script>
										<p id="myContents${tmp.board_seq}">${tmp.contents}</p>
											<script>    
												var text = $("#myContents${tmp.board_seq}").html();  
												var regex = /(#[^#\s,;]+)/gi  ;              
												var newtxt;
				  								if(text != null) {
				  									 newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
				  								}        
			  							        $("#myContents${tmp.board_seq}").html(newtxt);
											</script>
								</div>
									<!-- 이미지 -->
								<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
									<a id="${tmp.board_seq}" > <!--src='AttachedMedia/${media.system_file_name}'-->
										<img class="card-img-top" id="card"
											src='AttachedMedia/${media.system_file_name}' 
											alt="Card image cap">
									</a>
								</c:forEach>
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
//                                   alert(width + " : " + width1)
                                  $(".modalmedia").attr("style", "flex-direction: row; height:600px; width:"+width+"px; min-width:600px;");  
                                 $(".modalmedia1").attr("style", "height:600px; width:"+width1+"px;");  
                                      
                                 
                                 $(".modalslide").attr("style", " height:590px;");               
                                 }    
                            }); 
                           
                             $("#boardmodal").modal();                      
                       });

                     
             				</script>
				</c:forEach>
				</div>
</c:when>
<c:otherwise>  
<div class="row">
<c:forEach var="tmp" items="${result}" varStatus="status">
<div class="col-md-4">            
					<div class="card" id="card">
						<h4 class="card-title" id="searchTop">
							<img src="루이.jpg" alt="Card image cap" width="30" height="30" class="rounded-circle">
								<a id="ids" href="board.bo?id=${tmp.id}&cat=1">${tmp.id}</a>
									<!-- 북마크 -->  
								<c:choose> 
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
									
									<!-- 좋아요 -->
									<c:choose>
										<c:when test="${result3.containsKey(tmp.board_seq)}">
											<i value="${tmp.board_seq}" style="cursor: pointer; display: none;" 
												id="likeit${tmp.board_seq}" class="far fa-heart icon mr-1 lk" onclick="likeit(this)"></i>
											<i value="${tmp.board_seq}" style="color: red; cursor: pointer;" 
												id="likecancel${tmp.board_seq}" class="fas fa-heart lkc" onclick="unlikeit(this)"></i>
											<!-- 좋아요 카운트 -->
											<c:choose>
												<c:when test="${result4[tmp.board_seq] != null}">
													<p id="p">
														<i value="${tmp.board_seq}" id="count${tmp.board_seq}">
															<c:out value="${result4[tmp.board_seq]}"/>명이 좋아합니다
														</i>
													</p>
												</c:when>
													<c:otherwise>
														<p id="p">
															<i value="${tmp.board_seq}" id="count${tmp.board_seq}">
																<c:out value="${result4[tmp.board_seq]}"/>
															</i>
														</p>
													</c:otherwise>
											</c:choose>
										</c:when>
											<c:otherwise>   
												<i value="${tmp.board_seq}" style="cursor: pointer;" id="likeit${tmp.board_seq}" 
													class="far fa-heart icon mr-1 lk" 
													onclick="likeit(this)"></i>
			                   					<i value="${tmp.board_seq}" style="color: red; display: none; cursor: pointer;" 
			                   						id="likecancel${tmp.board_seq}" class="fas fa-heart lkc" 
			                   						onclick="unlikeit(this)"></i>
												<!-- 좋아요 카운트 -->
												<c:choose>
													<c:when test="${result4[tmp.board_seq] != null}">
														<p id="p">
															<i value="${tmp.board_seq}" id="count${tmp.board_seq}">
																<c:out value="${result4[tmp.board_seq]}"/>명이 좋아합니다
															</i>
														</p>
													</c:when>
														<c:otherwise>
															<p id="p">
																<i value="${tmp.board_seq}" id="count${tmp.board_seq}">
																	<c:out value="${result4[tmp.board_seq]}"/>
																</i>
															</p>
														</c:otherwise>
												</c:choose>
											</c:otherwise>
									</c:choose>	
							</h4> <div class="dropdown-divider"  id="modifydiv"></div>
								<!-- 태그,글 보이기 -->
								<div class="hidden" style="padding-left: 5px" id="hidden${tmp.board_seq}">
									<script> $("#myContents${tmp.board_seq}").attr("style","overflow:visible"); </script>
										<p id="myContents${tmp.board_seq}">${tmp.contents}</p>
											<script>    
												var text = $("#myContents${tmp.board_seq}").html();  
												var regex = /(#[^#\s,;]+)/gi  ;              
												var newtxt;
				  								if(text != null) {
				  									 newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
				  								}        
			  							        $("#myContents${tmp.board_seq}").html(newtxt);
											</script>
								</div>
									<!-- 이미지 -->
								<c:forEach begin="0" end="0" var="media" items="${result2[status.index]}">
									<a id="${tmp.board_seq}" > <!--src='AttachedMedia/${media.system_file_name}'-->
										<img class="card-img-top" id="card"
											src='AttachedMedia/${media.system_file_name}' 
											alt="Card image cap">
									</a>
								</c:forEach>
					</div>
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
//                                   alert(width + " : " + width1)
                                  $(".modalmedia").attr("style", "flex-direction: row; height:600px; width:"+width+"px; min-width:600px;");  
                                 $(".modalmedia1").attr("style", "height:600px; width:"+width1+"px;");  
                                      
                                 
                                 $(".modalslide").attr("style", " height:590px;");               
                                 }    
                            }); 
                           
                             $("#boardmodal").modal();                      
                       });

                     
             				</script>
				</c:forEach>
</div>

</c:otherwise>
</c:choose> 
</div> <!-- container -->
</div>  <!-- centerwrapperr -->
</div> <!-- allwrapper -->
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




<%@ include file="include/bottom3.jsp"%>