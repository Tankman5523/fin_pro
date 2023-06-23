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
 	<c:if test="${not empty alertMsg}">
	
		<script>
		 	alert("${alertMsg}");
		</script>
		
		<c:remove var="alertMsg" scope="session"/>
		
	</c:if>

	<div class="wrap">
		<%@include file="../common/mainPageHeader.jsp" %>
		
		<div id="content">
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
					currentImg = 0,
					slideCount = slide.length,
					slideWidth = 100,
					prevBtn = document.querySelector('.prev'),
					nextBtn = document.querySelector('.next')
					
				makeClone();
				
				function makeClone(){
					
					for(var i=0; i<slideCount; i++){
						var cloneSlide = slide[i].cloneNode(true)
						cloneSlide.classList.add('clone')
						slideBox.appendChild(cloneSlide)
					}
					for(var i = slideCount -1; i>=0; i--){
						var cloneSlide = slide[i].cloneNode(true)
						cloneSlide.classList.add('clone')
						slideBox.prepend(cloneSlide)
					}
					updateWidth();
					setIntervalPos();
					
					setTimeout(function(){
						slideBox.classList.add('slideShow')
					},100)
				}
				
				function updateWidth(){
					var currentSlides = document.querySelectorAll('.main-img')
					var newSlideCount = currentSlides.length;
					
					var newWidth = slideWidth * newSlideCount + 'vw';
					slideBox.style.width = newWidth;
				}
				function setIntervalPos(){
					var initialTranslateValue = -(slideWidth * slideCount)
					slideBox.style.transform = 'translateX(' + initialTranslateValue + 'vw)'
				}
				
				function moveSlide(num){
					slideBox.style.left = -num * slideWidth + 'vw'
					currentImg = num
					
					if(currentImg == slideCount || currentImg == -slideCount){
						
						setTimeout(function(){
							slideBox.classList.remove('slideShow')
							slideBox.style.left = '0px'
							currentImg = 0
						}, 5000)
						setTimeout(function(){
							slideBox.classList.add('slideShow')
						}, 5100)
						
					}
				}
				
				var timer = undefined
				
				function autoSlide(){
					if(timer == undefined){
						timer = setInterval(function(){
							moveSlide(currentImg + 1)
						}, 5000)
					}
				}
				
				autoSlide()
				
				function stopSlide(){
					clearInterval(timer)
					timer = undefined
				}
				slideBox.addEventListener('mouseenter', function(){
					stopSlide()
				})
				slideBox.addEventListener('mouseleave', function(){
					autoSlide()
				})
				
				/* 날씨 정보 데이터 미리 호출(캐시값 담아놓기 위해서) */
				$(function(){
					
					$.ajax({
						url : "weather.api"
					});
				});

			</script>
		
		
		<%@include file="../common/mainPageFooter.jsp" %>
	</div>
</body>
</html>