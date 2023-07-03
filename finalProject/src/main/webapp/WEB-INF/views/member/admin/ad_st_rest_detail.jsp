<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/studentRestFormView.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/admin_menubar.jsp"%>
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
					<a href="stuRestList.ad" style="color:#00aeff; font-weight: 550;">휴/복학 관리</a>
				</div>
				<div class="child_title">
					<a href="proRestList.ad">안식/퇴직 관리</a>
				</div>
				<div class="child_title">
				    <a href="selectNotice.ad">공지사항 관리</a>
				</div>
			</div>
			<div id="content_1" align="center">
				<span id="content_title">휴학/복학 정보</span>
				<div style="border-top: 2px solid lightblue; width: 100%">
				<div id="board_border">
					<br>
						<h5>학생 정보</h5>
						<table border="2" class="board_list table">
							<tbody>
								<tr>
									<td>학생명</td>
									<td><input type="text" value="${s.studentName }" readonly></td>
									<td>학번</td>
									<td><input type="text" value="${s.studentNo }" name="studentNo" readonly></td>
								</tr>
								<tr>
									<td>학과</td>
									<td><input type="text" value="${s.departmentNo }" readonly></td>
									<td>이메일</td>
									<td><input type="text" value="${s.email }" readonly></td>
								</tr>
								<tr>
									<td>학년</td>
									<td><input type="text" value="${s.classLevel }" readonly></td>
									<td>연락처</td>
									<td><input type="text" value="${s.phone }" readonly></td>
								</tr>
							</tbody>
						</table>
					
						<br>
						<h5>신청 정보</h5>
						<table border="2" id="enrollTable" class="board_list table">
	
							<tr>
								<td>신청 구분</td>
								<td><input type="text" value="${sr.category}" readonly></td>
	
								<td>신청 사유</td>
								<td><input type="text" value="${sr.reason}" readonly></td>
							</tr>
							<c:choose>
								<c:when test="${sr.category eq '일반휴학'||sr.category eq '특별휴학'}">
									<tr>
										<td>휴학 시작일</td>
										<td><input type="text" name="startDate"
											value="${sr.startDate}" maxlength="10" readonly></td>
										<td>복학 예정</td>
										<td><input type="text" name="endDate"
											value="${sr.endDate}" maxlength="10" readonly></td>
									</tr>
								</c:when>
								<c:when test="${sr.category == '복학'}">
									<tr>
										<td>휴학 시작일</td>
										<td><input type="text" name="startDate" id="startedDate"
											maxlength="10" value="${sr.startDate}" readonly></td>
										<td>복학 예정</td>
										<td><input type="text" name="endDate" id="returnDate"
											maxlength="10" value="${sr.endDate}" readonly></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td>휴학 시작일</td>
										<td><input type="text" name="startDate" id="startedDate"
											maxlength="10" value="${sr2.startDate}" readonly></td>
										<td>복학 예정</td>
										<td><input type="text" name="endDate" id="returnDate"
											maxlength="10" value="${sr2.endDate}" readonly></td>
									</tr>
									<tr id="newDate">
										<td>휴학 연장 시작일</td>
										<td><input type="text" name="startDate"
											value="${sr.startDate }" maxlength="10" readonly></td>
										<td>연장 복학 예정</td>
										<td><input type="text" name="endDate"
											value="${sr.endDate}" maxlength="10" readonly></td>
									</tr>
								</c:otherwise>
							</c:choose>
							<tr>
								<td>휴학 횟수</td>
								<td><input type="text" value="${rcount}" readonly></td>
								<td>등록여부</td>
								<td>
									<c:choose>
										<c:when test="${rp.inputPay>=rp.mustPay}">
											<input type="text" value="등록휴학" readonly>
										</c:when>
										<c:otherwise>
											<input type="text" value="미등록휴학" readonly>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<br>
				<br>
				<div>
					<c:choose>
						<c:when test="${sr.status eq 'B'}">
							<button type="button" onclick="location.href='updateRestRetire.ad?restNo=${sr.restNo}'"
							class="btn btn-danger btn-lg">반려</button>
							
							<button type="button" onclick="permitbtn();"
							class="btn btn-primary btn-lg" style="margin-left:20px;">승인</button>
						</c:when>
						<c:otherwise>
							<!-- 이미 승인하거나 반려했다면 뒤로 돌아가는 버튼 보여줌 -->
							<input type="button" value="돌아가기" class="btn btn-secondary btn-lg" onclick="history.back();" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
<script>
	function permitbtn(){
		var cno = ${sr.restNo};
		var sno = "${s.studentNo}";
		var category = "${sr.category}";
		var status ;
		if(category == "복학"){
			status = "재학";
		}else{
			status = "휴학";
		}
		location.href='updateRestPermit.ad?restNo='+cno+'&studentNo='+sno+'&status='+status;		
	}
</script>
</body>
</html>