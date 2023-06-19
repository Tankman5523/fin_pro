<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학기별 성적 조회</title>
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

    .wholeGrade-area {
        width: 100%;
        height: 30%;
        overflow: auto;
    }
    
    .transcript {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    
    .transcript * {
        margin: 0 7px;
    }

    .transcript>input {
        width: 150px;
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
	    margin-left: 20px;
	}

    .termGrade-area {
        width: 100%;
        height: 33%;
        overflow: auto;
    }
    
    .wholeGrade-table, .termGrade-table {
		width: 100%;
		text-align: center;
		border-collapse: collapse;
	}
	
	.wholeGrade-table>thead, .termGrade-table>thead {
		background-color: #76D2FF;
	    position: sticky;
	    top: 0;
	}
	
	.wholeGrade-table>thead>tr, .termGrade-table>thead>tr {
		font-size: 17px;
	}
	
	.wholeGrade-table>tbody>tr, .termGrade-table>tbody>tr {
		border-bottom: 0.5px solid gray;
		height: 30px;
	}
	
/* 	.termGrade-table>tbody>tr:not(.no-hover):hover { */
/* 		background-color: #E0E0E0; */
/* 		font-weight: 550; */
/* 	} */
	
	.wholeGrade-table th, .wholeGrade-table td, .termGrade-table th, .termGrade-table td {
		border-left: 1px solid gray;
	}
</style>
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/student_menubar.jsp" %>
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">수업관리</span>
                </div>
                <div class="child_title">
                    <a href="classManagement.st" style="color:#00aeff; font-weight: 550;">학기별 성적 조회</a>
                </div>
                <div class="child_title">
                    <a href="#">성적 이의신청</a>
                </div>
            </div>
            <div id="content_1">
                <br>
				<span class="page_title">학기별 성적</span>
                <div class="b_line"></div>

                <div class="wholeGrade-area">
                    <table class="wholeGrade-table">
                        <thead>
                            <tr height="40">
                                <th width="15%" style="border-left: 1px solid #76D2FF;">학년도</th>
                                <th width="15%">학기</th>
                                <th width="10%">신청학점</th>
                                <th width="10%">취득학점</th>
                                <th width="12%">평점계</th>
                                <th width="14%">학기별석차</th>
                                <th width="14%">전체석차</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="no-hover" style="border: 0;">
                    			<td colspan="7" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
                    		</tr>
                        </tbody>
                    </table>
                </div>
                <div class="b_line"></div>
                
                <div class="transcript">
                	<br><br>
                    <span>증명신청학점:</span> <input type="text" id="" value="130" readonly>
                    <span>증명취득학점:</span> <input type="text" id="" value="130" readonly> 
                    <span>증명평점계:</span> <input type="text" id="" value="3.8" readonly>
                    <span>증명평점평균:</span> <input type="text" id="" value="92" readonly>
                    <br><br>
                </div>
                <div class="b_line"></div>

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
                <br>

                <div class="termGrade-area">
                    <table class="termGrade-table">
                        <thead>
                            <tr height="40">
                                <th width="15%" style="border-left: 1px solid #76D2FF;">이수학년도</th>
                                <th width="13%">이수학기</th>
                                <th width="12%">과목번호</th>
                                <th width="18%">과목명</th>
                                <th width="12%">담당교수</th>
                                <th width="10%">과목학점</th>
                                <th width="10%">성적</th>
                                <th width="10%">등급</th>
                            </tr>
                        </thead>
                        <tbody>
                             <tr class="no-hover" style="border: 0;">
                    			<td colspan="8" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
                    		</tr>
                        </tbody>
                    </table>
                </div>

                <script>
	                var arr = ${classTerm};
	                
	                $(function() {
	                    $("select[name=year]").children().first().prop("selected", true).change();
	                    selectClassList();
	                    
	                	$(".selectTerm").on("change", "#term", function() {
	                		selectClassList();
	                	});
	                })
	                
	                function changeYear(e) {
	                	var $year = e.value;
	                	var count=0;
	                	var str = "";
	                	
	                	for(var i=0;i<arr.length;i++) {
	                		var tmp = arr[i].toString().substr(0,4);
	                		if(tmp.includes($year)) {
	                			count++;
	                		}
	                	}
	                	
	                	str += "<option value='1'>1학기</option>";
	                	if(count==2) {
	                		str += "<option value='2'>2학기</option>";
	                	}
	                	
	                	$("#term").empty();
	                	$("#term").append(str);
// 	                	clearPage();
	                }
	                
	                function prevTerm() { // 마지막 학기일 경우 alert, 2학기->1학기, 1학기 -> 이전 년도 2학기
	                	var $thisYear = $("select[name=year]");
	                	var $term = $("select[name=term]");
	                
	                	if(($thisYear.children().last().val() == $thisYear.val()) && ($term.children().first().val() == $term.val())) { // 마지막 학기
	                		alert("조회 내용이 없습니다.");
	                	}
	                	else {
	                		if($term.children().first().val() == $term.val()) { // 이전 년도 2학기로 바꿔야함
				                var $index = $thisYear.children("option:selected").index();
		                		$thisYear.children().eq($index+1).prop("selected", true).change();
	                			$term.children().last().prop("selected", true).change();
		                	}
		                	else { // 같은 년도 1학기로 바꿔야함
		                		$term.children().first().prop("selected", true).change();
		                	}
	                	}
	                }
	                
	                function nextTerm() { // 마지막 학기일 경우 alert, 1학기 -> 2학기, 2학기 -> 다음 년도 1학기
	                	var $thisYear = $("select[name=year]");
	                	var $term = $("select[name=term]");
	                	
	                	if(($thisYear.children().first().val() == $thisYear.val()) && ($term.children().last().val() == $term.val())) { // 마지막 학기
	                		alert("조회 내용이 없습니다.");
	                	}
	                	else {
		                	if($term.children().last().val() == $term.val()) { // 다음 년도 1학기로 바꿔야함
		                		var $index = $thisYear.children("option:selected").index();
	                			$thisYear.children().eq($index-1).prop("selected", true).change();
	                			$term.children().first().prop("selected", true).change();
	                		}
	                		else { // 같은 년도 2학기로 바꿔야함
		                		$term.children().last().prop("selected", true).change();
		                	}
	                	}
	                }
	                
	                function selectClassList() {
// 	                	clearPage();
						var str = "";
	                	
	                	$.ajax({
	                		url: "selectClassList.st",
	                		data: {
	                			year: $("#year").val(),
                				term: $("#term").val()
	                		},
	                		success: function(cList) {
	                			if(cList != "") {
	                				for(var i=0;i<cList.length;i++) {
										str += "<tr>"
											 + "<td style='border: 0;'>" + cList[i].classYear + "</td>"
											 + "<td>" + cList[i].classTerm + "</td>"
											 + "<td>" + cList[i].classNo + "</td>"
											 + "<td>" + cList[i].className + "</td>"
											 + "<td>" + cList[i].professorName + "</td>"
											 + "<td>" + cList[i].credit + "</td>"
											 + "<td>" + cList[i].score + "</td>"
											 + "<td>" + cList[i].gradeLevel + "</td>"
											 + "</tr>";
									}
	                			}
	                			else {
	                				str += "<tr class='no-hover' style='border: 0;'><td colspan='8' style='border: 0;''>해당 테이블에 데이터가 없습니다.</td></tr>";
	                			}
								
								$(".termGrade-table>tbody").empty();
								$(".termGrade-table>tbody").append(str);
	                		},
	                		error: function() {
	                			console.log("통신 오류");
	                		}
	                	})
	                }
	                
	                function clearPage() {
// 	                	$("div[class*=stClass_class]").remove();
	                }
                </script>
            </div>
        </div>
    </div>
</body>
</html>