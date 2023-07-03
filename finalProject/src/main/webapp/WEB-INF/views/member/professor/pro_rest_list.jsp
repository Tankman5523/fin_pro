<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안식 신청 조회</title>
<link rel="stylesheet" href="/fin/resources/css/professorRestView.css">
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/professor_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%>
    	<%@include file="../../common/datepicker.jsp" %>  
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="infoProfessor.pr">교수 정보 관리</a>
                </div>
				<div class="child_title">
                    <a href="classListView.pr">강의 시간표</a>
                </div>
				<div class="child_title">
                    <a href="personalTimetable.pr">개인 시간표</a>
                </div>
				<div class="child_title">
                    <a href="professorRestList.pr" style="color:#00aeff; font-weight: 550;">안식/퇴직 신청 조회</a>
                </div>
				<div class="child_title">
                    <a href="professorRestEnroll.pr">안식/퇴직 신청</a>
                </div>
            </div>
            <div id="content_1">
				<span id="content_title">안식/퇴직 신청 내역</span>
                <div style="border-top:2px solid lightblue;" align="center">
                    <table id="rest_list2" border="2" class="table" style="width: 80%;margin-top:2%;text-align: center;">
                        <thead>
                            <tr>
                                <th>종류(안식/퇴직)</th>
                                <th>신청년도일자</th>
                                <th>직번</th>
                                <th>예정일</th>
                                <th>복귀일</th>
                                <th>처리상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                            	<c:when test="${empty list}">
                            		<tr>
                            			<td colspan="6">조회된 신청 내역이 없습니다.</td>
                            		</tr>
                            	</c:when>
                            	<c:otherwise>
                            		<c:forEach var="r" items="${list}">
                            		<tr>
                            			<td>${r.category eq 0 ?'퇴직':'안식' }</td>
                            			<td>${r.requestDate }</td>
                            			<td>${r.professorNo }</td>
                            			<td>${r.startDate }</td>
                            			<td>${r.endDate eq null ?'퇴직': r.endDate}</td>
                            			<td>
                            				<c:choose>
		                            			<c:when test="${r.status eq 'B'}">
		                            				<span style="color:blue;">승인대기중</span>
		                            			</c:when>
		                            			<c:when test="${r.status eq 'Y'}">
		                            				<span style="color:green;">승인완료</span>
		                            			</c:when>
		                            			<c:otherwise>
		                            				<span style="color:red;">비승인</span>
		                            			</c:otherwise>
		                            		</c:choose>
                            			</td>
                            		</tr>
                            		</c:forEach>
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