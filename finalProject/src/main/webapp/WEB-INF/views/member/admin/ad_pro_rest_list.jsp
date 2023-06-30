<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/adminProfessorRestList.css">
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/admin_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="enrollStudent.ad">학생 관리</a>
                </div>
				<div class="child_title">
                    <a href="enrollProfessor.ad">임직원 관리</a>
                </div>
                <div class="child_title">
                    <a href="calendarView.ad">학사일정 관리</a>
                </div>
                <div class="child_title">
                    <a href="stuRestList.ad">휴/복학 관리</a>
                </div>
                <div class="child_title">
                    <a href="proRestList.ad" style="color:#00aeff; font-weight: 550;">안식/퇴직 관리</a>
                </div>
            </div>
            <div id="content_1">
            	<span id="content_title">안식/퇴직 조회</span>
            	
                <div style="border-top:2px solid lightblue;" align="center">
                    <table id="rest_list" class="table " border="2" style="width: 80%;margin-top:2%;text-align: center;">
                        <thead>
                            <tr>
                            	<th width="11%">신청번호</th>
                                <th width="14%">신청년도일자</th>
                                <th width="11%">직번</th>
                                <th width="9%">교수명</th>
                                <th width="16%">종류(안식/퇴직)</th>
                                <th width="13%">예정일</th>
                                <th width="13%">복귀일</th>
                                <th width="13%">처리상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                            	<c:when test="${empty list}">
                            		<tr>
                            			<td colspan="8">조회된 신청 내역이 없습니다.</td>
                            		</tr>
                            	</c:when>
                            	<c:otherwise>
                            		<c:forEach var="r" items="${list}">
                            		<tr>
                            			<td>${r.restNo}</td>
                            			<td>${r.requestDate }</td>
                            			<td>${r.professorNo }</td>
                            			<td>${r.professorName }
                            			<td>${r.category eq 0 ?'퇴직':'안식휴가' }</td>
                            			<td>${r.startDate }</td>
                            			<td>${r.endDate eq null ?'퇴직': r.endDate}</td>
                            			<td>${r.status eq 'B'? '승인대기중':r.status eq 'Y'? '승인완료':'비승인'}</td>
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
    <script>
    	$(function(){
    		$("#rest_list>tbody>tr").click(function(){
    			var restNo = $(this).children().eq(0).text();
    			if(restNo!='조회된 신청 내역이 없습니다.'){
    				location.href="proRestDetail.ad?restNo="+restNo;
    			}
    		})
    	})
    </script>
</body>
</html>