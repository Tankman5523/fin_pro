<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>종합정보시스템</title>
<style>
	.c_content div {
		box-sizing: border-box;
	}
	
	#content {
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.c_content {
		width: 90%;
		height: 85%;
	}
	
	.c_content>div {
		float: left;
	}
	
	.c_content_1 {
		width: 32%;
		height: 100%;
	}
	
	.c_content_2 {
		width: 3%;
		height: 100%;
	}
	
	.c_content_3 {
		width: 65%;
		height: 100%;
	}
	
	.c_content_11, .c_content_13, .c_content_31, .c_content_33 {
		width: 100%;
		height: 47.5%;
		border: 1px solid black;
	}
	
	.c_content_12, .c_content_32 {
		width: 100%;
		height: 5%;
	}
	
	.c_content_131 {
		width: 100%;
		height: 14%;
		display: flex;
		align-items: center;
	}
	
	.c_content_132 {
		width: 100%;
		height: 86%;
	}
	
	.c_content_311, .c_content_331 {
		width: 100%;
		height: 14%;
		display: flex;
		align-items: center;
	}
	
	.c_content_131>span, .c_content_311>span, .c_content_331>span {
		margin-left: 3%;
		font-size: large;
		font-weight: bold;
	}
	
	.c_content_131>a {
		margin-left: auto;
		margin-right: 3%;
	}
	
	.c_content_311>a, .c_content_331>a {
		margin-left: auto;
		margin-right: 2%;
	}
	
	.c_content_312, .c_content_332 {
		width: 100%;
		height: 86%;
	}
	
	.c_content_312, .c_content_332 {
		display: flex;
		align-items: center;
		justify-content: center;
	}
	
	.c_content_312_table-area, .c_content_332_table-area {
		width: 95%;
		height: 85%;
	}
	
	.c_content_312_table-area>table, .c_content_332_table-area>table {
		width: 100%;
		height: 100%;
		text-align: center;
	}
	
</style>
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/student_menubar.jsp" %>
		<div id="content">
			<div class="c_content">
				<div class="c_content_1">
					<div class="c_content_11">학적정보</div>
					
					<div class="c_content_12"></div>
					
					<div class="c_content_13">
						<div class="c_content_131">
							<span>개인 시간표</span> <a href="personalTimetable.st"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
						</div>
						<div class="c_content_132"></div>
					</div>
				</div>
				
				
				<div class="c_content_2"></div>
				
				
				<div class="c_content_3">
					<div class="c_content_31">
						<div class="c_content_311">
							<span>학사 일정</span> <a href="haksaSchedule.mp"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
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
															<td>${cal.startDate }</td>
															<td>${cal.endDate }</td>
															<td>${cal.content }</td>
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
							<span>공지사항</span> <a href="notice.mp" style="float:right;"><i class="fa-regular fa-plus fa-2xl" style="color: #686e78;"></i></a>
						</div>
						<div class="c_content_332">
							<div class="c_content_332_table-area">
								<table border="1">
									<tbody>
										<c:choose>
											<c:when test="${!empty nList }">
												<c:forEach var="n" items="${nList }">
													<tr>
														<td width="80%">${n.noticeTitle }</td>
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
				</div>
			</div>
		</div>
	</div>
</body>
</html>