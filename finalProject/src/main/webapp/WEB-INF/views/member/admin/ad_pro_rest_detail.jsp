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
                <div class="child_title">
				    <a href="selectNotice.ad">공지사항 관리</a>
				</div>
            </div>
            <div id="content_1">
            	<c:choose>
            		<c:when test="${pr.category eq 1}"><!-- 안식 휴가 신청인지 퇴직 신청인지 -->
            			<span id="content_title">안식 정보</span>
            		</c:when>
            		<c:otherwise>
            			<span id="content_title">퇴직 정보</span>
            		</c:otherwise>
            	</c:choose>
                    <div id="content_top" align="center">
                     	<div id="content_middle">
	                        <table style="width:80%;" class="table">
	                            <tr>
	                                <td>대학</td>
	                                <td><input type="text" name="collegeNo" value=": ${p.collegeNo}" readonly></td>
	                                <td>학과</td>
	                                <td><input type="text" name="departmentNo" value=": ${p.departmentNo}" readonly></td>
	                            </tr>
	                            <tr>
	                                <td>성명</td>
	                                <td><input type="text" name="professorName" value=": ${p.professorName}" readonly></td>
	                                <td>연락처</td>
	                                <td><input type="text" name="phone" value=": ${p.phone}" readonly></td>
	                            </tr>
	                            <tr>
	                                <td>채용일자</td>
	                                <td><input type="text" name="address" value=": ${p.entranceDate}" readonly></td>
	                                <td>주소</td>
	                                <td><input type="text" name="address" value=": ${p.address}" readonly></td>
	                            </tr>
	                            <tr>
	                                <td>현재 근속 년수</td>
	                                <td><input type="text" id="jobYear" readonly></td>
	                                <td>안식 기간</td>
	                                <td>
	                                    <input type="text" id="startDate" value=": ${pr.startDate}" readonly>
	                                    <c:if test="${pr.category eq 1}">
		                                    ~
		                                    <input type="text" id="endDate" value="${pr.endDate }" readonly>
	                                    </c:if>
	                                </td>
	                            </tr>
	                        </table>
                        	<span style="font-size:20px;">기타 참고사항:</span>
                        	<br>
                    <textarea name="reason" id="" cols="100" rows="5" style="resize: none;" readonly>${pr.reason}</textarea>
                    </div>
                    <br>
                    <div id="btn_area">
                    	<c:choose>
                    	<c:when test="${pr.status eq 'B'}">
	                        <button type="reset" class="btn btn-danger btn-lg" onclick="updateProRest('N');">반려</button>
	                        <button type="submit" class="btn btn-primary btn-lg" onclick="updateProRest('Y');">승인</button>
                    	</c:when>
                    	<c:otherwise><!-- 이미 승인하거나 반려했다면 뒤로 돌아가는 버튼 보여줌 -->
                    		<input type="button" value="돌아가기" class="btn btn-secondary btn-lg" onclick="history.back();" />
                    	</c:otherwise>
                    	</c:choose>
                    </div>
        	</div>
     	</div>
     </div>
</div>
<script>
	  	$(function(){
	    		var today = new Date();//현재 날짜
	    		var enter = new Date('${p.entranceDate}');//입사일
	    		var diff = Math.abs(today.getTime()-enter.getTime());
	    		diff = Math.ceil(diff / (1000 * 60 * 60 * 24));//근속일
	    		
	    		var jobYear = Math.floor(((diff/365)*100)/100); //근속 년수
	    		
	    		$("#jobYear").val(": "+jobYear+"년"+"("+diff+"일)");
	    })
	    
	    function updateProRest(status){
	  		var restNo = ${pr.restNo}; //상담번호
	  		console.log(restNo);
	  		location.href="updateProRest.ad?restNo="+restNo+"&status="+status;
	  	}
	    
  	</script>
</body>
</html>