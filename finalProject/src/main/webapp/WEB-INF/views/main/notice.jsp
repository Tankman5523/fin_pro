<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 : Feasible University</title>
<link rel="stylesheet" href="/fin/resources/css/noticeBoard.css">
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
					<div class="faq_content">
						<div class="thumb_title">
							제목입니다제목입니다제목입니다제목입니다
						</div>
						<div class="thumb_content">
							내용임돠내용임돠내용임돠내용임돠내용임돠내용임돠
							내용임돠내용임돠내용임돠내용임돠내용임돠내용임돠
							내용임돠내용임돠내용임돠내용임돠내용임돠내용임돠
							내용임돠내용임돠내용임돠내용임돠내용임돠내용임돠
						</div>
					</div>
					<div class="faq_content">학사 FAQ2</div>
					<div class="faq_content">학사 FAQ3</div>
					<div class="faq_content">학사 FAQ4</div>
				</div>
				<div class="tab_content">
					<div class="faq_content">장학 FAQ1</div>
					<div class="faq_content">장학 FAQ2</div>
					<div class="faq_content">장학 FAQ3</div>
					<div class="faq_content">장학 FAQ4</div>
				</div>
				<div class="tab_content">
					<div class="faq_content">입학 FAQ1</div>
					<div class="faq_content">입학 FAQ2</div>
					<div class="faq_content">입학 FAQ3</div>
					<div class="faq_content">입학 FAQ4</div>
				</div>
				<div class="tab_content">
					<div class="faq_content">채용 FAQ1</div>
					<div class="faq_content">채용 FAQ2</div>
					<div class="faq_content">채용 FAQ3</div>
					<div class="faq_content">채용 FAQ4</div>
				</div>
				<div class="tab_content">
					<div class="faq_content">기타 FAQ1</div>
					<div class="faq_content">기타 FAQ2</div>
					<div class="faq_content">기타 FAQ3</div>
					<div class="faq_content">기타 FAQ4</div>
				</div>
			</div>
			
			<script type="text/javascript">
			const tabBtn = document.querySelectorAll('.tab_btn')
			const tabCont = document.querySelectorAll('.tab_content')
			
			tabBtn.forEach((tab, index) => {
				
				tab.addEventListener('click', function(){
					tabCont.forEach((cont) => {
						cont.classList.remove('active')
					})
					
					tabBtn.forEach((btn) => {
						btn.classList.remove('active')
					})
					
					tabBtn[index].classList.add('active')
					tabCont[index].classList.add('active')
				})
				
			})
			</script>
		</div>
		
		<div class="notice_area">
			<div class="notice_board">
				<p>공지사항</p>
				
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
						<tr>
							<td>학사</td>
							<td>학사입니다.</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-23</td>
						</tr>
						<tr>
							<td>학사</td>
							<td>학사입니다2</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-21</td>
						</tr>
						<tr>
							<td>장학</td>
							<td>장학입니다.</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-20</td>
						</tr>
						<tr>
							<td>학사</td>
							<td>학사입니다.</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-23</td>
						</tr>
						<tr>
							<td>학사</td>
							<td>학사입니다2</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-21</td>
						</tr>
						<tr>
							<td>장학</td>
							<td>장학입니다.</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-20</td>
						</tr>
						<tr>
							<td>학사</td>
							<td>학사입니다.</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-23</td>
						</tr>
						<tr>
							<td>학사</td>
							<td>학사입니다2</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-21</td>
						</tr>
						<tr>
							<td>장학</td>
							<td>장학입니다.</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-20</td>
						</tr>
						<tr>
							<td>장학</td>
							<td>장학입니다.</td>
							<td><i class="fa-solid fa-paperclip"></i></td>
							<td>2023-05-20</td>
						</tr>
					</tbody>
				</table>
			
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
			</div>
		</div>
						
		
	</div>
	
	<%@include file="../common/mainPageFooter.jsp" %>
</div>
</body>
</html>