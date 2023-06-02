<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- jQuery library -->
	<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="resources/css/searchIdForm.css">
    <title>Document</title>
</head>
<body>
    <div class="wrap">
    
        <div class="content" id="content01">

            <h2>비밀번호 재설정</h2>
            
	            <span id="text">
					다음 중 한 가지를 선택하여 비밀번호 재설정을 진행해주시기 바랍니다.
	                <br><br>
					휴대폰 본인인증(본인명의)는 현재 사용중인 휴대폰으로 진행 가능합니다.
	                <br>
					등록된 이메일, 등록된 휴대폰 번호는 학교에 등록되어 있는 정보입니다.
	            </span>
	                <br>
	                <br>
	                
            <div id="button_area">
                <button onclick="">휴대폰 본인인증</button>
                <button onclick="searchEmailForm()">등록된 이메일</button>
            </div>

            <div id="login_footer">
                <button type="button" onclick="location.href='login.me'">돌아가기</button>
            </div>
			
        </div>
        
        <div class="content" id="content02">

            <h2>비밀번호 재설정 - 등록된 이메일</h2>
            
	            <span id="text">
					학교에 등록된 이메일을 입력해 주세요.
	            </span>
	                <br>
	                <br>
	         
            <div id="input_area">
                <span class="left_span"><label for="studentNo">아이디</label></span>
                <br>
                <input name="studentNo" id="studentNo" placeholder="직번/학번을 입력하세요">
                <br>
                <span class="left_span"><label for="stduentName">이름</label></span>
                <br>
            	<input name="studentName" id="stduentName" placeholder="이름">
                <br>
                <span class="left_span"><label for="email">이메일</label></span>
                <br>
            	<input name="email" id="email" placeholder="등록된 이메일">
            </div>

            <div id="login_footer2">
                <button onclick="" id="footer_btn">인증요청</button>
                <button type="button" onclick="backForm();">돌아가기</button>
            </div>
            
        </div>
        
			<script>
				function searchEmailForm(){
					$("#content01").hide();
					$("#content02").show();
				};
				
				function backForm(){
					$("#content01").show();
					$("#content02").hide();
				};
			</script>
    </div>
</body>
</html>

