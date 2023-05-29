<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /*===========카테고리 영역=============*/
    #cate_title{
        width: 100%;
        height: 9%;
        font-size: 35px;
        border-bottom: 1px solid black;
        position: relative;
    }
    #cate_title>h3{
        margin: 0%;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
    }
    .child_title{
        display: flex;
        align-items: center;
        width: 100%;
        height: 6%;
        border-bottom: 1px solid black;
        text-align: center;
        font-size: 25px;
    }
    .child_title a{
        margin-left: 50px;
        text-decoration: none;
        color: black;
    }
</style>
</head>
<body>
    <div class="wrap">
    	<%@include file="student_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <h3>큰제목</h3>
                </div>
                <div class="child_title">
                    <a href="">소제목</a>
                </div>
            </div>
            <div id="content_1">
				개인 구현
            </div>
        </div>
    </div>
</body>
</html>