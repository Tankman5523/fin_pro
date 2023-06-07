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
            			<select name="collegeNo" id="collegeNo" onchange="selectClass(1)">
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
            			
            			<select name="departmentNo" id="departmentNo" onchange="selectClass(2)">
            				<option value="0" id="dno0">학과</option>
            				<option value="1" id="dno1">교양</option>
            				<option value="2" id="dno2">국어국문학과</option>
            				<option value="3" id="dno2">영어영문학과</option>
            				<option value="4" id="dno2">일어일문학과</option>
            				<option value="5" id="dno2">사학과</option>
            				<option value="6" id="dno3">경제경영학과</option>
            				<option value="7" id="dno3">회계학과</option>
            				<option value="8" id="dno3">법학과</option>
            				<option value="9" id="dno3">행정학과</option>
            				<option value="10" id="dno4">초등교육과</option>
            				<option value="11" id="dno4">유아교육과</option>
            				<option value="12" id="dno5">생명공학과</option>
            				<option value="13" id="dno5">수학과</option>
            				<option value="14" id="dno5">물리학과</option>
            				<option value="15" id="dno5">통계학과</option>
            				<option value="16" id="dno6">건축학과</option>
            				<option value="17" id="dno6">기계학과</option>
            				<option value="18" id="dno6">컴퓨터공학과</option>
            				<option value="19" id="dno6">전자전기과</option>
            				<option value="20" id="dno6">화학공학과</option>
            				<option value="21" id="dno7">시각디자인학과</option>
            				<option value="22" id="dno7">패션디자인학과</option>
            				<option value="23" id="dno8">연극영화과</option>
            				<option value="24" id="dno8">실용음악과</option>
            			</select>
            			
            			<button onclick="majorClass()">검색</button>
            		</div>
            		
            		<script>
            		
            		/* 학부전공별 카테고리 설정 */
           			function selectClass(num){
           				
           				if(num == 1){ //사용자가 단과대학을 선택했을 경우
           					var cno = $("#collegeNo").val(); //단대 번호 추출
           					
           					$("#departmentNo>[id *= dno]").attr("selected",false);
           					
	           				switch(cno){
		       					case "0" : $("#departmentNo>[id *= dno]").attr("hidden",false);
		       								$("#departmentNo>[id = dno0]").attr("selected",true);
											$("#collegeNo>[id *= cno]").attr("hidden",false).attr("selected",false);
		       						break;
		           				case "1" : $("#departmentNo>[id != dno1][id != dno0]").attr("hidden",true);
		           							$("#departmentNo>[id = dno1]").attr("selected",true);
		           					break;
		           				case "2" : $("#departmentNo>[id != dno2][id != dno0]").attr("hidden",true);
		           							$("#departmentNo").children().eq(2).attr("selected",true);
		           					break;
		           				case "3" : $("#departmentNo>[id != dno3][id != dno0]").attr("hidden",true);
		           							$("#departmentNo").children().eq(6).attr("selected",true);
		       						break;
		       					case "4" : $("#departmentNo>[id != dno4][id != dno0]").attr("hidden",true);
		       								$("#departmentNo").children().eq(10).attr("selected",true);
		       						break;
		           				case "5" : $("#departmentNo>[id != dno5][id != dno0]").attr("hidden",true);
		           							$("#departmentNo").children().eq(12).attr("selected",true);
		           					break;
		           				case "6" : $("#departmentNo>[id != dno6][id != dno0]").attr("hidden",true);
		           							$("#departmentNo").children().eq(16).attr("selected",true);
		           					break;
		           				case "7" : $("#departmentNo>[id != dno7][id != dno0]").attr("hidden",true);
		           							$("#departmentNo").children().eq(21).attr("selected",true);
		       						break;
		       					case "8" : $("#departmentNo>[id != dno8][id != dno0]").attr("hidden",true);
		       								$("#departmentNo").children().eq(23).attr("selected",true);
		       						break;
           					
	           				}
           				}else{ //사용자가 학과를 선택했을 경우
           					
           					var dno = $("#departmentNo option:selected").attr("id"); //학과 id 추출
           					
           					switch(dno){
           						case "dno0" : $("#collegeNo>[id *= cno]").attr("hidden",false).attr("selected",false);
           										$("#collegeNo>[id = cno0]").attr("selected",true);
           										$("#departmentNo>[id *= dno]").attr("hidden",false);
       								break;
           						case "dno1" : $("#collegeNo>[id = cno1]").attr("selected",true);
           										$("#collegeNo>[id != cno1][id != cno0]").attr("hidden",true);
       								break;
           						case "dno2" : $("#collegeNo>[id = cno2]").attr("selected",true);
           										$("#collegeNo>[id != cno2][id != cno0]").attr("hidden",true);
       								break;
           						case "dno3" : $("#collegeNo>[id = cno3]").attr("selected",true);
           										$("#collegeNo>[id != cno3][id != cno0]").attr("hidden",true);
       								break;
           						case "dno4" : $("#collegeNo>[id = cno4]").attr("selected",true);
           										$("#collegeNo>[id != cno4][id != cno0]").attr("hidden",true);
       								break;
           						case "dno5" : $("#collegeNo>[id = cno5]").attr("selected",true);
           										$("#collegeNo>[id != cno5][id != cno0]").attr("hidden",true);
       								break;
           						case "dno6" : $("#collegeNo>[id = cno6]").attr("selected",true);
           										$("#collegeNo>[id != cno6][id != cno0]").attr("hidden",true);
       								break;
           						case "dno7" : $("#collegeNo>[id = cno7]").attr("selected",true);
           										$("#collegeNo>[id != cno7][id != cno0]").attr("hidden",true);
       								break;
           						case "dno8" : $("#collegeNo>[id = cno8]").attr("selected",true);
           										$("#collegeNo>[id != cno8][id != cno0]").attr("hidden",true);
       								break;
           					}
           				}
           			}
            		
            		/* 학부 전공별 조회 리스트 */
            		function majorClass(){
            			$.ajax({
            				url : "majorClass.st",
            				data : {
            					dno : $("#departmentNo").val()
            				},
            				success : function(result){
            					console.log(result[0].className);
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