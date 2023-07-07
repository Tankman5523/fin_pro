<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main : Feasible University</title>
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/fin/resources/css/mainPage.css">
</head>
<body>
	<script>
	/* 날씨 정보 데이터 미리 호출(캐시값 담아놓기 위해서) */
		$(function(){
			
			$.ajax({
				url : "weather.api"
			});
			
			$.ajax({
				url : "skyPty.api"
			});
			
			$.ajax({
				url : "tmnTmx.api"
			});
			
			$.ajax({
				url : "dust.api"
			});
		});
	</script>

 	<c:if test="${not empty alertMsg}">
	
		<script>
		 	alert("${alertMsg}");
		</script>
		
		<c:remove var="alertMsg" scope="session"/>
		
	</c:if>

	<div class="wrap">
		<%@include file="../common/mainPageHeader.jsp" %>
		
		<div id="content" style="height: 810px;">
			<div class="img-wrap">
				<ul class="img-container">
					<li class="main-img">
						<img alt="main1" src="/fin/resources/icon/main-img-1.jpg">
					</li>
					<li class="main-img">
						<img alt="main2" src="/fin/resources/icon/main-img-2.jpg">
					</li>
					<li class="main-img">
						<img alt="main3" src="/fin/resources/icon/main-img-3.jpg">
					</li>		
				</ul>
			</div>
		</div>
		
		<script type="text/javascript">
				var slideBox = document.querySelector('.img-container'),
					slide = document.querySelectorAll('.main-img'),
					currentImg = 0, // 현재 이미지
					slideCount = slide.length, // 총 이미지 개수를 이용하여 slide 카운트
					slideWidth = 100 // 슬라이드 이미지 크기
					
				makeClone(); // makeClone 함수 호출
				
				//makeClone 함수
				function makeClone(){
					
					// 원본 이미지 슬라이드를 복제하여 클론 이미지 슬라이드를 만들기
					for(var i=0; i<slideCount; i++){
						var cloneSlide = slide[i].cloneNode(true)
						cloneSlide.classList.add('clone')
						//원본 이미지 슬라이드 뒤에 복제한 클론 이미지 슬라이드를 append 한다.
						slideBox.appendChild(cloneSlide)
					}
					
					for(var i = slideCount -1; i>=0; i--){
						var cloneSlide = slide[i].cloneNode(true)
						cloneSlide.classList.add('clone')
						//원본 이미지 슬라이드 앞에 복제한 클론 이미지 슬라이드를 prepend 한다.
						slideBox.prepend(cloneSlide)
					}
					updateWidth(); // updateWidth() 함수 호출
					setIntervalPos(); // setIntervalPos() 함수 호출
					
					//setTimeOut을 이용하여 0.1초 뒤에
					//슬라이드 박스에 'slideShow'라는 클래스명을 추가하도록 한다.
					setTimeout(function(){
						slideBox.classList.add('slideShow')
					},100)
					
				}
				
				function updateWidth(){
					// 클래스 이름이 main-img인 요소를 전부 담아준다 (앞 클론(3)+원본(3)+뒤 클론(3))
					var currentSlides = document.querySelectorAll('.main-img')
					var newSlideCount = currentSlides.length; // = 9
					
					// 클론 슬라이드들과 원본 슬라이드가 모두 들어갈 수 있게 슬라이드 박스(.img-container)의 넓이 값을 변경해준다.
					// newWidth = 100 * 9 + 'vw';
					// newWidth = 900vw;
					var newWidth = slideWidth * newSlideCount + 'vw';
					slideBox.style.width = newWidth;
				}
				
				function setIntervalPos(){
					// initialTranslateValue = -(100 * 3);
					// initialTranslateValue = -300;
					var initialTranslateValue = -(slideWidth * slideCount);
					// 슬라이드 박스를 우에서 좌로 300vw만큼 이동시킨다. 
					slideBox.style.transform = 'translateX(' + initialTranslateValue + 'vw)'
				}
				
				// 슬라이드쇼
				function moveSlide(num){
					// 슬라이드 박스를 왼쪽을 기준으로 -num * 100vw 만큼 이동시킨다
					slideBox.style.left = -num * slideWidth + 'vw'
					currentImg = num
					
					//현재 페이지가 + 또는 슬라이드 카운트와 같을 때
					if(currentImg == slideCount || currentImg == -slideCount){
						
						//5초마다
						setTimeout(function(){
							// 슬라이드 박스에서 'slideShow'라는 클래스명을 지워준다. 
							slideBox.classList.remove('slideShow')
							// 슬라이드 박스 left를 0px로 초기화
							slideBox.style.left = '0px'
							// 현재 이미즈를 0으로 초기화
							currentImg = 0
						}, 5000)
						
						//5.1초마다
						setTimeout(function(){
							// 슬라이드 박스에 다시 'slideShow'라는
							// 클래스명을 넣어준다.
							slideBox.classList.add('slideShow')
						}, 5100)
					}
				}
				
				var timer = undefined
				
				// 자동으로 슬라이드가 움직이는 함수
				function autoSlide(){
					// timer가  undefined일 때
					if(timer == undefined){
						// setInterval 함수를 이용하여
						// 5초 간격으로 슬라이드쇼 함수를 반복 실행한다.
						timer = setInterval(function(){
							moveSlide(currentImg + 1)
						}, 5000)
					}
				}
				
				autoSlide();
				
				// 마우스 커서가 슬라이드 영역 안에 있을 때 stopSlide함수를 실행 
				slideBox.addEventListener('mouseenter', function(){
					stopSlide()
				})
				// 마우스 커서가 슬라이드 영역 밖에 있을 때 autoSlide함수를 실행
				slideBox.addEventListener('mouseleave', function(){
					autoSlide()
				})
				
				function stopSlide(){
				//clearInterval 함수를 이용하여 슬라이드 반복을 중단한다
					clearInterval(timer)
					timer = undefined
				}

			</script>
		
		
		<%@include file="../common/mainPageFooter.jsp" %>
	</div>
</body>
</html>