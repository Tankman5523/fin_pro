<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>종합정보시스템</title>
<link rel="stylesheet" href="resources/css/adminMainPage.css">
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
								<a href="classManagePage.ad"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
							</div>
							<div class="c_content_1122">
								<div class="c_content_1122_table-area">
									<table border="1" style="table-layout:fixed;">
										<thead>
							                <tr>
							                    <th width="60px">학년도</th>
							                    <th width="50px">학기</th>
							                    <th width="40px">강의시간</th>
							                    <th width="150px">학과</th>
							                    <th width="50px">수강학년</th>
							                    <th width="220px">강의명</th>
							                    <th width="70px">교수</th>
							                    <th width="80px">개설여부</th>
							                </tr>
							            </thead>
										<tbody>
											<c:choose>
												<c:when test="${!empty classList }">
													<c:forEach var="classes" items="${classList }">
														<tr>
															<%-- <td style="display: none;">${class.classNo }</td> --%>
															<td>${classes.classYear}</td>
															<td>${classes.classTerm}</td>
															<td>${classes.classHour}</td>
															<td>${classes.departmentNo}</td>
															<td>${classes.classLevel}</td>
															<td class="text-limit">${classes.className}</td>
															<td>${classes.professorNo}</td>
															
															<c:if test="${classes.status eq 'N' }">
																<td style='color: orange; font-weight: bold;'>검토중</td>
															</c:if>
															<c:if test="${classes.status eq 'Y' }">
																<td style='color: #0080ff; font-weight: bold;'>개설승인</td>
															</c:if>
															<c:if test="${classes.status eq 'C' }">
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
						<div class="c_content_13_1">
							<div class="c_content_131">
								<span><i class="fa-solid fa-graduation-cap" style="color: #2071fe;"></i> &nbsp;&nbsp;학생관리</span>
								<a href="stuRestList.ad"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
							</div>
							<div class="c_content_132">
								<div class="c_content_1321">
									<div class="c_content_1321_table-area">
										<table border="1" id="stdTable" style="width:95%;">
								            <thead>
								                <tr>
								                    <th>신청날짜</th>
								                    <th>이름</th>
								                    <th>내용</th>
								                    <th>처리상태</th>
								                </tr>
								            </thead>            
								            <tbody>
								                <c:choose>
													<c:when test="${!empty srList }">
														<c:forEach var="student" items="${srList}">
															<tr>
																<%-- <td style="display: none;">${student.restNo }</td> --%>
																<td>${student.requestDate}</td>
																<td>${student.studentName}</td>
																<td>${student.category}</td>
																
																<c:if test="${student.status eq 'B' }">
																	<td style='color: orange; font-weight: bold;'>검토중</td>
																</c:if>
																<c:if test="${student.status eq 'Y' }">
																	<td style='color: #0080ff; font-weight: bold;'>허가</td>
																</c:if>
																<c:if test="${student.status eq 'N' }">
																	<td style='color: red; font-weight: bold;'>비허가</td>
																</c:if>
																
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
															<td colspan="4">조회된 데이터가 없습니다.</td>
														</tr>
													</c:otherwise>
												</c:choose>
								            </tbody>
								        </table>  
							        </div>     
								</div>
							</div>
						</div>
						<div class="c_content_13_2">
						<!-- 빈줄 --> 
						
						</div>
						<div class="c_content_13_3">
							<div class="c_content_131">
								<span><i class="fa-sharp fa-solid fa-user-tie" style="color: #ffae00;"></i>&nbsp;&nbsp;임직원 관리</span>
								<a href="proRestList.ad"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
							</div>
							<div class="c_content_132">
								<div class="c_content_1321">
									<div class="c_content_1321_table-area">
										<table border="1" id="profTable" style="width:95%;" >
								            <thead>
								                <tr>
								                    <th>신청날짜</th>
								                    <th>이름</th>
								                    <th>내용</th>
								                    <th>처리상태</th>
								                </tr>
								            </thead>            
								            <tbody>
								                <c:choose>
													<c:when test="${!empty prList }">
														<c:forEach var="prof" items="${prList}">
															<tr>
																<%-- <td style="display: none;">${student.restNo }</td> --%>
																<td>${prof.requestDate}</td>
																<td>${prof.professorName}</td>
																<c:choose>
																	<c:when test="${prof.category eq 1}">
																		<td>안식</td>
																	</c:when>
																	<c:when test="${prof.category eq 0}">
																		<td>퇴직</td>
																	</c:when>
																</c:choose>
																
																<c:if test="${prof.status eq 'B' }">
																	<td style='color: orange; font-weight: bold;'>검토중</td>
																</c:if>
																<c:if test="${prof.status eq 'Y' }">
																	<td style='color: #0080ff; font-weight: bold;'>허가</td>
																</c:if>
																<c:if test="${prof.status eq 'N' }">
																	<td style='color: red; font-weight: bold;'>비허가</td>
																</c:if>
																
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
															<td colspan="4">조회된 데이터가 없습니다.</td>
														</tr>
													</c:otherwise>
												</c:choose>
								            </tbody>
							        	</table>  
						        	</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="c_content_2">
					<div class="c_content_22">
					
					</div>
				</div>
				
				<div class="c_content_3">
					<div class="c_content_31">
						<div class="c_content_311">
							<span><i class="fa-regular fa-calendar fa-lg" style="color: #d184f5;"></i>&nbsp;&nbsp;이번 달 학사일정</span>
							<a href="haksaSchedule.mp"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
						</div>
						<div class="c_content_312">
							<div class="c_content_312_table-area">
								<table border="1" style="table-layout:fixed;">
									<thead>
										<tr>
											<th width="20%">기간</th>
											<th width="60%">내용</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
												<c:when test="${!empty calList }">
													<c:forEach var="cal" items="${calList }">
														<tr>
															<td height="32px" width="30%" style="font-size:12px;">
																${cal.start } ~<br>
																${cal.end }
															</td>
															<td class="text-limit">${cal.title }</td>
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
								<table border="1" style="table-layout:fixed;">
									<thead>
										<tr>
											<th width="80%">제목</th>
											<th width="20%">작성일</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${!empty nList }">
												<c:forEach var="n" items="${nList }">
													<tr>
														<td class="text-limit" width="80%" height="50px">${n.noticeTitle }</td>
														<td width="20%" style="font-size:12px;">${n.createDate }</td>
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
				</div>
			</div>
		</div>
	</div>
</body>
</html>