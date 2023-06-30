<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>종합정보시스템</title>
<link rel="stylesheet" href="resources/css/studentProfessorMainPage.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/student_menubar.jsp" %>
		<div id="content">
			<div class="c_content">
				<div class="c_content_1">
					<div class="c_content_11">
						<div class="c_content_111">
							<table border="1">
								<tbody>
									<tr>
										<td rowspan="4" width="40%" align="center">
											<c:choose>
												<c:when test="${!empty filePath }">
													<img src="${filePath }" alt="프로필사진" style="width: 70%; height: 80%;">
												</c:when>
												<c:otherwise>
													<img src="resources/icon/profileImg.png" alt="프로필사진" style="width: 70%; height: 80%;">
												</c:otherwise>
											</c:choose>
										</td>
										<td width="60%" style="font-weight: bold;">&nbsp;&nbsp;${loginUser.studentName } (${loginUser.studentNo })</td>
									</tr>
									<tr>
										<td>&nbsp;&nbsp;학과:&nbsp;&nbsp;${loginUser.departmentNo }</td>
									</tr>
									<tr>
										<td>&nbsp;&nbsp;학년:&nbsp;&nbsp;${loginUser.classLevel }</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="c_content_112">
							<div class="c_content_1121">
								<span><i class="fa-solid fa-receipt fa-lg" style="color: #118f00;"></i>&nbsp;&nbsp;등록금 납부 현황</span>&nbsp;&nbsp;&nbsp;
								<a href="listPage.rg"><i class="fa-regular fa-plus fa-xl" style="color: #686e78;"></i></a>
							</div>
							<div class="c_content_1122">
								<div class="c_content_1122_table-area">
									<table border="1">
										<thead>
											<tr>
												<th width="30%">학기</th>
												<th width="45%">금액</th>
												<th width="25%">납부여부</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${!empty regList }">
													<c:forEach var="r" items="${regList }">
														<tr>
															<td>${r.classTerm }</td>
															<td>${r.mustPay }</td>
															<c:if test="${r.payStatus eq 'Y' }">
																<td>납부완료</td>
															</c:if>
															<c:if test="${r.payStatus eq 'O' }">
																<td>초과납부</td>
															</c:if>
															<c:if test="${r.payStatus eq 'D' }">
																<td>금액미달</td>
															</c:if>
															<c:if test="${r.payStatus eq 'N' }">
																<td>미납부</td>
															</c:if>
															
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="3">조회된 데이터가 없습니다.</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					
					<div class="c_content_12"></div>
					
					<div class="c_content_13">
						<div class="c_content_131">
							<span><i class="fa-solid fa-calendar-days fa-lg" style="color: #ffae00;"></i>&nbsp;&nbsp;개인 시간표</span>
							<a href="personalTimetable.st"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
						</div>
						<div class="c_content_132">
							<div class="c_content_1321">
								<a onclick="previousDay();"><i class="fa-solid fa-chevron-left fa-xl" style="color: #686e78;"></i></a>
								<span id="today-date"></span>
								<a onclick="nextDay();"><i class="fa-solid fa-chevron-right fa-xl" style="color: #686e78;"></i></a>
							</div>
							<div class="c_content_1322">
								<p id="today-class">
								</p>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="c_content_2"></div>
				
				
				<div class="c_content_3">
					<div class="c_content_31">
						<div class="c_content_311">
							<span><i class="fa-regular fa-calendar fa-lg" style="color: #d184f5;"></i>&nbsp;&nbsp;이번 달 학사일정</span>
							<a href="haksaSchedule.mp"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
						</div>
						<div class="c_content_312">
							<div class="c_content_312_table-area">
								<table border="1">
									<thead>
										<tr>
											<th width="18%">시작</th>
											<th width="18%">마감</th>
											<th width="64%">내용</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
												<c:when test="${!empty calList }">
													<c:forEach var="cal" items="${calList }">
														<tr>
															<td height="32px">${cal.start }</td>
															<td>${cal.end }</td>
															<td>${cal.title }</td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="3">조회된 데이터가 없습니다.</td>
													</tr>
												</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="c_content_32"></div>
					
					<div class="c_content_33">
						<div class="c_content_331">
							<span><i class="fa-solid fa-check fa-lg" style="color: #ff5024;"></i>&nbsp;&nbsp;공지사항</span>
							<a href="notice.mp" style="float:right;"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
						</div>
						<div class="c_content_332">
							<div class="c_content_332_table-area">
								<table border="1">
									<tbody>
										<c:choose>
											<c:when test="${!empty nList }">
												<c:forEach var="n" items="${nList }">
													<tr>
														<td width="80%" height="50px">${n.noticeTitle }</td>
														<td width="20%">${n.createDate }</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="2">조회된 데이터가 없습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<script>
						$(function() {
							var today = new Date();
							var year = today.getFullYear();
							
							var month = today.getMonth() + 1;
							if(month<10) {
								month = "0" + month.toString();
							}
							
							var date = today.getDate();
							if(date<10) {
								date = "0" + date.toString();
							}
							
							var fullWeek = ['일', '월', '화', '수', '목', '금', '토'];
							var day = fullWeek[today.getDay()];
							
							var $today = year + "-" + month + "-" + date + " (" + day + ")";
							$("#today-date").text($today);
							
							getClasses(today.getDay());
						})
						
						function previousDay() {
							var today = new Date($("#today-date").text());
							var day = today.setDate(today.getDate()-1); // 전 날
							makeDay(day);
						}
						
						function nextDay() {
							var today = new Date($("#today-date").text());
							var day = today.setDate(today.getDate()+1); // 다음 날
							makeDay(day);
						}
						
						function makeDay(day) {
							var theDay = new Date(day);
							
							var year = theDay.getFullYear();
							
							var month = theDay.getMonth() + 1;
							if(month<10) {
								month = "0" + month.toString();
							}
							
							var date = theDay.getDate();
							if(date<10) {
								date = "0" + date.toString();
							}
							
							var fullWeek = ['일', '월', '화', '수', '목', '금', '토'];
							var day = fullWeek[theDay.getDay()];
							
							var $today = year + "-" + month + "-" + date + " (" + day + ")";
							$("#today-date").text($today);
							getClasses(theDay.getDay());
						}
						
						function getClasses($day) {
							$.ajax({
								url: "getClasses.st",
								success: function(cList) {
									var str = "";
									for(var i=0;i<cList.length;i++) {
										if(cList[i].day == $day) {
											switch(cList[i].period) {
												case '1':
													str += '09:00';
													break;
												case '2':
													str += '10:00';
													break;
												case '2':
													str += '11:00';
													break;
												case '3':
													str += '12:00';
													break;
												case '4':
													str += '13:00';
													break;
												case '5':
													str += '14:00';
													break;
												case '6':
													str += '15:00';
													break;
												case '7':
													str += '16:00';
													break;
												case '8':
													str += '17:00';
													break;
												case '9':
													str += '18:00';
													break;
												case '10':
													str += '19:00';
													break;
											}
											str += "&nbsp;&nbsp;" + cList[i].className + "<br>";
										}
									}
									
									if(str == "") {
										str = "수업이 없습니다.";
									}
									$("#today-class").html(str);
								},
								error: function() {
									console.log("통신 오류");
								}
							})
						}
					</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>