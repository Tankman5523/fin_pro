<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생</title>
</head>
<body>
    <div class="wrap">
        <!--===============================메뉴바-===============================-->
    	<%@include file="../../../common/admin_menubar.jsp" %>
        <!--===============================메뉴바-===============================-->
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">등록/장학</span>
                </div>
                <div class="child_title">
                    <a href="#">등록금 납부조회</a>
                </div>
                <div class="child_title">
                    <a href="#">등록금납입 이력</a>
                </div>
                <div class="child_title">
                    <a href="#">장학금 수혜내역</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <!--이름/학번 로그인 세션에서 가져오기-->
                    <label for="classNo">학번</label><input type="text" name="classNo" id="classNo" value="${loginUser.studentNo}" readonly>
                    <br>
                    <label for="studentName">이름</label><input type="text" name="studentName" id="studentName" value="${loginUser.studentName}" readonly>
                    <br>
                    <label for="classTerm">학기</label>
                    <select name="classTerm" id="classTerm">
                        <option value="0">=전체=</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                    </select>
                    <!--최초 현재월 입력--> 
                    <label for="startDate">납부기간</label><input type="date" name="startDate" id="startDate" required> 
                    <label for="endDate"> ~ </label><input type="date" name="endDate" id="endDate" required>
                    <!--버튼 클릭시 ajax로 값 가지고가서 처리-->
                    <button>조회</button>
                    <br><br>
                    <table border="1" style="width: 100%;">
                        <thead style="background-color: bisque;">
                            <tr>
                                <th>납부일</th>
                                <th>납부시간</th>
                                <th>학번</th>
                                <th>성명</th>
                                <th>입금금액</th>
                                <th>입금계좌</th>
                                <th>입금한계좌(학생)</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:choose>
                        		<c:when test="${not empty list}">
                        			<c:forEach items="list" var="r">
			                            <tr>
			                                <td>${r.payDate}</td><!--연월일까지 자르기-->
			                                <td>${r.payDate}</td><!--시간자르기-->
			                                <td>${r.studentNo}</td>
			                                <td>${r.studentName}</td>
			                                <td>${r.mustPay}</td>
			                                <td>${r.regAccountNo}</td>
			                                <td>${r.payAccountNo}</td>
			                                <td>${r.payStatus}</td>
			                            </tr>
		                            </c:forEach>
	                            </c:when>
	                            <c:otherwise>
	                            	<tr>
	                            		<td colspan="8">데이터가 없습니다.</td>
	                            	</tr>
	                            </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>