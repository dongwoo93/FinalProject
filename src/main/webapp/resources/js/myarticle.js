$(document).ready(function() {
	$("#logout").click(function() {
		$(location).attr("href", "logout.do");
	})

	$('#boardmodal').on('hidden.bs.modal', function () {
		$(".first").remove();
		$("#firstli").attr('class', 'active');
		$("#firstItem").attr('class', 'carousel-item active');
		if($("#carousel-indicators li:nth-child(2)").length) {
			$(".element").remove();
		}
	});

	$("#toMy").click(function() {
		$(location).attr("href", "profile.member");
	})

	$("#goNext").click(function() {
		$(".first").remove();
		$("#firstli").attr('class', 'active');
		$("#firstItem").attr('class', 'carousel-item active');
		if($("#carousel-indicators li:nth-child(2)").length) {
			$(".element").remove();
		}
		var seq = $("#next").val();
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
				$("#modalcontents").html(data[0].contents);
				$("#seq").val(data[0].board_seq);
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
              	  $("#articlecomment:last-child").append("<ul id='ul"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)'><li id='li1'><a href='' class='mr-2' id='commentid'>"+data[2][i].id+"</a></li><li id='li2'><div class='commenttxt txt' id='commenttxt"+data[2][i].comment_seq+"' style='word-wrap:break-word'>"+data[2][i].comment_contents+"</div></li></ul>");
                }
                

                
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
				$("#modalcontents").html(data[0].contents);
				$("#seq").val(data[0].board_seq);
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
              	  $("#articlecomment:last-child").append("<ul id='ul"+data[2][i].comment_seq+"' value='"+data[2][i].comment_seq+"' class='commentline navbar-nav' onmouseover = 'commentover(this)' onmouseleave='commentleave(this)'><li id='li1'><a href='' class='mr-2' id='commentid'>"+data[2][i].id+"</a></li><li id='li2'><div class='commenttxt txt' id='commenttxt"+data[2][i].comment_seq+"' style='word-wrap:break-word'>"+data[2][i].comment_contents+"</div></li></ul>");
                }
                   
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
	})

	document.getElementById("delete").onclick = function() {
		var seq = document.getElementById("hidden").value;
		location.href = "boardDelete.bo?seq="+seq;
	}	

	$("#modify").click(function(){
		$("#modalcontents").attr("contentEditable","true");
		$("#modalcontents").focus();

	})

	$("#modifysubmitbtn").click(function(){
		var board_seq = $("#seq").val();
		var contents = $("#modalcontents").html();

		$.ajax({
			type:"POST",
			url:"boardModify.bo",
			data: {board_seq:board_seq, contents:contents},
			success: function(data)
			{
				if(data == 1){
					$("#modalcontents").val(contents);
					$("#modalcontents").attr("contentEditable","false");

				}else {
					alert("다시 시도해주세요");
				}

			}
		});
	})
	

})

	function commentover(e) {    
    	
	var comment_seq = $(e).attr("value");           
	var sessionid = $("#sessionid").val();
	var commentid = $(e).children().children().html();    
	     
	
		$(e).attr("style","background-color:#E1F5FE");
		$("#commenttxt"+comment_seq).attr("style","word-wrap: break-word; background-color:#E1F5FE"); 
		 
		if(sessionid == commentid) {      
		//삭제수정
		}  
	
    }

function commentleave(e) {   
	var comment_seq = $(e).attr("value"); 
	 
	$("#ul"+comment_seq).attr("style",false);            
	$("#commenttxt"+comment_seq).attr("style","word-wrap: break-word;"); 
	  

}
	
 
	 