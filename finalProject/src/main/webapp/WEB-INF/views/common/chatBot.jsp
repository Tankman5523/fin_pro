<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/chatBot.css">
<title>chatBot</title>
</head>
<body>
	<div id="chatWrap">
		<div id="chatHead">
		
			<button id="startBtn" onclick="openChat();">
				<img src='resources/icon/blue_plane.png'>
			</button>
			<div id="chatBody">
				<button id="bodyBtn" onclick="closeChat();">
					<img src='resources/icon/white_plane.png'>
				</button>
				<div id="resultDiv">
				</div>
				<div id="startDiv">
					<button id="startChatBtn" onclick="startChat();">챗봇 시작하기</button>
				</div>
				<div id="questionDiv">
					<input type="text" id="question">
					<button id="questionBtn" onclick="questionBtn();">전송</button>
				</div>
			</div>
			
		</div>
	</div>
</body>

<script>
	function openChat(){
		$("#chatBody").show(500);
		$("#startBtn").hide();
	}
	
	function closeChat(){
		$("#chatBody").hide(500);
		$("#startBtn").show(650);
		$("#questionDiv").hide();
		$("#startDiv").show();
		$("#resultDiv").html("");
	}
	
	function startChat(){
		$("#questionDiv").show();
		$("#startDiv").hide();
		questionBtn();
	}
	
	function questionBtn(num){
		$.ajax({
			url : "chatBot.cb",
			data : {
				question : $("#question").val(),
				num : num
			},
			success : function(result){
				$("#question").html("");
				$("#resultDiv").html(result);
			},
			error : function(){
				console.log("쳇봇 통신실패");
			}
		});
		$("#question").val("");
	}
</script>

</html>