<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main : Feasible University</title>
<link rel="stylesheet" href="/fin/resources/css/mainPage.css">
</head>
<body>
 	<c:if test="${not empty alertMsg}">
	
		<script>
		 	alert("${alertMsg}");
		</script>
		
		<c:remove var="alertMsg" scope="session"/>
		
	</c:if>

	<div class="wrap">
		<%@include file="../common/mainPageHeader.jsp" %>
		
		<div id="content">
			<h1>Content-area</h1>
		</div>
		
		<%@include file="../common/mainPageFooter.jsp" %>
	</div>
</body>
</html>