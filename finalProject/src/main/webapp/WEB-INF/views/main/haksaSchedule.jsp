<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/haksaSchedule.css">
</head>
<body>
<div class="wrap">
	<%@include file="../common/mainPageHeader.jsp" %>
	
	<div id="content">
		<div id="content_title">
			<h3>학사일정</h3>
		</div>
		
		<div id="calendar-container">
			<p id="year">2023</p>
		
			<%-- 3월 학사일정 --%>
			<div class="month" style="height: 200px; border-top: 3px solid lightgray;">
				<p>3월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week"  style="border-top: 3px solid lightgray;">
					<p>3/2(목)</p>
				</div>
							
				<div class="content"  style="border-top: 3px solid lightgray;">
					<p>2023학년도 1학기 개강</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>3/2(목) ~ 6(월)</p>
				</div>
							
				<div class="content">
					<p>조기졸업 신청기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>3/8(수) ~ 9(월)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 1학기 수강신청 최종 정정기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>3/28(화) ~ 4/11(화)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 1학기 중간 강의평가 기간</p>
				</div>
			</div>
			
			<%-- 4월 학사일정 --%>
			<div class="month" style="height: 100px;">
				<p>4월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>4/10(월) ~ 14(금)</p>
				</div>
							
				<div class="content">
					<p>2022학년도 후기 졸업예정자 졸업논문 제출기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>4/20 (목)</p>
				</div>
							
				<div class="content">
					<p>입대휴학자의 학기인정 기준일</p>
				</div>
			</div>
			
			<%-- 5월 학사일정 --%>
			<div class="month" style="height: 150px;">
				<p>5월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>5/15(월) ~ 18(목)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 여름 계절학기 신청기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>5/15(월) ~ 19(금)</p>
				</div>
							
				<div class="content">
					<p>다중.복수.연계.부전공 신청 및 포기기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>5/30(화) ~ 6/29(목)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 1학기 기말 강의평가기간</p>
				</div>
			</div>
			
			<%-- 6월 학사일정 --%>
			<div class="month" style="height: 300px;">
				<p>6월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>6/7(수) ~ 9(금)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 재입학 접수기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>6/13(화) ~ 29(목)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 1학기 성적입력 및 열람기간 (이의신청 및 정정포함)</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>6/21(수)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 1학기 종강</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>6/22(목)</p>
				</div>
							
				<div class="content">
					<p>보강가능일</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>6/23(금) ~ 7/13(목)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 여름 계절학기</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>6/23(금) ~ 8/31(목)</p>
				</div>
							
				<div class="content">
					<p>하계방학</p>
				</div>
			</div>
			
			<%-- 7월 학사일정 --%>
			<div class="month" style="height: 150px;">
				<p>7월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>7/10(월) ~ 14(금)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 1학기 학사학위취득유예 신청기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>7/10(월) ~ 21(금)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 휴∙복학 신청기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>7/31(월) ~ 8/2(수)</p>
				</div>
							
				<div class="content">
					<p>2022학년도 후기 졸업사정</p>
				</div>
			</div>
			
			<%-- 8월 학사일정 --%>
			<div class="month" style="height: 150px;">
				<p>8월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>8/4(금) ~ 11(금)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 수강신청기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>8/16(수)</p>
				</div>
							
				<div class="content">
					<p>2022학년도 후기 학위수여식</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>8/17(목)</p>
				</div>
							
				<div class="content">
					<p>2022학년도 후기 학위수여식</p>
				</div>
			</div>
			
			<%-- 9월 학사일정 --%>
			<div class="month" style="height: 200px;">
				<p>9월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>9/1(금)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 개강</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>9/1(금) ~ 5(화)</p>
				</div>
							
				<div class="content">
					<p>조기졸업 신청기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>9/7(목) ~ 8(금)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 수강신청 최종 정정기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>9/27(수) ~ 10/11(수)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 중간 강의평가 기간</p>
				</div>
			</div>
			
			<%-- 10월 학사일정 --%>
			<div class="month" style="height: 100px;">
				<p>10월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>10/10(화) ~ 13(금)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 전기 졸업예정자 졸업논문 제출기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>10/20(금)</p>
				</div>
							
				<div class="content">
					<p>입대휴학자의 학기인정 기준일</p>
				</div>
			</div>
			
			<%-- 11월 학사일정 --%>
			<div class="month" style="height: 200px;">
				<p>11월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>11/6(월) ~ 10(금)</p>
				</div>
							
				<div class="content">
					<p>2024학년도 1학기 재입학 접수기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>11/13(월) ~ 16(목)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 겨울 계절학기 신청기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>11/13(월) ~ 17(금)</p>
				</div>
							
				<div class="content">
					<p>다중.복수.연계.부전공 신청 및 포기기간</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>11/29(수) ~ 12/28(목)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 기말 강의평가 기간</p>
				</div>
			</div>
			
			<%-- 12월 학사일정 --%>
			<div class="month" style="height: 200px; border-bottom: 3px solid lightgray;">
				<p>12월</p>
			</div>
			
			<div class="row-content">
				<div class="day-week">
					<p>12/12(화) ~ 28(목)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 성적입력 및 열람기간 (이의신청 및 정정포함)</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>12/21(목)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 2학기 종강</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week">
					<p>12/22(금) ~ 1/15(월)</p>
				</div>
							
				<div class="content">
					<p>2023학년도 겨울 계절학기</p>
				</div>
			</div>
			<div class="row-content">
				<div class="day-week" style="border-bottom: 3px solid lightgray;">
					<p>12/22(금) ~ 2/29(목)</p>
				</div>
							
				<div class="content" style="border-bottom: 3px solid lightgray;">
					<p>동계방학</p>
				</div>
			</div>
			
		</div>
	</div>
	
	<%@include file="../common/mainPageFooter.jsp" %>
</div>
</body>
</html>