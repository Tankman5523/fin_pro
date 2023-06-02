<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/universityIntroduction.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../common/mainPageHeader.jsp" %>
		
		<div id="content">
			<div id="content_title">
				<h3>학교소개</h3>
			</div>
			<div id="president_area">
				<img src="resources/icon/yangcheol.png">
				<p>
	                <span id="span1">Welcome to Feasible University</span>
	                <br><br>
	                <span id="span2">
	                    FEASIBLE UNIVERSITY 총장 <b>진양철</b>
	                </span>
                </p>
			</div>
			
			<div class="title_area">
				<h2>설립목적</h2>
			</div>
			<div id="uni_purpose">
				<p>
					Feasible University는 문화,예술,학술 등 다양한 프로그램을 통해 서로 어울리며 <br>
					공동체 의식을 함양함으로써 창의적 역량을 갖춘 Feasible한 리더를 양육함을 목적으로 하고 있다.
				</p>
			</div>
			
			<div class="title_area">
				<h2>오시는 길</h2>
			</div>
			
		</div>
		
		<%@include file="../common/mainPageFooter.jsp" %>
	</div>
</body>
</html>