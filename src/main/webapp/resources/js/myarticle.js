$(document).ready(function() {
	
	$("#boardmodal").on("shown.bs.modal", function () { 
		var seq = $("#hidden").val();

	    $.ajax({
	           type: "POST",
	           url: "boardView.bo",
	           data: {seq:seq},
	           success: function(data)
	           {
	        	   $("#modalid").text(data.id);
	        	
	        	   
	               $("#modalcontents").text(data.contents);
	               
	               $("#seq1").text(data.board_seq);
	               $("#seq2").text(data.board_seq);
	               
	           }
	         });
		});
	
	$("#toMy").click(function() {
		$(location).attr("href", "profile.member");
	})
	})