<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 : Feasible University</title>
<link rel="stylesheet" href="resources/css/regClassForm.css">
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
                    <a href="classListView.st">강의시간표</a>
                </div>
                <div class="child_title">
                    <a href="registerClassForm.st" style="color:#00aeff; font-weight: 550;">수강신청</a>
                </div>
                <div class="child_title">
                    <a href="cancelRegClassForm.st">수강취소</a>
                </div>
                <div class="child_title">
                    <a href="searchRegClassForm.st">수강신청 내역조회</a>
                </div>
                <div class="child_title">
                    <a href="preRegisterClass.st">예비수강신청</a>
                </div>
            </div>
            <div id="content_1">
            	<div id="main_div">
            		<p>수강정보 - 수강신청</p>
            		<hr>
            		
            		<div id="sub_div1">
	            		<label for="classYear">학년도 : </label>
	            		<input type="text" name="classYear" id="classYear" value="" disabled>
	            		<label for="classTerm">학기 : </label>
	            		<input type="text" name="classTerm" id="classTerm" value="" disabled>
            		</div>
            		
            		<script>
            			/* 현재 년도 및 월 */
            			$(function(){
            				var now = new Date();
            				var year = now.getFullYear();
            				var month = now.getMonth()+1;
            				$("#classYear").val(year);
            				if(month>2 && month<9){
            					$("#classTerm").val("1학기");
            				}else{
            					$("#classTerm").val("2학기");
            				}
            			});
            		</script>
            		
            		<hr>
            		
            		<div id="sub_div2">
           				<input id="major" type="radio" name="sub_div2_radio" onchange="mainContent(1);" checked> <label for="major">단과대학 전공별</label>
           				<input id="elective" type="radio" name="sub_div2_radio" onchange="mainContent(2);"> <label for="elective">교양선택</label>
           				<input id="proName" type="radio" name="sub_div2_radio" onchange="mainContent(3);"> <label for="proName">교수명검색</label>
           				<input id="subject" type="radio" name="sub_div2_radio" onchange="mainContent(4);"> <label for="subject">과목검색</label>
           				<input id="bucket" type="radio" name="sub_div2_radio" onchange="mainContent(5);"> <label for="bucket">장바구니</label>
            		</div>
            		<hr>
            		<div id="contentDiv1">
	            		<div class="subInput" id="sub_inputDiv1">
	            			<select class="selectReset" name="collegeNo" id="collegeNo" onchange="selectClass(this)">
	            				<option value="0" id="cno0">단과대학선택</option>
	            				<option value="1" id="cno2">인문대학</option>
	            				<option value="2" id="cno3">사회과학대학</option>
	            				<option value="3" id="cno4">교육대학</option>
	            				<option value="4" id="cno5">자연대학</option>
	            				<option value="5" id="cno6">공학대학</option>
	            				<option value="6" id="cno7">미술대학</option>
	            				<option value="7" id="cno8">예술대학</option>
	            			</select>
	            			
	            			<select class="selectReset" name="departmentNo" id="departmentNo"></select>
	            			
	            			<button class="contentBtn" id="categoryBtn" onclick="searchClass(1)"  disabled>검색</button>
	            		</div>
	           			<div id="main_content">
	           				<table class="mcTable" id="majorClassTable" border="1" >
	           					<thead>
	            					<tr>
										<th>단과대학</th>
							            <th>과목번호</th>
							            <th>과목명</th>
							            <th>교수명</th>
							            <th>개설학과</th>
							            <th>시간/학점</th>
							            <th>수강인원</th>
							            <th>강의시간(강의실)</th>
							            <th>수강대상</th>
							            <th>강의 신청</th>
						            </tr>
	           					</thead>
	           					<tbody>
	           						
	           					</tbody>
	           				</table>
	           			</div>
           			</div>
           			<div id="contentDiv2">
	           			<div id="main_content2">
							<table class="mcTable" id="electiveClassTable" border="1" >
	           					<thead>
	            					<tr>
										<th>단과대학</th>
							            <th>과목번호</th>
							            <th>과목명</th>
							            <th>교수명</th>
							            <th>개설학과</th>
							            <th>시간/학점</th>
							            <th>수강인원</th>
							            <th>강의시간(강의실)</th>
							            <th>수강대상</th>
							            <th>강의 신청</th>
						            </tr>
	           					</thead>
	           					<tbody>
	           						
	           					</tbody>
	           				</table>
	           			</div>
           			</div>
           			<div id="contentDiv3">
           				<div id="main_content3">
           					<div class="subInput" id="sub_inputDiv3">
	            				<input type="text" class="searchInput" id="searchProfessor" placeholder="교수명을 입력해주세요">
	            				<button class="contentBtn" id="searchProBtn" onclick="searchClass(3)">검색</button>
	            			</div>
							<table class="mcTable" id="proNameClassTable" border="1" >
	           					<thead>
	            					<tr>
										<th>단과대학</th>
							            <th>과목번호</th>
							            <th>과목명</th>
							            <th>교수명</th>
							            <th>개설학과</th>
							            <th>시간/학점</th>
							            <th>수강인원</th>
							            <th>강의시간(강의실)</th>
							            <th>수강대상</th>
							            <th>강의 신청</th>
						            </tr>
	           					</thead>
	           					<tbody>
	           						
	           					</tbody>
	           				</table>
	           			</div>
           			</div>
           			<div id="contentDiv4">
           				<div id="main_content4">
	           				<div class="subInput" id="sub_inputDiv4">
	            				<input type="text" class="searchInput" id="searchClass" placeholder="과목명을 입력해주세요">
	            				<button class="contentBtn" id="searchClassBtn" onclick="searchClass(4)">검색</button>
	            			</div>
							<table class="mcTable" id="classNameTable" border="1" >
	           					<thead>
	            					<tr>
										<th>단과대학</th>
							            <th>과목번호</th>
							            <th>과목명</th>
							            <th>교수명</th>
							            <th>개설학과</th>
							            <th>시간/학점</th>
							            <th>수강인원</th>
							            <th>강의시간(강의실)</th>
							            <th>수강대상</th>
							            <th>강의 신청</th>
						            </tr>
	           					</thead>
	           					<tbody>
	           						
	           					</tbody>
	           				</table>
	           			</div>
           			</div>
           			<div id="contentDiv5">
           				<div id="main_content5">
	           				<table class="mcTable" id="postBucketTable" border="1" >
	           					<thead>
	            					<tr>
										<th>단과대학</th>
							            <th>과목번호</th>
							            <th>과목명</th>
							            <th>교수명</th>
							            <th>개설학과</th>
							            <th>시간/학점</th>
							            <th>수강인원</th>
							            <th>강의시간(강의실)</th>
							            <th>수강대상</th>
							            <th>강의 신청</th>
						            </tr>
	           					</thead>
	           					<tbody>
	           						
	           					</tbody>
	           				</table>
	           			</div>
           			</div>
           			
            		<script>
            		
            		$(function(){
            			mainContent(1);
            		});
            		
            		/* content 선택 */
            		function mainContent(num){
            			$("div[id *= contentDiv]").css("display","none");
            			$("#departmentNo").hide();
            			$(".selectReset").val(0);
            			$(".mcTable>tbody").html("");
            			$(".searchInput").val("");
            			$("#categoryBtn").attr("disabled",true);
            			switch(num){
	            			case 1 : $("#contentDiv1").css("display","block");
	            				break;
	            			case 2 : $("#contentDiv2").css("display","block");
	            						searchClass(2);
	            				break;
	            			case 3 : $("#contentDiv3").css("display","block");
	            				break;
	            			case 4 : $("#contentDiv4").css("display","block");
	            				break;
	            			case 5 : $("#contentDiv5").css("display","block");
	            						searchClass(5);
	            				break;
            			}
            		}
            		
            		/* 학부전공별 카테고리 설정 */           		
            		function selectClass(e){
            			
            			var $cno = e.value;
            			
            			if($cno != 0){
            				$("#departmentNo").show();
            				$("#categoryBtn").attr("disabled",false);
            			}else{
            				$("#departmentNo").hide();
            				$("#categoryBtn").attr("disabled",true);
            			}
            			
            			$.ajax({
            				url : "selectCollegeNo.st",
            				data :{
            					cno : $cno
            				},
            				success : function(list){
            					
            					var result = "";
            					
            					for(var i=0; i<list.length; i++){
            						result += "<option value ='" + list[i] + "'>"
            									+ list[i]
            									+ "</option>";
            					}
            					
            					$("#departmentNo").html(result);
            				},
            				error : function(){
            					console.log("카테고리 통신 실패");
            				}
            			})
            		}
            		

            		/* 수강 조회 리스트 */
            		function searchClass(num){
            			var result = "";
            			
            		 	if(num == 3 && !$("#searchProfessor").val()){
            				alert("교수명을 입력해 주세요");
            			}else if(num == 4 && !$("#searchClass").val()){
            				alert("과목명을 입력해 주세요");
            			}else if(num == 5){
            				$.ajax({
            					url : "postRegBucket.st",
            					data : {
            						studentNo : "${loginUser.studentNo}",
            						classYear : $("#classYear").val(),
	            					classTerm : $("#classTerm").val()
            					},
            					success : function(list){
                   					result += "<input type='hidden' id='hiddenNum' value='"+num+"'>"
	            					if(list.length !== 0){
		            					for(var i=0; i<list.length; i++){
		            						result += "<tr ";
		            								 if(i%2 == 0){
		            									 result += "style = 'background-color:rgb(117, 200, 255);color : white;' >";
		            								 }else{
		            									 result += ">";
		            								 }
											  result +="<td>" + list[i].collegeName + "</td>"
													 +"<td>" + list[i].classNo + "</td>"
													 +"<td>" + list[i].className + "</td>"
													 +"<td>" + list[i].professorName + "</td>"
													 +"<td>" + list[i].departmentName + "</td>"
													 +"<td>" + list[i].creditHour + "</td>"
													 +"<td>" + list[i].postClassNos + "</td>"
													 +"<td>" + list[i].classInfo + "</td>"
													 +"<td>" + list[i].classLevel + "</td>"
													 +"<td><button>수강신청</button></td>"
													 +"</tr>";
		            					}
	            					}else{
	            						result += "<tr><th colspan='10' style='font-size:20px;'>예비 수강신청한 강의가 존재하지 않거나 이미 신청한 강의입니다.</th></tr>";
	            					}
                   					$("#postBucketTable>tbody").html(result);
            					},
            					error : function(){
            						console.log("장바구니조회 통신실패");
            					}
            				});
            			}else{
	            			$.ajax({
	            				url : "postRegClass.st",
	            				data : {
	            					classYear : $("#classYear").val(),
	            					classTerm : $("#classTerm").val(),
	            					departmentName : $("#departmentNo").val(),
	            					professorName : $("#searchProfessor").val(),
	            					className : $("#searchClass").val(),
	            					studentNo : "${loginUser.studentNo}",
	            					studentLevel : "${loginUser.classLevel}"
	            				},
	            				success : function(list){
	            					result += "<input type='hidden' id='hiddenNum' value='"+num+"'>"
	            					if(list.length !== 0){
		            					for(var i=0; i<list.length; i++){
		            						result += "<tr ";
		            								 if(i%2 == 0){
		            									 result += "style = 'background-color:rgb(117, 200, 255);color : white;' >";
		            								 }else{
		            									 result += ">";
		            								 }
											  result +="<td>" + list[i].collegeName + "</td>"
													 +"<td>" + list[i].classNo + "</td>"
													 +"<td>" + list[i].className + "</td>"
													 +"<td>" + list[i].professorName + "</td>"
													 +"<td>" + list[i].departmentName + "</td>"
													 +"<td>" + list[i].creditHour + "</td>"
													 +"<td>" + list[i].postClassNos + "</td>"
													 +"<td>" + list[i].classInfo + "</td>"
													 +"<td>" + list[i].classLevel + "</td>"
													 +"<td><button>수강신청</button></td>"
													 +"</tr>";
		            					}
	            					}else{
	            						result += "<tr><th colspan='10' style='font-size:20px;'>신청 가능한 강의가 존재하지 않습니다.</th></tr>";
	            					}
	            					switch(num){
		            					case 1 : $("#majorClassTable>tbody").html(result);
		            						break;
		            					case 2 : $("#electiveClassTable>tbody").html(result);
		            						break;
		            					case 3 : $("#proNameClassTable>tbody").html(result);
		            						break;
		            					case 4 : $("#classNameTable>tbody").html(result);
		            						break;
            						}
	            				},
	            				error : function(){
	            					console.log("학부전공별 리스트 조회 실패")
	            				}
	            			});
            			}
            		}
            		
            		$(function(){
            			/* 수강신청 버튼 클릭시 */
            			$(document).on("click",".mcTable>tbody>tr button",function(){
            				var cno = $(this).closest("tr").children().eq(1).text();
            				var num = parseInt($("#hiddenNum").val());
            				var regCredit = parseInt($(this).closest("tr").children().eq(5).text().charAt(2)); //신청하려는 강의 학점추출
            				var sumCredit = parseInt($("#sumCredit").val()); //신청된 강의의 학점 합계
            				if((sumCredit+regCredit)>20){
            					alert("한 학기에 최대 20학점을 초과할 수 없습니다.")
            				}else{
	            				$.ajax({
	            					url : "postRegisterClass.st",
	            					data : {
	            						classYear : $("#classYear").val(),
		            					classTerm : $("#classTerm").val(),
	            						classNo : cno, 
	            						studentNo : "${loginUser.studentNo}"
	            					},
	            					success : function(result){
	            						if(result > 0){
	            							alert("수강신청이 완료되었습니다.");
	            							searchClass(num);
	            							postRegList();
	            						}else{
	            							alert("해당 강의를 신청하실 수 없습니다.");
	            						}
	            					},
	            					error : function(){
	            						console.log("수강신청 통신실패");
	            					}
	            				});
            				}
            			});
            		});
            		</script>
            	</div>
            	<div id="postRegistered_area">
					<hr>
	       			<div id="postReg_div">
	       				수강신청 내역
	       				<span id="sumCredit_span">
       						신청 학점 합계 : <input type="text" id="sumCredit" readonly>
       					</span>
	       			</div>
	        		<hr>
            		<div id="postRegistered_list">
						<table class="postMcTable" id="postRegisteredTable" border="1" >
           					<thead>
            					<tr>
									<th>단과대학</th>
						            <th>과목번호</th>
						            <th>과목명</th>
						            <th>교수명</th>
						            <th>개설학과</th>
						            <th>시간/학점</th>
						            <th>수강인원</th>
						            <th>강의시간(강의실)</th>
						            <th>수강대상</th>
						            <th>수강취소</th>
					            </tr>
           					</thead>
           					<tbody>
           						
           					</tbody>
           				</table>
            		</div>
            		
            		<script>
            			$(function(){
            				postRegList();
            			});
            		
            		
            			/* 수강신청 내역 조회 */
            			function postRegList(){
            				$.ajax({
            					url : "postRegList.st",
            					data : {
            						studentNo : "${loginUser.studentNo}",
           							classYear : $("#classYear").val(),
   	            					classTerm : $("#classTerm").val()
            					},
            					success : function(list){
            						var result = "";
            						var sumCredit = 0;
            						if(list.length !== 0){
		            					for(var i=0; i<list.length; i++){
		            						result += "<tr ";
		            								 if(i%2 == 0){
		            									 result += "style = 'background-color:#dadada;'>";
		            								 }else{
		            									 result += ">";
		            								 }
											  result +="<td>" + list[i].collegeName + "</td>"
													 +"<td>" + list[i].classNo + "</td>"
													 +"<td>" + list[i].className + "</td>"
													 +"<td>" + list[i].professorName + "</td>"
													 +"<td>" + list[i].departmentName + "</td>"
													 +"<td>" + list[i].creditHour + "</td>"
													 +"<td>" + list[i].postClassNos + "</td>"
													 +"<td>" + list[i].classInfo + "</td>"
													 +"<td>" + list[i].classLevel + "</td>"
													 +"<td><button>수강취소</button></td>"
													 +"</tr>";
											//학점 추출 및 합계
											sumCredit += parseInt((list[i].creditHour).charAt(2));
		            					}
            						}else{
            							result += "<tr><th colspan='10' style='font-size:20px;'>현재 수강신청한 내역이 없습니다.</th></tr>";
            						}
            						$("#postRegisteredTable>tbody").html(result);
            						$("#sumCredit").val(sumCredit);
            					},
            					error : function(){
            						console.log("수강신청내역 조회 통신실패");
            					}
            					
            				});
            			}
            			
            			//수강신청 - 수강신청내역 수강취소
            			$(function(){
            				$(document).on("click","#postRegisteredTable>tbody>tr button",function(){
            					var postCno = $(this).closest("tr").children().eq(1).text(); //과목번호 추출
            					var num = parseInt($("#hiddenNum").val());
            					$.ajax({
            						url : "delPostRegList.st",
            						data : {
            							classNo : postCno,
            							studentNo : "${loginUser.studentNo}"
            						},
            						success : function(result){
            							if(result > 0){
            								searchClass(num);
            								postRegList();
            							}else{
            								alert("수강취소에 실패하였습니다.");
            							}
            						},
            						error : function(){
            							console.log("수강취소 통신실패");
            						}
            					});
            				});
            			});
            		
            		</script>
            		
            	</div>
            </div>
        </div>
    </div>
</body>
</html>