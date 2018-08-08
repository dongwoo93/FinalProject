$(document).ready(function(){
   var formInputs = $('input[type="id"],input[type="password"]');
   formInputs.focus(function() {
       $(this).parent().children('p.formLabel').addClass('formTop');
       $('div#formWrapper').addClass('darken-bg');
       $('div.logo').addClass('logo-active');
   });
   
   formInputs.focusout(function() {
      if ($.trim($(this).val()).length == 0){
      $(this).parent().children('p.formLabel').removeClass('formTop');
      }
      $('div#formWrapper').removeClass('darken-bg');
      $('div.logo').removeClass('logo-active');
   });
   
   $('p.formLabel').click(function(){
       $(this).parent().children('.form-style').focus();
   });
   
   $("#action").click(function() {
		
		var val = $("#text").val();
		$("#text").val("");
		
		
		$.ajax({
			url:"ajax01.do",
			type:"get",
			data:{value:val},
			success:function(response) {
				$("#response").text(response);
			},
			error:function() {
				console.log("에러 발생!");
			},
			complete:function() {
				console.log("성공이건 실패건 어찌되었든 ajax 종료");
			}
		});
	})
})