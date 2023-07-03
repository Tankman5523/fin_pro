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
<link rel="stylesheet" href="resources/css/calendarView.css">
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
                    <a href="enrollStudent.ad">학생 관리</a>
                </div>
                <div class="child_title">
                    <a href="enrollProfessor.ad">임직원 관리</a>
                </div>
                 <div class="child_title">
                    <a href="calendarView.ad" style="color:#00aeff; font-weight: 550;">학사일정 관리</a>
                </div>
                <div class="child_title">
                    <a href="stuRestList.ad">휴/복학 관리</a>
                </div>
                <div class="child_title">
                    <a href="proRestList.ad">안식/퇴직 관리</a>
                </div>
            </div>
            <div id="content_1">
            	<div id="calendar-container">
            		<div id="calendar"></div>
            	</div>
            	<div class="btn-area">
            		<button id="btn" onclick="$('#myModal').modal('show'); $('#insert').css('display', 'block');">일정 추가</button>
            	</div>
            	
            	<script>
            		var $color = ['#BE5EC2', '#F862A7', '#FF7B87', '#FFA26A', '#FFCE5E', '#F9F871', '#9BDE7E', '#4BBC8E', '#04aba6', '#4da5e3', '#8e84f5'];
            	
            		$(function() {
            			$("#modalContent").val("");
            			$("#startDate").val("");
            			$("#endDate").val("");
            			
            			$("#myModal").on("hidden.bs.modal", function (e) {
            				$("#modalContent").val("");
                			$("#startDate").val("");
                			$("#endDate").val("");
                			$(".modalBtn-area>button").css("display", "none");
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
            		        eventClick: function(arg) { // 일정 클릭시
            		        	openUpdate(arg);
            		        },
            		        dateClick: function(arg) { // 날짜 클릭시
            		        	openInsert(arg);
            		        },
            				initialView: 'dayGridMonth',
            				locale: 'ko', // 한국어
            				dayMaxEvents: true,
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
                    							textColor : "#000000",
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
            			
            			$("#myModal").modal("show");
						$("#update").css("display", "block");
						$("#delete").css("display", "block");
            			$("#calendarNo").val(arg.event.groupId);
            			$("#modalContent").val(arg.event.title);
            			$("#startDate").val($start.substring(1, $start.length-2));
            			$("#endDate").val($end.substring(1, $end.length-2));
            		}
            		
            		function openInsert(arg) {
            			$("#myModal").modal("show");
            			$("#insert").css("display", "block");
            			$("#startDate").val(arg.dateStr+"T00:00");
            		}
            	</script>
            	
            	<!-- The Modal -->
			    <div class="modal" id="myModal">
			        <div class="modal-dialog modal-dialog-centered">
			            <div class="modal-content">
			        
			                <!-- Modal Header -->
			                <div class="modal-header">
			                <h4 class="modal-title">학사일정 관리</h4>
			                	<button type="button" class="close" onclick="$('#myModal').modal('hide');">&times;</button>
			                </div>
			        
			                <!-- Modal body -->
			                <div id="calModal" class="modal-body">
			                	<form action="manageCalendar.ad" method="post">
			                		<input type="hidden" id="calendarNo" name="calendarNo">
			                		<input type="hidden" id="check" name="check">
			                		<fieldset>
								                   일정 <br>
								        <textarea id="modalContent" name="content" style="resize:none; width: 400px;" placeholder="일정을 입력하세요."></textarea> <br><br>
								                   시작일: <input type="datetime-local" id="startDate" name="startDate" style="width: 200px;"> <br><br>
								                   종료일: <input type="datetime-local" id="endDate" name="endDate" style="width: 200px;"> <br><br>
			                		</fieldset>
					                <br><br>
					                
					                <div class="modalBtn-area">
						            	<button type="submit" class="btn btn-warning" id="insert" style="display: none;">등록</button>
						            	<button type="submit" class="btn btn-warning" id="update" style="display: none;">수정</button>
						            	<button type="submit" class="btn btn-danger" id="delete" style="display: none;">삭제</button>
					                </div>
			                	</form>
			                </div>
			                
			                <script>
			                	$(function() {
			                		$("#insert").on("click", function() {
			                			$("#calendarNo").val("0");
			                			$("#check").val("insert");
			                		});
			                		
			                		$("#update").on("click", function() {
			                			$("#check").val("update");
			                		});
			                		
			                		$("#delete").on("click", function() {
			                			$("#check").val("delete");
			                		});
			                	})
			                </script>
			            </div>
			        </div>
			    </div>
            </div>
		</div>
	</div>
</body>
</html>