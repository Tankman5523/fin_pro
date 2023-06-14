<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의시간표</title>
<link rel="stylesheet" href="resources/css/classListView.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/student_menubar.jsp" %>
		<div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">수강신청</span>
                </div>
                <div class="child_title">
                    <a href="classListView.st" style="color:#00aeff; font-weight: 550;">강의시간표</a>
                </div>
                <div class="child_title">
                    <a href="registerClassForm.st">수강신청</a>
                </div>
                <div class="child_title">
                    <a href="#">수강취소</a>
                </div>
                <div class="child_title">
                    <a href="#">수강신청 내역조회</a>
                </div>
                <div class="child_title">
                    <a href="preRegisterClass.st">예비수강신청</a>
                </div>
            </div>
            <div id="content_1">
				<br>
                <span class="page_title">전체 강의 목록 조회</span>
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

                <input type="radio" name="search_category" id="major" onchange="selectCategory();" checked> <label for="major">단과대학 전공별</label>
                <input type="radio" name="search_category" id="elective" onchange="selectCategory();"> <label for="elective">교양</label>
                <input type="radio" name="search_category" id="search_pro" onchange="selectCategory();"> <label for="search_pro">교수명 검색</label>
                <input type="radio" name="search_category" id="search_sub" onchange="selectCategory();"> <label for="search_sub">과목 검색</label>
                <br>
                
                <!-- 학부 전공별 -->
                <div class="content_major">
                	<div class="setting_div">
	                    <select name="colleage" id="college" style="margin-left: 2%;" onchange="selectCollege(this);">
	                        <option value=""> ==단과대학== </option>
	                        <option value="인문대학">인문대학</option>
	                        <option value="사회과학대학">사회과학대학</option>
	                        <option value="교육대학">교육대학</option>
	                        <option value="자연대학">자연대학</option>
	                        <option value="공학대학">공학대학</option>
	                        <option value="미술대학">미술대학</option>
	                        <option value="예술대학">예술대학</option>
	                    </select>
	                    <select name="department" id="department">
	                        <option value=""> ====전공==== </option>
	                    </select>
	                    <button type="button" class="btn btn-primary btn-sm" id="selectList" onclick="selectMajor();">조회</button>
                	</div>
                    <br>
                    
                    <div class="table-area">
	                    <table id="class-table">
	                    	<thead>
	                    		<tr>
	                    			<th width="3%" style="border: 0;"></th> <!-- 강의계획서 첨부파일 -->
	                    			<th width="6%">강의번호</th>
	                    			<th width="20%">강의명</th>
	                    			<th width="7%">교수명</th>
	                    			<th width="12%">개설학과</th>
	                    			<th width="3%">학점</th>
	                    			<th width="3%">수강인원</th>
	                    			<th width="3%">여석</th>
	                    			<th width="26%">강의시간 (강의실)</th>
	                    			<th width="8%">수강대상</th>
	                    		</tr>
	                    	</thead>
	                    	<tbody id="class-table-tbody">
	                    		<tr class="no-hover">
	                    			<td colspan="10" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
	                    		</tr>
	                    	</tbody>
	                    </table>
                    </div>
                </div>
                
                <!-- 교양 -->
                <div class="content_elective">
                	<div class="table-area2">
	                    <table id="class-table2">
	                    	<thead>
	                    		<tr>
	                    			<th width="3%" style="border: 0;"></th> <!-- 강의계획서 첨부파일 -->
	                    			<th width="6%">강의번호</th>
	                    			<th width="20%">강의명</th>
	                    			<th width="7%">교수명</th>
	                    			<th width="12%">개설학과</th>
	                    			<th width="3%">학점</th>
	                    			<th width="3%">수강인원</th>
	                    			<th width="3%">여석</th>
	                    			<th width="26%">강의시간 (강의실)</th>
	                    			<th width="8%">수강대상</th>
	                    		</tr>
	                    	</thead>
	                    	<tbody id="class-table-tbody2">
	                    		<tr class="no-hover">
	                    			<td colspan="10" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
	                    		</tr>
	                    	</tbody>
	                    </table>
	               	</div>
                </div>
                
                <!-- 교수명 검색 -->
                <div class="content_searchPro">
                	<div class="setting_div">
	                	<input type="text" name="professorName" id="professorName" placeholder="교수명을 입력하세요." style="margin-left: 2%; width:20%;">
	                	<button type="button" class="btn btn-primary btn-sm" id="selectList" onclick="searchProfessor();">검색</button>
                	</div>
                	<br>
                	
                	<div class="table-area3">
	                    <table id="class-table3">
	                    	<thead>
	                    		<tr>
	                    			<th width="3%" style="border: 0;"></th> <!-- 강의계획서 첨부파일 -->
	                    			<th width="6%">강의번호</th>
	                    			<th width="20%">강의명</th>
	                    			<th width="7%">교수명</th>
	                    			<th width="12%">개설학과</th>
	                    			<th width="3%">학점</th>
	                    			<th width="3%">수강인원</th>
	                    			<th width="3%">여석</th>
	                    			<th width="26%">강의시간 (강의실)</th>
	                    			<th width="8%">수강대상</th>
	                    		</tr>
	                    	</thead>
	                    	<tbody id="class-table-tbody3">
	                    		<tr class="no-hover">
	                    			<td colspan="10" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
	                    		</tr>
	                    	</tbody>
	                    </table>
	               	</div>
                </div>
                
                <!-- 과목 검색 -->
                <div class="content_searchSub">
                	<div class="setting_div">
                		<input type="text" name="subjectName" id="subjectName" placeholder="검색어를 입력하세요." style="margin-left: 2%; width:20%;">
	                	<button type="button" class="btn btn-primary btn-sm" id="selectList" onclick="searchSubject();">검색</button>
                	</div>
                	<br>
                	
                	<div class="table-area4">
	                    <table id="class-table4">
	                    	<thead>
	                    		<tr>
	                    			<th width="3%" style="border: 0;"></th> <!-- 강의계획서 첨부파일 -->
	                    			<th width="6%">강의번호</th>
	                    			<th width="20%">강의명</th>
	                    			<th width="7%">교수명</th>
	                    			<th width="12%">개설학과</th>
	                    			<th width="3%">학점</th>
	                    			<th width="3%">수강인원</th>
	                    			<th width="3%">여석</th>
	                    			<th width="26%">강의시간 (강의실)</th>
	                    			<th width="8%">수강대상</th>
	                    		</tr>
	                    	</thead>
	                    	<tbody id="class-table-tbody4">
	                    		<tr class="no-hover">
	                    			<td colspan="10" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
	                    		</tr>
	                    	</tbody>
	                    </table>
	               	</div>
                </div>

                <script>
                	var arr = ${classTerm};
                
	                $(function() {
	                    $(".content_major").css("display", "block");
	                    $("select[name=year]").children().first().prop("selected", true).change();
	                    
	                	$(".selectTerm").on("change", "#term", function() {
	                		selectCategory();
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
	                	clearPage();
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
	
	                function selectCategory() {
	                	$("div[class*=content]").each(function() {
                            $(this).css("display", "none");
                        });
	                	clearPage();
	                	
	                    if($('#major').is(':checked')){
	                        $(".content_major").css("display", "block");
	                    }
	                    else if($('#elective').is(':checked')) {
	                        $(".content_elective").css("display", "block");
	                        
	                        $.ajax({
	                        	url: "selectDepartment.me",
	                        	data: {
	                        		department: "교양",
	                        		year: $("#year").val(),
	                				term: $("#term").val()
	                        	},
	                        	success: function(cList) {
	                        		var str = drawTable(cList);
	                				$("#class-table-tbody2").empty();
	                				$("#class-table-tbody2").append(str);
	                        	},
	                        	error: function() {
	                        		console.log("통신 오류");
	                        	}
	                        })
	                    }
	                    else if($('#search_pro').is(':checked')) {
	                        $(".content_searchPro").css("display", "block");
	                    }
	                    else if($('#search_sub').is(':checked')) {
	                        $(".content_searchSub").css("display", "block");
	                    }
	                }
	
	                function selectCollege(e) {
	                	$("#class-table-tbody").html("<tr class='no-hover' style='border: 0;'><td colspan='10' style='border: 0;'>해당 테이블에 데이터가 없습니다.</td></tr>");
	                    var $college = e.value;
	                    var str = "";
	                    
	                    $.ajax({
	                    	url: "selectDepart.me",
	                    	data: {college: $college},
	                    	success: function(dList) {
	                    		$("#department").empty();
	                    		str += "<option value=''> ====전공==== </option>";
	                    		for(var i=0;i<dList.length;i++) {
	                    			str += "<option value='" + dList[i] + "'>" + dList[i] + "</option>";
	                    		}
	                    		$("#department").append(str);
	                    	},
	                    	error: function() {
	                    		console.log("통신 오류");
	                    	}
	                    })
	                }
	                
	                function selectMajor() {
	                	var $department = $("#department").val();
	                	
	                	if($department != "") {
	                		$.ajax({
	                			url: "selectDepartment.me",
	                			data: {
	                				department: $department,
	                				year: $("#year").val(),
	                				term: $("#term").val()
	                			},
	                			success: function(cList) {
	                				var str = drawTable(cList);
	                				$("#class-table-tbody").empty();
	                				$("#class-table-tbody").append(str);
	                			},
	                			error: function() {
	                				console.log("통신 오류");
	                			}
	                		})
	                	}
	                }
	                
	                function searchProfessor() {
	                	$.ajax({
	                		url: "searchClassKeyword.me",
	                		data: {
	                			condition: "professor",
	                			keyword: $("#professorName").val(),
                				year: $("#year").val(),
                				term: $("#term").val()
	                		},
	                		success: function(cList) {
	                			var str = drawTable(cList);
	                			$("#class-table-tbody3").empty();
                				$("#class-table-tbody3").append(str);
	                		},
	                		error: function() {
	                			console.log("통신 오류");
	                		}
	                	})
	                }
	                
	                function searchSubject() {
	                	$.ajax({
	                		url: "searchClassKeyword.me",
	                		data: {
	                			condition: "subject",
	                			keyword: $("#subjectName").val(),
                				year: $("#year").val(),
                				term: $("#term").val()
	                		},
	                		success: function(cList) {
	                			var str = drawTable(cList);
	                			$("#class-table-tbody4").empty();
                				$("#class-table-tbody4").append(str);
	                		},
	                		error: function() {
	                			console.log("통신 오류");
	                		}
	                	})
	                }
	                
	                function drawTable(cList) {
	                	var str = "";
            			if(cList != "") {
        					for(var i=0;i<cList.length;i++) {
            					str += "<tr>";
            					if(cList[i].fileNo == null) {
            						str += "<td style='border-left: 0;'></td>";
            					}
            					else { // 클릭하면 강의계획서 볼 수 있게
            						str += "<td style='border-left: 0;'><i class='fa-solid fa-file-pdf fa-sm fileDown' style='color: #7cd7fe;'></i></td>";
            					}
        						 str += "<td>" + cList[i].classNo + "</td>"
        						 + "<td>" + cList[i].className + "</td>"
        						 + "<td>" + cList[i].professorNo + "</td>"
        						 + "<td>" + cList[i].departmentNo + "</td>"
        						 + "<td>" + cList[i].credit + "</td>"
        						 + "<td>" + cList[i].classNos + "</td>"
        						 + "<td>" + cList[i].spareNos + "</td>"
        						 + "<td>" + cList[i].day + " " + cList[i].period + " (" + cList[i].classroom + ")" + "</td>"
        						 + "<td>" + cList[i].classLevel + "</td></tr>";
            				}
        				}
        				else {
        					str += "<tr class='no-hover' style='border: 0;'><td colspan='10' style='border: 0;'>해당 테이블에 데이터가 없습니다</td></tr>";
        				}
            			
            			return str;
	                }
	                
	                function clearPage() {
	                	$("#college").val("");
                		$("#department").val("");
                		$("#professorName").val("");
                		$("#subjectName").val("");
	                	$("tbody[id*=tbody]").each(function() {
	                		$(this).html("<tr class='no-hover' style='border: 0;'><td colspan='10' style='border: 0;'>해당 테이블에 데이터가 없습니다.</td></tr>");
	                	});
	                }
                </script>
            </div>
        </div>
	</div>
</body>
</html>