<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생</title>
</head>
<body>
    <div class="wrap">
        <!--===============================메뉴바-===============================-->
    	<%@include file="../../../common/student_menubar.jsp" %>
        <!--===============================메뉴바-===============================-->
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">등록/장학</span>
                </div>
                <div class="child_title">
                    <a href="#">등록금 납부조회</a>
                </div>
                <div class="child_title">
                    <a href="#">등록금 납입이력</a>
                </div>
                <div class="child_title">
                    <a href="listPage.sc">장학금 수혜내역</a>
                </div>
            </div>
            <!--컨텐츠 영역 -->
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <div class="info">
                        <h4>장학금 수혜관련 문의</h4>
                        <ul>
                            <li>TEL : 02-580-5141 (장학팀)</li>
                            <li>담당자 : 이레빌딩 20층 장학팀 김장학</li>
                        </ul>
                    </div>
                    <div class="list">
                        <!--loginUser 입학일자 기준으로 최근까지 / 변경시 ajax로 비동기처리-->
                        <select id="classYear" onchange="yearChange();">
                            <option value="0">==전체==</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                            <option value="2020">2020</option>
                            <option value="2019">2019</option>
                            <option value="2018">2018</option>
                            <option value="2017">2017</option>
                            <option value="2017">2016</option>
                        </select>
                        <table border="1" style="width: 100%;" id="scholarList">
                            <thead>
                                <tr>
                                    <th>년도</th>
                                    <th>학기</th>
                                    <th>장학금명</th>
                                    <th>수혜금액</th>
                                    <th>처리상태</th>
                                    <th>처리일자</th>
                                    <th>비고</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<!-- 기본 전체 조회 -->
                            	 <c:choose>
                            		<c:when test="${not empty list}">
                            			<c:forEach var="sc" items="${list}">
		                           			<tr>
			                                    <td>${sc.classYear}</td>
			                                    <td>${sc.classTerm}</td>
			                                    <c:choose>
													<c:when test="${sc.schCategoryNo eq 1}">
														<td>국가장학금</td>
													</c:when>		
													<c:when test="${sc.schCategoryNo eq 2}">
														<td>근로장학금</td>
													</c:when>
													<c:when test="${sc.schCategoryNo eq 3}">
														<td>성적장학금</td>
													</c:when>	
													<c:when test="${sc.schCategoryNo eq 4}">
														<td>우수장학금</td>
													</c:when>                                    				
			                                    </c:choose>
			                                    
			                                    <td>${sc.schAmount}.toLocaleString() 원</td>
			                                    
			                                    <c:choose>
					                            	<c:when test="${sc.status eq 'Y'}">
					                            		 <td>처리완료</td>
					                            	</c:when>
					                            	<c:when test="${sc.status eq 'W'}">
					                            		 <td>처리대기</td>
					                            	</c:when>
					                            	<c:when test="${sc.status eq 'N'}">
					                            		 <td>취소</td>
					                            	</c:when>
			                                    </c:choose>
			                                    
			                                    <td>${sc.proDate}</td>
			                                    <td>${sc.etc}</td>
		                                	</tr>
	                                	</c:forEach>
                            		</c:when>
                            		<c:otherwise>
                            			<tr>
                            				<td colspan="7">데이터가 없습니다.</td>
                            			</tr>
                            		</c:otherwise>
                            	</c:choose>
                            </tbody>
                        </table>
                        <span>* 장학금은 차학기 등록금에서 차감되며 금액초과시 입금통장으로 환급됩니다.</span>
                        <span>* 해당 학기 장학금은 해학기 등록금을 초과하지 않습니다. 이에 유의 바랍니다.</span>
                    </div>
                    <script>
                    	function yearChange(){
                    		
                    		var stuNo = "${loginUser.studentNo}";
                    		
                    		$.ajax({
                    			url : "list.sc",
                    			data : {
                    				classYear : $("#classYear").val(),
                    				studentNo : stuNo
                    			},
                    			success: function(list){
                    				console.log(list);
                    				var str = "";
                    				if(!list.isEmpty){
                    					for(var i in list){
                    						str +="<tr>"
                    							 +"<td>"+list[i].classYear+"</td>"
                    							 +"<td>"+list[i].classTerm+"</td>";
                    							 
	                    						 if(list[i].schCategoryNo==1){
	            	    							str+="<td>국가장학금</td>";
	                							 }else if(list[i].schCategoryNo==2){
	                								str+="<td>근로장학금</td>";
	                							 }else if(list[i].schCategoryNo==3){
	                								str+="<td>성적장학금</td>";
	                							 }else if(list[i].schCategoryNo==4){
	                								str+="<td>우수장학금</td>";
	                							 }
                    							 
	                    						 str+="<td>"+list[i].schAmount.toLocaleString()+" 원 </td>";
	                    						 
	                    						 if(list[i].status=='W'){
	                 								str+="<td>처리대기</td>";
	                 							 }else if(list[i].status=='N'){
	                 								str+="<td>취소</td>";	
	                 							 }else{
	                 								str+="<td>처리완료</td>";
	                 							 }
                    							 
	                    						 str+="<td>"+list[i].proDate+"</td>";
	                    						 
                    							 if(list[i].etc==null){
                     								str+="<td></td>";
                     							 }else{
                     								str+="<td>"+list[i].etc+"</td>";
                     							 } 
                    							 str+="</tr>";
                    					}
                    				}else{
                    					str += "<tr><td colspan='7'>데이터가 없습니다.</td></tr>" 
                    				}
                    				$("#scholarList>tbody").html(str);
                    			},
                    			error : function(){
									 alert("통신오류");                   				
                    			}
                    		});
                    	}
                    
                    </script>
                </div>
            </div>
            <!--컨텐트 영역 종료-->
        </div>
    </div>
</body>
</html>