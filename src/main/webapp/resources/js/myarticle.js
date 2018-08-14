$(document).ready(function() {
	$("#logout").click(function() {
		$(location).attr("href", "logout.do");
	})
	
	$("#boardmodal").on("shown.bs.modal", function () {
		
		var seq = $("#hidden").val();
		 
		
		var prevSeq;
		var nextSeq;
		
		for(var i =0; i<list.length; i++) {
			if(seq == list[i]) {
				if(i==0) {
					$("#goPrev").hide();
				}
				else if(i == (list.length-1)){
					$("#goNext").hide();
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
	        	   $("#modalid").text(data.id);	        	   
// 	               $("#modalcontents").text(data.contents);       
				   $("#modalcontents").html(data.contents);
	               $("#seq").val(data.board_seq);
	               $("#modalid2").text(data.id);	   
	               $("#prev").val(prevSeq); 
            	   $("#next").val(nextSeq);
	           	}
	         });
		});
	
		$("#toMy").click(function() {
			$(location).attr("href", "profile.member");
			})
			
			$("#goNext").click(function() {
			var seq = $("#next").val();
			var prevSeq;
			var nextSeq;
			for(var i = 0; i<list.length; i++) {
				if(seq == list[i]) {
					if(i==0) {
						$("#goPrev").hide();
					}
					else if(i == (list.length-1)){
						$("#goNext").hide();
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
			        	   $("#modalid").text(data.id);	        	   
						   $("#modalcontents").html(data.contents);
			               $("#seq").val(data.board_seq);
			               $("#modalid2").text(data.id);	   
			               $("#prev").val(prevSeq); 
                    	   $("#next").val(nextSeq);
                    	   
              
			           	}
			         });
			})
			
			$("#goPrev").click(function() {
			var seq = $("#prev").val();
			var prevSeq;
			var nextSeq;
			for(var i =0; i<list.length; i++) {
				if(seq == list[i]) {
					if(i==0) {
						$("#goPrev").hide();
					}
					else if(i == (list.length-1)){
						$("#goNext").hide();
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
			        	   $("#modalid").text(data.id);	        	       
						   $("#modalcontents").html(data.contents);
			               $("#seq").val(data.board_seq);
			               $("#modalid2").text(data.id);	 
			               $("#prev").val(prevSeq); 
                    	   $("#next").val(nextSeq); 
                    	   
 							if(i == 0) {
                    		   
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