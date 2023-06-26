<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/counselHistoryDetail.css">
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
				<a href="counselHistory.pr" class="childBtn">상담이력조회</a>
			</div>
		</div>
		<div id="content_1">
			
			<div id="result-area">
				<table class="record-table">
					<tr>
						<th>학생명</th>
						<td><input type="text" value="${c.studentName }" readonly="readonly"></td>
						<th>상담신청일자</th>
						<td><input type="text" value="${c.applicationDate }" readonly="readonly"></td>
					</tr>
					<tr>
						<th>학과</th>
						<td><input type="text" value="${c.departmentName }" readonly="readonly"></td>
						<th>상담요청일자</th>
						<td><input type="text" value="${c.requestDate }" readonly="readonly"></td>
					</tr>
					<tr>
						<th>학번</th>
						<td><input type="text" value="${c.studentNo }" readonly="readonly"></td>
						<th>상담분야</th>
						<td><input type="text" value="${c.counselArea }" readonly="readonly"></td>
					</tr>
					<tr>
						<th>학생 전화번호</th>
						<td><input type="text" value="${c.phone }" readonly="readonly"></td>
						<th>상담여부</th>
						<td>
							<input type="text" id="status" readonly="readonly">
						</td>
					</tr>
					<c:choose>
						<c:when test="${c.status eq 'C' }">
							<tr style="border-top: 1px solid black;">
								<th style="height: 200px;">상담 요청 내용</th>
								<td colspan="3" style="border: none; padding: 10px 0;">
									<textarea class="content" readonly="readonly"><c:out value="${c.counselContent }"/></textarea>
								</td>
							</tr>
							<tr style="border-top: 1px solid black;">
								<th style="height: 150px;">상담 반려 내용</th>
								<td colspan="3" style="border: none; padding: 10px 0;">
									<textarea class="content" readonly="readonly"><c:out value="${c.counselResult }"/></textarea>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr style="border-top: 1px solid black;">
								<th style="height: 200px;">상담 요청 내용</th>
								<td colspan="3" style="border: none; padding: 10px 0;">
									<textarea class="content" readonly="readonly"><c:out value="${c.counselContent }"/></textarea>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			
				<div class="btn-area">
					<button onclick="prevPage();" id="prevBtn">이전</button>
					<button type="button" class="openModal" data-toggle="modal" data-target="#updateCounselModal">
					  변경
					</button>
				</div>
			</div>	
		</div>
	</div>
	
	<!-- The Modal -->
	<div class="modal" id="updateCounselModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
		      <h4 class="modal-title">상담 정보 변경</h4>
		      <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	      	<form action="updateCounselStatus" id="updateCounselStatus">
	      		상담 상태&nbsp;&nbsp;:&nbsp;&nbsp;
				<select name="counsel-status" id="counselStatus" onchange="changeValue()">
					<option value="N">상담 전</option>
					<option value="Y">상담 완료</option>
					<option value="C" id="cancel">상담 취소</option>
				</select>
				
				<textarea rows="3" cols="50" id="cancelResult" name="cancelResult" placeholder="상담 취소 사유를 입력해 주세요."></textarea>
				<input type="hidden" name="counselNo" value="${c.counselNo }">
				
		      <div class="btn-area">
		        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
		        <button type="submit" class="btn btn-info">변경</button>
		      </div>
	      	</form>
	      </div>
	
	
	    </div>
	  </div>
	</div>
</div>


<script type="text/javascript">

	var input = document.getElementById('status')
	var status = '${c.status}'
	
	switch (status) {
	case 'N':
		input.value = "상담 전"
		break;
	case 'Y':
		input.value = "상담 완료"
		break;
	case 'C':
		input.value = "상담 취소"
		break;
	}
	
	function prevPage(){
		history.back();
	}
	
	function changeValue(){
		const select = document.getElementById('counselStatus')
		const value = select.options[select.selectedIndex].value
		
		if(value == 'C') {
			document.getElementById('counselStatus').style.marginBottom = '20px'
			document.getElementById('cancelResult').style.display = 'flex'
		}else if(value != 'C'){
			document.getElementById('counselStatus').style.marginBottom = '0px'
			document.getElementById('cancelResult').style.display = 'none'
		}
	}
	
	const msg = "${m.msg}"
	
	if(msg != ''){
		alert(msg)		
	}
	
	
</script>


</body>
</html>