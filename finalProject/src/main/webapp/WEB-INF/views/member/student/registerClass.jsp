<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/registerClassForm.css">
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
                    <a href="#">강의시간표</a>
                </div>
            </div>
            <div id="content_1">
            	<div id="main_div">
            		<p>담당자 문의 정보</p>
            		<hr>
            		
            		<div id="sub_div1">
	            		<label for="classYear">학년도 : </label>
	            		<input type="text" name="classYear" id="classYear" value="2023" disabled>
	            		<label for="classTerm">학기 : </label>
	            		<input type="text" name="classTerm" id="classTerm" value="1학기" disabled>
            		</div>
            		<hr>
            		
            		<div id="sub_div2">
            		<!-- ajax에 num값만 다르게 해서 출력 -->
            			<ul>
            				<li onclick="">학부전공별</li>
            				<li onclick="">교양선택</li>
            				<li onclick="">일반선택</li>
            				<li onclick="">교수명검색</li>
            				<li onclick="">과목검색</li>
            				<li onclick="">장바구니</li>
            			</ul>
            		</div>
            		<hr>
            		
            		<div id="sub_inputDiv1">
            			<select name="collegeNo" id="collegeNo" onchange="selectClass(this)">
            				<option value="0" id="cno0">단과대학</option>
            				<option value="1" id="cno1">교양</option>
            				<option value="2" id="cno2">인문대학</option>
            				<option value="3" id="cno3">사회과학대학</option>
            				<option value="4" id="cno4">교육대학</option>
            				<option value="5" id="cno5">자연대학</option>
            				<option value="6" id="cno6">공학대학</option>
            				<option value="7" id="cno7">미술대학</option>
            				<option value="8" id="cno8">예술대학</option>
            			</select>
            			
            			<select name="departmentNo" id="departmentNo"></select>
            			
            			<button onclick="majorClass()" id="categoryBtn" disabled>검색</button>
            		</div>
            			<hr>
           			<div id="main_content">
           				<table border="1">
           					<thead>
            					<tr>
									<th>이수구문(주전공)</th>
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
            		

            		/* 학부 전공별 조회 리스트 */
            		function majorClass(){
            			
            			$.ajax({
            				url : "majorClass.st",
            				data : {
            					departmentName : $("#departmentNo").val()
            				},
            				success : function(result){
            					console.log(result);
            					var table = "";
            					
            				},
            				error : function(){
            					console.log("학부전공별 리스트 조회 실패")
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