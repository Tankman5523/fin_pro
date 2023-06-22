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
                    <span style="margin: 0 auto;">강의관리</span>
                </div>
                <div class="child_title">
                    <a href="classCreateSelectt.pr">강의개설신청 내역</a>
                </div>
                <div class="child_title">
                    <a href="classCreateEnroll.pr">강의 개설 신청</a>
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
                        	<c:choose>
                        		<c:when test="${empty list }">
                        			<tr>
                        				<td colspan="12">강의 개설 신청 내역이 없습니다.</td>
                        			</tr>
                        		</c:when>
                        	<c:otherwise>
	                        	<c:forEach var="c" items="${list }">
	                        		<tr>
	                        			<td>${c.classNo }</td>
	                        			<td>${c.division eq 0?'전공':'교양'}</td>
	                        			<td>${c.departmentNo }</td>
	                        			<td>${c.className }</td>
	                        			<td>${c.classYear }년</td>
	                        			<td>${c.classTerm }학기</td>
	                        			<td>${c.classroom }</td>
	                        			<td>
	                        				${c.period }<br>
	                        				${c.day }
	                        			</td>
	                        			<td>${c.classLevel eq 0?'전':c.classLevel }학년</td>
	                        			<td>${c.classNos }</td>
	                        			<td>${c.credit }</td>
	                        			<c:choose>
	                        			<c:when test="${c.status eq 'C'}">
	                        				<td><button type="button" onclick="location.href='updateClassCreate.pr?classNo=${c.classNo}'" class="btn btn-warning">반려(수정)</button></td>
	                        			</c:when>
	                        			<c:otherwise>
	                        				<td>${c.status eq 'Y'?'개설완료': c.status eq 'B'?'승인대기중':'학기종료'}</td>
	                        			</c:otherwise>
	                        			</c:choose>
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