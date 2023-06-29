<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학사일정 : Feasible University</title>
<link rel="stylesheet" href="/fin/resources/css/haksaSchedule.css">
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
</head>
<body>
<div class="wrap">
	<%@include file="../common/mainPageHeader.jsp" %>
	
	<div id="content">
		<div id="content_title">
			<h3>학사일정</h3>
		</div>
		
		<div id="calendar"></div>
		<script>
			
			document.addEventListener('DOMContentLoaded', function() {
			var calendarEl = document.getElementById('calendar');
			
			var calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar: {
					left: 'prev',
					center: 'title',
					right: 'next'
				},
				initialView: 'dayGridMonth',
				locale: 'ko', // 한국어
				dayMaxEvents: true, // allow "more" link when too many events
				events: [
					$.ajax({
						url: "haksaSchedule.mp",
						method: "post",
						success: function(list){
							
							for(var i=0; i<list.length; i++){
								var red = Math.floor(Math.random() * 127 + 128).toString(16);
								var green = Math.floor(Math.random() * 127 + 128).toString(16);
								var blue = Math.floor(Math.random() * 127 + 128).toString(16);
								
								calendar.addEvent({									
									groupId: list[i].calendarNo,
									title: list[i].content,
									start: list[i].startDate,
									end: list[i].endDate,
									color: "#" + red + green + blue,
									textColor: "#000000"
								});
								
							}
						},
						error: function(){
							alert("현재 페이지를 로드할 수 없습니다.")
						}
					})
				]
			});
			
				calendar.render();
			});
		
		</script>
	</div>
	
	<%@include file="../common/mainPageFooter.jsp" %>
</div>

</body>
</html>