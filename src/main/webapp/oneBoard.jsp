<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>

<link rel="stylesheet" type="text/css" href="resources/css/oneboard.css">
<script>

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
			$(e).parent().parent().remove();
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
	$("#commentSection"+comment_seq).prop('readonly', false);
	$("#commentSection"+comment_seq).focus();
	
	$("#commentmod"+comment_seq).click(function(){
		var comment = $("#commentSection"+comment_seq).val();
		
		if(comment==""){
			alert("댓글을 입력해 주세요");
			comment.focus();
			
		}else{

			$.ajax({
				type : "post",
				data : { comment_contents : comment , comment_seq : comment_seq },
				url : "commentmod.co",
				success: function(resp){
					
					$("#commentSection"+comment_seq).prop('readonly', true);
					
				}
					
				
			});
		}
		
	});
	
	$("#commentSection"+comment_seq).keypress(function(event){
  
		var keycode=(event.keyCode ? event.keyCode : event.which);
		if(keycode=='13'){
			var comment = $("#commentSection"+comment_seq).val();
			
			if(comment==""){
				alert("댓글을 입력해 주세요");
				comment.focus();
				
			}else{

				$.ajax({
					type : "post",
					data : { comment_contents : comment , comment_seq : comment_seq },
					url : "commentmod.co",
					success: function(resp){
						
						$("#commentSection"+comment_seq).prop('readonly', true);
						
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
		var comment = $("#comment").val();
		var session = $("#sessionid").val();	
		if(comment==""){
			alert("댓글을 입력해 주세요");
			comment.focus();
			
		}else{
			$.ajax({
				type : "post",
				data : {board_seq : ${b.board_seq}, comment_contents : comment },
				url : "insertComment.co",
				success: function(seq){
					    
					$("#comment").val("");
					var start = $("#comment-contents");					
					start.append('<ul class="commentline navbar-nav"  onmouseover="commentover(this)" value="'+seq+'" onmouseleave="commentleave(this)"><li id="li1"><a href="#" id="writerId'+seq+'">'+session+'</a></li><li id="li2"><input type=text id="commentSection'+seq+'" value="'+comment+'" readonly class="commenttxt"></li><li id="li3"><a style="cursor:pointer;" onclick="delComment(this)"  id="commentdel'+seq+'"></a></li><li id="li4"><a style="cursor:pointer;" onclick="modComment(this)" id="commentmod'+seq+'"></a></li></ul>');
				}   

			});
		}  
	}
	  
});
})
</script>


<div id="allwrapper">
	<div class="" id="centerwrapper">
		<div class="container" id="contents">
		
		<div id="board">
		<div class="py-2 my-5" id="feed">
                  <div class="profile-image">
                     <img class="ml-3 mr-2"
                        src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
                     <%--               <h5 class="mt-1 idtxt">${tmp.id}</h5>  --%>
                     <br> 
                     <a class="mt-1 idtxt" id="id" href="#">
                    
						${b.id}
						
                     
                     </a>
                  </div>
                  
		
		<div class="mt-2" id="boardimg">
		
		
		
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
                           
                           <a class="btn navbar-btn ml-2 text-white "> 
                                    <i  id="mark"
                                       class="far fa-bookmark icon"
                                       style="cursor: pointer; "
                                       onclick="markit(this)"></i>
                                    <i 
                                       style="cursor: pointer; display: none; font-weight: bold; color: #00B8D4;"
                                       id="markcancel"  class="far fa-bookmark icon"
                                       onclick="unmarkit(this)"></i>
                           </a>
                        </div>
                     </nav>
				
		<div id="contcenter" class="mt-2 mx-3 pb-2">
		
		<div class="navbar-nav">
                           <a class="ml-1 idtxt" id="con"
                              href="">${b.id}</a>

                           <div class='pl-3 mt-1' id="contdiv">
                           ${b.contents}
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
                        <li id="li1"><a href="#" id="writerId${item.comment_seq}">${item.id}</a></li>
                        <li id="li2"><input type=text id="commentSection${item.comment_seq}" value="${item.comment_contents}" readonly="readonly" class='commenttxt'></li>
                       			
                        <li id="li3"><a style="cursor:pointer;" onclick="delComment(this)"  id="commentdel${item.comment_seq}"></a></li>     
                        <li id="li4"><a style="cursor:pointer;" onclick="modComment(this)" id='commentmod${item.comment_seq}'></a></li>
                        
                        </ul>                       
                        </c:forEach>
            				<input type=hidden id='sessionid' value="${sessionScope.loginId}">            
                        
                        </div>
                        
		</div> <!-- contcenter -->
		   <div class="crecodiv py-2 navbar-nav">


                      
                           <input type="text" placeholder="댓글 달기..." name="comment_contents" class="creco  ml-2 " id="comment">

                              <div class="btn-group bg-white">
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