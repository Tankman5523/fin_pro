<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의시간표</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
            margin-left: 30px;
        }

        input[name=search_category] {
            opacity: 0;
            margin: 0 10px;
        }

        input[name=search_category]+label:hover {
            cursor: pointer;
        }

        input[name=search_category]:checked+label {
            color:#00aeff;
            border-bottom: 2px solid #00aeff;
        }
        
        .content_major {
        	padding-top: 10px;
        }
        
        #college {
        	margin-left: 2%;
        }

        div[class*=content] {
            margin: 0 auto;
            width: 100%;
            height: 77%;
            display: none;
        }
        
        .table-area {
        	width: 100%;
        	height: 92%;
        	overflow: auto;
        }

		#class-table {
			width: 100%;
			text-align: center;
			border-collapse: collapse;
		}
		
		#class-table>thead {
			background-color: rgb(250, 250, 133);
        	position: sticky;
        	top: 0;
		}
		
		#class-table>tbody>tr {
			border-bottom: 0.5px solid lightgray;
		}
		
/* 		#class-table>tbody>tr>td { */
/* 			border-left: 0.5px solid black; */
/* 		} */

		#class-table td {
			border-left: 1px solid lightgray;
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
                    <a href="#">예비수강신청</a>
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
<!--                                             <option value="1">1학기</option> -->
<!--                                             <option value="2">2학기</option> -->
                                       </select>
                    <!-- 이전학기 다음학기 버튼 -->
                </div>
                <br>

                <input type="radio" name="search_category" id="major" onchange="selectCategory();" checked> <label for="major">단과대학 전공별</label>
                <input type="radio" name="search_category" id="elective" onchange="selectCategory();"> <label for="elective">교양</label>
                <input type="radio" name="search_category" id="search_pro" onchange="selectCategory();"> <label for="search_pro">교수명 검색</label>
                <input type="radio" name="search_category" id="search_sub" onchange="selectCategory();"> <label for="search_sub">과목 검색</label>
                <br>
                
                <!-- 학부 전공별 -->
                <div class="content_major">
                    <select name="colleage" id="college" onchange="selectCollege(this);">
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
                    <br><br>
                    
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
	                    		<tr style="border: 0;">
	                    			<td colspan="10" style="border: 0;">해당 테이블에 데이터가 없습니다.</td>
	                    		</tr>
	                    	</tbody>
	                    </table>
                    </div>
                </div>
                
                <!-- 교양 -->
                <div class="content_elective"></div>
                
                <!-- 교수명 검색 -->
                <div class="content_searchPro">
                	<span>교수: </span> <input type="text" name="professorName" id="professorName">
                	<button type="button" class="btn btn-primary btn-sm" id="selectList">검색</button>
                </div>
                
                <!-- 과목 검색 -->
                <div class="content_searchSub">
                	<span>검색어: </span> <input type="text" name="subjectName" id="subjectName">
                	<button type="button" class="btn btn-primary btn-sm" id="selectList">검색</button>
                </div>

                <script>
                	var arr = ${classTerm};
                
	                $(function() {
	                    $(".content_major").css("display", "block");
	                })
	                
	                function changeYear(e) {
	                	var $year = e.value;
	                	
	                	for(var i=0;i<arr.length;i++) {
	                		console.log(arr[i].substring(0,5));
	                		if(arr[i].substring(0,5).includes($year)) {
	                			console.log(arr[i]);
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
                            $(this).css("display", "none");
                        });
	                	
	                    if($('#major').is(':checked')){
	                        $(".content_major").css("display", "block");
	                    }
	                    else if($('#elective').is(':checked')) {
	                        $(".content_elective").css("display", "block");
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
	                			url: "selectDepartmentMajor.st",
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
	                						 + "<td>" + cList[i].classLevel + "학년 </td>";
		                				}
		                				$("#class-table-tbody").empty();
		                				$("#class-table-tbody").append(str);
	                				}
	                				else {
	                					alert("검색 결과가 없습니다.");
	                				}
	                			},
	                			error: function() {
	                				console.log("통신 오류");
	                			}
	                		})
	                	}
	                }
                </script>
            </div>
        </div>
	</div>
</body>
</html>