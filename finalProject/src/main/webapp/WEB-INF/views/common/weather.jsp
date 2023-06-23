<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/weather.css">
<title>Insert title here</title>
</head>
<body>
	<div id="weather_area">
		<div id="weather_icon"></div>
		<div id="weather_temp"></div>
		<div id="weather_sky"></div>
		<div id="weather_minMax"></div>
		<div id="dustInfo"></div>
	</div>
	
	<script>
	
		$(function(){
			
			/* 날씨정보 */
			$.ajax({
				
				url : "weather.api",
				
				success : function(result){
					$("#weather_icon").html(result.IMG);
					$("#weather_temp").html(result.T1H + 'º');
					$("#weather_sky").html(result.SKY);
					$("#weather_minMax").html("<span style='color:#5b8fed;'>"+ result.TMN +"º</span>" + "<span style='color : #d3d5d7;'>/</span>"+"<span style='color:#f55f5e;'>"+ result.TMX +"º</span>");
				}
			});
			
			/* 최저,최고기온  정보 추출*/
			/*
			$.ajax({
				url : "tmnTmx.api",
				success : function(result){
					$("#weather_minMax").html("<span style='color:#5b8fed;'>"+ result.TMN +"º</span>" + "<span style='color : #d3d5d7;'>/</span>"+"<span style='color:#f55f5e;'>"+ result.TMX +"º</span>");
				}
				
			});
			*/
			/* 미세먼지, 초미세먼지 */
			$.ajax({
				url : "dust.api",
				
				success : function(result){
					$("#dustInfo").html("미세&nbsp" + result.pm10Grade1h + "<span style='color : #d3d5d7;'>&nbspㆁ&nbsp</span>" + "초미세&nbsp" + result.pm25Grade1h)
				}
			})
		});
	</script>
</body>
</html>