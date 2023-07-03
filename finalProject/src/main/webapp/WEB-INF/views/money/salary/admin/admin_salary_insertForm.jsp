<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리_급여입력</title>
    <style>
    	.readonly{
    		background-color : lightgray;
    	}
    	.pay{
    		background-color:rgb(69, 190, 238);
    	}
    	.deduct{
    		background-color:lightcoral;
    	}
    	.total{
    		background-color:lightyellow;
    	}
    </style>
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
                    <a href="allList.rg">등록금 관리</a>
                </div>
                <div class="child_title">
                    <a href="allList.sc">장학금 관리</a>
                </div>
                <div class="child_title" style="font-weight:bold;color:#00aeff;">
                    <a href="allList.sl">급여 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <div style="height:15%;">
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='allList.sl'">급여내역조회</button> 
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='insert.sl'">급여 입력</button>
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='mylist.sl'">내 급여 조회</button>
                        <hr>
                        <h2>급여 입력</h2>
                    </div>
                    <br>
                    <div style="height:80%;" id="pay_content">
                        <table align="center">
                            <tr>
                                <td><label for="professorName">임직원명</label></td>
                                <td><input type="text" name="professorName" id="professorName"></td>
                                <td><label for="professorNo">직번</label></td>
                                <td><input type="text" name="professorNo" id="professorNo"> <button class="btn btn-outline-primary btn-sm" onclick="search();">조회</button></td>
                            </tr>
                            <tr>
                                <td><label for="position">직책</label></td>
                                <td><input class="readonly" type="text" name="position" id="position" readonly></td>
                                <td><label for="paymentDate">급여일</label></td>
                                <td><input class="readonly" type="text" name="paymentDate" id="paymentDate" value="매월 10일" readonly></td>
                            </tr>
                             <tr>
                                <td><label for="phone">연락처</label></td>
                                <td><input class="readonly" type="text" name="phone" id="phone" readonly></td>
                                <td><label for="accountNo">계좌번호</label></td>
                                <td><input class="readonly" type="text" name="accountNo" id="accountNo" readonly></td>
                            </tr>
                        </table>
	                    <div id="pay_stub" align="center" style="height:52%;overflow-y: auto;">
	                    	<hr>
	                    	<form action="insert.sl" method="post" >
	                    	<div id="hiddenNo">
	                    		
	                    	</div>
	                    	<table id="pay_stub_list" border="1" style="text-align: center;width: 80%;" align="center">
	                    		<tr>
	                    			<th class="pay">기본급</th>
	                    			<td><input type="number" id="basePay" name="basePay" onchange="submitDisable();"></td>
	                    			<th class="deduct">국민연금</th>
	                    			<td><input type="number" id="nationalTax" name="nationalTax" onchange="submitDisable();"></td>
	                    		</tr>
	                    		<tr>
	                    			<th class="pay">직책수당</th>
	                    			<td><input type="number" id="positionPay" name="positionPay" onchange="submitDisable();"></td>
	                    			<th class="deduct">건강보험</th>
	                    			<td><input type="number" id="healthTax" name="healthTax" onchange="submitDisable();"></td>
	                    		</tr>
	                    		<tr>
	                    			<th class="pay">연장근로수당</th>
	                    			<td><input type="number" id="extensionPay" name="extensionPay" onchange="submitDisable();"></td>
	                    			<th class="deduct">고용보험</th>
	                    			<td><input type="number" id="employTax" name="employTax" onchange="submitDisable();"></td>
	                    		</tr>
	                    		<tr>
	                    			<th class="pay">휴일근로수당</th>
	                    			<td><input type="number" id="holidayPay" name="holidayPay" onchange="submitDisable();"></td>
	                    			<th class="deduct">소득세</th>
	                    			<td><input type="number" id="incomeTax" name="incomeTax" onchange="submitDisable();"></td>
	                    		</tr>
	                    		<tr>
	                    			<th class="pay">연구비</th>
	                    			<td><input type="number" id="researchPay" name="researchPay" onchange="submitDisable();"></td>
	                    			<th></th>
	                    			<td></td>
	                    		</tr>
	                    		<tr>
	                    			<th></th>
	                    			<td></td>
	                    			<th class="deduct">공제액계</th>
	                    			<td><input type="number" id="deductTotal" class="readonly" name="deductTotal" onchange="submitDisable();" readonly></td>
	                    		</tr>
	                    		<tr>
	                    			<th class="pay">지급액계</th>
	                    			<td><input type="number" id="paymentTotal" class="readonly" name="paymentTotal" onchange="submitDisable();" readonly></td>
	                    			<th class="total">실수령액</th>
	                    			<td><input type="number" id="realPay" class="readonly" name="realPay" onchange="submitDisable();" readonly></td>
	                    		</tr>
	                    	</table>
	                    	<br>
	                    	<button class="btn btn-outline-warning btn-sm" type="button" onclick="reCalBtn();">변경값 계산</button>
	                    	<button id="submitBtn" class="btn btn-outline-primary btn-sm" type="submit">입력</button>
	                    	</form>
	                    </div>	
	                    
	                    <hr style="margin:0;margin-top:5px;">
	    				<div id="searchMemberList" style="height:50%;overflow-y: auto;">
	    					<span>검색결과 [ <span id="searchedMemberCount" style="color:blue;"></span> 명 ]</span>
	    					<table align="center" border="1" style="text-align: center;width: 100%;" >
	    						<thead style='background-color: #4fc7ff;'>
	    							<tr>
	    								<th>직번</th>
	    								<th>성명</th>
	    								<th>직책</th>
	    								<th>연락처</th>
	    								<th>채용일</th>
	    								<th>이메일</th>
	    								<th>주소</th>
	    								<th>계좌번호</th>
	    							</tr>
	    						</thead>
	    						<tbody>
	    							<c:choose>
	    								<c:when test="${not empty p}">
	    									<tr>
			    								<td>${p.professorNo}</td>
			    								<td>${p.professorName}</td>
			    								<td>${p.position}</td>
			    								<td>${p.phone}</td>
			    								<td>${p.entranceDate }</td>
			    								<td>${p.email}</td>
			    								<td>${p.address}</td>
			    								<td>${p.accountNo}</td>
	    									</tr>
	    								</c:when>
	    								<c:otherwise>
	    									<tr>
	    										<td colspan="8">데이터가 없습니다.</td>
	    									</tr>
	    								</c:otherwise>
	    							</c:choose>
	    							
	    						</tbody>
	    					</table>
	    				</div>	
                    </div>
                </div>
                
                <script>
                
	                $('document').ready(function hideStub(){
						$("#pay_stub").hide();                		
	            	});
	            	
	            	$('document').ready(function hideList(){
						$("#searchMemberList").hide();                		
	            	});
	            	
	            	
                	//교수명 , 직번으로 검색
                	function search(){
                		var professorName = $("#professorName").val();
                		var professorNo = $("#professorNo").val();
                		
                		$.ajax({
                			url : "selectPf.sl",
                			
                			data : {
                				professorName : professorName,
                				professorNo : professorNo
                			},
                			
                			success : function(list){
                				
                				$("#searchedMemberCount").html("<b>"+list.length+"</b>");
                				
                				var str = "";
                				if(list[0]!=null){
                					for(var i in list){
                					str +="<tr>"
                						 +"<td>"+list[i].professorNo+"</td>"
                						 +"<td>"+list[i].professorName+"</td>"
                						 +"<td>"+list[i].position+"</td>"
                						 +"<td>"+list[i].phone+"</td>"
                						 +"<td>"+list[i].entranceDate+"</td>"
                						 +"<td>"+list[i].email+"</td>"
                						 +"<td>"+list[i].address+"</td>"
                						 +"<td>"+list[i].accountNo+"</td>"
                						 +"</tr>"
                					}
                				}else{
                					str +="<tr><td colspan='8'>데이터가 없습니다.</td></tr>"
                				}
           						$("#searchMemberList").show();                		
                				$("#searchMemberList>table>tbody").html(str);
                			},
                			
                			error : function(){
                				alert("통신오류");
                			}
                		});
                	}
                	
                	$(function(){
                		// 하단 테이블의 tr 클릭시 해당 직원 정보 및 급여정보 상단에 자동 입력
                    	$("#searchMemberList>table>tbody").on("click","tr",function(){
                    		var professorName =  $(this).children().eq(1).text();
                    		
                    		$("#professorName").val(professorName);
                    		var professorNo = $(this).children().eq(0).text();
                    		$("#professorNo").val(professorNo);
                    		var position = $(this).children().eq(2).text(); 
                    		$("#position").val(position);
                    		var phone = $(this).children().eq(3).text();
                    		$("#phone").val(phone);
                    		var account = $(this).children().eq(7).text();
                    		$("#accountNo").val(account);
                    		
                    		
                    		var today = new Date();
                    		today.setMonth(today.getMonth()+1); //작성하는 다음 달
                    		today.setDate(10);
                    		
                    		var year = today.getFullYear();
                    		var month = today.getMonth()+1; //월이 0~11 로 리턴되기 때문에 여기서 +1처리 
                    		var day = today.getDate();
                    		
                    		var weekDay = today.getDay();
                    		if(weekDay==7){ //해당 요일이 일요일일시
                    			day = day - 2;
                    		}else if(weekDay==6){
                    			day = day - 1;
                    		}
                    		var payDay = year+'/'+month+'/'+day;
                    		
                    		$("#paymentDate").val(payDay);
                    		
                    		$("#pay_stub").show();
                    		$("#searchMemberList").css("height","30%");
                    		var str="<input type='hidden' name='professorNo' value="+professorNo+">"
                    			   +"<input type='hidden' name='paymentDate' value="+payDay+">";
                    		$("#hiddenNo").html(str);
                    		
                    		$('#pay_content').scrollTop(0);
                    		inputPay();
                    		calPay();
                    		calDeduct();
                    		calReal();
                    		submitAble();
                    	});
                	});
                	
                	function inputPay(){
                		var position = $("#position").val();
                		if(position=='행정직원'){
                			$("#basePay").val(3300000);
                			$("#positionPay").val(0);
                			$("#researchPay").val(0);
                		}else if(position=='부교수'){
                			$("#basePay").val(8000000);
                			$("#positionPay").val(0);
                			$("#researchPay").val(300000);
                		}else if(position=='정교수'){
                			$("#basePay").val(12000000);
                			$("#positionPay").val(1000000);
                			$("#researchPay").val(500000);
                		}else if(position=='명예교수'){
                			$("#basePay").val(7500000);
                			$("#positionPay").val(0);
                			$("#researchPay").val(500000);
                		}else if(position=='관리자'){
                			$("#basePay").val(3800000);
                			$("#positionPay").val(0);
                			$("#researchPay").val(0);
                		}
                		
                		$("#holidayPay").val(0);  //일단 0시간근무
                		$("#extensionPay").val(0); //일단 0시간근무
                	}
                	
                	
                	
                	function calPay(){ //급여 총계 자동계산
                		var basePay = $("#basePay").val();
                		var positionPay = $("#positionPay").val();
                		var extensionPay = $("#extensionPay").val();
                		var holidayPay = $("#holidayPay").val();
                		var researchPay = $("#researchPay").val();
                		var total = parseInt(basePay) + parseInt(positionPay) + parseInt(extensionPay) + parseInt(holidayPay) + parseInt(researchPay);
                		
                		$("#paymentTotal").val(total);
                	}
                	
                	function calDeduct(){ //공제액 자동계산
                		var paymentTotal = $("#paymentTotal").val();
                	
                		var nationalTax = Math.round(paymentTotal * 0.045);
                		$("#nationalTax").val(nationalTax);
                		var healthTax = Math.round(paymentTotal * 0.035);
                		$("#healthTax").val(healthTax);
                		var employTax = Math.round(paymentTotal * 0.009);
                		$("#employTax").val(employTax);
                		
                		var incomeTax = 0;
                		
                		if(paymentTotal<=14000000){
                			incomeTax = Math.round(paymentTotal * 0.033); //0.06 * 0.55 
                		}else if(paymentTotal>14000000){
                			incomeTax = Math.round(paymentTotal * 0.07); //0.15 * 0.55
                		}
                		$("#incomeTax").val(incomeTax);
                		
                		var deductTotal = nationalTax + healthTax + employTax + incomeTax; 
                		$("#deductTotal").val(deductTotal);
                	}
                	
                	function calReal(){//실수령액 계산
                		var realPay = $("#paymentTotal").val() - parseInt($("#deductTotal").val()); 
                		$("#realPay").val(realPay);
                	}
                	
                	function reCalBtn(){//직접 수정 후 다시 계산버튼
                		calPay();
                		calDeduct();
                		calReal();
                		submitAble();
                	}
                	//입력버튼 비활성화
                	function submitDisable(){
                		$("#submitBtn").attr("disabled",true);
                		$("#submitBtn").attr("class","btn btn-outline-danger btn-sm");
                		$("#submitBtn").text("입력불가");
                	}
                	//입력버튼 활성화
                	function submitAble(){
                		$("#submitBtn").attr("disabled",false);
                		$("#submitBtn").attr("class","btn btn-outline-primary btn-sm");
                		$("#submitBtn").text("입력");
                	}
                </script>
                
            </div>
        </div>
    </div>
</body>
</html>