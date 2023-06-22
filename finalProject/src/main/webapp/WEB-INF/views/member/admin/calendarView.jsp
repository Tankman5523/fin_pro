<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학사 일정 관리</title>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<style>
	/* body 스타일 */
	html, body {
/* 		overflow: hidden; */
		font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
		font-size: 14px;
	}
	/* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
	.fc-header-toolbar {
		padding-top: 1em;
		padding-left: 1em;
		padding-right: 1em;
	}
	
	.fc-button-primary {
		background-color: #4fc7ff !important;
		color: black;
		border: 0 !important;
	}
	
	.fc-button-primary:active {
		border: 2px solid red !important;
	}
	
	.fc-daygrid-day-number, .fc-col-header-cell-cushion {
		color: black;
	}
	
	#calendar-container {
		width: 100%;
		height: 93%;
	}
	
	#calendar {
		width: 100%;
		height: 100%;
	}
	
	.btn-area {
		width: 100%;
 		height: 7%;
		display: flex;
 		align-items: center;
		justify-content: center;
	}
	
	#btn {
		width: 100px;
		height: 35px;
		border-radius: 10px;
		background-color: #4fc7ff;
		border: 0;
		color: white;
	}
	
	#insert, #update {
		margin: 0 auto !important;
	}
</style>
</head>
<body>

	<div class="wrap">
		<%@include file="../../common/admin_menubar.jsp" %>
		<c:if test="${!empty alertMsg }">
			<script>
				alert("${alertMsg}");
			</script>
			<c:remove var="alertMsg" scope="session"/>
		</c:if>
		
		<div id="content">
			<div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">강의관리</span>
                </div>
                <div class="child_title">
                    <a href="#">학생 관리</a>
                </div>
                <div class="child_title">
                    <a href="#">임직원 관리</a>
                </div>
                 <div class="child_title">
                    <a href="calendarView.ad" style="color:#00aeff; font-weight: 550;">학사일정 관리</a>
                </div>
            </div>
            <div id="content_1">
            	<div id="calendar-container">
            		<div id="calendar"></div>
            	</div>
            	<div class="btn-area">
            		<button id="btn" onclick="$('#insertModal').modal('show');">일정 추가</button>
            	</div>
            	
            	<script>
            		var $color = ['#BE5EC2', '#F862A7', '#FF7B87', '#FFA26A', '#FFCE5E', '#F9F871', '#9BDE7E', '#4BBC8E', '#04aba6', '#4da5e3', '#8e84f5'];
            	
            		$(function() {
            			$("textarea[id*=content]").val("");
            			$("input[id*=startDate]").val("");
            			$("input[id*=endDate]").val("");
            			
            			$("div[class=modal]").on("hidden.bs.modal", function (e) {
            				$("textarea[id*=content]").val("");
                			$("input[id*=startDate]").val("");
                			$("input[id*=endDate]").val("");
            			});
            			
            			var calendarEl = $("#calendar")[0];
            			var calendar = new FullCalendar.Calendar(calendarEl, {
            				height: '100%',
            				// 해더에 표시할 툴바
            		        headerToolbar: {
            		          left: 'prev,next today',
            		          center: 'title',
            		          right: 'dayGridMonth,listWeek'
            		        },
            		        eventClick: function(arg) {
            		        	openUpdate(arg);
            		        },
            				initialView: 'dayGridMonth',
            				locale: 'ko', // 한국어
            				events: [ // 띄울 학사일정
            					$.ajax({
                    				url: "calendarView.ad",
                    				method: "post",
                    				success: function(calList) {
//                     					var check=0;
                    					for(var i=0;i<calList.length;i++) {
                    						var $r = Math.floor(Math.random() * 127 + 128).toString(16);
                    						var $g = Math.floor(Math.random() * 127 + 128).toString(16);
                    						var $b = Math.floor(Math.random() * 127 + 128).toString(16);
//                    							if(check==11) {
//                    								check=0;
//                    							};
                    						calendar.addEvent({
                    							groupId: calList[i].calendarNo,
                    							title: calList[i].title,
                    							start: calList[i].start,
                    							end: calList[i].end,
//                     							color : $color[check],
												color: "#" + $r + $g+ $b,
                    							textColor : "#000000"
                    						});
//                     						check++;
                    					}
                    				},
                    				error: function() {
                    					console.log("통신 오류");
                    				}
                    			})
            				]
            			});
            			calendar.render();
            		});

            		function openUpdate(arg) {
            			var $start = JSON.stringify(arg.event.start);
            			var $end = JSON.stringify(arg.event.end);
            			
            			$("#updateModal").modal("show");
            			$("#calendarNo").val(arg.event.groupId);
            			$("#content2").val(arg.event.title);
            			$("#startDate2").val($start.substring(1, $start.length-2));
            			$("#endDate2").val($end.substring(1, $end.length-2));
            		}
            	</script>
            	
            	<!-- The Modal -->
			    <div class="modal" id="insertModal">
			        <div class="modal-dialog modal-dialog-centered">
			            <div class="modal-content">
			        
			                <!-- Modal Header -->
			                <div class="modal-header">
			                <h4 class="modal-title">학사일정 입력</h4>
			                	<button type="button" class="close" onclick="$('#insertModal').modal('hide');">&times;</button>
			                </div>
			        
			                <!-- Modal body -->
			                <div class="modal-body">
			                	<form action="insertCalendar.ad" method="post">
			                		<fieldset>
								                   일정 <br>
								        <textarea id="content" name="content" style="resize:none; width: 400px;" placeholder="일정을 입력하세요."></textarea> <br><br>
								                   시작일: <input type="datetime-local" id="startDate1" name="startDate" style="width: 200px;"> <br><br>
								                   종료일: <input type="datetime-local" id="endDate1" name="endDate" style="width: 200px;"> <br><br>
			                		</fieldset>
					                <br><br>
					                
					            	<button type="submit" class="btn btn-warning" id="insert">등록</button>
			                	</form>
			                </div>
			            </div>
			        </div>
			    </div>
			    
			    <!-- The Modal -->
			    <div class="modal" id="updateModal">
			        <div class="modal-dialog modal-dialog-centered">
			            <div class="modal-content">
			        
			                <!-- Modal Header -->
			                <div class="modal-header">
			                <h4 class="modal-title">학사일정 수정</h4>
			                	<button type="button" class="close" onclick="$('#updateModal').modal('hide');">&times;</button>
			                </div>
			        
			                <!-- Modal body -->
			                <div class="modal-body">
			                	<form action="updateCalendar.ad" method="post">
			                		<input type="hidden" id="calendarNo" name="calendarNo">
			                		<fieldset>
								                   일정 <br>
								        <textarea id="content2" name="content" style="resize:none; width: 400px;" placeholder="일정을 입력하세요."></textarea> <br><br>
								                   시작일: <input type="datetime-local" id="startDate2" name="startDate" style="width: 200px;"> <br><br>
								                   종료일: <input type="datetime-local" id="endDate2" name="endDate" style="width: 200px;"> <br><br>
			                		</fieldset>
					                <br><br>
					                
					            	<button type="submit" class="btn btn-warning" id="update">수정</button>
			                	</form>
			                </div>
			            </div>
			        </div>
			    </div>
            </div>
		</div>
	</div>
</body>
</html>