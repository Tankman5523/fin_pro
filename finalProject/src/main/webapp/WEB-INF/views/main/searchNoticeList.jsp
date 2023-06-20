<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/notice.css">
</head>
<body>
<div class="wrap">
	<%@include file="../common/mainPageHeader.jsp" %>
	
	<div id="content">
		<div id="content_title">
			<h3 style="margin: 0;">공지게시판</h3>
		</div>
		
		<div class="notice_area">
			<div style="height: 150px; margin-top: 50px;">
				<p style="margin-top: 0px;">검색결과</p>
				<p style="margin-top: 30px; font-size: 15px;">''로 검색된 게시물은 총 ${searchPi.listCount } 개 입니다.<p>
			</div>
			
			<div class="notice_board">
				<form id="searchForm" action="search.mp" method="get" align="center" style="margin-top: 0px;">
					<div id="btn-area">
						<select name="selectBox">
							<option value="both">제목+내용</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
						<input type="text" name="keyword" placeholder="검색어를 입력해주세요.">
						<button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>				
				</form>
				
				<table class="notice_table">
					<thead>
						<tr>
							<th style="width: 80px;">분류</th>
							<th>제목</th>
							<th style="width: 80px;">첨부파일</th>
							<th style="width: 200px;">게시일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="s" items="${slist }">
							<tr>
								<td>
									<input type="hidden" class="nno" value="${s.noticeNo }">
									${s.categoryName }
								</td>
								<td>${s.noticeTitle }</td>
								<td>
									<c:if test="${not empty s.originName }">
										<i class="fa-solid fa-paperclip"></i>
									</c:if>
								</td>
								<td>${s.createDate }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div id="pagingArea">
					<ul class="pagination">
						<%-- 이전 페이지 --%>
						<c:choose>
							<c:when test="${searchPi.currentPage eq 1 }">
								<li class="page-btn"><a class="pLink" href="#"><i class="fa-solid fa-chevron-left"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="page-btn"><a class="pLink" href="notice.mp?currentPage=${searchPi.currentPage - 1 }"><i class="fa-solid fa-chevron-left"></i></a></li>
							</c:otherwise>
						</c:choose>
						
						<%-- 페이지 --%>
						<c:forEach var="p" begin="${searchPi.startPage }" end="${searchPi.endPage }">
							<c:choose>
								<c:when test="${p eq searchPi.currentPage }">
									<li class="page-btn"><a class="pLink active" href="notice.mp?currentPage=${p }">${p }</a></li>
								</c:when>								
								<c:otherwise>
									<li class="page-btn"><a class="pLink" href="notice.mp?currentPage=${p }">${p }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<%-- 다음 페이지 --%>
						<c:choose>
							<c:when test="${searchPi.currentPage eq searchPi.maxPage }">
								<li class="page-btn"><a class="pLink" href="#"><i class="fa-solid fa-chevron-right"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="page-btn"><a class="pLink" href="notice.mp?currentPage=${searchPi.currentPage + 1 }"><i class="fa-solid fa-chevron-right"></i></a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="../common/mainPageFooter.jsp" %>
</div>
</body>
</html>