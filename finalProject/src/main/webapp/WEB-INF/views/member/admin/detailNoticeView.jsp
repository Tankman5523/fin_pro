<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/detailNoticeView.css">
<!-- 서머노트 쓰기위한 CDN(jQuery, 서머노트cdn) -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<!-- 메뉴바에 있는 jquery와 충돌이 나기 때문에 필요한 js는 $대신 변수를 지정해서 써준다. -->
<script > var jb = jQuery.noConflict(); </script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>
<body>
<div class="wrap" style="height: auto;">
	<%@include file="../../common/admin_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
	<div id="content" style="height: 1000px;">
		<div id="category">
			<div id="cate_title" style="height: 94px;">
				<span style="margin: 0 auto;">학사관리</span>
			</div>
			<div class="child_title" style="height: 77px;">
			    <a href="enrollStudent.ad">학생관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
			    <a href="enrollProfessor.ad">임직원 관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
			    <a href="calendarView.ad">학사일정 관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
				<a href="stuRestList.ad">휴/복학 신청 관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
				<a href="proRestList.ad">안식/퇴직 관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
			    <a href="selectNotice.ad" style="color:#00aeff; font-weight: 550;">공지사항 관리</a>
			</div>
	    </div>
		<div id="content_1">
		
			<p id="sub-title">공지사항 상세보기</p>
			
			<div id="notice-container">
				<button id="update" onclick="update()">수정</button>
				<button type="button" id="back" onclick="history.back();">이전</button>
				<table id="field-area">
					<tr>
						<c:choose>
							<c:when test="${b.field eq 0}">
								<td><input type="text" class="field" value="공지사항" readonly="readonly"></td>
							</c:when>
							<c:otherwise>
								<td><input type="text" class="field" value="FAQ" readonly="readonly"></td>
							</c:otherwise>
						</c:choose>
						<td><input type="text" id="cate" value="${n.categoryName }" readonly="readonly"></td>
					</tr>
				</table>
				
				<input type="text" id="noticeTitle" value="${n.noticeTitle }" readonly="readonly">
				
				<c:if test="${na ne ''}">
					<ul id="file-container">
						<c:forEach var="i" items="${na }">
							<li class="file-list">
								<a href="${i.changeName }" download="${i.originName }">
									<i class="fa-solid fa-paperclip"></i>&nbsp;&nbsp;&nbsp;${i.originName }
								</a>
							</li>
						</c:forEach>
					</ul>
				</c:if>
				
				<div id="summernote">${n.noticeContent }</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function update(){
		const noticeNo = '${n.noticeNo}'
		location.href = "updateNotice.ad?noticeNo="+noticeNo;
	}
</script>
</body>
</html>