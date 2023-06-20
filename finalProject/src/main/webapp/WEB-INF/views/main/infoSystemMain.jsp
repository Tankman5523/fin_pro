<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>종합정보시스템 : Feasible University</title>
<link rel="stylesheet" href="/fin/resources/css/infoSystemMain.css">
<script src="https://kit.fontawesome.com/7f4a340891.js" crossorigin="anonymous"></script>
</head>
<body>

 	<c:if test="${not empty alertMsg}">
	
		<script>
		 	alert("<c:out value='${alertMsg}'/>");
		</script>
		
		<c:remove var="alertMsg" scope="session"/>
		
	</c:if>

	<div class="wrap">
	    <div id="content_1">
	        <div id="left_area">
	            <div id="logo_area">
	                <img src="resources/icon/blue_logo_text.png">
	            </div>
	            <div id="login_area">
	            	<button type="button" id="mainPage_btn" onclick="location.href='mainPage.mp'">학교 홈페이지</button> <br>
	                <button type="button" id="login_btn" onclick="location.href='login.me'">로그인</button> <br>
	            	<button type="button" class="forgot_btn" onclick="location.href='searchIdForm.me?num=1'">아이디 찾기</button> /
	            	<button type="button" class="forgot_btn" onclick="location.href='resetPwdForm.me?num=1'">비밀번호 초기화</button>
	            </div>
	            <div>
	                <p>(07212) 서울특별시 영등포구 선유동2로 57 이레빌딩</p>
	            </div>
	        </div>
	    </div>
	    <div id="content_2">
	        <div id="right_area">
	            <input type="radio" id="notice_btn" name="tab" checked>
	            <label for="notice_btn">공지사항</label>
	
	            <input type="radio" id="faq_btn" name="tab">
	            <label for="faq_btn">자주묻는질문</label>
	
	            <div id="board_area">
	                <section id="notice_section">
	                	<button onclick="location.href='notice.mp'">전체보기>></button>
	                    <table class="notice_table">
							<thead>
								<tr>
									<th style="width: 10%;">분류</th>
									<th style="width: 60%;">제목</th>
									<th style="width: 10%;">첨부파일</th>
									<th style="width: 20%;">게시일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="n" items="${infoList }">
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
	                </section>
	                
	                <section id="faq_section">
	                    <button onclick="location.href='notice.mp'">전체보기>></button>
	                    <table class="notice_table">
							<thead>
								<tr>
									<th style="width: 20%;">분류</th>
									<th style="width: 60%;">제목</th>
									<th style="width: 20%;">게시일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="f" items="${infoFaq }">
									<tr>
										<td>
											<input type="hidden" class="nno" value="${f.noticeNo }">
											${f.categoryName }
										</td>
										<td>${f.noticeTitle }</td>
										<td>${f.createDate }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
	                </section>
	            </div>
	        </div>
	    </div>
	</div>
	
	<script>
				
		const notice = document.querySelectorAll('#notice_section > table > tbody > tr')
		const faq = document.querySelectorAll('#faq_section > table > tbody > tr')
		
		notice.forEach(function(tr, index){
			tr.addEventListener('click', function(){
				var noticeNo = tr.children[0].children[0].value;
				location.href = "detail.mp?noticeNo="+noticeNo;
			})							
		})
		
		faq.forEach(function(tr, index){
			tr.addEventListener('click', function(){
				var noticeNo = tr.children[0].children[0].value;
				location.href = "faqDetail.mp?faqNo="+noticeNo;
			})							
		})
		
	</script>
</body>
</html>