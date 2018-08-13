$(document).ready(function(){
	AOS.init();
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
   

		
		
		
	
   $("#loginform").submit(function(e) {


	    var form = $(this);
	    $("#preloader").show();

	    $.ajax({
	           type: "POST",
	           url: "login.do",
	           data: form.serialize(), // serializes the form's elements.
	           success: function(data)
	           {
	               if(data == 1) {
	            	   $(location).attr("href", "feed.bo");
	               }else {
	            	   $("#result").html("<div data-aos='zoom-in'>아이디와 비밀번호를 다시 확인해주세요</div>")
	            	   $("#preloader").hide();
	               }
	           }
	         });

	    e.preventDefault(); // avoid to execute the actual submit of the form.
	});
});
