<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학교소개 : Feasible University</title>
<link rel="stylesheet" href="/fin/resources/css/universityIntroduction.css">
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
		<div align="center">
			
			<div class="busTable_area" style="width:800px;">
				<h3>버스노선안내</h3>
				<br>
				<table id="bus_time_table" border="1" >
			        <thead style="background-color: #ddd">
			            <tr>
			                <th style="width: 20%;">하차지점</th>
			                <th>유형</th>
			                <th>노선번호</th>
			                <th colspan="2">버스위치 정보</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			                <td rowspan="11">선유고등학교<br>(구)강서세무서</td>
			                <td><i class="fa-sharp fa-solid fa-bus" style="color: #28c31d;"></i> 지선버스 / 초록버스</td>
			                <td>
			                    <span>7612</span>
			                </td>
			                <td>
			                     <i id="show_marker_7612" onclick='showBusMarker("100100346",1)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                     <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                </td>
			                
			            </tr>
			            <tr>
			                <td rowspan="10"><i class="fa-sharp fa-solid fa-bus" style="color: #c11f1f;"></i> 광역버스 / 빨간버스</td>
			                <td>
			                    <span>1000</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_1000" onclick='showBusMarker("165000145",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>1200</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_1200" onclick='showBusMarker("165000148",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>1300</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_1300" onclick='showBusMarker("165000149",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>1301</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_1301" onclick='showBusMarker("165000150",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>1302</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_1302" onclick='showBusMarker("165000421",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>1400</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_1400" onclick='showBusMarker("165000151",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>1500</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_1500" onclick='showBusMarker("165000152",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>1601</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_1601" onclick='showBusMarker("165000154",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>M6628</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_M6628" onclick='showBusMarker("165000409",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>M6724</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_M6724" onclick='showBusMarker("165000381",2)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td rowspan="6">당산역</td>
			                <td rowspan="6"><i class="fa-sharp fa-solid fa-bus" style="color: #28c31d;"></i> 지선버스 / 초록버스</td>
			                <td>
			                    <span>760</span><br>
			                </td>
			                <td>
			                	<i class="fa-solid fa-location-dot showMark" style="color: #1160e8;" id="show_marker_760" onclick='showBusMarker("100100511",1)'></i>
			                    <!-- <button id="show_marker_760" onclick='showBusMarker("100100511",1)'>보이기/새로고침</button> -->
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>5620</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_5620" onclick='showBusMarker("100100277",1)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>5714</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_5714" onclick='showBusMarker("100100288",1)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>6514</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_6514" onclick='showBusMarker("100100294",1)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>6623</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_6623" onclick='showBusMarker("100100301",1)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			            <tr>
			                <td>
			                    <span>6631</span><br>
			                </td>
			                <td>
			                    <i id="show_marker_6631" onclick='showBusMarker("100100308",1)' class="fa-solid fa-location-dot showMark" style="color: #1160e8;"></i>
			                    <i class="fa-solid fa-circle-xmark hideMark" onclick='del_mark();' style="color: #e50606;"></i>
			                    <br>
			                </td>
			            </tr>
			        </tbody>
			    </table>
			</div>
		</div>
		<br><br>
		
		<script>
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
                center: new kakao.maps.LatLng(37.5339148578269, 126.89678447948727), //지도의 중심좌표.
                level: 3 //지도의 레벨(확대, 축소 정도)
              };
        var markerPosition  = new kakao.maps.LatLng(37.5339148578269, 126.89678447948727);
        
        function showBusMarker(busRouteId,typeNum){
        	del_mark();
            
            var busRouteId = busRouteId;
            var typeNum = typeNum;
            var options2;
            if(typeNum==1){
	            options = { //지도를 생성할 때 필요한 기본 옵션
	                    center: new kakao.maps.LatLng(37.5339148578269, 126.89678447948727), //지도의 중심좌표.
	                   	level : 5 //지도의 레벨(확대, 축소 정도)
	                  };
            }else if(typeNum==2){
            	options = { //지도를 생성할 때 필요한 기본 옵션
	                    center: new kakao.maps.LatLng(37.5339148578269, 126.89678447948727), //지도의 중심좌표.
	                   	level : 6 //지도의 레벨(확대, 축소 정도)
	                  };
            }
            
            var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
            //마커이미지

            var imageSize = new kakao.maps.Size(28, 30); 
            
            if(typeNum==1){
            	var imageSrc = "resources/icon/green_bus_mark.png"; 
            }else if(typeNum==2){
            	var imageSrc = "resources/icon/red_bus_mark.png";
            }
            
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
             
            $.ajax({
                url : "busMark.mp",
                data : {
                	busRouteId : busRouteId
                },
                success : function(result){
                	
                    if(result[0]!=null){
                        for(var i=0;i<result.length;i++){
                
                            //버스위치 마킹
                            var busMarker = new kakao.maps.Marker({
                            	title : busRouteId,
                            	map : map,
                                position : new kakao.maps.LatLng(result[i].gpsY,result[i].gpsX),
                                image : markerImage
                            });
                        }
                        //alert("지도에 버스 위치가 반영되었습니다.");
                    }else{
                        alert("해당 버스 데이터를 불러오는데 실패했습니다.");
                    } 
                },
                error : function(){
                    alert("통신 에러");
                }
            }); 
            
          	//이레빌딩 위치 마킹
            var marker = new kakao.maps.Marker({
            	title : "이레빌딩",
            	position: markerPosition
            });
            
            marker.setMap(map);
        }
        
        function del_mark(){//이레빌딩 제외 마크 전부 삭제
        	
        	options = { //지도를 생성할 때 필요한 기본 옵션
                    center: new kakao.maps.LatLng(37.5339148578269, 126.89678447948727), //지도의 중심좌표.
                    level: 3 //지도의 레벨(확대, 축소 정도)
                  };
        
        	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
        	
            //이레빌딩 위치 마킹
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });
            
            marker.setMap(null);
            marker.setMap(map);
            
        }
        
        
    	</script>
		<%@include file="../common/mainPageFooter.jsp" %>
	</div>
</body>
</html>