<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<title>종합정보시스템</title>
    <link rel="stylesheet" href="/fin/resources/css/infoSystemMain.css">
</head>
<body>
	<div class="wrap">
	    <div id="content_1">
	        <div id="left_area">
	            <div id="logo_area">
	                <img src="resources/icon/blue_logo_text.png">
	            </div>
	            <div id="login_area">
	                <button type="button" id="login_btn" onclick="location.href='login.me'">로그인</button> <br>
	            	<button type="button" class="forgot_btn" onclick="location.href='searchIdForm.me?num=1'">아이디 찾기</button> /
	            	<button type="button" class="forgot_btn" onclick="location.href='resetPwdForm.me?num=1'">비밀번호 초기화</button>
	            </div>
	            <div>
	                <p>(07212) 서울특별시 영등포구 선유동2로 57 이레빌딩</p>
	            </div>
	        </div>
	    </div>
	    <div id="content_2">
	        <div id="right_area">
	            <input type="radio" id="notice_btn" name="tab" checked>
	            <label for="notice_btn">공지사항</label>
	
	            <input type="radio" id="faq_btn" name="tab">
	            <label for="faq_btn">자주묻는질문</label>
	
	            <div id="board_area">
	                <section id="notice_section">
	                    <table>
	                        <tr>
	                            <td>공지사항입니다.</td>
	                        </tr>
	                    </table>
	                </section>
	                
	                <section id="faq_section">
	                    <table>
	                        <tr>
	                            <td>FAQ입니다.</td>
	                        </tr>
	                    </table>
	                </section>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>