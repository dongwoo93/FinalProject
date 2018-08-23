<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.3.1.js"></script> 
</head>
<body>
<script>
if(${sessionScope.loginId != null}) {
	alert("잘못된 접근입니다");
    $(location).attr("href", "feed.bo");
 }else {
	 alert("먼저 로그인을 해주세요");
	 $(location).attr("href", "main.jsp");
 }

</script>

</body>
</html>