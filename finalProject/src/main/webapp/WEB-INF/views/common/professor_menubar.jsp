<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>종합정보시스템</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/fin/resources/css/professorPageStylesheet.css">
</head>
<body>
	<div id="header">
		<table id="user_log">
	        <tr>
	            <td>
					${loginUser.professorName} 님 환영합니다.
		        </td>
		        <td style="padding-left: 50px;">
		            <button type="button" class="btn btn-primary" onclick="">로그아웃</button>
		        </td>
		    </tr>
		</table>
	</div>
	<div id="menubar">
	    <ul id="nav">
            <li><a href="#">홈</a></li>
            <li><a href="mylist.sl">급여관리</a></li>
            <li><a href="#">학사관리</a></li>
            <li><a href="#">상담관리</a></li>
            <li><a href="#">강의관리</a></li>
            <li><a href="#">수업관리</a></li>
        </ul>
	</div>
</body>
</html>