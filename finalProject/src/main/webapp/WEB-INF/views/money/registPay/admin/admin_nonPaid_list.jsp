<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                    <a href="#">등록금 관리</a>
                </div>
            </div>
            <!--컨텐츠 영역-->
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <div>
                    <button>미납금관리</button> <button>등록금납부조회</button>
                    </div>
            
                    <hr>
            
                    <div>
	                    <h3>미납금 관리</h3>
	                   	 미납인원 : ${list.size} (명) 
	                   	 미납금 총계 : 0 (원) 
	                   	 <br>
	                                             미입금 : 0 (명) 
	                                             금액미달 : 0 (명)
                    </div>
                    <hr>
                    <br>
                    <button id="sendAll">일괄발송</button>
                    <table id="nonPaidList" border="1" style="width:100%;text-align: center;">
                        <thead>
                            <tr>
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
		                            	<c:forEach var="r" items="list">
			                            	<tr>
				                                <td><input type="checkbox" name="" class="checkbox"></td>
				                                <td>${r.studentNo}</td>
				                                <td class="studentName">${r.studentName}</td>
				                                <td class="nonPaidAmount">${r.nonPaidAmount}</td>
				                                <td>${r.payStatus}</td>
				                                <td>${r.regAccountNo}</td>
				                                <td class="email" >${r.studentEmail}</td>
				                                <td class="phone">${r.studentPhone}</td>
				                                <td><button class="sendDunningBtn">발송</button></td>
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
    
    <script>
    	function sendDunning(){
    		$.ajax({
    			url : "dunning.rg",
    			data : {
    				studentName:$(".studentName").val(),
    				phone:$(".")
		    				
    			},
    			success : function(result){
    				
    			},
    			error : function(){
    				
    			}
    		});
    	}
    	
    	$(function(){
    		$("#checkAll").click(function(){
        		var allcheck = $("#checkAll").is(":checked");
        		
        		if(allcheck){
        			$("input:checkbox").prop("checked",true);
        		}else{
        			$("input:checkbox").prop("checked",false);
        		}
        	});
        	
        	$("#sendAll").click(function(){
        		var control = confirm("선택된 학생에 모두 메시지를 보내겠습니까?");
        		
        		if(control){
        			$("#nonPaidList>tbody>tr>td>input:checkbox:checked").each(function(index){
        				var studentName = $(this).parent().siblings().eq(1).val();
        				console.log(studentName);
        				var nonPaidAmount = $(this).parent().siblings().eq(2).val();
        				var phone = $(this).parent().siblings().eq(5).val();
        				var email = $(this).parent().siblings().eq(6).val();
        				//데이터 없어서 안되는중..
        				
        				//아무튼 ajax처리
        				$.ajax({
        					url : "dunning.rg",
        					data : {
        						studentName : studentName,
        						phone : phone,
        						email : email,
        						nonPaidAmount : nonPaidAmount
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
    	});
    	
    	
    	
    </script>
    
    
    
</body>
</html>