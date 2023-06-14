<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 시간표</title>
<style>
    .b_line {
        border: 0.5px solid lightgray;
        margin: 20px 0px;
    }

    .page_title {
        margin-top: 5px;
        margin-left: 5px;
        margin-bottom: 0px;
        font-weight: bold;
    }

    .selectTerm {
        display: flex;
        align-items: center;
    }

    .selectTerm * {
        margin-left: 10px;
    }

    #selectList {
        border-radius: 10px;
    }

    .schedule-area {
        display: flex;
        flex-flow: row wrap; /*줄 바꿈 가능*/
        width: 100%;
        height: 86%;
        border: 1px solid black;
        /* background-color: yellow; */
    }

    .schedule-area>div {
        width: 16.6666667%;
        height: 9.090909%;
        border: 0.5px solid black;
        text-align: center;
    }
    
    .schedule-area>div[class*=day], .schedule-area>div[class*=period] {
        line-height: 66px;
        font-size: large;
        font-weight: 600;
    }

    .student_class01 { background-color: #BE5EC2; }
    .student_class02 { background-color: #F862A7; }
    .student_class03 { background-color: #FF7B87; }
    .student_class04 { background-color: #FFA26A; }
    .student_class05 { background-color: #FFCE5E; }
    .student_class06 { background-color: #F9F871; }
    .student_class07 { background-color: #9BDE7E; }
    .student_class08 { background-color: #4BBC8E; }
    .student_class09 { background-color: #039590; }
    .student_class10 { background-color: #1C6E7D; }
</style>
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
                    <a href="#">휴/복학 신청</a>
                </div>
                <div class="child_title">
                    <a href="#">휴/복학 조회</a>
                </div>
                <div class="child_title">
                    <a href="#">졸업 사정표</a>
                </div>
                <div class="child_title">
                    <a href="#">졸업 확정 신고</a>
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
                    <span>학기: </span> <select name="term" id="term">
                                       </select>
                    <button type="button" class="btn btn-outline-primary btn-sm" id="selectList" style="margin-left:2%;" onclick="prevTerm();">이전 학기</button>
                    <button type="button" class="btn btn-outline-primary btn-sm" id="selectList" style="margin-left:0;" onclick="nextTerm();">다음 학기</button>
                </div>
                <div class="b_line"></div>

                <div class="schedule-area">
                    <div></div>
                    <div class="day1">월</div>
                    <div class="day2">화</div>
                    <div class="day3">수</div>
                    <div class="day4">목</div>
                    <div class="day5">금</div>
                    <div class="period01">1교시</div>
<!--                     <div class="student_class01">와플온도이론1</div> -->
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="period02">2교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="period03">3교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div  class="period04">4교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="period05">5교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="period06">6교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="period07">7교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="period08">8교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="period09">9교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="period10">10교시</div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                </div>

				<script>
					var arr = ${classTerm};
	                
	                $(function() {
	                	$("select[name=year]").children().first().prop("selected", true).change();
	                	selectTimetable();
	                    
	                	$(".selectTerm").on("change", "#term", function() {
	                		selectTimetable();
	                	});
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
	                	clearPage();
	                	
	                	$.ajax({
	                		url: "selectTimetable.st",
	                		data: {
	                			year: $("#year").val(),
                				term: $("#term").val()
	                		},
	                		success: function(cList) {
	                			console.log(cList);
	                		},
	                		error: function() {
	                			console.log("통신 오류");
	                		}
	                	})
	                }
	                
	                function clearPage() {
	                	console.log("clearPage");
	                }
				</script>
            </div>
        </div>
	</div>
</body>
</html>