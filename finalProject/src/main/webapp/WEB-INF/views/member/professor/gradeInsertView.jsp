<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성적 관리</title>
<link rel="stylesheet" href="resources/css/gradeInsertView.css">
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/professor_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%>
    	<c:if test="${check eq 'impossible' }">
    		<script>
	    		alert("성적입력 및 수정이 불가능합니다.");
    		</script>
    	</c:if>
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">수업관리</span>
                </div>
                <div class="child_title">
                    <a href="professorGradeReport.pr">성적 이의신청 조회</a>
                </div>
                <div class="child_title">
                    <a href="gradeInsert.pr" style="color:#00aeff; font-weight: 550;">성적 관리</a>
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
                    <span>교과목명: </span> <select name="classList" id="classList"></select>
                    <button type="button" class="btn btn-outline-primary btn-sm" id="selectList" onclick="selectStudentGradeList();">조회</button>
                    <c:if test="${check eq 'possible' }">
	                    <button type="button" class="btn btn-warning" id="possible" onclick="possibleInsert();">성적 입력</button>
	                    <button type="button" class="btn btn-danger" id="impossible" onclick="impossibleInsert();">입력 완료</button>
                    </c:if>
                </div>
                <div class="b_line"></div>

                <div class="student-count" align="right" style="">
                	<span style="margin: 10px; font-weight: 600; padding: 5px 5px 0 5px;"></span>
                </div>
                <div class="student-area" style="height: 710px;">
                    <table class="student-table">
                        <thead>
                            <tr height="40">
                                <th width="25%" style="border-left: 1px solid #88C1E3;">학과</th>
                                <th width="21%">학번</th>
                                <th width="12%">학년</th>
                                <th width="18%">이름</th>
                                <th width="12%">성적</th>
                                <th width="12%">등급</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
                
                <script>
	                var arr = ${classTerm};
	                
	                $(function() {
	                	$("select[name=year]").children().first().prop("selected", true).change();
	                	selectClassList();
	                	$("button[id*=possible]").prop("disabled", true);
	                	$("button[id*=possible]").css("display", "none");
	                    
	                	$(".selectTerm").on("change", "#term", function() {
	                		selectClassList();
	                		$("button[id*=possible]").prop("disabled", true);
	                		$("button[id*=possible]").css("display", "none");
	                	});
	                	
	                	$(".selectTerm").on("change", "#classList", function() {
	                		$(".student-count>span").css("border", "0");
	                		$(".student-count>span").html("");
	                		$(".student-table>tbody").html("");
	                		$("button[id*=possible]").prop("disabled", true);
	                		$("button[id*=possible]").css("display", "none");
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
	                	$("#term").children().first().prop("selected", true).change();
	                	selectClassList();
	                }
	                
	               function selectClassList() {
	            	   $(".student-table>tbody").html("");
	            	   var str = "";
               		
	               		$.ajax({
	               			url: "selectProfessorTimetable.pr",
	               			data: {
	               				year: $("#year").val(),
	               				term: $("#term").val()
	               			},
	               			success: function(cList) {
	               				for(var i=0;i<cList.length;i++) {
	               					str += "<option value='" + cList[i].classNo + "'>"
	               						 + cList[i].className + "</option>";
	               				}
			               		
			               		$("#classList").empty();
			                	$("#classList").append(str);
	               			},
	               			error: function() {
	               				console.log("통신 오류");
	               			}
	               		});
	               }
	               
	               function selectStudentGradeList() {
	            	   var str1 = "";
	            	   var str2 = "";
	            	   
	            	   $.ajax({
	            		   url: "selectStudentGradeList.pr",
	            		   data: { cn: $("#classList").val() },
	            		   success: function(sList) {
	            			   if(sList.length != 1) {
		            			   str1 += "정원: " + sList[0].allCount + "명 "
		            			   		 + "A: " + sList[0].aCount + "명  "
		            			   		 + "B: " + sList[0].bCount + "명  "
		            			   		 + "C: " + sList[0].cCount + "명  "
		            			   		 + "D: " + sList[0].dCount + "명  "
		            			   		 + "F: " + sList[0].fCount + "명  ";
		            			   for(var i=1;i<sList.length;i++) {
		            				   str2 += "<tr>"
		            				   		+ "<td style='border: 0;'>" + sList[i].departmentName + "</td>"
		            				   		+ "<td>" + sList[i].studentNo + "</td>"
		            				   		+ "<td>" + sList[i].classLevel + "</td>"
		            				   		+ "<td>" + sList[i].studentName + "</td>"
		            				   		+ "<td>" + sList[i].score + "</td>"
		            				   		+ "<td>" + sList[i].gradeLevel + "</td>"
		            				   		+ "</tr>";
		            			   }
		            			   
		            			   if($("#possible").css("display") == "none" && $("#impossible").css("display") == "none") {
		            				   $("#possible").css("display", "block");
		            				   
		            				   var date = new Date();

		            				   var $year = date.getFullYear();
		            				   var $month = date.getMonth() + 1;
		            				   if($year == $("#year").val()) { // 년도 체크
		            				   	   if($("#term").val()==1 && (3<=$month&&$month<=7)) {
		            				   		$("#possible").prop("disabled", false);
		            				   	   }
		            				   	   else if($("#term").val()==2 && (9<=$month&&$month<=12)) {
		            				   		$("#possible").prop("disabled", false);
		            				   	   }
		            				   }
		            			   }
		            			   
		            			   $(".student-count>span").css("border", "1px solid black");
		            			   $(".student-count>span").css("border-bottom", "0");
	            			   }
	            			   else {
		            			   $(".student-count>span").css("border", "0");
	            				   str2 += "<tr class='no_hover' style='border: 0; pointer-events: none;'><td colspan='6' style='border: 0;'>해당 테이블에 데이터가 없습니다</td></tr>";
	            			   }
	            			   
	            			   $(".student-count>span").html(str1);
	            			   $(".student-table>tbody").html(str2);
	            		   },
	            		   error: function() {
	            			   console.log("통신 오류");
	            		   }
	            	   })
	               }
	               
	               function possibleInsert() {
	            	   $(".student-table>tbody").on("click", "tr", function() {
	            		   var $gradeLevel = $(this).children().eq(5).text();
	            		   
	                		$(".departmentName").val($(this).children().eq(0).text());
	                		$(".studentNo").val($(this).children().eq(1).text());
	                		$(".classLevel").val($(this).children().eq(2).text());
	                		$(".studentName").val($(this).children().eq(3).text());
	                		$(".score").val($(this).children().eq(4).text());
	                		$(".gradeLevel").val($(this).children().eq(5).text());
	                		
	                		if($gradeLevel == " ") {
	                			$("#insert").css("display", "block");
	                			$("#update").css("display", "none");
	                		}
	                		else {
	                			$("#insert").css("display", "none");
	                			$("#update").css("display", "block");
	                		}
	                		
	                		$("#myModal").modal("show");
	               	   });
	            	   
	            	   $("#possible").css("display", "none");
	            	   $("#impossible").css("display", "block");
	            	   $("#impossible").prop("disabled", false);
	            	   $(".student-table>tbody>tr").hover(function() {
	            		   $(this).css("cursor", "pointer");
	            	   });
	               }
	               
	               function impossibleInsert() {
	            	   $(".student-table>tbody").off("click", "tr");
	            	   $("#possible").css("display", "block");
	            	   $("#possible").prop("disabled", false);
	            	   $("#impossible").css("display", "none");
	            	   $(".student-table>tbody>tr").hover(function() {
	            		   $(this).css("cursor", "default");
	            	   });
	               }
	               
	               function scoreInsert(e) {
	            	   var $score = Number(e.value);
	            	   var $grade = "";
	            	   
	            	   if(0<= $score && $score < 60) {
						   $grade = "F";
	            	   }
	            	   else if(60<= $score && $score <= 63) {
	            		   $grade = "D-";
	            	   }
	            	   else if(64<= $score && $score <= 66) {
	            		   $grade = "D0";
	            	   }
	            	   else if(67<= $score && $score <= 69) {
	            		   $grade = "D+";
	            	   }
	            	   else if(70<= $score && $score <= 73) {
	            		   $grade = "C-";
	            	   }
	            	   else if(74<= $score && $score <= 76) {
	            		   $grade = "C0";
	            	   }
	            	   else if(77<= $score && $score <= 79) {
	            		   $grade = "C+";
	            	   }
	            	   else if(80<= $score && $score <= 83) {
	            		   $grade = "B-";
	            	   }
	            	   else if(84<= $score && $score <= 86) {
	            		   $grade = "B0";
	            	   }
	            	   else if(87<= $score && $score <= 89) {
	            		   $grade = "B+";
	            	   }
	            	   else if(90<= $score && $score <= 93) {
	            		   $grade = "A-";
	            	   }
	            	   else if(94<= $score && $score <= 96) {
	            		   $grade = "A0";
	            	   }
	            	   else if(97<= $score && $score <= 100) {
	            		   $grade = "A+";
	            	   }
	            	   else {
	            		   alert("0~100 사이의 숫자를 입력해주세요.");
	            		   $(".score").val("");
	            	   }
	            	   $(".gradeLevel").val($grade);
	               }
	               
	               function gradeInsert() {
	               		$.ajax({
	               			url: "gradeInsert.pr",
	               			method: "post",
	               			data: {
	               				classNo: $("#classList").val(),
	               				studentNo: $(".studentNo").val(),
	               				score: $(".score").val(),
	               				gradeLevel: $(".gradeLevel").val()
	               			},
	               			success: function(result) {
	               				if(result=='Y') { // 성적 입력 성공
	               					alert("성적이 입력되었습니다.");
	               					$("#myModal").modal("hide");
	               					selectStudentGradeList();
	               					socket.send("gradeInsert,"+$(".studentNo").val()+","+"${loginUser.professorName}");
	               				}
	               				else if(result=='N') {
	               					alert("성적 입력 실패");
	               				}
	               				else { // 성적 비율 초과
	               					alert("성적 입력이 가능한 비율을 초과하였습니다.");
	               				}
	               			},
	               			error: function() {
	               				console.log("통신 오류");
	               			}
	               		});
	               	}
	               
	               function gradeUpdate() {
	               		$.ajax({
	               			url: "gradeUpdate.pr",
	               			method: "post",
	               			data: {
	               				classNo: $("#classList").val(),
	               				studentNo: $(".studentNo").val(),
	               				score: $(".score").val(),
	               				gradeLevel: $(".gradeLevel").val()
	               			},
	               			success: function(result) {
	               				if(result=='Y') { // 성적 입력 성공
	               					alert("성적이 수정되었습니다.");
	               					$("#myModal").modal("hide");
	               					selectStudentGradeList();
	               					socket.send("gradeUpdate,"+$(".studentNo").val()+","+"${loginUser.professorName}");
	               				}
	               				else if(result=='N') {
	               					alert("성적 수정 실패");
	               				}
	               				else { // 성적 비율 초과
	               					alert("성적 입력이 가능한 비율을 초과하였습니다.");
	               				}
	               			},
	               			error: function() {
	               				console.log("통신 오류");
	               			}
	               		});
	               	}
                </script>
            </div>
            
            <!-- The Modal -->
		    <div class="modal" id="myModal">
		        <div class="modal-dialog modal-dialog-centered">
		            <div class="modal-content">
		        
		                <!-- Modal Header -->
		                <div class="modal-header">
		                <h4 class="modal-title">성적 입력</h4>
		                	<button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		        
		                <!-- Modal body -->
		                <div class="modal-body">
	                		<input type="hidden" name="classNo" class="classNo">
					                   학과: <input style="margin: 0 30px 0 10px; width: 150px;" type="text" class="departmentName" readonly>
					                   학번: <input style="margin: 0 20px 0 10px; width: 150px;" type="text" class="studentNo" readonly> <br><br>
					                   학년: <input style="margin: 0 30px 0 10px; width: 150px;" type="text" class="classLevel" readonly>
					                   이름: <input style="margin: 0 20px 0 10px; width: 150px;" type="text" class="studentName" readonly> <br><br>
					                   성적: <input style="margin: 0 30px 0 10px; width: 150px;" type="number" min="0" max="100" class="score" onchange="scoreInsert(this);">
					                   등급: <input style="margin: 0 20px 0 10px; width: 150px;" type="text" class="gradeLevel" readonly>
			                <br><br><br>
			                
			            	<button type="button" class="btn btn-warning" id="insert" onclick="gradeInsert();">등록</button>
			            	<button type="button" class="btn btn-warning" id="update" onclick="gradeUpdate();">수정</button>
		                </div>
		            </div>
		        </div>
		    </div>
        </div>
    </div>
</body>
</html>