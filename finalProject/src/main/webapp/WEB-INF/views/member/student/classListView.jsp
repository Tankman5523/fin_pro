<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의시간표</title>
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

        input[name=search_category] {
            opacity: 0;
            margin: 0 10px;
        }

        input[name=search_category]+label:hover {
            cursor: pointer;
        }

        input[name=search_category]:checked+label {
        	font-weight: 550;
            color:#00aeff;
            border-bottom: 2px solid #00aeff;
        }

        div[class*=content] {
            margin: 0 auto;
            width: 100%;
            height: 77%;
            display: none;
            overflow: hidden;
            padding-top: 10px;
        }
        
        .table-area, .table-area3, .table-area4 {
        	width: 100%;
        	height: 92%;
        	overflow: auto;
        }
        
        .table-area2 {
        	width: 100%;
        	height: 100%;
        	overflow: auto;
        }
        
        table[id*=class] {
			width: 100%;
			text-align: center;
			border-collapse: collapse;
		}
		
		table[id*=class]>thead {
			background-color: rgb(250, 250, 133);
        	position: sticky;
        	top: 0;
		}
		
		table[id*=class]>tbody>tr {
			border-bottom: 0.5px solid lightgray;
		}

		table[id*=class] td {
			border-left: 1px solid lightgray;
		}
		
		.setting_div {
			display: flex;
			width: 100%;
			height: 30px;
		}
		
		.setting_div * {
			margin-left: 1%;
			height: 100% !important;
			justify-content: center;
			line-height: 30px;
		}
    </style>
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
                    <a href="#" style="color:#00aeff; font-weight: 550;">강의시간표</a>
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
                    <button type="button" class="btn btn-outline-primary btn-sm" id="selectList" onclick="prevTerm();">이전 학기</button>
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
	                    			<td width="3%" style="border: 0;"></td> <!-- 강의계획서 첨부파일 -->
	                    			<td width="7%">강의번호</td>
	                    			<td width="20%">강의명</td>
	                    			<td width="7%">교수명</td>
	                    			<td width="12%">개설학과</td>
	                    			<td width="3%">학점</td>
	                    			<td width="3%">수강인원</td>
	                    			<td width="3%">여석</td>
	                    			<td width="27%">강의시간 (강의실)</td>
	                    			<td width="6%">수강대상</td>
	                    		</tr>
	                    	</thead>
	                    	<tbody id="class-table-tbody">
	                    		<tr>
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
	                    			<td width="3%" style="border: 0;"></td> <!-- 강의계획서 첨부파일 -->
	                    			<td width="7%">강의번호</td>
	                    			<td width="20%">강의명</td>
	                    			<td width="7%">교수명</td>
	                    			<td width="3%">학점</td>
	                    			<td width="3%">수강인원</td>
	                    			<td width="3%">여석</td>
	                    			<td width="27%">강의시간 (강의실)</td>
	                    			<td width="6%">수강대상</td>
	                    		</tr>
	                    	</thead>
	                    	<tbody id="class-table-tbody2">
	                    		<tr>
	                    			<td colspan="9" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
	                    		</tr>
	                    	</tbody>
	                    </table>
	               	</div>
                </div>
                
                <!-- 교수명 검색 -->
                <div class="content_searchPro">
                	<div class="setting_div">
	                	<span style="margin-left: 2%;">교수: </span> <input type="text" name="professorName" id="professorName">
	                	<button type="button" class="btn btn-primary btn-sm" id="selectList" onclick="searchProfessor();">검색</button>
                	</div>
                	<br>
                	
                	<div class="table-area3">
	                    <table id="class-table3">
	                    	<thead>
	                    		<tr>
	                    			<td width="3%" style="border: 0;"></td> <!-- 강의계획서 첨부파일 -->
	                    			<td width="7%">강의번호</td>
	                    			<td width="20%">강의명</td>
	                    			<td width="7%">교수명</td>
	                    			<td width="12%">개설학과</td>
	                    			<td width="3%">학점</td>
	                    			<td width="3%">수강인원</td>
	                    			<td width="3%">여석</td>
	                    			<td width="27%">강의시간 (강의실)</td>
	                    			<td width="6%">수강대상</td>
	                    		</tr>
	                    	</thead>
	                    	<tbody id="class-table-tbody3">
	                    		<tr>
	                    			<td colspan="10" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
	                    		</tr>
	                    	</tbody>
	                    </table>
	               	</div>
                </div>
                
                <!-- 과목 검색 -->
                <div class="content_searchSub">
                	<div class="setting_div">
                		<span style="margin-left: 2%;">검색어: </span> <input type="text" name="subjectName" id="subjectName">
	                	<button type="button" class="btn btn-primary btn-sm" id="selectList" onclick="searchSubject();">검색</button>
                	</div>
                	<br>
                	
                	<div class="table-area4">
	                    <table id="class-table4">
	                    	<thead>
	                    		<tr>
	                    			<td width="3%" style="border: 0;"></td> <!-- 강의계획서 첨부파일 -->
	                    			<td width="7%">강의번호</td>
	                    			<td width="20%">강의명</td>
	                    			<td width="7%">교수명</td>
	                    			<td width="12%">개설학과</td>
	                    			<td width="3%">학점</td>
	                    			<td width="3%">수강인원</td>
	                    			<td width="3%">여석</td>
	                    			<td width="27%">강의시간 (강의실)</td>
	                    			<td width="6%">수강대상</td>
	                    		</tr>
	                    	</thead>
	                    	<tbody id="class-table-tbody4">
	                    		<tr>
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
	                    changeYear($("#year"));
	                    
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
	                	selectCategory();
	                }
	                
	                function prevTerm() { // 마지막 학기일 경우 alert, 2학기->1학기, 1학기 -> 이전 년도 2학기
	                	var $thisYear = $("select[name=year]");
	                	var $term = $("select[name=term]");
	                
	                	if(($thisYear.children().last().val() == $thisYear.val()) && ($term.children().first().val() == $term.val())) { // 마지막 학기
	                		alert("조회 내용이 없습니다.");
	                	}
	                	else {
		                	if($term.val() == 1) { // 이전 년도 2학기로 바꿔야함
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
		                	if($term.val() == 2) { // 다음 년도 1학기로 바꿔야함
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
	                		$("#college").val("");
	                		$("#department").val("");
	                		$("#professorName").val("");
	                		$("#subjectName").val("");
	                		$("#class-table-tbody").html("<tr style='border: 0;'><td colspan='10' style='border: 0;'>해당 테이블에 데이터가 없습니다.</td></tr>");
	                		$("#class-table-tbody3").html("<tr style='border: 0;'><td colspan='10' style='border: 0;'>해당 테이블에 데이터가 없습니다.</td></tr>");
	                		$("#class-table-tbody4").html("<tr style='border: 0;'><td colspan='10' style='border: 0;'>해당 테이블에 데이터가 없습니다.</td></tr>");
                            $(this).css("display", "none");
                        });
	                	
	                    if($('#major').is(':checked')){
	                        $(".content_major").css("display", "block");
	                    }
	                    else if($('#elective').is(':checked')) {
	                        $(".content_elective").css("display", "block");
	                        
	                        $.ajax({
	                        	url: "selectElective.me",
	                        	data: {
	                        		year: $("#year").val(),
	                				term: $("#term").val()
	                        	},
	                        	success: function(cList) {
	                        		if(cList != "") {
	                        			var str = "";
	                					for(var i=0;i<cList.length;i++) {
		                					str += "<tr>";
		                					if(cList[i].fileNo == 0) {
		                						str += "<td style='border-left: 0;'></td>";
		                					}
		                					else { // 클릭하면 강의계획서 볼 수 있게
		                						str += "<td style='border-left: 0;'><i class='fa-solid fa-file-pdf fa-sm' style='color: #7cd7fe;'></i></td>";
		                					}
	                						 str += "<td>" + cList[i].classNo + "</td>"
	                						 + "<td>" + cList[i].className + "</td>"
	                						 + "<td>" + cList[i].professorNo + "</td>"
	                						 + "<td>" + cList[i].credit + "</td>"
	                						 + "<td>" + cList[i].classNos + "</td>"
	                						 + "<td>" + cList[i].classNos + "</td>" // 여석 계산**********************
	                						 + "<td>" + cList[i].day + " " + cList[i].period + " (" + cList[i].classroom + ")" + "</td>"
	                						 + "<td>" + cList[i].classLevel + "</td>";
		                				}
		                				$("#class-table-tbody2").empty();
		                				$("#class-table-tbody2").append(str);
	                				}
	                				else {
	                					$("#class-table-tbody2").empty();
	                					$("#class-table-tbody2").append("<td colspan='9' style='border: 0;''>해당 테이블에 데이터가 없습니다.</td>");
	                				}
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
	                	var str = "";
	                	
	                	if($department != "") {
	                		$.ajax({
	                			url: "selectDepartmentMajor.me",
	                			data: {
	                				department: $department,
	                				year: $("#year").val(),
	                				term: $("#term").val()
	                			},
	                			success: function(cList) {
	                				if(cList != "") {
	                					for(var i=0;i<cList.length;i++) {
		                					str += "<tr>";
		                					if(cList[i].fileNo == 0) {
		                						str += "<td style='border-left: 0;'></td>";
		                					}
		                					else { // 클릭하면 강의계획서 볼 수 있게
		                						str += "<td style='border-left: 0;'><i class='fa-solid fa-file-pdf fa-sm' style='color: #7cd7fe;'></i></td>";
		                					}
	                						 str += "<td>" + cList[i].classNo + "</td>"
	                						 + "<td>" + cList[i].className + "</td>"
	                						 + "<td>" + cList[i].professorNo + "</td>"
	                						 + "<td>" + cList[i].departmentNo + "</td>"
	                						 + "<td>" + cList[i].credit + "</td>"
	                						 + "<td>" + cList[i].classNos + "</td>"
	                						 + "<td>" + cList[i].classNos + "</td>" // 여석 계산**********************
	                						 + "<td>" + cList[i].day + " " + cList[i].period + " (" + cList[i].classroom + ")" + "</td>"
	                						 + "<td>" + cList[i].classLevel + "</td>";
		                				}
		                				$("#class-table-tbody").empty();
		                				$("#class-table-tbody").append(str);
	                				}
	                				else {
	                					alert("검색 결과가 없습니다.");
	                					$("#class-table-tbody").empty();
	                					$("#class-table-tbody").append("<td colspan='10' style='border: 0;''>해당 테이블에 데이터가 없습니다.</td>");
	                				}
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
	                			var str = "";
	                			
	                			if(cList != "") {
                					for(var i=0;i<cList.length;i++) {
	                					str += "<tr>";
	                					if(cList[i].fileNo == 0) {
	                						str += "<td style='border-left: 0;'></td>";
	                					}
	                					else { // 클릭하면 강의계획서 볼 수 있게
	                						str += "<td style='border-left: 0;'><i class='fa-solid fa-file-pdf fa-sm' style='color: #7cd7fe;'></i></td>";
	                					}
                						 str += "<td>" + cList[i].classNo + "</td>"
                						 + "<td>" + cList[i].className + "</td>"
                						 + "<td>" + cList[i].professorNo + "</td>"
                						 + "<td>" + cList[i].departmentNo + "</td>"
                						 + "<td>" + cList[i].credit + "</td>"
                						 + "<td>" + cList[i].classNos + "</td>"
                						 + "<td>" + cList[i].classNos + "</td>" // 여석 계산**********************
                						 + "<td>" + cList[i].day + " " + cList[i].period + " (" + cList[i].classroom + ")" + "</td>"
                						 + "<td>" + cList[i].classLevel + "</td>";
	                				}
	                				$("#class-table-tbody3").empty();
	                				$("#class-table-tbody3").append(str);
                				}
                				else {
                					alert("검색 결과가 없습니다.");
                					$("#class-table-tbody3").empty();
                					$("#class-table-tbody3").append("<td colspan='10' style='border: 0;''>해당 테이블에 데이터가 없습니다.</td>");
                				}
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
	                			var str = "";
	                			
	                			if(cList != "") {
                					for(var i=0;i<cList.length;i++) {
	                					str += "<tr>";
	                					if(cList[i].fileNo == 0) {
	                						str += "<td style='border-left: 0;'></td>";
	                					}
	                					else { // 클릭하면 강의계획서 볼 수 있게
	                						str += "<td style='border-left: 0;'><i class='fa-solid fa-file-pdf fa-sm' style='color: #7cd7fe;'></i></td>";
	                					}
                						 str += "<td>" + cList[i].classNo + "</td>"
                						 + "<td>" + cList[i].className + "</td>"
                						 + "<td>" + cList[i].professorNo + "</td>"
                						 + "<td>" + cList[i].departmentNo + "</td>"
                						 + "<td>" + cList[i].credit + "</td>"
                						 + "<td>" + cList[i].classNos + "</td>"
                						 + "<td>" + cList[i].classNos + "</td>" // 여석 계산**********************
                						 + "<td>" + cList[i].day + " " + cList[i].period + " (" + cList[i].classroom + ")" + "</td>"
                						 + "<td>" + cList[i].classLevel + "</td>";
	                				}
	                				$("#class-table-tbody4").empty();
	                				$("#class-table-tbody4").append(str);
                				}
                				else {
                					alert("검색 결과가 없습니다.");
                					$("#class-table-tbody4").empty();
                					$("#class-table-tbody4").append("<td colspan='10' style='border: 0;''>해당 테이블에 데이터가 없습니다.</td>");
                				}
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