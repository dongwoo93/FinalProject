<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
   <div cols="33" rows="5" id="txt">
하하하 블라블라 #잡담, #태그, #추출 #흠냐리#이어짐
  #abcd
</div>
<br />
<button id="getTag">해쉬태그뽑기</button>
<br /><br />
추출된 태그:
<div id="tags"></div>



    <script>  
    $(document).ready(function() { 
                       
    	var regex =  /(#[^#\s,;]+)/gi ;       
    	 var txt = $("#txt").html(); 
    	 var tag = [];
    	   $("#getTag").click(function() {   
    
    		   $("#tags").html(txt.replace(regex, "<a href=''>"+"$1"+"</a>"));       
    		//   while (regex.exec(txt) != null) {  
//     			regex.test(txt);   
//     			  tag.push("#"+RegExp.$1);   
//     			   alert("#"+RegExp.$1);     
    			  
        //     }  
    		//   $("#tags").html(tag); 
     		 });
    })

    </script>
    
 -->

<a href="feed.bo">피드로가기</a>

<table border=1>
		<tr>
			<td>글번호</td>
			<td>작성자</td>
			<td>내용</td>
			
		</tr>
		<c:choose>
			<c:when test="${result.size() > 0}">
				<c:forEach var="tmp" items="${result}">
				
			
					<tr>
						<td>${tmp.board_seq}</td>
						<td id=contents>${tmp.id}
				
							<script>
				var regex = /(#[^#\s,;]+)/gi ;         
		    	 var txt = "${tmp.contents}"; 
		    	  var newtxt = txt.replace(regex, "<a href=''>"+"$1"+"</a>");  
		    	  alert(newtxt);    
		    	  $("#contents:last-child").after("</td><td>"+newtxt+"</td>");
				</script>  
					 
					</tr>

				</c:forEach>

			</c:when>
			<c:otherwise>표시할 내용이 없습니다.</c:otherwise>
		</c:choose>
	</table>


</body>
</html>