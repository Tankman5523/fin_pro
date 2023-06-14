<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 : Feasible University</title>
<link rel="stylesheet" href="/fin/resources/css/notice.css">
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
</head>
<body>
<div class="wrap">
	<%@include file="../common/mainPageHeader.jsp" %>
	
	<div id="content">
		<div id="content_title">
			<h3 style="margin: 0;">공지게시판</h3>
		</div>
		
		<div class="tab_area">
		 	<h1>자주 묻는 질문</h1>
		 	
			<ul class="tab">
				<li class="tab_btn active">
					<span>학사</span>
				</li>
				<li class="tab_btn">
					<span>장학</span>
				</li>
				<li class="tab_btn">
					<span>입학</span>
				</li>
				<li class="tab_btn">
					<span>채용</span>
				</li>
				<li class="tab_btn">
					<span>기타</span>
				</li>
			</ul>
			
			<div class="tab_contents">
				
				<div class="tab_content active">
<!-- 					<div class="faq_content"> -->
						<span>1</span>
						<span>2</span>
						<span>3</span>
<!-- 					</div> -->
				</div>
				
<!-- 				<div class="tab_content janghak"> -->
<!-- 					<div class="faq_content"> -->
<!-- 						<span class="thumb_title"> -->
<!-- 							2 -->
<!-- 						</span> -->
<!-- 						<span class="thumb_content"> -->
<!-- 							2 -->
<!-- 						</span> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="tab_content iphak"> -->
<!-- 					<div class="faq_content"> -->
<!-- 						<span class="thumb_title"> -->
<!-- 							3 -->
<!-- 						</span> -->
<!-- 						<span class="thumb_content"> -->
<!-- 							3 -->
<!-- 						</span> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="tab_content chaeyong"> -->
<!-- 					<div class="faq_content"> -->
<!-- 						<span class="thumb_title"> -->
<!-- 							4 -->
<!-- 						</span> -->
<!-- 						<span class="thumb_content"> -->
<!-- 							4 -->
<!-- 						</span> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="tab_content gita"> -->
<!-- 					<div class="faq_content"> -->
<!-- 						<span class="thumb_title"> -->
<!-- 							5 -->
<!-- 						</span> -->
<!-- 						<span class="thumb_content"> -->
<!-- 							5 -->
<!-- 						</span> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
			</div>
			
			<script type="text/javascript">
				const tabBtn = document.querySelectorAll('.tab_btn')
				const tabCont = document.querySelectorAll('.tab_content')
				
// 				const category = new Array()
// 				const title = new Array()
// 				const content = new Array()
				
// 				var btnText = ""
				
// 				const faqCont = document.getElementsByClassName('faq_content')
				
// 				const titleSpan = document.createElement('span')
// 				titleSpan.className = 'thumb_title'
				
// 				const contentSpan = document.createElement('span')
// 				contentSpan.className = 'thumb_content'
				
// 				<c:forEach var="f" items="${faq}">
// 					category.push("${f.noticeCategory}")
// 					title.push("${f.noticeTitle}")
// 					content.push("${f.noticeContent}")
// 				</c:forEach>
				
				tabBtn.forEach((tab, index) => {
										
					tab.addEventListener('click', function(){
											
						tabCont.forEach((cont) => {
							cont.classList.remove('active')
						})
						
						tabBtn.forEach((btn) => {
							btn.classList.remove('active')
						})
						
						tabCont[index].classList.add('active')
						tabBtn[index].classList.add('active')
					})
					
				})
				
				
				window.onload = function(){
// 				(function(){
					
				
					
					const category = new Array()
					const title = new Array()
					const content = new Array()
					
					const active = document.getElementsByClassName('.tab_content active')
					
					console.log(active)
// 					const faqCont = document.getElementsByClassName('faq_content')
					
					const faqCont = document.createElement('div')
	 				faqCont.className = 'faq_content'
	 				
	 				const titleSpan = document.createElement('span')
	 				titleSpan.className = 'thumb_title'
					
	 				const contentSpan = document.createElement('span')
	 				contentSpan.className = 'thumb_content'
					
					var btnText = ""
					
					<c:forEach var="f" items="${faq}">
						category.push("${f.noticeCategory}")
						title.push("${f.noticeTitle}")
						content.push("${f.noticeContent}")
					</c:forEach>
					
						
						
// 					while (faqCont.length < 4) {
						for(var i=0; i<category.length; i++){
							if(category[i] == 1){
								titleSpan.innerHTML = title[i]
								contentSpan.innerHTML = content[i]
								faqCont.append(titleSpan, contentSpan)
// 								active.appendChild(faqCont)
// 								console.log(active)
							}
						}
// 					}			
						
						
// 				})()	
    			}
				
				
			</script>
		</div>
		
		<div class="notice_area">
			<div class="notice_board">
				<p>공지사항</p>
				
				<form id="searchForm" action="search.mp" method="get" align="center">
					<select>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="both">제목+내용</option>
					</select>				
					<label>
						<input type="text" name="keyword" placeholder="검색어를 입력해주세요.">
						<button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
					</label>
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
						<c:forEach var="n" items="${list }">
							<tr>
								<td>${n.categoryName }</td>
								<td>${n.noticeTitle }</td>
								<td>
									<c:if test="${not empty n.originName }">
										<i class="fa-solid fa-paperclip"></i>
									</c:if>
								</td>
								<td>${n.createDate }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div id="pagingArea">
					<ul class="pagination">
						<%-- 이전 페이지 --%>
						<c:choose>
							<c:when test="${pi.currentPage eq 1 }">
								<li class="page-btn"><a class="pLink" href="#"><i class="fa-solid fa-chevron-left"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="page-btn"><a class="pLink" href="notice.mp?currentPage=${pi.currentPage - 1 }"><i class="fa-solid fa-chevron-left"></i></a></li>
							</c:otherwise>
						</c:choose>
						
						<%-- 페이지 --%>
						<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
							<c:choose>
								<c:when test="${p eq pi.currentPage }">
									<li class="page-btn"><a class="pLink active" href="notice.mp?currentPage=${p }">${p }</a></li>
								</c:when>								
								<c:otherwise>
									<li class="page-btn"><a class="pLink" href="notice.mp?currentPage=${p }">${p }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<%-- 다음 페이지 --%>
						<c:choose>
							<c:when test="${pi.currentPage eq 1 }">
								<li class="page-btn"><a class="pLink" href="#"><i class="fa-solid fa-chevron-right"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="page-btn"><a class="pLink" href="notice.mp?currentPage=${pi.currentPage + 1 }"><i class="fa-solid fa-chevron-right"></i></a></li>
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