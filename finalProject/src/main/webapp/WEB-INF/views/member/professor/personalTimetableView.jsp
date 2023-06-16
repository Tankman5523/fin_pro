<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 시간표</title>
<link rel="stylesheet" href="resources/css/personalTimetableView.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/professor_menubar.jsp" %>
		<div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="infoProfessor.pr">교수 정보 관리</a>
                </div>
				<div class="child_title">
                    <a href="#">강의 시간표</a>
                </div>
				<div class="child_title">
                    <a href="personalTimetable.pr">개인 시간표</a>
                </div>
				<div class="child_title">
                    <a href="#">안식/퇴직 신청 조회</a>
                </div>
				<div class="child_title">
                    <a href="#">안식/퇴직 신청</a>
                </div>
            </div>
            <div id="content_1">
                <br>
                <div class="selectTerm">
                    <span>학년도: </span> <select name="year" id="year" onchange="changeYear(this);">
 												<c:set var="previous" value="0"/>
												<c:forEach var="y" items="${classTerm}">
														<c:if test="${fn:substring(y, 0, 4) ne previous }">
															<option value="${fn:substring(y, 0, 4) }">${fn:substring(y, 0, 4) }년도</option>
														</c:if>
														<c:set var="previous" value="${fn:substring(y, 0, 4) }"/>
												</c:forEach>
                                        </select>
                    <span>학기: </span> <select name="term" id="term"></select>
                    <button type="button" class="btn btn-outline-primary btn-sm" id="selectList" style="margin-left:2%;" onclick="prevTerm();">이전 학기</button>
                    <button type="button" class="btn btn-outline-primary btn-sm" id="selectList" style="margin-left:0;" onclick="nextTerm();">다음 학기</button>
                </div>
                <div class="b_line"></div>

                <div class="schedule-area">
                    <div class="area1">
                    	<div class="day0" style="width: 187.3px; border-bottom: 1px solid lightgray;"></div>
	                    <div class="day1">월</div>
	                    <div class="day2">화</div>
	                    <div class="day3">수</div>
	                    <div class="day4">목</div>
	                    <div class="day5">금</div>
                    </div>
                    <div class="area2">
	                    <div class="area21">
		                    <div class="period01"><span>1교시<br>(09:00 ~ 10:00)</span></div>
		                    <div class="period02"><span>2교시<br>(10:00 ~ 11:00)</span></div>
		                    <div class="period03"><span>3교시<br>(11:00 ~ 12:00)</span></div>
		                    <div class="period04"><span>4교시<br>(12:00 ~ 13:00)</span></div>
		                    <div class="period05"><span>5교시<br>(13:00 ~ 14:00)</span></div>
		                    <div class="period06"><span>6교시<br>(14:00 ~ 15:00)</span></div>
		                    <div class="period07"><span>7교시<br>(15:00 ~ 16:00)</span></div>
		                    <div class="period08"><span>8교시<br>(16:00 ~ 17:00)</span></div>
	                    	<div class="period09"><span>9교시<br>(17:00 ~ 18:00)</span></div>
	                    	<div class="period10"><span>10교시<br>(18:00 ~ 19:00)</span></div>
	                    </div>
	                    <div class="area22">
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass"></div>
							<div class="divclass_last"></div>
	                    </div>                    
                    </div>
                </div>

				<script>
					var arr = ${classTerm};
	                
	                $(function() {
	                	$("select[name=year]").children().first().prop("selected", true).change();
	                	selectTimetable();
	                    
	                	$(".selectTerm").on("change", "#term", function() {
	                		selectTimetable();
	                	});
	                	
	                	$(".period10").nextAll().css("border-bottom", "2px solid black");
	                })
	                
	                function changeYear(e) {
	                	var $year = e.value;
	                	var str = "";
	                	
	                	for(var i=0;i<arr.length;i++) {
	                		var tmp = arr[i].toString().substr(0,4);
	                		if(tmp.includes($year)) {
	                			var tmp2 = arr[i].toString().substr(5,);
		                		if(tmp2 == "1") {
		                			str += "<option value='1'>1학기</option>";
		                		}
		                		if(tmp2 == "2") {
		                			str += "<option value='2'>2학기</option>";
		                		}
	                		}
	                	}
	                	
	                	$("#term").empty();
	                	$("#term").append(str);
	                	clearPage();
	                }
	                
	                function prevTerm() { // 마지막 학기일 경우 alert, 무조건 강의한 이전학기로
	                	var $thisYear = $("select[name=year]");
	                	var $term = $("select[name=term]");
	                
	                	if(($thisYear.children().last().val() == $thisYear.val()) && ($term.children().first().val() == $term.val())) { // 마지막 학기
	                		alert("조회 내용이 없습니다.");
	                	}
	                	else {
							if($term.children().first().val() == $term.val()) { // 해 바뀜
								var $index = $thisYear.children("option:selected").index();
								$thisYear.children().eq($index+1).prop("selected", true).change();
	                			$term.children().last().prop("selected", true).change();
							}
							else {
		                		$term.children().first().prop("selected", true).change();
		                	}
	                	}
	                }
	                
	                function nextTerm() { // 마지막 학기일 경우 alert, 무조건 강의한 다음학기로
	                	var $thisYear = $("select[name=year]");
	                	var $term = $("select[name=term]");
	                	
	                	if(($thisYear.children().first().val() == $thisYear.val()) && ($term.children().last().val() == $term.val())) { // 마지막 학기
	                		alert("조회 내용이 없습니다.");
	                	}
	                	else {
	                		if($term.children().last().val() == $term.val()) { // 해 바뀜
		                		var $index = $thisYear.children("option:selected").index();
	                			$thisYear.children().eq($index-1).prop("selected", true).change();
	                			$term.children().first().prop("selected", true).change();
	                		}
	                		else {
		                		$term.children().last().prop("selected", true).change();
		                	}
	                	}
	                }
	                
	                function selectTimetable() {
	                	clearPage();
	                	
	                	$.ajax({
	                		url: "selectProfessorTimetable.pr",
	                		data: {
	                			year: $("#year").val(),
                				term: $("#term").val()
	                		},
	                		success: function(cList) {
								var str = "";
								for(var i=0;i<cList.length;i++) {
									/* top: 66.7*(period-1), left: 186*(day-1) */
									if(cList[i].period == 2) { // 2시간 강의
										str += "<div class='stClass_class" + i + "' style='top:" + 70*(cList[i].period-1) + "px; left:" + 185.7*(cList[i].day-1)
										+ "px; width:185.8px; height:140px;'><span style='margin: 20px auto; line-height: 200%;'>" + cList[i].className + "<br>" + cList[i].professorNo + "<br>" + cList[i].classroom + "</span></div>";
									}
									else { // 1시간 강의
										str += "<div class='stClass_class" + i + "' style='top:" + 70*(cList[i].period-1) + "px; left:" + 185.7*(cList[i].day-1)
												+ "px; width:185.8px; height:70px;'><span style='margin: 5px auto;'>" + cList[i].className + "<br>" + cList[i].professorNo + "<br>" + cList[i].classroom + "</span></div>";
									}
								}
								
								$(".area22").append(str);
	                		},
	                		error: function() {
	                			console.log("통신 오류");
	                		}
	                	})
	                }
	                
	                function clearPage() {
	                	$("div[class*=stClass_class]").remove();
	                }
				</script>
            </div>
        </div>
	</div>
</body>
</html>