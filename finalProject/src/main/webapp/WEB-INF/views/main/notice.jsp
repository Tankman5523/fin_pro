<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 : Feasible University</title>
<link rel="stylesheet" href="/fin/resources/css/notice.css">
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
					<span>행사</span>
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
					<div class="faq_content">학사 FAQ1</div>
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
					<div class="faq_content">행사 FAQ1</div>
					<div class="faq_content">행사 FAQ2</div>
					<div class="faq_content">행사 FAQ3</div>
					<div class="faq_content">행사 FAQ4</div>
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
			
		</div>
						
		
	</div>
	
	<%@include file="../common/mainPageFooter.jsp" %>
</div>
</body>
</html>