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
		<%@include file="../../common/student_menubar.jsp" %>
		<div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="infoStudent.st">학적 정보 조회</a>
                </div>
                <div class="child_title">
                    <a href="personalTimetable.st" style="color:#00aeff; font-weight: 550;">개인 시간표</a>
                </div>
               <div class="child_title">
                    <a href="studentRestEnroll.st">휴/복학 신청</a>
                </div>
				<div class="child_title">
                    <a href="studentRestList.st">휴/복학 조회</a>
                </div>
                <div class="child_title">
                    <a href="graduationInfoForm.st">졸업 사정표</a>
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
	                	$("#term").children().first().prop("selected", true).change();
	                	$("div[class*=stClass_class]").remove();
	                }
	                
	                function prevTerm() { // 마지막 학기일 경우 alert, 무조건 재학한 이전학기로
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
	                
	                function nextTerm() { // 마지막 학기일 경우 alert, 무조건 재학한 다음학기로
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
	                	var $classSet = new Set();
						var $classArr = [];
						$("div[class*=stClass_class]").remove();
	                	
	                	$.ajax({
	                		url: "selectStudentTimetable.st",
	                		data: {
	                			year: $("#year").val(),
                				term: $("#term").val()
	                		},
	                		success: function(cList) {
								for(var i=0;i<cList.length;i++) {
									$classSet.add(cList[i].classNo); // 강의번호 중복없이 저장하기 위해 Set에 저장
								}
								$classArr = Array.from($classSet); // Array로 변환
								
								var str = "";
								var tmp = 0;
								for(var i=0;i<cList.length;i++) {
									var $index = $classArr.indexOf(cList[i].classNo);
									
									/* top: 70*(period-1), left: 186*(day-1) */
									if(cList[i].classNo == tmp) { // 2시간 강의
										str += "<div class='stClass_class" + $index + "' " /*색깔담고있는 class*/
											+ "style='top:" + 70*(cList[i-1].period-1) + "px; "
											+ "left:" + 186*(cList[i].day-1) + "px; "
											+ "width:185px; height:139px;'>"
											+ "<span style='margin: 20px auto;'>"
											+ cList[i].className + "<br>" + cList[i].professorNo + "<br>"
											+ cList[i].classroom + "</span></div>";
									}
									else { // 1시간 강의
										str += "<div class='stClass_class" + $index + "' " /*색깔담고있는 class*/
											+ "style='top:" + 70*(cList[i].period-1) + "px; "
											+ "left:" + 186*(cList[i].day-1)+ "px; "
											+ "width:185px; height:69px;'>"
											+ "<span style='margin: 5px auto; line-height: 130%;'>" 
											+ cList[i].className + "<br>" + cList[i].professorNo + "<br>" 
											+ cList[i].classroom + "</span></div>";
									}
									tmp = cList[i].classNo;
								}
								
								$(".area22").append(str);
	                		},
	                		error: function() {
	                			console.log("통신 오류");
	                		}
	                	})
	                }
				</script>
            </div>
        </div>
	</div>
</body>
</html>