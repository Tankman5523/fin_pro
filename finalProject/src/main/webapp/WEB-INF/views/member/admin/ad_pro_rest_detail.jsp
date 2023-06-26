<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
                    <a href="#">임직원 관리</a>
                </div>
                <div class="child_title">
                    <a href="#">학사일정 관리</a>
                </div>
                <div class="child_title">
                    <a href="stuRestList.ad">휴/복학 신청 관리</a>
                </div>
                <div class="child_title">
                    <a href="proRestList.ad" style="color:#00aeff; font-weight: 550;">안식/퇴직 관리</a>
                </div>
            </div>
            <div id="content_1">
            	<c:choose>
            		<c:when test="${pr.category eq 1}">
            			<h3>안식 신청 정보</h3>
            		</c:when>
            		<c:otherwise>
            			<h3>퇴직 신청 정보</h3>
            		</c:otherwise>
            	</c:choose>
                    <div>
                        <table>
                            <tr>
                                <td>대학</td>
                                <td><input type="text" name="collegeNo" value="${p.collegeNo}" readonly></td>
                                <td>학과</td>
                                <td><input type="text" name="departmentNo" value="${p.departmentNo}" readonly></td>
                            </tr>
                            <tr>
                                <td>성명</td>
                                <td><input type="text" name="professorName" value="${p.professorName}" readonly></td>
                                <td>연락처</td>
                                <td><input type="text" name="phone" value="${p.phone}" readonly></td>
                            </tr>
                            <tr>
                                <td>채용일자</td>
                                <td><input type="text" name="address" value="${p.entranceDate}" readonly></td>
                                <td>주소</td>
                                <td><input type="text" name="address" value="${p.address}" readonly></td>
                            </tr>
                            <tr>
                                <td>현재 근속 년수</td>
                                <td><input type="text" id="jobYear" readonly></td>
                                <td>안식 기간</td>
                                <td>
                                    <input type="text" name="startDate" value="${pr.startDate}" readonly>
                                    <c:if test="${pr.category eq 1}">
	                                    ~
	                                    <input type="text" name="endDate" value="${pr.endDate }" readonly>
                                    </c:if>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        	기타 참고사항:
                    </div>
                    <textarea name="reason" id="" cols="100" rows="5" style="resize: none;" readonly>${pr.reason}</textarea>
                    <br>
                    <div style="text-align: center;">
                        <button type="reset" class="btn btn-secondary" onclick="updateProRest(N);">반려</button>
                        <button type="submit" class="btn btn-primary" onclick="updateProRest(Y);">승인</button>
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
	    		
	    		$("#jobYear").val(jobYear+"년"+"("+diff+"일)");
	    })
	    
	    function updateProRest(status){
	  		var restNo = ${pr.restNo}; //상담번호
	  		location.href="updateProRest.ad?restNo"+restNo+"&status="+status;
	  	}
	    
  	</script>
</body>
</html>