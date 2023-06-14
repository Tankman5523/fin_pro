<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- jQuery library -->
	<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="resources/css/login.css">
    <title>Document</title>
</head>
<body>
    <div class="wrap">
        <div class="content">

		 	<c:if test="${not empty alertMsg}">
			
				<script>
				 	alert("<c:out value='${alertMsg}'/>");
				</script>
				
				<c:remove var="alertMsg" scope="session"/>
				
			</c:if>
	
	 		<script>
				$(function(){
					
					var saveId = "${cookie.userNo.value}";
					
					if(saveId != ""){
						$("#userNo").val(saveId);
						$("#save_userNo").attr("checked",true);
					}
				});
			</script> 

            <form action="login.me" method="post" onsubmit="return chkLogin()">
            
                <h2>통합 LOGIN</h2>

                <div id="userNo_area">
                    <span class="left_span"><label for="userNo">아이디</label></span>
                    <br>
                    <input type="text" name="userNo" id="userNo" placeholder="직번/학번을 입력하세요" onkeyup="changeComment()">
                </div>

                <div id="userPwd_area">
                    <span class="left_span"><label for="userPwd">비밀번호</label></span>
                    <br>
                    <input type="password" name="userPwd" id="userPwd" placeholder="비밀번호를 입력하세요">
                </div>

				<div id="checkComment">
				</div>

                <div id="save_userNo_area">
                    <input type="checkbox" name="saveId" id="save_userNo">
                    <label for="save_userNo">아이디 저장</label>
                </div>

                <div id="login_area">
                    <button type="submit">
                        <img src="resources/icon/login_Button.png">
                        <br>
                        	로그인
                    </button>
                </div>

                <div id="login_footer">
                    <span class="left_span"><a href="searchIdForm.me?num=2">ID찾기></a></span>
                    <span class="right_span"><a href="resetPwdForm.me?num=2">비밀번호 초기화></a></span>
                </div>
                
                <div id="login_backButton">
                	<button type="button" onclick="location.href='infoSystem.mp'">돌아가기</button>
                </div>
            </form>
            <script>
            	function chkLogin(){
            		if($("#userNo").val() == ""){ //아이디 빈값 처리
            			var comment = "아이디 또는 비밀번호를 입력해 주세요.";
            			$("#checkComment").text(comment);
            			return false;
            		}
            	}
            	
            	function changeComment(){
            		if($("#userNo").val() != ""){ //아이디 input이 빈값이 아니라면
            			$("#checkComment").text(""); // 코멘트 지우기
            		}
            	}
            </script>
        </div>
    </div>
</body>
</html>

