<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="9fiDYsKwG1z/+w1AGQMIMrK7Um7HCEnUze7XQeilNE91vhMXTrOAHoPUrl5GSKNNtp/njXQ2r4Kee6Qk2n2wzg==" />
  
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.js"
	integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
	crossorigin="anonymous">
	
</script>

<script src="https://unpkg.com/infinite-scroll@3/dist/infinite-scroll.pkgd.js"></script>
<script>

	$(window).scroll(function(){
		if($(window).scrollTop() >=$(document).height()- $(window).height()-50){
			{
				
				
		$('.article').append('<div><img src="https://unsplash.it/400/300/?random" border="1"></div>');
			}
		
		}
	}); 

    if ($("body").height() < $(window).height()) {
        alert("There isn't a vertical scroll bar");
    } 

</script>
</head>
<style>
body{
margin:0;
padding:0;
}
.container{

width:100%;
height:770px;
background:#ff0;
}
.container .article{
	align:center;
	
}


</style>
<body>
<div class="container">
	<div class='article'><img src="https://unsplash.it/400/300/?random" border="1"></div>


</div>


</body>
</html>