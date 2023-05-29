<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	div{
	    box-sizing: border-box;
	}
	.wrap{
	    width: 1400px;
	    height: 1400px;
	    margin: auto;
	    border: 1px solid lightblue;
	}
	.wrap>div{
	    width: 100%;
	}
	#header{
	    height: 10%;
	    background-color: red;
	}
	#menubar{
	    height: 5%;
	    background-color: orange;
	}
	#content{
	    width: 100%;
	    height: 90%;
	    background-color: yellow;
	}
	#header_1{
	    height: 65%;
	}
	#category{
	    width: 20%;
	    height: 100%;
	    background-color: aqua;
	    float: left;
	}
	#content_1{
	    width: 80%;
	    height: 100%;
	    float: right;
	    background-color: blueviolet;
	}
	/*=========메뉴바 영역===========*/
    #nav{
        margin: 0%;
        padding: 0%;
        list-style-type: none;
    }
    #nav>li{
        width: 10%;
        height: 100%;
        display: inline-block;
        line-height: 70px;
        text-align: center;
        vertical-align: top;
    }
    #menubar a{
        width: 100%;
        height: 100%;
        display: block;
        text-decoration: none;
        font-size: 23px;
        font-weight: bold;
        color: black;
    }
    /*===============로그인 유저============*/
	#user_log{
	    margin: 0 50px;
	    float: right;
	    line-height: 137px;
	}
	#user_log td{
	    text-align: right;
	}
	#logout-btn{
	    width: 80px;
	    height: 30px;
	    border: none;
	    border-radius: 5px;
	    background-color: #4fc7ff;
	    /* color: white; */
	    font-weight: bold;
	}
</style>	
<body>
	<div id="header">
	    <div id="header_1">
	        <table id="user_log">
                 <tr>
                     <td>
						${loginUser.professorName} 님 환영합니다.
                     </td>
                     <td style="padding-left: 50px;">
                         <button id="logout-btn" onclick="">로그아웃</button>
                     </td>
                 </tr>
             </table>
	    </div>
	</div>
	<div id="menubar">
	    <ul id="nav">
            <li><a href="#">홈</a></li>
            <li><a href="#">등록/장학</a></li>
            <li><a href="#">학사관리</a></li>
            <li><a href="#">상담관리</a></li>
            <li><a href="#">강의관리</a></li>
            <li><a href="#">수업관리</a></li>
        </ul>
	</div>
</body>
</html>