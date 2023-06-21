<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					
				</div>
				<div class="tab_content">
					
				</div>
				<div class="tab_content">
				
				</div>
				<div class="tab_content">
					
				</div>
				<div class="tab_content">
					
				</div>
			</div>
			
		</div>
		
		<div class="notice_area">
			<div class="notice_board">
				<p>공지사항</p>
				
				<form id="searchForm" action="search.mp" method="get" align="center">
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
						<c:forEach var="n" items="${list}">
							<tr>
								<td>
									<input type="hidden" class="nno" value="${n.noticeNo }">
									${n.categoryName }
								</td>
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
							<c:when test="${pi.currentPage eq pi.maxPage }">
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

	<script>
	
		const tabBtn = document.querySelectorAll('.tab_btn')
		const tabCont = document.querySelectorAll('.tab_content')
		
		var nno = '';
		
		$('document').ready(function(){
			
			const active = tabBtn[0].children[0].innerHTML
			
			$.ajax({
                url: "loadFaq.mp",
                data: {
                	active : active
                },
                success: function (result) {
                	var str = "";
                	
                	for(var i=0; i<result.length; i++){
	                	str += "<div class='faq_content'>"
	                		+"<form action='faqDetail.mp' method='get'>"
                	   		+"<span class='thumb_title'>"+result[i].noticeTitle
                	   		+"<button type='submit'>"+"전체보기>>"+"</button>"
                	   		+"</span>"
	                   		+"<span class='thumb_content'>"+result[i].noticeContent+"</span>"
	                   		+"<input type='hidden' name='faqNo' value='"+result[i].noticeNo+"'>"
	 		                +"</form></div>"
                	}
                	$(".tab_contents").children().eq(0).html(str);
                },
                error : function(){
                	console.log("통신 오류")
                }
			})
		});
				
		var btnText = ""
			
		tabBtn.forEach(function(tab, index){
								
			tab.addEventListener('click', function(){
									
				tabCont.forEach(function(cont){
					cont.classList.remove('active')
				})
				
				tabBtn.forEach(function(btn){
					btn.classList.remove('active')
				})
				
				tabCont[index].classList.add('active')
				tabBtn[index].classList.add('active')
				
				$.ajax({
	                url: "clickFaq.mp",
	                data: {
	                	active : tab.children[0].innerHTML
	                },
	                success: function (result) {
	                	
	                	var str = "";
	                	
	                	switch (result[0].noticeCategory) {
						case 1:
							for(var i=0; i<result.length; i++){
			                	str += "<div class='faq_content'>"
			                		+"<form action='faqDetail.mp' method='get'>"
		                	   		+"<span class='thumb_title'>"+result[i].noticeTitle
		                	   		+"<button type='submit'>"+"전체보기>>"+"</button>"
		                	   		+"</span>"
			                   		+"<span class='thumb_content'>"+result[i].noticeContent+"</span>"
			                   		+"<input type='hidden' name='faqNo' value='"+result[i].noticeNo+"'>"
			 		                +"</form></div>"
		                	}
		                	$(".tab_contents").children().eq(0).html(str);
							break;
						case 2:
							for(var i=0; i<result.length; i++){
			                	str += "<div class='faq_content'>"
			                		+"<form action='faqDetail.mp' method='get'>"
		                	   		+"<span class='thumb_title'>"+result[i].noticeTitle
		                	   		+"<button type='submit'>"+"전체보기>>"+"</button>"
		                	   		+"</span>"
			                   		+"<span class='thumb_content'>"+result[i].noticeContent+"</span>"
			                   		+"<input type='hidden' name='faqNo' value='"+result[i].noticeNo+"'>"
			 		                +"</form></div>"
		                	}
		                	$(".tab_contents").children().eq(1).html(str);
							break;
						case 3:
							for(var i=0; i<result.length; i++){
			                	str += "<div class='faq_content'>"
			                		+"<form action='faqDetail.mp' method='get'>"
		                	   		+"<span class='thumb_title'>"+result[i].noticeTitle
		                	   		+"<button type='submit'>"+"전체보기>>"+"</button>"
		                	   		+"</span>"
			                   		+"<span class='thumb_content'>"+result[i].noticeContent+"</span>"
			                   		+"<input type='hidden' name='faqNo' value='"+result[i].noticeNo+"'>"
			 		                +"</form></div>"
		                	}
		                	$(".tab_contents").children().eq(2).html(str);
							break;
						case 4:
							for(var i=0; i<result.length; i++){
			                	str += "<div class='faq_content'>"
			                		+"<form action='faqDetail.mp' method='get'>"
		                	   		+"<span class='thumb_title'>"+result[i].noticeTitle
		                	   		+"<button type='submit'>"+"전체보기>>"+"</button>"
		                	   		+"</span>"
			                   		+"<span class='thumb_content'>"+result[i].noticeContent+"</span>"
			                   		+"<input type='hidden' name='faqNo' value='"+result[i].noticeNo+"'>"
			 		                +"</form></div>"
		                	}
		                	$(".tab_contents").children().eq(3).html(str);
							break;
						case 5:
							for(var i=0; i<result.length; i++){
			                	str += "<div class='faq_content'>"
			                		+"<form action='faqDetail.mp' method='get'>"
		                	   		+"<span class='thumb_title'>"+result[i].noticeTitle
		                	   		+"<button type='submit'>"+"전체보기>>"+"</button>"
		                	   		+"</span>"
			                   		+"<span class='thumb_content'>"+result[i].noticeContent+"</span>"
			                   		+"<input type='hidden' name='faqNo' value='"+result[i].noticeNo+"'>"
			 		                +"</form></div>"
		                	}
		                	$(".tab_contents").children().eq(4).html(str);
							break;								
						}
	                },
					error : function(){
	                	console.log("통신 오류")
	                }
				})
				
				
			})
		})
	</script>
	
	<script>
				
		const tr = document.querySelectorAll('tbody > tr')
		
		tr.forEach(function(tr, index){
			tr.addEventListener('click', function(){
				var noticeNo = tr.children[0].children[0].value;
				location.href = "detail.mp?noticeNo="+noticeNo;
			})							
		})
		
	</script>
</body>
</html>