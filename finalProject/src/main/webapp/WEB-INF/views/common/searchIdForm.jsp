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

            <h2>로그인ID 조회</h2>
            
	            <span id="text">
					다음 중 한 가지를 선택하여 로그인ID 조회를 진행해주시기 바랍니다.
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
                <button type="button" onclick="history.back();">돌아가기</button>
            </div>
			
        </div>
        
        <div class="content" id="content02">

            <h2>로그인ID 조회 - 등록된 이메일</h2>
            
	            <span id="text">
					학교에 등록된 이름과 전화번호를 입력해 주세요.
	            </span>
	                <br>
	                <br>
	         
            <div id="input_area">
                <span class="left_span"><label for="studentName">이름</label></span>
                <br>
            	<input name="studentName" id=studentName placeholder="이름" required>
                <br>
                <span class="left_span"><label for="phone">휴대폰 번호</label></span>
                <br>
            	<input type="number" name="phone" id="phone" placeholder="- 을 제외하고 입력해주세요" required>
                <br>
                <div id="checkDiv">
                    <span class="left_span"><label for="checkEmail">인증 번호</label></span>
                    <span id="timer"></span>
                    <button onclick="plusTime();">시간연장</button>
                    <input type="number" name="checkEmail" id="checkEmail" placeholder="인증번호 6자리를 입력해주세요">
                </div>
            </div>

            <div id="login_footer2">
                <button onclick="checkEmail();" id="footer_btn">인증요청</button>
                
                <!-- 메일인증 후 번호 확인 완료되면 학번 표시 -->
                
                <button onclick="checkSubmit();" id="footer_btn2">인증완료</button>
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
					$("#footer_btn").show();
					$("#footer_btn2").hide();
                    $("#checkDiv").hide();
                    clearInterval(timer);
                    $("#checkDiv>#timer").html("");
                    $("#studentName").val("");
                    $("#phone").val("");
				};

                function checkEmail(){
                    $.ajax({
                        
                        url : "checkEmail.st",

                        data : {
                        	studentName : $("#studentName").val(),
                            phone : $("#phone").val()
                        },
                        
                        success : function(result){
                        	
                            if(result > 0){
                            	
                                $("#checkDiv").show();
                                $("#footer_btn").hide();
                                $("#footer_btn2").show();
                                
                                startTimer();
                                
                            }else{
                            	alert("잘못된 학생 정보입니다.");
                            };
                            
                        },
                        
                        error : function(){
                            alert("잘못된 학생 정보입니다.");
                        }
                        
                    });
                };
                
                var timer;
                
                function startTimer(){
                	
                	clearInterval(timer);
                	
                    var time = 30;
                    var min = "";
                    var sec = "";
                    
                    timer = setInterval(function(){
                    	
                    	min = parseInt(time/60);
                    	
                    	sec = time%60;
                    	
                    	$("#checkDiv>#timer").html(min+"분"+sec+"초");
                    	
                    	time--;
                    	
                    	if(time < 0){
                    		clearInterval(timer);
                    		hide();
                    	}
                    	
                    },1000);
                };
                
                function hide(){
                	$("#checkDiv").hide();
                	$("#footer_btn2").hide();
                	$("#footer_btn").show();
                	$("#checkDiv>#checkEmail").val("");
                };
                
                function plusTime(){
                	startTimer();
                };
         	</script>
    </div>
</body>
</html>

