<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>졸업사정표 : Feasible University</title>
<link rel="stylesheet" href="resources/css/graduationInfoForm.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/student_menubar.jsp" %>
		<div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="infoStudent.st">학적 정보 조회</a>
                </div>
                <div class="child_title">
                    <a href="personalTimetable.st">개인 시간표</a>
                </div>
                <div class="child_title">
                    <a href="#">휴/복학 신청</a>
                </div>
                <div class="child_title">
                    <a href="#">휴/복학 조회</a>
                </div>
                <div class="child_title">
                    <a href="graduationInfoForm.st" style="color:#00aeff; font-weight: 550;">졸업 사정표</a>
                </div>
                <div class="child_title">
                    <a href="#">졸업 확정 신고</a>
                </div>
            </div>
            <div id="content_1">
            	<div id="main_div">
            		<div class="subDiv" id="sub_div1">
	            		<span class="mainSpan">학생정보</span>
	            		<hr>
	            		<table>
		            		<tr>
		            			<td>학번 : <input type="text" value="${student.studentNo}" readonly></td>
		            			<td>성명 : <input type="text" value="${student.studentName}" readonly></td>
		            			<td>입학년도 : <input type="text" value="${student.entranceDate}" readonly></td>
		            		</tr>
		            		<tr>
		            			<td>소속 : <input type="text" value="${student.collegeName}" readonly></td>
		            			<td>전공 : <input type="text" value="${student.departmentName}" readonly></td>
		            			<td>학적상태 : <input type="text" value="${student.status}" readonly></td>
		            		</tr>
		            		<tr>
		            			<td>학년 : <input type="text" value="${student.classLevel}" readonly></td>
		            			<td>이수학기 : <input type="text" value="${student.classTerm}" readonly></td>
		            			<td>총 취득학점 : <input type="text" value="${student.sumCredit}" readonly></td>
		            			<td>졸업사정일자 : <input type="text" id="graDate" readonly></td>
		            		</tr>
	            		</table>
            		</div>
            		<div class="subDiv" id="sub_div2">
            			<span class="mainSpan">INFO</span>
            			<hr>
            			<div id="infoDiv">
            				- 상단의 졸업사정일자를 기준으로 반영한 내용이며 이후의 변경사항은 다음 졸업사정일에 반영됩니다.<br>
            				- 전체 이수 과목 내역을 보려면, '과목 상세 내역 보기' 를 눌러주세요.<br>
            				- 이수 구분 변경 신청은 졸업예정자(졸업학점 120학점 이상 이수 중인 4-2학기 재학생 및 조기졸업대상자)만 가능합니다.<br>
            				- 졸업논문/시험/대체 자격증 등은 학과 사무실에 문의 부탁드립니다.
            			</div>
            		</div>
            		<div class="subDiv" id="sub_div3">
            			<span class="mainSpan">전체 이수현황</span>
            			<span id="commentSpan"></span>
            			<hr>
            			<table id="statusTable" border=1>
            				<tr class="tableLine">
            					<th colspan="2">전공</th>
            					<th colspan="4">세부</th>
            				</tr>
            				<tr>
            					<td colspan="2">주전공</td>
            					<td colspan="4">${student.departmentName}</td>
            				</tr>
            				<tr class="tableLine">
            					<th colspan="2">적용년도</th>
            					<th colspan="4">소속대학</th>
            				</tr>
            				<tr>
            					<td colspan="2">${student.entranceDate}</td>
            					<td colspan="4">${student.collegeName}</td>
            				</tr>
            				<tr class="tableLine">
            					<th colspan="2">구분</th>
            					<th>기준학점</th>
            					<th>이수(수강)학점</th>
            					<th colspan="2">판정</th>
            				</tr>
            				<tr>
            					<th rowspan="3">교양</th>
            					<td>교양공통(교공)</td>
            					<td id="standardCommon">16</td>
            					<td id="commonArea"></td>
            					<td id="commonResult"></td>
            					<td style="width:80px"><button class="tableBtn" onclick="commonBtn()">버튼</button></td>
            				</tr>
            				<tr>
            					<td>교양일반(교일)</td>
            					<td id="standardNomal">0</td>
            					<td id="nomalArea"></td>
            					<td></td>
            					<td><button class="tableBtn" onclick="">버튼</button></td>
            				</tr>
            				<tr class="tableLine">
            					<td>소계</td>
            					<td id="standardSumGen">24</td>
            					<td id="generalSumArea"></td>
            					<td id="generalSumResult" colspan="2"></td>
            				</tr>
            				<tr>
								<th rowspan="2">전공</th>
            					<td>전공심화(전심)</td>
            					<td id="standardMajor">96</td>
            					<td id="majorArea"></td>
            					<td id="majorResult"></td>
            					<td><button class="tableBtn" onclick="">버튼</button></td>
            				</tr>
            				<tr class="tableLine">
            					<td>소계</td>
            					<td id="standardSumMaj">96</td>
            					<td id="majorSumArea"></td>
            					<td id="majorSumResult" colspan="2"></td>
            				</tr>
            				<tr>
            					<th colspan="2">총 취득학점</th>
            					<td id="standardSumAll">120</td>
            					<td id="allSumArea"></td>
            					<td id="SumResult" colspan="2"></td>
            				</tr>
            				<tr class="tableLine">
            					<th id="standardEndResult" colspan="2">판정결과</th>
            					<th id="endResult" colspan="4"></th>
            				</tr>
            			</table>
						<script>
							$(function(){
								
								/* 년도 및 월 추출 */
								var now = new Date();
								var year = now.getFullYear();
								var month = now.getMonth()+1;
								var day = now.getDate();
								if(month>1 && month<8){ //2월~7월
									$("#graDate").val(year+"-02-01");
								}else{
									$("#graDate").val(year+"-08-01");
								}
								
								/* 전체 이수현황 조회 */
								$.ajax({
									url : "selectGraStatus.st",
									data : {
										studentNo : "${student.studentNo}",
										departmentName : "${student.departmentName}",
										graDate : $("#graDate").val()
									},
									success : function(result){
										var genSum = result.commonClass + result.nomalClass;	//교양 소계 값 추출
										var allSum = genSum + result.majorClass;				//총 취득학점 값 추출
										$("#commonArea").text(result.commonClass);				//교양공통
										$("#nomalArea").text(result.nomalClass);				//교양일반
										$("#generalSumArea").text(genSum);						//교양 소계
										$("#majorArea").text(result.majorClass);				//전공심화
										$("#majorSumArea").text(result.majorClass);				//전공소계
										$("#allSumArea").text(allSum);							//총 취득학점
										
										//교양공통 판정
										if(result.commonClass >= parseInt($("#standardCommon").text())){  
											$("#commonResult").text("합격");
										}else{
											$("#commonResult").html("<p style='color:#e65f3e'>불합격</p>");
										}
										
										//교양소계 판정
										if(genSum >= parseInt($("#standardSumGen").text())){ 
											$("#generalSumResult").text("합격");
										}else{
											$("#generalSumResult").html("<p style='color:#e65f3e'>불합격</p>");
										}
										
										//전공심화 판정
										if(result.majorClass >= parseInt($("#standardMajor").text())){
											$("#majorResult").text("합격");
										}else{
											$("#majorResult").html("<p style='color:#e65f3e'>불합격</p>");
										}
										
										//전공소계 판정
										if(result.majorClass >= parseInt($("#standardSumMaj").text())){
											$("#majorSumResult").text("합격");
										}else{
											$("#majorSumResult").html("<p style='color:#e65f3e'>불합격</p>");
										}
										
										//총 취득학점 판정
										if(allSum >= parseInt($("#standardSumAll").text())){
											$("#SumResult").text("합격");
										}else{
											$("#SumResult").html("<p style='color:#e65f3e'>불합격</p>");
										}
										
										//최종 판정결과
										var endCheck = "";
										$("#statusTable p").each(function(){
											if($(this).text() === "불합격"){
												endCheck = $(this).text(); //불합격
											}
										});
										if(endCheck !== "불합격"){
											$("#endResult").text("합격");
										}else{
											$("#endResult").html("<p style='color:#e65f3e'>불합격</p>");
										}
										
										//코멘트 작성
										if(endCheck === "불합격"){
											$("#commentSpan").text("코멘트 들어갈 곳");
										}
									},
									error : function(){
										console.log("전체 이수현황 조회 통신실패");
									}
								});
							});
							/* 
								ex)
								1년에 교양공통 3개 전공 4개 => 120학점
								1년에 교양공통 2개 전공 4개 + 교양일반 2개+ 교양공통1개or교양일반1개 => 120학점 이상
							*/
						</script>
            		</div>
            	</div>
            </div>
		</div>
				<div id="modalArea">
		         	<div class="modalDiv" id="commonModal">
		         		<div class="common" id="commonHeader">
		         		<span>졸업세부영역별현황</span>
		         		<button id="modalClose" onclick="hideModal(1);">X</button>
		         		</div>
		         		<div class="subLine">
		         			<span>교양공통(교공)</span>
		         			<hr>
		         		</div>
		         		<div class="common" id="commonBody">
		         			
		         			<table id="comBodyTable">
		         				<thead>
			         				<tr>
			         					<th>과목명</th>
			         					<th>필수 이수학점</th>
			         					<th>이수현황</th>
			         					<th>등급</th>
			         					<th>이수학점</th>
			         				</tr>
		         				</thead>
		         				<tbody>
		         				</tbody>
		         			</table>
		         		</div>
		         		<div class="subLine">
		         			<span>이수방법</span>
		         			<hr>
		         		</div>
		         		<div class="common" id="commonBody2">
		         			<ul>
		         				<li>
		         					교양공통 기준학점 이상 이수
		         				</li>
		         				<li>
		         					폐지 혹은 면제된 과목은 이수하지 않아도 됨<br>
		         					(단,폐지된 과목이라도 대체과목이 지정되어 있으면 해당과목은 이수해야 함)
		         				</li>
		         				<li>
		         					공통 : 타대학(타기관)취득 학점은 자가진단 본화면에서는 집계되나 팝업창에서는 해당 과목 내역을 확인할 수 없음<br>
		         					★주의사항★<br>
		         					- 타전공 취득 학점은 교양일반으로 집계되며 해당 강의 학점으로 인정해줌<br>
		         				</li>
		         			</ul>
		         		</div>
		         		<div class="common" id="commonFooter">
		         			<button onclick="hideModal(1)">확인</button>
		         		</div>
		         	</div>
		        </div>
		        
		        <script>
		        	/* 교양공통 세부확인 모달 */
		        	function commonBtn(){
		        		
		        		$.ajax({
		        			url : "",
		        			data : {
		        				
		        			},
		        			success : function(list){
		        				
		        			},
		        			error : function(){
		        				console.log("교양공통 세부확인조회 통신실패);
		        			}
		        		});
		        		
		        		document.getElementById("modalArea").style.display = 'flex';
		        	}
		        	
		        	/* 모달창의 확인버튼 클릭 시 모달 닫기 */
		        	function hideModal(num){
		        		if(num == 1){
		        			document.getElementById("modalArea").style.display = 'none';
		        		}
		        	}
		        	
		        	/* 모달영역 외 클릭 시 모달 닫기 */
		        	$(function(){
		        		$("#modalArea").on("click",function(e){
		        			if(e.target.id == "modalArea"){
		        				document.getElementById("modalArea").style.display = 'none';
		        			}
		        		});
		        	});
		        </script>
	</div>
</body>
</html>