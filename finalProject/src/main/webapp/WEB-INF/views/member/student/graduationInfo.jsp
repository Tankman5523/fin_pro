<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>졸업사정표 : Feasible University</title>
<link rel="stylesheet" href="resources/css/graduationInfoForm.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/student_menubar.jsp" %>
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
                    <a href="#">휴/복학 신청</a>
                </div>
                <div class="child_title">
                    <a href="#">휴/복학 조회</a>
                </div>
                <div class="child_title">
                    <a href="graduationInfoForm.st" style="color:#00aeff; font-weight: 550;">졸업 사정표</a>
                </div>
                <div class="child_title">
                    <a href="#">졸업 확정 신고</a>
                </div>
            </div>
            <div id="content_1">
            	<div id="main_div">
            		<div class="subDiv" id="sub_div1">
	            		<span class="mainSpan">학생정보</span>
	            		<hr>
	            		<table>
		            		<tr>
		            			<td>학번 : <input type="text" readonly></td>
		            			<td>성명 : <input type="text" readonly></td>
		            			<td>학년 : <input type="text" readonly></td>
		            		</tr>
		            		<tr>
		            			<td>소속 : <input type="text" readonly></td>
		            			<td>전공 : <input type="text" readonly></td>
		            			<td>학적상태 : <input type="text" readonly></td>
		            		</tr>
		            		<tr>
		            			<td>인정학점 : <input type="text" readonly></td>
		            			<td>이수학기 : <input type="text" readonly></td>
		            			<td>입학년도 : <input type="text" readonly></td>
		            			<td>졸업사정일자 : <input type="text" readonly></td>
		            		</tr>
	            		</table>
            		</div>
            		<div class="subDiv" id="sub_div2">
            			<span class="mainSpan">Info</span>
            			<hr>
            			<div id="infoDiv">
            				- 상단의 졸업사정일자를 기준으로 반영한 내용이며 이후의 변경사항은 다음 졸업사정일에 반영됩니다.<br>
            				- 전체 이수 과목 내역을 보려면, '과목 상세 내역 보기' 를 눌러주세요.<br>
            				- 이수 구분 변경 신청은 졸업예정자(졸업학점 120학점 이상 이수 중인 4-2학기 재학생 및 조기졸업대상자)만 가능합니다.<br>
            				- 졸업논문/시험/대체 자격증 등은 학과 사무실에 문의 부탁드립니다.
            			</div>
            		</div>
            		<div class="subDiv" id="sub_div3">
            			<span class="mainSpan">졸업사정결과</span>
            			<hr>
            		</div>
            	</div>
            </div>
		</div>
	</div>
</body>
</html>