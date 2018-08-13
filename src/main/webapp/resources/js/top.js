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