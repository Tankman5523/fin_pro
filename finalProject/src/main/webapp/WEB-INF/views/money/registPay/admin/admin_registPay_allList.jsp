<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자_등록금납부조회</title>
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
                <div class="child_title" style="font-weight:bold;">
                    <a href="allList.rg">등록금 관리</a>
                </div>
                <div class="child_title">
                    <a href="allList.sc">장학금 관리</a>
                </div>
                <div class="child_title">
                    <a href="allList.sl">급여 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;overflow-y: auto;">
                    <div>
                        <button onclick="location.href='allList.rg'">등록금 납부 현황</button> <button onclick="location.href='nonPaidList.rg'">미납금 조회</button>
                        <button onclick="location.href='insert.rg'">등록금 입력</button>
                        <hr>
                        <h3>등록금 납부 조회</h3>
                    </div>
                    
                    <div class="list">
                        <div class="listHead">
                            <div class="refundAllBtn" style="float:left">
                                <button>일괄 환급</button><br>
                            </div>
                
                            <div class="search" style="float:right">
                                <label for="studentName">이름검색</label><input type="text" name="studentName" id="studentName">
                                <select name="payStatus" id="payStatus">
                                    <!--미입금 / 금액부족은 미납에서 처리-->
                                    <option value="0">입금여부</option>
                                    <option value="1">입금</option>
                                    <option value="2">금액초과</option>
                                </select>
                                <button onclick="selectRegistPay()">조회</button>
                            </div>
                        </div>
                        <br>
                        <div class="listBody">
                        <table border="1" style="width: 100%;text-align: center;" id="registPayList">
                            <thead>
                            	<tr style='background-color: #4fc7ff;'>
	                                <th><input type="checkbox" name="checkAll" id="checkAll"></th>
	                                <th>납부일</th>
	                                <th>학번</th>
	                                <th>학생명</th>
	                                <th>실납부금액</th>
	                                <th>등록금액</th>
	                                <th>상태</th>
	                                <th>납입계좌</th>
	                                <th>초과금환급</th>
                                </tr>
                            </thead>
                
                            <tbody>
                            
                            </tbody>
                        </table>
                        </div>
                
                        <script>
                           	function selectRegistPay(){ //등록금 납부정보 조회/검색
                           		$.ajax({
                           			url : "allList.rg",
                           			data : {
                           				keyword : $("#studentName").val(),
                           				filter : $("#payStatus").val()
                           			},
                           			method : "POST",
                           			success : function(list){
                           				var str = "";
                           				if(list[0]!=null){
                           					for(var i in list){
                           						str +="<tr>"
                           							 +"<td><input type='checkbox' name='check' class='check'></td>"
                           							 +"<td>"+list[i].payDate+"</td>"
                           							 +"<td>"+list[i].studentNo+"</td>"
                           							 +"<td>"+list[i].studentName+"</td>"
                           							 +"<td>"+list[i].inputPay+"</td>"
                           							 +"<td>"+list[i].mustPay+"</td>";
                           							 
                      							 if(list[i].payStatus=='O'){
                       								 str+="<td>"+"금액초과"+"</td>"
                       									+"<td>"+list[i].payAccountNo+"</td>"
                       									+"<td><button class='refundBtn'>환급</button><input type='hidden' name='regNo' id='regNo'></td>";
                       							 }else{
                       								str+="<td>"+"입금완료"+"</td>"
                   									+"<td>"+list[i].payAccountNo+"</td>"
                   									+"<td><input type='hidden' name='regNo' id='regNo'></td>";
                       							 }
                           							str+="</tr>";
                           					}
                           				}else{
                           					str +="<tr><td colspan='9'>데이터가 없습니다.</td></tr>"
                           				}
                           				$("#registPayList>tbody").html(str);
                           			},
                           			error : function(){
                           				alert("통신오류");
                           			}
                           				
                           		});
                           	}
                          	//일괄체크
                           	$(function(){
                           		$("#checkAll").click(function(){
                            		var allcheck = $("#checkAll").is(":checked");
                            		
                            		if(allcheck){
                            			$("input:checkbox").prop("checked",true);
                            		}else{
                            			$("input:checkbox").prop("checked",false);
                            		}
                            	});
                           		//초과금 환급
                           		$(".refundBtn").on("click","button",function(){
                           			var inputPay = $(this).parent().siblings().eq(4).text();
                           			var mustPay = $(this).parent().siblings().eq(5).text();
                           			var overValue = inputPay - mustPay;
                           			
                           			var regNo = $(this).siblings().eq(0).val();
                           			
                           			var control = comfirm("초과금액 "+overValue+"(원) 을 환급하시겠습니까?");
                           			
                           			console.log(inputPay);
                           			console.log(mustPay);
                           			console.log(overvalue);
                           			
                           			console.log(regNo);
                           			
                           			/*
                           			$.ajax({
                           				url : "refund.rg",
                           				data : {
                           					
                           					inputPay : $(this),
                           					mustPay : $(this),
                           					regNo : $(this) 
                           				
                           				},
                           				success : function(result){
                           					if(result=='Y'){
                           						alert("초과금 환급완료");
                           					}else{
                           						alert("환급 실패! 비정상적 데이터입니다.");
                           					}
                           				},
                           				error : function(){
                           					alert("통신 오류");
                           				}
                           			}); 
                           			*/
                           		})
                           	});
                           	
                           	
                           	
                           	
                        </script>
                
                    </div>    
                </div>
            </div>
        </div>
    </div>
</body>
</html>