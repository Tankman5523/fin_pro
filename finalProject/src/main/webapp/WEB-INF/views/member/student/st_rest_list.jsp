<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴,복학 신청 조회 페이지</title>
</head>
<body>
    <div class="wrap">
    	<%@include file="../../common/student_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="infoStudent.st">학적 정보 조회</a>
                </div>
				<div class="child_title">
                    <a href="personalTimetable.st">개인 시간표</a>
                </div>
				<div class="child_title">
                    <a href="studentRestEnroll.st">휴/복학 신청</a>
                </div>
				<div class="child_title">
                    <a href="studentRestList.st" style="color:#00aeff; font-weight: 550;">휴/복학 조회</a>
                </div>
				<div class="child_title">
                    <a href="#">졸업사정표</a>
                </div>
				<div class="child_title">
                    <a href="#">졸업 확정 신고</a>
                </div>
            </div>
            <div id="content_1">
				<h4>휴복학 신청 조회</h4>
                <div style="border-top:1px solid;" align="center">

                    <table border="1" style="width:90%; text-align: center; margin-top:5%;">
                        <thead>
                            <tr>
                            	<th>신청일</th>
                                <th>학번</th>
                                <th>신청 목적</th>
                                <th>사유</th>
                                <th>시작일</th>
                                <th>복학예정일</th>
                                <th>처리여부</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:choose>
                        		<c:when test="${not empty list }">
		                        	<c:forEach var="c" items="${list }">
			                        	<tr>
			                        		<td>${c.requestDate }</td>                            
			                                <td>${c.studentNo }</td>
			                                <td>${c.category }</td>
			                                <td>${c.reason }</td>
			                                <td>${c.startDate }</td>
			                                <td>${c.endDate }</td>
			                                <td>${c.status eq 'B'? '처리중':c.status eq 'Y'?'승인':'비승인'}</td>
			                            </tr>
		                        	</c:forEach>
                        		</c:when>
                        		<c:otherwise>
                        			<tr>
                        				<td colspan="7">신청 내역이 없습니다.</td>
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