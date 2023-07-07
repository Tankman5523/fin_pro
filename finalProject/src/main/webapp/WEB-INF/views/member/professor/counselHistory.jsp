<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담이력조회</title>
<link rel="stylesheet" href="resources/css/counselHistory.css">
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/professor_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">상담관리</span>
                </div>
                <div class="child_title">
                    <a href="counselHistory.pr?user=${loginUser.professorNo }" class="childBtn" style="color:#00aeff; font-weight: 550;">상담이력조회</a>
                </div>
            </div>
            <div id="content_1">
					
				<div id="select-area">
					<table id="select-table">
						<tr>
							<th>상담종류</th>
							<td>
								<select name="counsel-type" id="counselType">
									<option value="allType">=== 전체 ===</option>
									<option value="jinro">진로(취업)</option>
									<option value="attendance">학사(출결)</option>
									<option value="rest">학사(휴학)</option>
									<option value="drop">학사(제적)</option>
									<option value="admin">학사행정</option>
									<option value="affect">심리정서</option>
									<option value="collLife">학교생활</option>
									<option value="etc">기타</option>
								</select>
							</td>
							<th>상담신청일</th>
							<td>
								<input type="date" id="startDate" min="2019-01-01" max="2060-12-31" placeholder="날짜 선택" required="required">								</td>
							<th>
								~
							</th>
							<td>
								<input type="date" id="endDate" min="2019-01-01" max="2060-12-31" placeholder="날짜 선택" required="required">
							</td>
						</tr>
					</table>
				</div>
				
				<div id="select-btn">
					<button onclick="searchCounsel();" id="submit"><i class="fa-solid fa-magnifying-glass"></i>&nbsp;조회</button>
					<button type="reset" onclick="location.reload();"><i class="fa-solid fa-arrow-rotate-left"></i>&nbsp;초기화</button>
				</div>
				
				<div id="record-area">
					<table id="record-table">
						<thead>
							<tr>
								<th style="width: 150px;">학생명</th>
								<th>학과명</th>
								<th>학년</th>
								<th>상담신청일자</th>
								<th>상담요청일자</th>
								<th>상담분야</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="c" items="${list }">
								<tr>
									<input type="hidden" id="counselNo" value="${c.counselNo }">
									<td>${c.studentName }</td>
									<td>${c.departmentName }</td>
									<td>${c.classLevel } 학년</td>
									<td>${c.applicationDate }</td>
									<td>${c.requestDate }</td>
									<td>${c.counselArea }</td>
									<c:choose>
										<c:when test="${c.status eq 'Y' }">
											<td style="color: #0080ff; font-weight: bold;">${c.status }</td>
										</c:when>
										<c:when test="${c.status eq 'N' }">
											<td style="color: orange; font-weight: bold;">${c.status }</td>
										</c:when>
										<c:otherwise>
											<td style="color: red; font-weight: bold;">${c.status }</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
            </div>
        </div>
	</div>
	
	<script type="text/javascript">
		
		var cno = "";
		var appDate = "";
		var requestDate = "";
		
		var rows = document.querySelectorAll('#record-table > tbody > tr')
		
		rows.forEach(function(tr, index){
			tr.addEventListener('click', function(){
				cno = tr.children[0].value
				
				location.href = "counselDetail.pr?cno="+cno;
			})
		})
		
		function searchCounsel(){
			
			const professorNo = "${loginUser.professorNo}";
			const select = document.getElementById('counselType');
			const counselType = select.options[select.selectedIndex].value;
			const startDate = document.getElementById('startDate').value;
			const endDate = document.getElementById('endDate').value;
			
			$.ajax({
				url: "selectCounsel.pr",
				type: 'post',
				data: {
					professorNo : professorNo,
					counselType : counselType,
					startDate : startDate,
					endDate : endDate
				},
				success: function(data){
					var result = "";
					
					if(data.length == 0){
						alert("조회 결과가 없습니다.")
						location.reload();
					}else{
						$.each(data, function(index,data){
							
							result += "<tr>"
								+"<input type='hidden' id='counselNo' value='"+data.counselNo+"'>"
								+"<td>"+data.studentName+"</td>"
								+"<td>"+data.departmentName+"</td>"
								+"<td>"+data.classLevel+"학년"+"</td>"
								+"<td>"+data.applicationDate+"</td>"
								+"<td>"+data.requestDate+"</td>"
								+"<td>"+data.counselArea+"</td>";
								
								switch (data.status) {
								case 'N':
									result+="<td style='color: orange; font-weight: bold;'>"+data.status+"</td>"
											+"</tr>"		
									break;
								case 'Y':
									result+="<td style='color: #0080ff; font-weight: bold;'>"+data.status+"</td>"
											+"</tr>"		
									break;
								case 'C':
									result+="<td style='color: red; font-weight: bold;'>"+data.status+"</td>"
											+"</tr>"		
									break;

								}
								
						})
					}
					$("#record-table > tbody").html(result);
					
					var rows = document.querySelectorAll('#record-table > tbody > tr')
					
					rows.forEach(function(tr, index){
						tr.addEventListener('click', function(){
							cno = tr.children[0].value
							
							location.href = "counselDetail.pr?cno="+cno;
						})
					})
				},
				error: function(){
					alert("현재 페이지를 로드할 수 없습니다.");
				}
			});
			
		}
		
	</script>
</body>
</html>