<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="wrap">
    	<%@include file="../../common/student_menubar.jsp" %>
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">수업관리</span>
                </div>
                <div class="child_title">
                    <a href="">학기별 성적 조회</a>
                </div>
                <div class="child_title">
                    <a href="studentGradeReport">성적 이의신청</a>
                </div>
                <div class="child_title">
                    <a href="classRatingInfo.st">강의평가</a>
                </div>
            </div>
            <div id="content_1">
					<div style="width: 90%;height: 90%;margin: 5%;overflow-y: auto;">
                    <div class="info">
                        <h4>강의평가</h4>
                    </div>
                    <div class="list">
                        <!-- 내가 들은 강의내역 or 성적이 나온 강의내역 -->
                        <table border="1" style="width: 100%;text-align:center;" id="myClassList">
                            <thead style="background-color:#4fc7ff;">
                                <tr>
                                    <th>강의번호</th>
                                    <th>강의명</th>
                                    <th>담당교수</th>
                                    <th>년도</th>
                                    <th>학기</th>
                                    <th>평가</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:choose>
                            		<c:when test="${not empty list}">
	                            		<c:forEach var="r" items="${list}">
	                            			<tr>
				                                <td>${r.classNo}</td>
				                                <td>${r.className}</td>
				                                <td>${r.professorName}</td>
				                                <td>${r.classYear}</td>
				                                <td>${r.classYear}</td>
				                                
				                                <c:choose>
				                                	<c:when test="${r.status eq null}">
						                                <td><button class="ratingStartBtn btn btn-outline-primary btn-sm">평가시작</button></td>
				                                	</c:when>
				                                	<c:otherwise>
				                                		<td><button class="btn btn-outline-danger btn-sm" disabled>평가완료</button></td>
				                                	</c:otherwise>
				                                </c:choose>
	                                		</tr>	
	                            		</c:forEach>
                            		</c:when>
                            		<c:otherwise>
                            		<tr>
	                                	<td colspan="6">수강한 강의가 없습니다.</td> 
	                                </tr>
                            		</c:otherwise>
                            	</c:choose>
                            </tbody>
                        </table>
                    </div>
                    <hr><br>

                    <div id="ratingForm" class="hide">
                    	<div>
                    		<input id="hiddenClassNo" type="hidden" name="classNo" value="">
                    		<span>강의명 : </span><span id="cn"></span> <span>/ 교수명 : </span><span id="pn"></span>
                    	</div>
                        <table border="1">
                            <thead>
                                <tr>
                                    <td colspan="6" style="background-color:lightgray;">
                                		본 강의평가 설문지는 익명으로 작성되며 , <br>
                                		이번학기 교과목의 수업진행에 대한 학생들의 솔직한 의견을 파악하여 , 앞으로 보다 나은 강의를 하기 위한 목적으로 실시되는 것입니다.<br> 
                                		따라서 학생 여러분은 각 평가 문항에 대하여 성실하고, 진지하게 답변해주시기 바랍니다.
                                    </td>
                                </tr>
                                <tr style="background-color: #4fc7ff;">
                                    <th>강의 평가 점수</th>
                                    <th>5</th>
                                    <th>4</th>
                                    <th>3</th>
                                    <th>2</th>
                                    <th>1</th>
                                </tr>
                            </thead>
                            <tbody style="background-color: #CCFFFF;">
                                <!--sample-->
                                <tr id="q1Head">
                                    <td> 1. 수업은 강의계획서에 따라 체계적으로 진행되었다.</td>
                                    <td><input type="radio" name="q1" value="5"></td>
                                    <td><input type="radio" name="q1" value="4"></td>
                                    <td><input type="radio" name="q1" value="3"></td>
                                    <td><input type="radio" name="q1" value="2"></td>
                                    <td><input type="radio" name="q1" value="1"></td>
                                </tr>
                                <tr id="q2Head">
                                    <td> 2. 수업내용이 명확하고 효과적으로 제시되었다.</td>
                                    <td><input type="radio" name="q2" value="5"></td>
                                    <td><input type="radio" name="q2" value="4"></td>
                                    <td><input type="radio" name="q2" value="3"></td>
                                    <td><input type="radio" name="q2" value="2"></td>
                                    <td><input type="radio" name="q2" value="1"></td>
                                </tr>
                                <tr id="q3Head">
                                    <td> 3. 수업은 학생의 학습동기와 흥미를 유발시켰다.</td>
                                    <td><input type="radio" name="q3" value="5"></td>
                                    <td><input type="radio" name="q3" value="4"></td>
                                    <td><input type="radio" name="q3" value="3"></td>
                                    <td><input type="radio" name="q3" value="2"></td>
                                    <td><input type="radio" name="q3" value="1"></td>
                                </tr>
                                <tr id="q4Head">
                                    <td> 4. 학생의 발표,토의,질문 등이 적극적으로 권장되었다.</td>
                                    <td><input type="radio" name="q4" value="5"></td>
                                    <td><input type="radio" name="q4" value="4"></td>
                                    <td><input type="radio" name="q4" value="3"></td>
                                    <td><input type="radio" name="q4" value="2"></td>
                                    <td><input type="radio" name="q4" value="1"></td>
                                </tr>
                                <tr id="q5Head">
                                    <td> 5. 수업시간이 전반적으로 잘 준수되었다.</td>
                                    <td><input type="radio" name="q5" value="5"></td>
                                    <td><input type="radio" name="q5" value="4"></td>
                                    <td><input type="radio" name="q5" value="3"></td>
                                    <td><input type="radio" name="q5" value="2"></td>
                                    <td><input type="radio" name="q5" value="1"></td>
                                </tr>
                                <tr id="q6Head">
                                    <td> 6. 성적평가의 기준과 방법이 합리적으로 제시되었다.</td>
                                    <td><input type="radio" name="q6" value="5"></td>
                                    <td><input type="radio" name="q6" value="4"></td>
                                    <td><input type="radio" name="q6" value="3"></td>
                                    <td><input type="radio" name="q6" value="2"></td>
                                    <td><input type="radio" name="q6" value="1"></td>
                                </tr>
                                <tr id="q7Head">
                                    <td> 7. 이 수업의 수강인원은 적절하였다.</td>
                                    <td><input type="radio" name="q7" value="5"></td>
                                    <td><input type="radio" name="q7" value="4"></td>
                                    <td><input type="radio" name="q7" value="3"></td>
                                    <td><input type="radio" name="q7" value="2"></td>
                                    <td><input type="radio" name="q7" value="1"></td>
                                </tr>
                                <tr id="q8Head">
                                    <td> 8. 나는 수업에 적극적으로 참여하였다.</td>
                                    <td><input type="radio" name="q8" value="5"></td>
                                    <td><input type="radio" name="q8" value="4"></td>
                                    <td><input type="radio" name="q8" value="3"></td>
                                    <td><input type="radio" name="q8" value="2"></td>
                                    <td><input type="radio" name="q8" value="1"></td>
                                </tr>
                            </tbody>
                            <tfoot style="background-color: ;text-align: center;">
                                <tr>
                                    <td colspan="6">교수님께 하고싶은 말이나 기타 건의사항이 있다면 아래에 작성 바랍니다.</td>
                                </tr>
                                <tr>
                                    <td colspan="6">
                                        <textarea name="etcText" id="etcText" cols="90" rows="4" style="resize: none;"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6"><button id="submitBtn" class="btn btn-outline-primary btn-sm" type="button">제출</button></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
					
					<script>
					
					 	$('document').ready(function hideForm(){ // div 숨기기
							$(".hide").hide();                		
		            	});
					 	
					 	$(".ratingStartBtn").on("click",function(){ // 강의평가 폼 show , 해당 강의 정보 입력
					 		$(".hide").show();
					 		
					 		var hiddenClassNo = $(this).parent().siblings().eq(0).text();
					 		$("#hiddenClassNo").val(hiddenClassNo);
					 		
					 		var className = $(this).parent().siblings().eq(1).text();
					 		var professorName = $(this).parent().siblings().eq(2).text();
					 		
					 		$("#cn").html("<b>"+className+"</b>");
					 		$("#pn").html("<b>"+professorName+"</b>");
					 		
					 	});
					 	
					 	$("#submitBtn").on("click",function(){ //강의평가 submit 
					 		var classNo = $("#hiddenClassNo").val();
					 		
					 		var q1 = $('input:radio[name=q1]:checked').val();
					 		var q2 = $('input:radio[name=q2]:checked').val();
					 		var q3 = $('input:radio[name=q3]:checked').val();
					 		var q4 = $('input:radio[name=q4]:checked').val();
					 		var q5 = $('input:radio[name=q5]:checked').val();
					 		var q6 = $('input:radio[name=q6]:checked').val();
					 		var q7 = $('input:radio[name=q7]:checked').val();
					 		var q8 = $('input:radio[name=q8]:checked').val();
					 		
					 		var etcText = $("#etcText").val();
					 		
					 		var studentNo = "${loginUser.studentNo}";
					 		
					 		$.ajax({
					 			url : "insertRating.st",
					 			data : {
					 				classNo : classNo,
					 				studentNo : studentNo,
					 				q1 : q1,
					 				q2 : q2,
					 				q3 : q3,
					 				q4 : q4,
					 				q5 : q5,
					 				q6 : q6,
					 				q7 : q7,
					 				q8 : q8,
					 				etc : etcText
					 			},
					 			method: "POST",
					 			success : function(result){
					 				if(result=='Y'){
						 				alert("해당 강의에 대한 강의 평가를 완료하였습니다.");
						 				location.reload(); //동기화 새로고침
						 				//비동기처리를 하기엔 너무 비합리적임.
					 				}else{
					 					alert("너무많은 텍스트를 입력하였거나 , 입력하지 않은 항목이 있습니다.");
					 				}
					 			},
					 			error : function(){
					 				alert("통신 에러");
					 			}
					 			
					 		});
					 	});
					 	
					</script>
					
					
                </div>
			    
    		</div>
      </div>
 </div>
</body>
</html>