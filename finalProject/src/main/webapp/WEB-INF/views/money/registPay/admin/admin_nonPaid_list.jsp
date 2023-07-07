<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자_미납금관리</title>
</head>
<body>
    <div class="wrap">
    	<!--===============================메뉴바-===============================-->
		<%@include file="../../../common/admin_menubar.jsp" %>
        <!--===============================메뉴바-===============================-->
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">금전관리</span>
                </div>
                <div class="child_title">
                    <a href="allList.rg" style="font-weight:bold;color:#00aeff;">등록금 관리</a>
                </div>
                <div class="child_title">
                    <a href="allList.sc">장학금 관리</a>
                </div>
                <div class="child_title">
                    <a href="allList.sl">급여 관리</a>
                </div>
            </div>
            <!--컨텐츠 영역-->
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <div>
                    <button class="btn btn-outline-primary btn-sm" onclick="location.href='allList.rg'">등록금 납부 현황</button> <button class="btn btn-outline-primary btn-sm" onclick="location.href='nonPaidList.rg'">미납금 조회</button>
                    <button class="btn btn-outline-primary btn-sm" onclick="location.href='insert.rg'">등록금 입력</button>
                    </div>
            
                    <hr>
            
                    <div>
	                    <h3>미납금 관리</h3>
	                   	<span>미납인원 : <span id="searchCount" style="color:red;font-weight:bold;">${fn:length(list)}</span> (명)</span> 
                        <br>
                        <!-- 미납금 계산 -->
                        <c:set var = "sumMoney" value = "0" />
						<c:forEach var="list" items="${list}">
							<c:set var= "sumMoney" value="${sumMoney + list.nonPaidAmount}"/>
						</c:forEach>
						
						<span>미납금 총계 : <span style="color:red;font-weight:bold;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sumMoney}"/></span> (원)</span>
						
                    </div>
                    <hr>
                    <button id="sendAll" class="btn btn-outline-primary btn-sm">일괄발송</button>
                    <br><br>
                    <div id="scrollList" style="overflow-y: auto;height:70%;">
                    <table id="nonPaidList" border="1" style="width:100%;text-align: center;">
                        <thead>
                            <tr style='background-color: #4fc7ff;'>
                                <th><input type="checkbox" name="checkAll" id="checkAll"></th>
                                <th>학번</th>
                                <th>학생명</th>
                                <th>미납액</th>
                                <th>입금상태</th>
                                <th>납입 계좌(학교)</th>
                                <th>학생 이메일</th>
                                <th>연락처</th>
                                <th>독촉문자</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:choose >
                        		<c:when test="${not empty list}" >
		                            	<c:forEach var="r" items="${list}" >
			                            	<tr>
				                                <td>
				                               		<input type="checkbox" name="checkbox" class="checkbox">
				                                </td>
				                                <td>${r.studentNo}</td>
				                                <td class="studentName">${r.studentName}</td>
				                                <td class="nonPaidAmount">
				                                	<%-- <fmt:formatNumber type="number" maxFractionDigits="3" value="${r.nonPaidAmount}"/> --%>
				                                 	<!-- 원 -->
				                                 	${r.nonPaidAmount}
				                                </td>
				                                <td>
				                                	<c:choose>
				                                		<c:when test="${RegistPay.payStatus eq 'D'}">
				                                			금액미달
				                                		</c:when>
				                                		<c:otherwise>
				                                			미납부
				                                		</c:otherwise>
				                                	</c:choose>
				                                </td>
				                                <td>${r.regAccountNo}</td>
				                                <td class="email" >${r.studentEmail}</td>
				                                <td class="phone">${r.studentPhone}</td>
				                                <td>
				                                	<button class="sendDunningBtn btn btn-outline-primary btn-sm">발송</button> 
				                                	<!-- <button class="cancelRegistBtn btn btn-outline-warning btn-sm">등록취소</button> -->
				                                </td>
			                            	</tr>
		                                </c:forEach>
	                            </c:when>
	                            <c:otherwise>
	                            	<tr>
		                                <td colspan="9">데이터가 없습니다.</td>
		                            </tr>
	                            </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    	$(function(){ //일괄 체크
    		$("#checkAll").click(function(){
        		var allcheck = $("#checkAll").is(":checked");
        		
        		if(allcheck){
        			$("input:checkbox").prop("checked",true);
        		}else{
        			$("input:checkbox").prop("checked",false);
        		}
        	});
        	
    		$(".sendDunningBtn").click(function(){ //독촉메시지 보내기 개별
        		var control = confirm("선택된 학생에게 메시지를 보내겠습니까?");
        		
        		if(control){
       				var studentName = $(this).parent().siblings().eq(2).text();
       				var nonPaidAmount = $(this).parent().siblings().eq(3).text();
       				var phone = $(this).parent().siblings().eq(7).text();
       				var email = $(this).parent().siblings().eq(6).text();
       				 
       				$.ajax({
       					url : "dunning.rg",
       					data : {
       						studentName : studentName,
       						nonPaidAmount : nonPaidAmount,
       						phone : phone,
       						email : email
       					},
       					method:"POST",
       					success : function(result){
       						if(result=="Y"){
       							alert("이메일 및 sms메시지가 발송되었습니다.");
       						}else{
       							alert("sms 발송 오류. 수신자 : "+result);
       						}
       					},
       					error : function(){
       						alert("통신 오류");
       					}
       				});  
       				
        		}
        	});
    		
    		
        	$("#sendAll").click(function(){ //독촉메시지 일괄 보내기
        		var control = confirm("선택된 학생에 모두 메시지를 보내겠습니까?");
        		
        		if(control){
        			$("#nonPaidList>tbody>tr>td>input:checkbox:checked").each(function(index){
        				var studentName = $(this).parent().siblings().eq(1).text();
        				var nonPaidAmount = $(this).parent().siblings().eq(2).text();
        				var phone = $(this).parent().siblings().eq(6).text();
        				var email = $(this).parent().siblings().eq(5).text();
        				
        				//아무튼 ajax처리
        				
        				$.ajax({
        					url : "dunning.rg",
        					data : {
        						studentName : studentName,
        						nonPaidAmount : nonPaidAmount,
        						phone : phone,
        						email : email
        					},
        					success : function(result){
        						if(result=="Y"){
        							alert("이메일 및 sms메시지가 발송되었습니다.");
        						}else{
        							alert("sms 발송 오류. 수신자 : "+result);
        						}
        					},
        					error : function(){
        						alert("통신 오류");
        					}
        				}); 
        				
        			});
        		}
        	});
        	//등록금 계속 안낼시 강제휴학
        	$(".cancelRegistBtn").on("click",function(){
        		var studentNo = $(this).parent().siblings().eq(1).text();
        		
        		/* 
        		$.ajax({
        			url : "cancelRegist.st",
        			data : {
        				studentNo : studentNo
        			},
        			success : function(result){
        				if(result=='Y'){
        					alert("해당학생은 등록금 미납으로 휴학처리 되었습니다.");
        					document.reload();
        				}else{
        					alert("데이터 처리 실패.");
        				}
        			},error : function(){
        				alert("통신 오류");
        			}
        		}); 
        		*/
        	});
        	
    	});
    	
    	
    	
    </script>
    
    
    
</body>
</html>