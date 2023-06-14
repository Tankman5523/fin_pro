<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의신청 조회</title>
</head>
<body>
     <div class="wrap">
    	<%@include file="../../common/professor_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">큰제목</span>
                </div>
                <div class="child_title">
                    <a href="#">소제목</a>
                </div>
            </div>
            <div id="content_1">
                <h4>강의 개설정보</h4>
                <div align="center">

                    <table border="1" style="width:80%; text-align: center;">
                        <thead>

                            <tr>
                                <th>강의번호</th>
                                <th>전공/교양</th>
                                <th>학과</th>
                                <th>강의명</th>
                                <th>학년도</th>
                                <th>학기</th>
                                <th>강의실</th>
                                <th>강의시간(요일포함)</th>
                                <th>수강대상</th>
                                <th>수강인원</th>
                                <th>이수학점</th>
                                <th>개설여부</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>50</td>
                                <td>전공</td>
                                <td>세무회계과</td>
                                <td>회계원리</td>
                                <td>2023</td>
                                <td>2학기</td>
                                <td>태양관502호</td>
                                <td>
                                    14:00~16:00<br>
                                    (월)
                                </td>
                                <td>1학년</td>
                                <td>32</td>
                                <td>3</td>
                                <td>개설완료</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>