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
		<%@include file="../../common/admin_menubar.jsp" %>
		<div id="content">
			<div class="c_content">
				<div class="c_content_1">
					<div class="c_content_11">
						<div class="c_content_112">
							<div class="c_content_1121">
								<span><i class="fa-solid fa-receipt fa-lg" style="color: #118f00;"></i>&nbsp;&nbsp;강의 개설 신청 목록</span>&nbsp;&nbsp;&nbsp;
								<a href="강의개설 리스트 매핑주소"><i class="fa-regular fa-plus fa-xl" style="color: #686e78;"></i></a>
							</div>
							<div class="c_content_1122">
								<div class="c_content_1122_table-area">
									<table border="1">
										<thead>
							                <tr>
							                    <th>신청날짜</th>
							                    <th>학년도</th>
							                    <th>학기</th>
							                    <th>강의시간</th>
							                    <th>학과</th>
							                    <th>수강학년</th>
							                    <th>강의명</th>
							                    <th>교수</th>
							                    <th>개설여부</th>
							                </tr>
							            </thead>
										<tbody>
											<c:choose>
												<c:when test="${!empty classList }">
													<c:forEach var="class" items="${classList }">
														<tr>
															<%-- <td style="display: none;">${class.classNo }</td> --%>
															<td>${class. }</td>
															<td>${class.classYear}</td>
															<td>${class.classTerm}</td>
															<td>${class.period}</td>
															<td>${class.departmentNo}</td>
															<td>${class.classLevel}</td>
															<td>${class.className}</td>
															<td>${class.professorName}</td>
															<td>${class.status}</td>
															
															<c:if test="${class.status eq 'N' }">
																<td style='color: orange; font-weight: bold;'>검토중</td>
															</c:if>
															<c:if test="${class.status eq 'Y' }">
																<td style='color: #0080ff; font-weight: bold;'>개설승인</td>
															</c:if>
															<c:if test="${class.status eq 'C' }">
																<td style='color: red; font-weight: bold;'>개설반려</td>
															</c:if>
															
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="9">조회된 데이터가 없습니다.</td>
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
							<span><i class="fa-solid fa-calendar-days fa-lg" style="color: #ffae00;"></i>&nbsp;&nbsp;학생관리</span>
							<a href="personalTimetable.pr"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
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
											<th width="20%">시작</th>
											<th width="20%">마감</th>
											<th width="60%">내용</th>
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
							//==========상담 내역==========
							$(".c_content_1122_table-area>table>tbody>tr").hover(function() {
								$(this).css("background-color", "#E0E0E0");
								$(this).css("cursor", "pointer");					
							}, function() {
								$(this).css("background-color", "white");
								$(this).css("cursor", "default");					
							});
							
							$(".c_content_1122_table-area>table>tbody").on("click", "tr", function() {
								var cno = $(this).children("td").eq(0).text();
								location.href = "counselDetail.pr?cno=" + cno;
							})

							//==========학사 일정==========
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
								url: "getClasses.pr",
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