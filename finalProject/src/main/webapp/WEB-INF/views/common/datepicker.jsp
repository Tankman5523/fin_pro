<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>datepicker</title>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.13.2/themes/redmond/jquery-ui.css">
</head>
<body>
	<!-- 달력보면서 날짜 고르게 하는 페이지 -->
	<!-- 반드시 JQuery cdn있는 메뉴바 밑에 include할것 -->
	<script>
		$(function(){
	        $.datepicker.setDefaults({
	            dateFormat: 'yy-mm-dd',
	            prevText: '이전 달',
	            nextText: '다음 달',
	            changeMonth: true,
	            changeYear: true,
	            earRange: 'c-100:c+10',
	            showButtonPanel: true,
	            currentText: '오늘' ,
	            closeText: '닫기',
	            showMonthAfterYear: true,
	            yearSuffix: '년',
	            showMonthAfterYear: true ,
	            dayNamesMin:['일', '월', '화', '수', '목', '금', '토'],
	            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	            monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
	            
	        });
	    });
		/*
			대충 예시 
			//원하는곳에 class든 id든 선언하고 function쓰듯이 쓰면 됨
			$(".datepicker").datepicker({ class="datepicker" 넣은 경우
				각자 페이지에서 원하는 조건 이렇게 넣으면됨 
                minDate:"2023-06-30"
            })
		
            //여기 밑에는 시작~끝 기간 설정할때 시작떄 고른 날짜보다 빠른날은 끝 기간에 못 고르게 하는경우
			$("#datepicker1").datepicker();
	        
	        $("#datepicker1").datepicker("option","onClose",function(selectDate){
	            $("#datepicker2").datepicker("option","minDate",selectDate);
	        })
	        $("#datepicker2").datepicker();
		*/
	</script>
</body>
</html>