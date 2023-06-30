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
	<script>
		var socket;
		
		$(function() {
			connect();
			
			$('html').click(function(e){
		    	if($(e.target).parents('#alarm-area').length < 1 && !$(e.target).is('#alarm-area') && !$(e.target).is('#alarmImg')){
		    		if($("#alarmDiv").html() != "<span>새로운 알람이 없습니다.</span>") {
			    		$("#alarmImg").attr("src", $("#alarmImg").data("animated"));
		    		}
		    		$("#alarm-area").addClass("alarm-remove");
		    	}
	        });
		})
		
		function connect() {
			if(!socket) {
				var url = "ws://localhost:8888/fin/echo";
				socket = new WebSocket(url);
			}
			
			socket.onopen = function() {
				console.log("서버와 연결되었습니다.");
				socket.send("${loginUser.studentNo}");
			};
			
			socket.onclose = function() {
				console.log("서버와 연결이 종료되었습니다.");
			};
			
			socket.onerror = function() {
				console.log("서버와 연결 과정에서 오류가 발생했습니다.");
			};
			
			socket.onmessage = function(e) {
				var obj = JSON.parse(e.data);
				
				if(obj.length != 0) {
					console.log("메세지가 도착했습니다.");
					var str = "<ul>";
					if(obj.length != undefined) { // 뒤늦게 메세지 받은거
						for(var i=0;i<obj.length;i++) {
							if(obj[i].cmd == 'gradeInsert') { // 성적 입력
								str += "<li style='font-size: 14px; line-height: 14px;'><a href='classManagement.st'>" + obj[i].professorName + " 교수님이 성적을 입력하셨습니다.</a></li><br>";
							}
							else if(obj[i].cmd == 'gradeUpdate') { // 성적 수정
								str += "<li style='font-size: 14px; line-height: 14px;'><a href='classManagement.st'>" + obj[i].professorName + " 교수님이 성적을 수정하셨습니다.</a></li><br>";
							}
							else if(obj[i].cmd == 'counselUpdate') { // 상담신청 변동
								str += "<li style='font-size: 14px; line-height: 14px;'><a href=''>" + obj[i].professorName + " 교수님이 상담신청을 거절하셨습니다.</a></li><br>";
							}
						}
					}
					else { // 실시간 메세지
						if(obj.cmd == 'gradeInsert') { // 성적 입력
							str += "<li style='font-size: 14px; line-height: 14px;'><a href='classManagement.st'>" + obj.professorName + " 교수님이 성적을 입력하셨습니다.</a></li><br>";
						}
						else if(obj.cmd == 'gradeUpdate') { // 성적 수정
							str += "<li style='font-size: 14px; line-height: 14px;'><a href='classManagement.st'>" + obj.professorName + " 교수님이 성적을 수정하셨습니다.</a></li><br>";
						}
						else if(obj.cmd == 'counselUpdate') { // 상담신청 변동
							str += "<li style='font-size: 14px; line-height: 14px;'><a href=''>" + obj.professorName + " 교수님이 상담신청을 거절하셨습니다.</a></li><br>";
						}
					}
					
					str += "</ul>";
					$("#alarmDiv").html(str);
					$("#alarm-area>button").text("확인");
					$("#alarmImg").attr("src", $("#alarmImg").data("animated"));
				}
			};
		}
	</script>

 	<c:if test="${not empty alertMsg}">
	
		<script>
		 	alert("<c:out value='${alertMsg}'/>");
		</script>
		
		<c:remove var="alertMsg" scope="session"/>
		
	</c:if>
	
	<div id="header">
		<div id="logo" style="width: 500px; height: 100%; margin: 0; float: left; display: flex; align-items: center; justify-content: center;">
			<img src="resources/icon/blue_logo_text.png" onclick="location.href='mainPage.mp'" style="width:300px;">
		</div>
		<div id="alarm-area" class="alarm-remove">
			<button type="button" class="btn btn-warning btn-sm" onclick="closeAlarm();">닫기</button><br><br>
			<div id="alarmDiv"><span>새로운 알람이 없습니다.</span></div>
		</div>
		<table id="user_log">
	        <tr>
	        	<td><img id="alarmImg" src="resources/icon/bell_static.png" data-animated="resources/icon/bell_animated.gif" data-static="resources/icon/bell_static.png" onclick="openAlarm();"></td>
	            <td>
					${loginUser.studentName}님 환영합니다.
	            </td>
	            <td style="padding-left: 50px;">
	                <button type="button" class="btn btn-primary" onclick="location.href='logout.me'" style="border-radius: 10px;">로그아웃</button>
	            </td>
	        </tr>
		</table>
	</div>
	<div id="menubar">
	    <ul id="nav">
	        <li><a href="main.st">홈</a></li>
	        <li><a href="onelist.rg">등록/장학</a></li>
	        <li><a href="infoStudent.st">학사관리</a></li>
	        <li><a href="counselingList.st">상담관리</a></li>
	        <li><a href="classListView.st">수강신청</a></li>
	        <li><a href="classManagement.st">수업관리</a></li>
	    </ul>
	</div>
	
	<script>
		function openAlarm() {
			$("#alarm-area").removeClass("alarm-remove");
			$("#alarmImg").attr("src", $("#alarmImg").data("static"));
		}
		
		function closeAlarm() {
			if($("#alarmDiv").html() != "<span>새로운 알람이 없습니다.</span>") {
				$.ajax({
					url: "alarmCheck.me",
					success: function(result) {
						console.log("업데이트 여부: " + result);
					},
					error: function() {
						console.log("업데이트 통신 오류");
					}
				});
			}
			$("#alarmDiv").html("<span>새로운 알람이 없습니다.</span>");
			$("#alarm-area>button").text("닫기");
			$("#alarm-area").addClass("alarm-remove");
		}
	</script>
	<%@include file="chatBot.jsp" %>
</body>
</html>