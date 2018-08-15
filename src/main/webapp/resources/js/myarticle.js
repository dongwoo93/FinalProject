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