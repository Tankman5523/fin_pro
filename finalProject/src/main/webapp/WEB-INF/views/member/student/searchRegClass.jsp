<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 내역조회 : Feasible University</title>
<link rel="stylesheet" href="resources/css/searchRegClassForm.css">
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
                    <a href="cancelRegClassForm.st">수강취소</a>
                </div>
                <div class="child_title">
                    <a href="searchRegClassForm.st" style="color:#00aeff; font-weight: 550;">수강신청 내역조회</a>
                </div>
                <div class="child_title">
                    <a href="preRegisterClass.st">예비수강신청</a>
                </div>
            </div>
            <div id="content_1">
            	<div id="main_div">
            		<p>수강신청 내역 조회</p>
            		<hr>
            		
            		<div id="sub_div1">
            			<c:if test="${not empty regYear}">
            				<label for="searchRegYear">학년도 : </label>
		            		<select class="selectReset" name="searchRegYear" id="searchRegYear">
								<c:forEach var="y" items="${regYear}">
									<option>${y.classYear}</option>
								</c:forEach>
		            		</select>
		            		<label for="searchRegTerm">학기 : </label>
		            		<select class="selectReset" name="searchRegTerm" id="searchRegTerm">
								<option>2</option>
								<option>1</option>
		            		</select>
		            		<button class="contentBtn" id="categoryBtn" onclick="searchReg()">검색</button>
		            		<span id="sumCredit_span">
       							총 학점 : <input type="text" id="sumCredit" readonly>
       						</span>
            			</c:if>
            		</div>
            		<hr>
            		<div id="contentDiv1">
	           			<div id="main_content">
	           				<table class="mcTable" id="searchRegTable" border="1" >
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
						            </tr>
	           					</thead>
	           					<tbody>
	           						
	           					</tbody>
	           				</table>
	           			</div>
           			</div>
           			<script>
            		
           				$(function(){
           					searchReg();
           				});
           			
            			/* 선택한 년도,학기 수강신청 내역 조회 */
            			function searchReg(){
            				var year = $("#searchRegYear").val();
            				var term = $("#searchRegTerm").val();
            				$.ajax({
            					url : "searchRegList.st",
            					data : {
            						studentNo : "${loginUser.studentNo}",
            						classYear : year,
            						classTerm : term
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
													 +"</tr>";
										   sumCredit += parseInt((list[i].creditHour).charAt(2));
		            					}
            						}else{
            							result += "<tr><th colspan='10' style='font-size:20px;'>해당 년도 및 학기에 수강신청한 내역이 없습니다.</th></tr>";
            						}
            						$("#searchRegTable>tbody").html(result);
            						$("#sumCredit").val(sumCredit);
            					},
            					error : function(){
            						console.log("수강신청 내역 조회 통신실패");
            					}
            				});
            			}
            			
            		</script>
            	</div>
            </div>
        </div>
    </div>
</body>
</html>