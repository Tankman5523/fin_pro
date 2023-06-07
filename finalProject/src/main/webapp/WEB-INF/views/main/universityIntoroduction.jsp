<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/universityIntroduction.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../common/mainPageHeader.jsp" %>
		
		<div id="content">
			<div id="content_title">
				<h3>학교소개</h3>
			</div>
			<div id="president_area">
				<img src="resources/icon/yangcheol.png">
				<p>
	                <span id="span1">Welcome to Feasible University</span>
	                <br><br>
	                <span id="span2">
	                    FEASIBLE UNIVERSITY 총장 <b>진양철</b>
	                </span>
                </p>
			</div>
			
			<div class="title_area">
				<h2>설립목적</h2>
			</div>
			<div id="uni_purpose">
				<p>
					Feasible University는 문화,예술,학술 등 다양한 프로그램을 통해 서로 어울리며 <br>
					공동체 의식을 함양함으로써 창의적 역량을 갖춘 Feasible한 리더를 양육함을 목적으로 하고 있다.
				</p>
			</div>
			
			<div class="title_area">
				<h2>오시는 길</h2>
			</div>
			<div id="map" style="width:1000px;height:400px; margin: auto; margin-bottom: 10px;"></div>
			<p align="center" style=" margin-bottom: 50px; font-size: 13px; color: grey;">(07212) 서울특별시 영등포구 선유동2로 57 이레빌딩</p>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=818e948194ea5ab0e44b2d7b11278950"></script>
			<script>
				var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
				var options = { //지도를 생성할 때 필요한 기본 옵션
								center: new kakao.maps.LatLng(37.5339148578269, 126.89678447948727), //지도의 중심좌표.
								level: 2 //지도의 레벨(확대, 축소 정도)
							  };
	
				var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
				
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(37.5339148578269, 126.89678447948727); 

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);

				// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
				// marker.setMap(null);   
			</script>
		</div>
		
		<%@include file="../common/mainPageFooter.jsp" %>
	</div>
</body>
</html>