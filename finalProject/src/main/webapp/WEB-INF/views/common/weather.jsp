<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/weather.css">
</head>
<body>
	<div id="weather_area">
			
	</div>
	<script>
		$(function(){
			$.ajax({
				
				url : "weather.api",
				
				success : function(result){
					var items = result.response.body.items;
				}
			});
		});
	</script>
</body>
</html>