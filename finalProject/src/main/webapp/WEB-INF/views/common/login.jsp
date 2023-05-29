<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/login.css">
    <title>Document</title>
</head>
<body>
    <div class="wrap">
        <div class="content">

            <form action="login.me" method="post">
            
                <h2>통합 LOGIN</h2>

                <div id="userNo_area">
                    <span class="left_span"><label for="userNo">아이디</label></span>
                    <br>
                    <input type="text" name="userNo" id="userNo" placeholder="직번/학번을 입력하세요">
                </div>

                <div id="userPwd_area">
                    <span class="left_span"><label for="userPwd">비밀번호</label></span>
                    <br>
                    <input type="password" name="userPwd" id="userPwd" placeholder="비밀번호를 입력하세요">
                </div>

                <div id="save_userNo_area">
                    <input type="checkbox" name="saveUserNo" id="save_userNo">
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
                    <span class="left_span"><a href="">ID찾기></a></span>
                    <span class="right_span"><a href="">비밀번호 초기화></a></span>
                </div>
                
            </form>
        </div>
    </div>
</body>
</html>

