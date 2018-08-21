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
	
	/*$('#profileimage').on('hidden.bs.modal', function (e) {

		var myvar = '<div class="modal-dialog modal-lg">'+
		'      <div class="modal-content">'+
		'        <div class="modal-header">'+
		'          <h4 class="modal-title">프로필 이미지</h4>'+
		'          <button type="button" class="close" data-dismiss="modal">×</button>'+
		'        </div>'+
		'        <div class="modal-body">'+
		'          <input type=\'file\' onchange="readURL(this);" />'+
		'			<img id="profileimg" src="resources/images/Placeholder.png" alt="your image" />'+
		'        </div>'+
		'        <div class="modal-footer">'+
		'          <button type="button" class="btn btn-primary" data-dismiss="modal">적용</button>'+
		'          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>'+
		'        </div>'+
		'      </div>'+
		'    </div>';
			
		$("#profileimage").html(myvar);

		})*/

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

			}
		});
	})
	
	$("#delete").click(function(){
		var seq = document.getElementById("hidden").value;
		location.href = "boardDelete.bo?seq="+seq;

	})

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
	
	$("#savebtn").click(function() {
		if($('#inputimg').get(0).files.length != 0) {
			var formData = new FormData($("#fileForm")[0]);
			$.ajax({
				type:"POST",
				url:"uploadImg.profile",
				data: formData,
				processData : false,
	            contentType : false,
				success: function(data) {
					alert(data);
					location.reload();
				},
				error : function(error) {
	                console.log(error);
	                console.log(error.status);
	            }
			});
		}else {
			var fileName = $("#hiddenimgname").val();
			var id = $("#hiddenid").val();
			$.ajax({
				type:"POST",
				url:"updateImg.profile",
				data: {system_file_name:fileName, id:id},
				success: function(data) {
					alert(data);
					location.reload();
				},
				error : function(error) {
	                console.log(error);
	                console.log(error.status);
	            }
			});
		}
		
	})
	
})