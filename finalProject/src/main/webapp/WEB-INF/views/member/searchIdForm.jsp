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
    <title>로그인ID 조회 : 종합정보시스템</title>
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
                <button onclick="searchPhoneForm()">휴대폰 본인인증</button>
                <button onclick="searchEmailForm()">등록된 이메일</button>
            </div>

            <div id="login_footer">
                <button type="button" onclick="location.href='${backPage}'">돌아가기</button>
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
            	<div id="inputDiv">
	                <span class="left_span"><label for="name">이름</label></span>
	                <br>
	            	<input name="name" id=name placeholder="이름" required>
	                <br>
	                <span class="left_span"><label for="phone">휴대폰 번호</label></span>
	                <br>
	            	<input type="number" name="phone" id="phone" placeholder="- 을 제외하고 숫자만 입력해주세요" required>
	                <br>
                </div>
                <div id="checkDiv">
                    <span class="left_span"><label for="checkNum">인증 번호</label></span>
                    <span id="restTime">남은시간 : </span>
                    <span id="timer"></span>
                    <button onclick="plusTime(1);">시간연장</button>
                    <input type="number" name="checkNum" id="checkNum" placeholder="인증번호 6자리를 입력해주세요">
                </div>
                
				<div id="emailDiv">
					<h2>아이디 : <span id="submitEmail"></span></h2>
                </div>
                <input type="hidden" id="ranNum">
                <input type="hidden" id="resultNo">
            </div>

            <div id="login_footer2">
                <button onclick="checkEmail();" id="footer_btn">인증요청</button>
                
                <button onclick="checkSubmit(1);" id="footer_btn2">인증완료</button>
                <button type="button" onclick="backForm(1);">돌아가기</button>
            </div>
            
        </div>
        
        <div class="content" id="content03">
			<h2>로그인ID 조회 - 휴대폰 본인인증</h2>
            
            <span id="text">
				학교에 등록된 이름과 전화번호를 입력해 주세요.
            </span>
                <br>
                <br>
			<div id="input_area2">
            	<div id="inputDiv2">
	                <span class="left_span"><label for="name">이름</label></span>
	                <br>
	            	<input name="name" id=name2 placeholder="이름" required>
	                <br>
	                <span class="left_span"><label for="phone">휴대폰 번호</label></span>
	                <br>
	            	<input type="number" name="phone" id="phone2" placeholder="- 을 제외하고 숫자만 입력해주세요" required>
	                <br>
                </div>
                <div id="checkDiv2">
                    <span class="left_span"><label for="checkSms">인증 번호</label></span>
                    <span id="restTime2">남은시간 : </span>
                    <span id="timer2"></span>
                    <input type="number" name="checkNum2" id="checkNum2" placeholder="인증번호 6자리를 입력해주세요">
                </div>
                
				<div id="SmsDiv">
					<h2>아이디 : <span id="submitSms"></span></h2>
                </div>
                <input type="hidden" id="ranSmsNum">
                <input type="hidden" id="resultSmsNo">
            </div>
			<div id="login_footer3">
                <button onclick="checkPhone()" id="footer_SmsBtn">인증요청</button>
                
                <button onclick="checkSubmit(2);" id="footer_SmsBtn2">인증완료</button>
                <button type="button" onclick="backForm(2);">돌아가기</button>
            </div>
        </div>
        
			<script>
			
				function searchEmailForm(){
					$("#content01").hide();
					$("#content02").show();
				};
				
				function searchPhoneForm(){
					$("#content01").hide();
					$("#content03").show();
				}
				
				function backForm(num){
					if(num == 1){
						$("#content01").show();
						$("#content02").hide();
						$("#footer_btn").show();
						$("#footer_btn2").hide();
						$("#inputDiv").show();
	                    $("#checkDiv").hide();
	                    $("#emailDiv").hide();
	                    $("#content02>#text").show();
	                    clearInterval(timer);
	                    $("#checkDiv>#timer").html("");
	                    $("#name").val("");
	                    $("#phone").val("");
	                    $("#checkNum").val("");
	                    $("#footer_btn2").attr("disabled",false);
					}else{
						$("#content01").show();
						$("#content03").hide();
						$("#footer_SmsBtn").show();
						$("#footer_SmsBtn2").hide();
						$("#inputDiv2").show();
	                    $("#checkDiv2").hide();
	                    $("#SmsDiv").hide();
	                    $("#content03>#text").show();
	                    clearInterval(timer);
	                    $("#name2").val("");
	                    $("#phone2").val("");
	                    $("#checkNum2").val("");
	                    $("#footer_SmsBtn2").attr("disabled",false);
					}
				};
				
                function checkEmail(){
                	
                    $.ajax({
                        
                        url : "checkEmail.me",

                        data : {
                        	name : $("#name").val(),
                            phone : $("#phone").val()
                        },
                        
                        success : function(obj){
                        	
                             if(obj != "null"){
                            	 
                            	var result = JSON.parse(obj);
                            	
                            	$("#ranNum").val(result.ranNum);
                            	$("#resultNo").val(result.resultNo);
                                $("#checkDiv").show();
                                $("#footer_btn").hide();
                                $("#footer_btn2").show();
                                startTimer(1); 
                                
                            }else{
                            	alert("잘못된 학생 정보입니다.");
                            	$("#name").val("");
        	                    $("#phone").val("");
                            };
                            
                        },
                        
                        error : function(){
                            console.log("이메일조회 실패.");
                        }
                        
                    });
                };
                
                function checkPhone(){
                	
                	$.ajax({
                		url : "checkPhone.me",
                		data : {
                			name : $("#name2").val(),
                			phone : $("#phone2").val()
                		},
                		success : function(obj){
                			
                            if(obj != "null"){
                           	 
                            	var result = JSON.parse(obj);
                            	
                            	$("#ranSmsNum").val(result.ranNum);
                            	$("#resultSmsNo").val(result.resultNo);
                                $("#checkDiv2").show();
                                $("#footer_SmsBtn").hide();
                                $("#footer_SmsBtn2").show();
                                startTimer(2); 
                                
                            }else{
                            	alert("잘못된 학생 정보입니다.");
                            	$("#name2").val("");
        	                    $("#phone2").val("");
                            };
                		},
                		error : function(){
                			console.log("휴대폰 인증 실패");
                		}
                	});
                }
                
                var timer;
                
                function startTimer(num){
                	clearInterval(timer);
                	
                    var time = 300;
                    var min = "";
                    var sec = "";
                    
                    if(num == 1){
                    	
	                    timer = setInterval(function(){
	                    	
	                    	min = parseInt(time/60);
	                    	
	                    	sec = time%60;
	                    	
	                    	$("#checkDiv>#timer").html(min+"분"+sec+"초");
	                    	
	                    	time--;
	                    	
	                    	if(time < 0){
	                    		clearInterval(timer);
	                    		hide(1);
	                    	}
	                    	
	                    },1000);
                    }else{
                    	
	                    timer = setInterval(function(){
	                    	
	                    	min = parseInt(time/60);
	                    	
	                    	sec = time%60;
	                    	
	                    	$("#checkDiv2>#timer2").html(min+"분"+sec+"초");
	                    	
	                    	time--;
	                    	
	                    	if(time < 0){
	                    		clearInterval(timer);
	                    		hide(2);
	                    	}
	                    	
	                    },1000);
                    }
                };
                
                function hide(num){
                	if(num == 1){
	                	$("#checkDiv").hide();
	                	$("#footer_btn").show();
	                	$("#footer_btn2").hide();
	                	$("#checkDiv>#checkNum").val("");
                	}else{
                		$("#checkDiv2").hide();
	                	$("#footer_SmsBtn").show();
	                	$("#footer_SmsBtn2").hide();
	                	$("#checkDiv2>#checkNum2").val("");
                	}
                };
                
                function plusTime(num){
                	startTimer(num);
                };
                
                function checkSubmit(num){
                	if(num == 1){
                		
	                	var code = $("#ranNum").val();
	                	var checkCode = $("#checkNum").val();
	                	
	                	if(code == checkCode){
	                		$("#emailDiv").show();
	                		$("#checkDiv").hide();
	                        $("#inputDiv").hide();
	                        $("#content02>#text").hide();
	                		clearInterval(timer);
	                		$("#footer_btn2").attr("disabled",true);
	                        $("#name").val("");
	                        $("#phone").val("");
	                        
	                		var str = $("#resultNo").val();
	                		$("#submitEmail").text(str);
	                		
	                	}else{
	                		alert("인증번호를 다시 입력해 주세요");
	                	}
                	}else{
                		
	                	var code = $("#ranSmsNum").val();
	                	var checkCode = $("#checkNum2").val();
	                	
	                	if(code == checkCode){
	                		$("#SmsDiv").show();
	                		$("#checkDiv2").hide();
	                        $("#inputDiv2").hide();
	                        $("#content03>#text").hide();
	                		clearInterval(timer);
	                		$("#footer_SmsBtn2").attr("disabled",true);
	                        $("#name").val("");
	                        $("#phone").val("");
	                        
	                		var str = $("#resultSmsNo").val();
	                		$("#submitSms").text(str);
	                		
	                	}else{
	                		alert("인증번호를 다시 입력해 주세요");
	                	}
                	}
                	
                };
         	</script>
    </div>
</body>
</html>

