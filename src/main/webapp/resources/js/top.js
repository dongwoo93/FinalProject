var ws = new WebSocket("ws://localhost/websocket?loginId="+currentId); 
    
$(function () {
	ws.onopen = function () {
	};
	ws.onmessage = function (msg) {
		 
		if(msg.data == 'c'){ 
			alert("코멘트 달았엉 알림가자~~~");  
		}else if(msg.data == 'l'){
			alert("좋아요알림가자~~~~"); 
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


//////////////////////////////// Connect WebSocket & Messenger

$(document).ready(function() {
	
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