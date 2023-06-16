<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main : Feasible University</title>
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
						}, 3000)
						setTimeout(function(){
							slideBox.classList.add('slideShow')
						}, 3100)
						
					}
				}
				
				var timer = undefined
				
				function autoSlide(){
					if(timer == undefined){
						timer = setInterval(function(){
							moveSlide(currentImg + 1)
						}, 3000)
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
				

			</script>
		
		
		<%@include file="../common/mainPageFooter.jsp" %>
	</div>
</body>
</html>