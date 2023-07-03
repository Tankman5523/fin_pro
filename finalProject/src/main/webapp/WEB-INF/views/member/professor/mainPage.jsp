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
		<%@include file="../../common/professor_menubar.jsp" %>
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
										<td width="60%" style="font-weight: bold;">&nbsp;&nbsp;${loginUser.professorName } (${loginUser.professorNo })</td>
									</tr>
									<tr>
										<td>&nbsp;&nbsp;학과:&nbsp;&nbsp;${loginUser.departmentNo }</td>
									</tr>
									<tr>
										<td>&nbsp;&nbsp;직급:&nbsp;&nbsp;${loginUser.position }</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="c_content_112">
							<div class="c_content_1121">
								<span><i class="fa-solid fa-receipt fa-lg" style="color: #118f00;"></i>&nbsp;&nbsp;상담 이력 조회</span>&nbsp;&nbsp;&nbsp;
								<a href="counselHistory.pr"><i class="fa-regular fa-plus fa-xl" style="color: #686e78;"></i></a>
							</div>
							<div class="c_content_1122">
								<div class="c_content_1122_table-area">
									<table border="1">
										<thead>
											<tr>
												<th>상담신청일자</th>
												<th>상담학생</th>
												<th>완료여부</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${!empty counList }">
													<c:forEach var="coun" items="${counList }">
														<tr>
															<td style="display: none;">${coun.counselNo }</td>
															<td>${coun.applicationDate }</td>
															<td>${coun.studentName }</td>
															<c:if test="${coun.status eq 'N' }">
																<td style='color: orange; font-weight: bold;'>${coun.status }</td>
															</c:if>
															<c:if test="${coun.status eq 'Y' }">
																<td style='color: #0080ff; font-weight: bold;'>${coun.status }</td>
															</c:if>
															<c:if test="${coun.status eq 'C' }">
																<td style='color: red; font-weight: bold;'>${coun.status }</td>
															</c:if>
															
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="3">조호된 데이터가 없습니다.</td>
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
						var $classes = new Array();	
					
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

							//==========개인 시간표==========
							$.ajax({
								url: "getClasses.pr",
								data: {},
								success: function(cList) {
									for(var i=0;i<cList.length;i++) {
										$classes[i] = cList[i];
									}
								},
								error: function() {
									console.log("통신 오류");
								}
							})
							
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
							
							getClasses(today);
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
							getClasses(theDay);
						}
						
						function getClasses(theDay) {
							var str = "";
							
							for(var i=0;i<$classes.length;i++) {
								if($classes[i].classYear == theDay.getFullYear()) { // 년도
									if(3<=(theDay.getMonth()+1) && (theDay.getMonth()+1)<=6) { // 학기
										if($classes[i].classTerm==1 && $classes[i].day == theDay.getDay()) {
											str += $classes[i].period + "&nbsp;&nbsp;" + $classes[i].className + "<br>";
										}
									}
									else if(9<=(theDay.getMonth()+1) && (theDay.getMonth()+1)<=12) {
										if($classes[i].classTerm==2 && $classes[i].day == theDay.getDay()) {
											str += $classes[i].period + "&nbsp;&nbsp;" + $classes[i].className + "<br>";
										}
									}
								}
							}
							
							if(str == "") {
								str = "수업이 없습니다.";
							}
							$("#today-class").html(str);
						}
					</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>