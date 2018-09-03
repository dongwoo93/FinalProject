<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--                                  DM -->
					<script>
					$(document).ready(function() {
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
					});
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
			                	for(var i=0;i<2;i++){
			                		if(i==0){
			                			for(var k=0;k<response[0].length;k++){
				                			console.log(response[2][k]);
			                				$("#onlinefriendlist").append("<li onclick='openmessage(this)'><img src='AttachedMedia/"+response[2][k]+"' class='dmimg'>"+response[0][k].nickname+"<input type='hidden' id='usernickname' value='"+response[0][k].nickname+"'><a class='favorite'><i class='fas fa-circle onlineicon'></a></li>");
			                			}
			       
			                		}
			                		else{
			                			for(var k=0;k<response[1].length;k++){
				                			console.log(response[3][k]);
				                			
			                				$("#offlinefriendlist").append("<li onclick='openmessage(this)'><img src='AttachedMedia/"+response[3][k]+"' class='dmimg'>"+response[1][k].nickname+"<input type='hidden' id='usernickname' value='"+response[1][k].nickname+"'><a class='favorite'><i class='fas fa-circle'></a></li>");
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
			                	$("#userId").val(response[0]);
			                	$(".chatbox-avatar a img").attr("src","AttachedMedia/"+response[1]);
			                	setRead(response[0]);
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
  
  <div class="chatbox group-chat" style="display:none;">
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
    	<img src="resources/images/imoticon/1.png" class="imoticon">
    	<img src="resources/images/imoticon/2.png" class="imoticon">
    	<img src="resources/images/imoticon/3.png" class="imoticon">
    	<img src="resources/images/imoticon/4.png" class="imoticon">
    	<img src="resources/images/imoticon/5.png" class="imoticon">
    	<img src="resources/images/imoticon/6.png" class="imoticon">
    	<img src="resources/images/imoticon/7.png" class="imoticon">
    	<img src="resources/images/imoticon/8.png" class="imoticon">
    	<img src="resources/images/imoticon/9.png" class="imoticon">
    	<img src="resources/images/imoticon/10.png" class="imoticon">
    	<img src="resources/images/imoticon/11.png" class="imoticon">
    	<img src="resources/images/imoticon/12.png" class="imoticon">
    	<img src="resources/images/imoticon/13.png" class="imoticon">
    	<img src="resources/images/imoticon/14.png" class="imoticon">
    	<img src="resources/images/imoticon/15.png" class="imoticon">
    	<img src="resources/images/imoticon/16.png" class="imoticon">
    	<img src="resources/images/imoticon/17.png" class="imoticon">
    	<img src="resources/images/imoticon/18.png" class="imoticon">
    	<img src="resources/images/imoticon/19.png" class="imoticon">
    	<img src="resources/images/imoticon/20.png" class="imoticon">
    	<img src="resources/images/imoticon/21.png" class="imoticon">
    	<img src="resources/images/imoticon/22.png" class="imoticon">
    	<img src="resources/images/imoticon/23.png" class="imoticon">
    	<img src="resources/images/imoticon/24.png" class="imoticon">
    	<img src="resources/images/imoticon/25.png" class="imoticon">
    	<img src="resources/images/imoticon/26.png" class="imoticon">
    	<img src="resources/images/imoticon/27.png" class="imoticon">
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