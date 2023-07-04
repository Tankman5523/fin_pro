<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<script>
		var socket;
		var $check=0;
		
		$(function() {
			connect();
			
			$('html').click(function(e){
		    	if($(e.target).parents('#alarm-area').length < 1 && !$(e.target).is('#alarm-area') && !$(e.target).is('#alarmImg')){
		    		if($("#alarmDiv").html() != "<span>새로운 알람이 없습니다.</span>") {
			    		$("#alarmImg").attr("src", $("#alarmImg").data("static"));
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
				socket.send("${loginUser.professorNo}");
				
				<c:if test="${not empty alarmCheck}">
					$check += ${alarmCheck};
					<c:remove var="alarmCheck" scope="session"/>
				</c:if>
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
					if(obj.length != undefined) { // 뒤늦게 메세지 받은거
						var str = "<ul>";
						for(var i=0;i<obj.length;i++) {
							if(obj[i].cmd == 'counselRequest') { // 상담 신청
								str += "<li style='font-size: 14px; line-height: 14px;'><input type='hidden' value='" + obj[i].alarmNo+ "'>"
									 + "<a href='counselHistory.pr' onclick='alarmCheck(this);'>" + obj[i].senderName + " 학생이 상담을 요청하였습니다.</a>"
									 + "<a style='margin-left: 10px;' onclick='alarmCheck(this);'><i class='fa-solid fa-trash' style='color: #c7c7c7;'></i></a>"
									 + "</li><br>";
							}
							else if(obj[i].cmd == 'reportRequest') { // 성적이의신청
								str += "<li style='font-size: 14px; line-height: 14px;'><input type='hidden' value='" + obj[i].alarmNo+ "'>"
									 + "<a href='professorGradeReport.pr' onclick='alarmCheck(this);'>" + obj[i].senderName + " 학생이 성적 이의신청을 하였습니다.</a>"
									 + "<a style='margin-left: 10px;' onclick='alarmCheck(this);'><i class='fa-solid fa-trash' style='color: #c7c7c7;'></i></a>"
									 + "</li><br>";
							}
						}
						str += "</ul>";
						$("#alarmDiv").html(str);
						$("#alarm-area>button").text("모두 지우기");
						if($("#alarmDiv").html() != "<span>새로운 알람이 없습니다.</span>") { // 알람있으면
							$("#alarmImg").css("filter", "grayscale(0%)");
						}
						
						if($check==1) {
							$("#alarm-area").removeClass("alarm-remove");
							$("#alarmImg").attr("src", $("#alarmImg").data("animated"));
							
							setTimeout(function() {
								$("#alarm-area").addClass("alarm-remove");
								$("#alarmImg").attr("src", $("#alarmImg").data("static"));
							}, 10000);
						}
					}
					else { // 실시간 메세지
						var str = "<span>";
						if(obj.cmd == 'counselRequest') { // 상담 신청
							str += obj.senderName + " 학생이 상담을 요청하였습니다.";
						}
						else if(obj.cmd == 'reportRequest') { // 성적이의신청
							str += obj.senderName + " 학생이 성적 이의신청을 하였습니다.";
						}
						
						str += "</span>";
						$("#alarm-area2").html(str);
						
						setTimeout(function() {
							$("#alarm-area2").removeClass("alarm-remove");
						}, 500);
						
						if(!$("#alarm-area").hasClass("alarm-remove")) { // 알람창 띄워져있으면 없애기
							$("#alarm-area").addClass("alarm-remove");
						}
						
						setTimeout(function() {
							$("#alarm-area2").addClass("alarm-remove");
							if($("#alarmDiv").html() == "<span>새로운 알람이 없습니다.</span>") {
								$("#alarmImg").css("filter", "grayscale(100%)");
							}
							$("#alarmImg").attr("src", $("#alarmImg").data("static"));
							
						}, 8000); // 8초동안 보여줌
						
						$("#alarmImg").css("filter", "grayscale(0%)");
						$("#alarmImg").attr("src", $("#alarmImg").data("animated"));
					}
					
					$check=2;
				}
			};
		}
		
		function disconnect() {
			socket.close();
			socket = "";
		}
	</script>
	
	<div id="header">
		<div id="logo" style="width: 500px; height: 100%; margin: 0; float: left; display: flex; align-items: center; justify-content: center;">
			<img src="resources/icon/blue_logo_text.png" onclick="location.href='mainPage.mp'" style="width:300px;">
		</div>
		<div id="alarm-area" class="alarm-remove">
			<button type="button" class="btn btn-warning btn-sm" onclick="closeAlarm();">닫기</button><br><br>
			<div id="alarmDiv"><span>새로운 알람이 없습니다.</span></div>
		</div>
		<div id="alarm-area2" class="alarm-remove"></div>
		<table id="user_log">
	        <tr>
	        	<td><img id="alarmImg" src="resources/icon/bell_static.png" style="filter: grayscale(100%);" data-animated="resources/icon/bell_animated.gif" data-static="resources/icon/bell_static.png" onclick="openAlarm();"></td>
	            <td>
					${loginUser.professorName}님 환영합니다.
		        </td>
		        <td style="padding-left: 50px;">
		            <button type="button" class="btn btn-primary" onclick="location.href='logout.me'" style="border-radius: 10px;">로그아웃</button>
		        </td>
		    </tr>
		</table>
	</div>
	<div id="menubar">
	    <ul id="nav">
            <li><a href="main.pr">홈</a></li>
            <li><a href="mylist.sl">급여관리</a></li>
            <li><a href="infoProfessor.pr">학사관리</a></li>
            <li><a href="counselHistory.pr?user=${loginUser.professorNo }">상담관리</a></li>
            <li><a href="classCreateSelect.pr">강의관리</a></li>
            <li><a href="professorGradeReport.pr">수업관리</a></li>
        </ul>
	</div>
	
	<script>
		function alarmCheck(e) {
			var $aNo = $(e).siblings("input").val();
			$.ajax({
				url: "alarmCheck.me",
				data: { aNo: $aNo },
				success: function(result) {
					console.log("업데이트 여부: " + result);
				},
				error: function() {
					console.log("업데이트 통신 오류");
				}
			});
			
			$(e).parents("li").remove();
			
			if($("#alarmDiv").text() == "") {
				$("#alarmDiv").html("<span>새로운 알람이 없습니다.</span>");
				$("#alarmImg").css("filter", "grayscale(100%)");
				$("#alarmImg").attr("src", $("#alarmImg").data("static"));
			}
		}
	
		function openAlarm() {
			if($("#alarm-area").hasClass("alarm-remove")) {
				if(!$("#alarm-area2").hasClass("alarm-remove")) {
					$("#alarm-area2").addClass("alarm-remove");
				}
				
				socket.send("${loginUser.professorNo}");
				$("#alarm-area").removeClass("alarm-remove");
				if($("#alarmDiv").html() != "<span>새로운 알람이 없습니다.</span>") {
					$("#alarmImg").attr("src", $("#alarmImg").data("animated"));
				}
			}
		}
		
		function closeAlarm() {
			if($("#alarmDiv").html() != "<span>새로운 알람이 없습니다.</span>") {
				$.ajax({
					url: "alarmAllCheck.me",
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
			$("#alarmImg").css("filter", "grayscale(100%)");
			$("#alarmImg").attr("src", $("#alarmImg").data("static"));
			$("#alarm-area").addClass("alarm-remove");
		}
	</script>
</body>
</html>