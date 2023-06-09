<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="/fin/resources/css/studentPageStylesheet.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>	
<body>
	<div id="header">
		<div id="logo" style="width: 500px; height: 100%; margin: 0; float: left; display: flex; align-items: center; justify-content: center;">
			<img src="resources/icon/blue_logo_text.png" style="width:300px;">
		</div>
		<table id="user_log">
	        <tr>
	            <td>
					${loginUser.studentName}님 환영합니다.
	            </td>
	            <td style="padding-left: 50px;">
	                <button type="button" class="btn btn-primary" onclick="location.href='logout.me'">로그아웃</button>
	            </td>
	        </tr>
		</table>
	</div>
	<div id="menubar">
	    <ul id="nav">
	        <li><a href="#">홈</a></li>
	        <li><a href="#">등록/장학</a></li>
	        <li><a href="#">학사관리</a></li>
	        <li><a href="counselingList.st">상담관리</a></li>
	        <li><a href="classListView.st">수강신청</a></li>
	        <li><a href="classManagement.st">수업관리</a></li>
	    </ul>
	</div>
</body>
</html>