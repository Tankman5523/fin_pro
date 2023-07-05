<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퇴직 신청 페이지</title>
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
                    <a href="professorRestList.pr">안식/퇴직 신청 조회</a>
                </div>
				<div class="child_title">
                    <a href="professorRestEnroll.pr"  style="color:#00aeff; font-weight: 550;">안식/퇴직 신청</a>
                </div>
            </div>
            <div id="content_1" align="center">
				<span id="content_title">퇴직 신청</span>
				<div id="change_btn">
	                <a href="professorRestEnroll.pr" class="btn btn-success">안식 신청</a>
	                <a href="professorRetireEnroll.pr" class="btn btn-danger">퇴직 신청</a>
                </div>
                <div id="table_out" >
					<form action="professorRestRetire.pr">
						<input type="hidden" name="professorNo" value="${loginUser.professorNo}">
	                        <table id="rest_list" class="table">
	                            <tr>
	                                <td>대학</td>
	                                <td><input type="text" name="collegeNo" value="${loginUser.collegeNo}" readonly></td>
	                                <td>학과</td>
	                                <td><input type="text" name="departmentNo" value="${loginUser.departmentNo}" readonly></td>
	                            </tr>
	                            <tr>
	                                <td>성명</td>
	                                <td><input type="text" name="professorName" value="${loginUser.professorName}" readonly></td>
	                                <td>연락처</td>
	                                <td><input type="text" name="phone" value="${loginUser.phone}" readonly></td>
	                            </tr>
	                            <tr>
	                                <td>채용일자</td>
	                                <td><input type="text" name="entranceDate" value="${loginUser.entranceDate}" readonly></td>
	                                <td>주소</td>
	                                <td><input type="text" name="address" value="${loginUser.address}" readonly></td>
	                            </tr>
	                            <tr>
	                                <td>근속 년수</td>
	                                <td><input type="text" id="jobYear" placeholder="퇴직(예정)일 입력시 계산" readonly></td>
	                                <td>*퇴직 (예정)일</td>
	                                <td>
	                                    <input type="date" name="startDate" id="datepicker1" onchange="retireDate()" data-placeholder="날짜 선택" required>                                 
	                                </td>
	                            </tr>
	                        </table>
	                    <div>
	                        	퇴직 사유:
	                    </div>
	                    <textarea name="reason" id="" cols="100" rows="5" style="resize: none;"></textarea>
	                    <br>
	                    <div id="btn_area">
	                        <button type="reset" class="btn btn-secondary btn-lg">초기화</button>
	                        <button type="submit" class="btn btn-primary btn-lg">신청</button>
	                    </div>
	                </form>
                </div>
            </div>
        </div>
    </div>
    <script >
    	$("#datepicker1").datepicker();
    	
    	function retireDate(){
    		var today = new Date($("#datepicker1").val());//현재 날짜
    		var enter = new Date('${loginUser.entranceDate}');//입사일
    		var diff = Math.abs(today.getTime()-enter.getTime());
    		diff = Math.ceil(diff / (1000 * 60   * 60 * 24));//근속일
    		var jobYear = Math.floor((diff/365)*100)/100; //근속 년수
    		
    		$("#jobYear").val(jobYear+"년"+"("+diff+"일)");
	    }
    </script>
</body>
</html>