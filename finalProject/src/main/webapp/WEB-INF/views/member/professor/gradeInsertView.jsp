<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성적 관리</title>
<style>
    .b_line {
        border: 0.5px solid lightgray;
        margin: 20px 0px;
    }

    .page_title {
        margin-top: 5px;
        margin-left: 5px;
        margin-bottom: 0px;
        font-weight: bold;
    }

    .selectTerm {
        display: flex;
        align-items: center;
    }

    .selectTerm * {
        margin-left: 10px;
    }

    #selectList {
        border-radius: 10px;
        margin-left: 30px;
    }

    .student-area {
        width: 100%;
        height: 80%;
        overflow: auto;
    }

    .student-table {
        width: 100%;
        height: 100%;
        text-align: center;
    }

    .student-table>thead {
        background-color: rgb(250, 250, 133);
        position: sticky;
        top: 0;
    }
</style>
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/professor_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">수업관리</span>
                </div>
                <div class="child_title">
                    <a href="#">성적 이의신청 조회</a>
                </div>
                <div class="child_title">
                    <a href="#" style="color:#00aeff;">성적 관리</a>
                </div>
            </div>
            <div id="content_1">
				<br>
				<span class="page_title">성적 관리</span>
                <div class="b_line"></div>

                <div class="selectTerm">
                    <span>학년도: </span> <select name="year" id="year" onchange="changeYear();">
                                            <option value="2022">2022학년도</option>
                                            <option value="2021">2021학년도</option>
                                            <option value="2020">2020년도</option>
                                        </select>
                    <span>학기: </span> <select name="term" id="term">
                                            <option value="1">1학기</option>
                                            <option value="2">2학기</option>
                                       </select>
                    <span>교과목명: </span> <select name="term" id="term">
                                                <option value="알고리즘A"> 알고리즘A </option>
                                                <option value="알고리즘B"> 알고리즘B </option>
                                            </select>
                    <button type="button" class="btn btn-primary btn-sm" id="selectList">조회</button>
                </div>
                <br>

                <div class="student-area">
                    <table class="student-table">
                        <thead>
                            <tr>
                                <th>학과</th>
                                <th>학번</th>
                                <th>학년</th>
                                <th>이름</th>
                                <th>성적</th>
                                <th>등급</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <!--20명-->
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr>
                            <!--25명까지 스크롤 안 생김-->
                            <!-- <tr>
                                <td>컴퓨터공학과</td>
                                <td>20211111</td>
                                <td>2학년</td>
                                <td>김가영</td>
                                <td>94</td>
                                <td>A0</td>
                            </tr> -->

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>