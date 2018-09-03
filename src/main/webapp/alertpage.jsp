<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>경고!!</title>
</head>
<body>
	<c:if test="${ updateDisabledInfoResult ne null }">
		<c:choose>
			<c:when test="${ updateDisabledInfoResult <= 0 }">
				<script>
					alert('비밀번호가 다릅니다.');
					history.back();
				</script>
			</c:when>
			<c:otherwise>
				<script>
					alert('계정이 비활성화되었습니다.');
					location.href = 'main.do';
				</script>
			</c:otherwise>
		</c:choose>
	</c:if>
		<c:if test="${ toggleDis ne null and sessionScope.loginId ne toggleDis }">
		<c:choose>
			<c:when test="${ toggleDis.isDisabledAccount eq 'y' }">
				<script>
					var select = confirm('${sessionScope.loginId}님의 아이디는 현재 비활성화 상태입니다.\n' 
							+'비활성화 상태를 해제하시겠습니까?');
					if(select){
						location.href = 'updateDisabledInfo.member?checkToggle=true' ;
					}else{
						location.href = 'logout.do';
					}
				</script>
			</c:when>
			<c:otherwise>
				<script>
					alert('잘못된 접근입니다.');
					location.href = 'main.do';
				</script>
			</c:otherwise>
		</c:choose>
	</c:if>
</body>
</html>