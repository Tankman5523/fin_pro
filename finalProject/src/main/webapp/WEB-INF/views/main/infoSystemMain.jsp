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
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/weather.css">
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
	                <div id="autoLoginStatus"></div>
	            	<button type="button" class="forgot_btn" onclick="location.href='searchIdForm.me?num=1'">아이디 찾기</button> /
	            	<button type="button" class="forgot_btn" onclick="location.href='resetPwdForm.me?num=1'">비밀번호 초기화</button>
	            </div>
	            <div>
	                <p>(07212) 서울특별시 영등포구 선유동2로 57 이레빌딩</p>
	            </div>
	        	<div id="weather_area">
					<div id="weather_icon"></div>
					<div id="weather_temp"></div>
					<div id="weather_sky"></div>
					<div id="weather_minMax"></div>
					<div id="dustInfo"></div>
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
	
	<script>
	
		$(function(){
			
			/* 로그인 상태 유지 확인 Text처리 */
			var autoLogin = decodeURIComponent("${cookie.autoLoginInfo.value}");
			if(autoLogin != ""){
				$("#autoLoginStatus").text("로그인 상태 유지중");
			}
			
			/* 현재 온도 (10분마다 갱신) */
			$.ajax({
				
				url : "weather.api",
				
				success : function(result){
					$("#weather_temp").html(result.T1H + 'º');
				}
			});
			
			/* 하늘상태(아이콘),강수형태 (10분마다 갱신) */
			$.ajax({
				
				url : "skyPty.api",
				
				success : function(result){
					$("#weather_icon").html(result.IMG);
					$("#weather_sky").html(result.SKY);
				}
			});
			
			/* 최저,최고기온  정보 추출 (하루 한번 23시30분에 갱신) */
			$.ajax({
				url : "tmnTmx.api",
				success : function(result){
					$("#weather_minMax").html("<span style='color:#5b8fed;'>"+ result.TMN +"º</span>" + "<span style='color : #d3d5d7;'>/</span>"+"<span style='color:#f55f5e;'>"+ result.TMX +"º</span>");
				}
				
			});
			
			/* 미세먼지, 초미세먼지 (30분마다 갱신) */
			$.ajax({
				url : "dust.api",
				
				success : function(result){
					if(result.chkError == "YYYY"){ //통신상태 이상 판별
						$("#dustInfo").html("미세&nbsp" + result.pm10Grade1h + "<span style='color : #d3d5d7;'>&nbspㆁ&nbsp</span>" + "초미세&nbsp" + result.pm25Grade1h)
					}else{
						$("#dustInfo").html(result.pm10Grade1h + "<span style='color : #d3d5d7;'>&nbspㆁ&nbsp</span>" + result.pm25Grade1h)
						$.ajax({
							url : "dustCache.api"
						});
					}
				}
			})
			
		});
	</script>
</body>
</html>