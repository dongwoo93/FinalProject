var ws = new WebSocket("ws://localhost/websocket?loginId="+currentId);         
AOS.init();

$(function () {
	ws.onopen = function () {
	};
	ws.onmessage = function (msg) {
		    
		if(msg.data == 'comment'){ 
			alert("코멘트 달았엉 알림가자~~~");  
		}else if(msg.data == 'l'){
			$("#totalreadcount2").attr("style",false);
			$("#countAlert").html("1");   
			
		}
		
		else{  
		var message = msg.data.split("뇽뇽뇽뇽321뇽뇽뇽뇽")[0];
		var sender = msg.data.split("뇽뇽뇽뇽321뇽뇽뇽뇽")[1];
		var receivernickname = $("#dmnickname").text();
		var receiverId = $("#userId").val();
		if(receiverId == sender){
	    	$("#message").append("<div class='message-box-holder'><div class='message-sender'><a>"+receivernickname+"</a></div><div class='message-box message-partner'>"+message+"</div></div>");
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
            data: {message:message,receiver:receiver,sender:currentId}, 
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
            		ws.send(receiver+"뇽뇽뇽뇽123뇽뇽뇽뇽"+message+"뇽뇽뇽뇽321뇽뇽뇽뇽"+currentId);
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
////////////////////////////////Connect WebSocket & Messenger

function closeDm() {  
	$("#dm").attr("style","width:0;");  
	$("#allwrapper").attr("style","margin-left:0;");  
    $("#footer").attr("style","margin-left:0;");    
}  
  
////////////////////////////////Messenger SideBar Hide 



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
/////////// mark & unmark   
 
 

 function commentover(e,id) {    
 	
	var comment_seq = $(e).attr("value"); 
	var sessionid = currentId;
	
	var commentid = $(e).children().first().children().first().html();  
	console.log(commentid);    
	
	var modstate = $("#modstate"+comment_seq).val();    
	 
		$("#ul"+comment_seq).attr("style","background-color:#E1F5FE");
		$("#commenttxt"+comment_seq).attr("style","word-wrap: break-word; word-break:break-all; background-color:#E1F5FE"); 
		
		if(sessionid == commentid) {          
		$("#commentdel"+comment_seq).html("삭제"); 
		
		if(modstate == "1") {
			$("#commentmod"+comment_seq).html("수정");
		} 
		else if(modstate =="2") {  
			$("#commentmod"+comment_seq).html("완료");}
		}  
	}
 
 function commentleave(e) {  
 	var seq = $(e).attr("value"); 
		 
		$("#ul"+seq).attr("style",false);            
		$("#commenttxt"+seq).attr("style","word-wrap: break-word; word-break:break-all"); 
		$("#commentdel"+seq).html("");   
		$("#commentmod"+seq).html("");

 }
   
////////////Comment Over & Leave event
 

 function delComment(e) {
			var board_seq = $(e).attr("value").split(":")[0]; 
			var comment_seq = $(e).attr("value").split(":")[1];
			alert(board_seq + " :"  + comment_seq);  
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
                   data: {board_seq : board_seq, comment_seq:comment_seq, comment_contents:txt},   
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
////////////Comment Modify & Delete
 
 

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
 

$(document).ready(function() { 
	  
	$("#allwrapper").click(function(){
		closeDm();
	});
	
////////////	Messenger SideBar Hide 
	

  
	$('#searchform').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13'){
          var text = $("#searchform").val();
        	if(text == ""){
        		alert("검색어를 입력해 주세요");
        	}
        	else{
        		$("#go").attr("onsubmit","return true;");
        	} 
        }
    });
	             
	var $nav = $("#navbar");

	$nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());

	$(window).scroll(function() {

				var $nav = $("#navbar");

				$nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());

			});

})

 AOS.init();