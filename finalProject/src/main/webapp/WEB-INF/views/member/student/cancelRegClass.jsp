<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강취소 : Feasible University</title>
<link rel="stylesheet" href="resources/css/cancelRegClassForm.css">
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
                    <a href="registerClassForm.st">수강신청</a>
                </div>
                <div class="child_title">
                    <a href="cancelRegClassForm.st" style="color:#00aeff; font-weight: 550;">수강취소</a>
                </div>
                <div class="child_title">
                    <a href="searchRegClassForm.st">수강신청 내역조회</a>
                </div>
                <div class="child_title">
                    <a href="preRegisterClassForm.st">예비수강신청</a>
                </div>
            </div>
            <div id="content_1">
            	<div id="main_div">
            		<p>수강정보 - 수강취소</p>
            		<hr>
            		
            		<div id="sub_div1">
	            		<label for="classYear">학년도 : </label>
	            		<input type="text" name="classYear" id="classYear" value="" disabled>
	            		<label for="classTerm">학기 : </label>
	            		<input type="text" name="classTerm" id="classTerm" value="" disabled>
       			       	<span id="sumCredit_span">
       						신청 학점 합계 : <input type="text" id="sumCredit" readonly>
       					</span>
            		</div>
            		
            		<script>
            			/* 현재 년도 및 월 */
            			$(function(){
            				var now = new Date();
            				var year = now.getFullYear();
            				var month = now.getMonth()+1
            				$("#classYear").val(year);
            				if(month>2 && month<9){
            					$("#classTerm").val("1학기");
            				}else{
            					$("#classTerm").val("2학기");
            				}
            			});
            		</script>
            		
            		<hr>
            		<div id="contentDiv1">
	           			<div id="main_content">
	           				<table class="mcTable" id="cancelRegTable" border="1" >
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
            						$("#cancelRegTable>tbody").html(result);
            						$("#sumCredit").val(sumCredit);
            					},
            					error : function(){
            						console.log("수강신청내역 조회 통신실패");
            					}
            				});
            			}
            			
            			//수강신청 - 수강신청내역 수강취소
            			$(function(){
            				$(document).on("click","#cancelRegTable>tbody>tr button",function(){
            					var postCno = $(this).closest("tr").children().eq(1).text(); //과목번호 추출
            					$.ajax({
            						url : "delPostRegList.st",
            						data : {
            							classNo : postCno,
            							studentNo : "${loginUser.studentNo}"
            						},
            						success : function(result){
            							if(result > 0){
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
    </div>
</body>
</html>