<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리_급여조회</title>
    <style>
      /* 전부 모달용 style */
      .modal {
        position: absolute;
        top: 0;
        left: 0;

        width: 100%;
        height: 100%;

        display: none;

        background-color: rgba(0, 0, 0, 0.4);
      }
      
      .modal.show {
        display: block;
      }
      .modalContent{
		position: absolute;
		top: 50%;
		left: 50%;
		
		width: 550px;
		height: 600px;
		
		padding: 40px;
		
		text-align: center;
		
		background-color: rgb(255, 255, 255);
		border-radius: 10px;
		box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
		
		transform: translateX(-50%) translateY(-50%);
      }
      
      .payCol{
      	background-color:rgb(69, 190, 238);
      }
      .taxCol{
      	background-color:lightcoral;
      }
      .realCol{
      	background-color:lightyellow;
      }
      .hiddenInput{
      	width:130px;
      }
      .modalContent input{
      	text-align:center;
      }
      #salaryList>tbody>tr:hover{
      	background-color : lightgray;
      	cursor : pointer;
      }
      #closeBtn:hover{
        cursor : pointer;			
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
                <div class="child_title">
                    <a href="allList.sl" style="font-weight:bold;color:#00aeff;">급여 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
					<div style="height:15%;">
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='allList.sl'">급여전체조회</button> 
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='insert.sl'">급여 입력</button>
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='mylist.sl'">내 급여 조회</button>
                        <hr>
                        <h2>급여 관리</h2>
                    </div>
			        <div id="listHead" style="height:80%;">
			            <div id="PayAllBtn" style="float:left;height:7%;">
			                <button id="payAll" class="btn btn-outline-primary btn-sm">일괄지급</button> <button class="btn btn-outline-primary btn-sm" id="deleteAll">일괄삭제</button>
			            	
			            </div>
			            <br>
			            <div id="search" style="float:right;height:7%;">
				            <form>
				                <label for="keyword">이름검색</label> <input type="text" name="keyword" id="keyword">
				                <select name="payStatus" id="payStatus">
				                    <option value="all">=전체=</option>
				                    <option value="N">미지급</option>
				                    <option value="E">지급오류</option>
				                    <option value="Y">지급완료</option>
				                </select>
				                <input class="btn btn-outline-primary btn-sm" type="button" value="조회" onclick="search();"> <input class="btn btn-outline-warning btn-sm" type="reset" value="초기화">
				            </form>
			            </div>
			            <br>
			            <span>조회결과 [ <span id="countSearch">-</span> 건 ]</span>
			            <div style="height:80%;">
			                <table id="salaryList" border="1" style="text-align: center;width: 100%;">
			                    <thead style='background-color: #4fc7ff;'>
			                        <tr>
			                            <th><input type="checkbox" name="checkAll" id="checkAll"></th>
			                            <th>직번</th>
			                            <th>직책</th>
			                            <th>교수명</th>
			                            <th>실수령액</th>
			                            <th>지급액</th>
			                            <th>공제액</th>
			                            <th>급여계좌</th>
			                            <th>급여일</th>
			                            <th>지급여부</th>
			                            <th>정보수정</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                        <!-- ajax 처리 -->	
			                    </tbody>
			                </table>
			            </div>
			        </div>
			        <div class="modal">
			        	<div class="modalContent">
			        		<span id="closeBtn" style="float:right;curser:pointer;" onclick="closeModal();"><i class="fa-solid fa-xmark"></i></span>
			        		<h4><b>급여명세서</b></h4>
			        		<br>
			        		<table border="1" style="text-align:center;width: 100%;height: 60%;">
			        		
	                    	</table>
	                    	<br>
	                    	<div id="modalBtns" style="float:right;width:100%;">
	
	                    	</div>
			        	</div>
			        </div>
                </div>
                
                <script>
	              	//해당 영역에 이벤트 안걸리게하기
	              	
	              	
	              	function stopEvent(){
	              		event.cancelBubble = true;
	              	}
                
                	function search(){//검색기능
                		var keyword = $("#keyword").val();
                		var payStatus = $("#payStatus").val();
                		
                		$.ajax({
                			url : "allList.sl",
                			data : {
                				professorName : keyword,
                				status : payStatus
                			},
                			method: "POST",
                			success : function(list){
                				var str = "";
                				var status = "";
                				if(list[0]!=null){
                					for(var i in list){
                						if(list[i].status=='Y'){
                							status = "지급완료";
                						}else if(list[i].status=='E'){
                							status = "지급오류";
                						}else if(list[i].status='N'){
                							status = "미지급";
                						}
	                					str +="<tr>"
	                						 +"<td onclick='stopEvent();'><input type='checkbox' name='check'></td>"
	                						 +"<td>"+list[i].professorNo+"</td>"
	                						 +"<td>"+list[i].position+"</td>"
	                						 +"<td>"+list[i].professorName+"</td>"
	                						 +"<td>"+list[i].realPay.toLocaleString()+"</td>"
	                						 +"<td>"+list[i].paymentTotal.toLocaleString()+"</td>"
	                						 +"<td>"+list[i].deductTotal.toLocaleString()+"</td>"
	                						 +"<td>"+list[i].accountNo+"</td>"
	                						 +"<td>"+list[i].paymentDate+"</td>"
	                						 +"<td>"+status+"</td>"
	                						 +"<td onclick='stopEvent();'>"+"<input type='hidden' name='payNo' value="+list[i].payNo+">";
                						 if(status!='지급완료'){
                						 	str +="<button class='deleteBtn btn btn-outline-danger btn-sm' onclick='deleteSalary("+list[i].payNo+");'>삭제</button>"
                						 }
                						 str+="</td>"
                						 	 +"</tr>";
                					}
                				}else{
                					str +="<tr><td colspan='11'>데이터가 없습니다.</td></tr>"
                				}
                				$("#salaryList>tbody").html(str);
                				$("#countSearch").html("<b>"+list.length+"</b>");
                				$("#countSearch").css("color","blue");
                			},
                			error : function(){
                				alert("통신오류");
                			}
                		});
                	}
                	
                	
                	$(function(){
                		//체크박스 일괄체크
                    	$("#checkAll").click(function(){
                    		var allcheck = $("#checkAll").is(":checked");
                    		
                    		if(allcheck){
                    			$("input:checkbox").prop("checked",true);
                    		}else{
                    			$("input:checkbox").prop("checked",false);
                    		}
                    	});
                	
                		//체크된 급여 일괄삭제
                    	$("#deleteAll").click(function(){
	                   		var control = confirm("선택된 급여정보를 모두 삭제하시겠습니까?");
	                   		
	                   		if(control){
	                   			var succ = 0;
	                   			var fail = 0;
                			 	$("#salaryList>tbody>tr>td>input:checkbox:checked").each(function(index){
	           						var payNo = $(this).parent().siblings().eq(9).children("input").val();
	           						var status = $(this).parent().siblings().eq(8).text();
	               					
	               					if(status!='지급완료'){ //이미 정상지급한 객체는 실패
		           						$.ajax({
		           			        		url: "delete.sl",
		           			        		data:{
		           			        			payNo: payNo
		           			        		},
		           			        		success: function(result){
		           			        			if(result=='Y'){
		           			        			}else{
		           			        				fail+=1;
		           			        			}
		           			        		},
		           			        		error: function(){
		           			        			alert("통신 연결 실패");
		           			        		},
		           			        		complete: function() {
		           			                    search();
		           			                }
		           			        	});
	               					}else{
	               						fail+= 1;
	               					}
	           						
	           						
	               				}); 
                			 	if(flag>0){
           							alert("성공한 급여 수 : "+succ+"(개) / 실패한 급여 수 :"+fail+"(개)");
           						}else{
           							alert("선택한 급여를 모두 삭제 완료하였습니다.");
           						}
	                   		}
                    	});
                		
                    	//체크된 급여 일괄송금 (실제로 돈이 들어왔을때 반응+상태변경)
                    	$("#payAll").click(function(){
	                   		var control = confirm("선택된 급여를 모두 송금하시겠습니까?");
	                   		
	                   		if(control){
	                   			var succ = 0;
	                   			var fail = 0;
	                			$("#salaryList>tbody>tr>td>input:checkbox:checked").each(function(index){
	           						var payNo = $(this).parent().siblings().eq(9).children("input").val();
	           						var status = $(this).parent().siblings().eq(8).text();
	               					
	               					if(status!='지급완료'){ //이미 정상지급한 객체는 실패
		           						$.ajax({
		           			        		url: "pay.sl",
		           			        		data:{
		           			        			payNo: payNo
		           			        		},
		           			        		success: function(result){
		           			        			if(result=='N'){
		           			        				fail+=1;
		           			        			}else{
		           			        				succ+=1;
		           			        			}
		           			        		},
		           			        		error: function(){
		           			        			alert("통신 연결 실패");
		           			        		},
		           			        		complete: function() {
		           			                    search();
		           			                }
		           			        	}); 
	               					}else{
	               						fail+=1;
	               					}
	               				}); 
	                			if(flag>0){
           							alert("성공한 급여 수 :"+succ+"(개) / 실패한 급여 수 :"+fail+"(개)");
           						}else{
           							alert("선택한 급여를 모두 송금 완료하였습니다.");
           						}
	                   		}
                    	});
                    	
                    	//급여명세서 모달로 띄워주기
                    	$("#salaryList>tbody").on("click","tr",function(){
                    		var payNo = $(this).children().siblings().eq(10).children("input").val();
                    		var status = $(this).children().siblings().eq(9).text();
                    		$.ajax({
                    			url : "modal.sl",
                    			data : {
                    				payNo : payNo
                    			},
                    			success : function(result){
									var str = "";
									str +="<tr>"
										 +"<th class='payCol'>기본급</th>"
										 +"<td><span class='showVal'>"+result.basePay.toLocaleString()+"</span><input type='number' id='modal_basePay' class='hiddenInput' name='basePay' value="+result.basePay+" onchange='submitDisable();'>"+"</td>"
										 +"<th class='taxCol'>국민연금</th>"
										 +"<td><span class='showVal'>"+result.nationalTax.toLocaleString()+"</span><input type='number' id='modal_nationalTax' class='hiddenInput' name='nationalTax' value="+result.nationalTax+" onchange='submitDisable();'>"+"</td>"
										 +"</tr>"
										 
										 +"<tr>"
										 +"<th class='payCol'>직책수당</th>"
										 +"<td><span class='showVal'>"+result.positionPay.toLocaleString()+"</span><input type='number' id='modal_positionPay' class='hiddenInput' name='positionPay' value="+result.positionPay+" onchange='submitDisable();'>"+"</td>"
										 +"<th class='taxCol'>건강보험</th>"
										 +"<td><span class='showVal'>"+result.healthTax.toLocaleString()+"</span><input type='number' id='modal_healthTax' class='hiddenInput' name='healthTax' value="+result.healthTax+" onchange='submitDisable();'>"+"</td>"
										 +"</tr>"
										 
										 +"<tr>"
										 +"<th class='payCol'>연장근로수당</th>"
										 +"<td><span class='showVal'>"+result.extensionPay.toLocaleString()+"</span><input type='number' id='modal_extensionPay' class='hiddenInput' name='extensionPay' value="+result.extensionPay+" onchange='submitDisable();'>"+"</td>"
										 +"<th class='taxCol'>고용보험</th>"
										 +"<td><span class='showVal'>"+result.employTax.toLocaleString()+"</span><input type='number' id='modal_employTax' class='hiddenInput' name='employTax' value="+result.employTax+" onchange='submitDisable();'>"+"</td>"
										 +"</tr>"
										 
										 +"<tr>"
										 +"<th class='payCol'>휴일근로수당</th>"
										 +"<td><span class='showVal'>"+result.holidayPay.toLocaleString()+"</span><input type='number' id='modal_holidayPay' class='hiddenInput' name='holidayPay' value="+result.holidayPay+" onchange='submitDisable();'>"+"</td>"
										 +"<th class='taxCol'>소득세</th>"
										 +"<td><span class='showVal'>"+result.incomeTax.toLocaleString()+"</span><input type='number' id='modal_incomeTax' class='hiddenInput' name='incomeTax' value="+result.incomeTax+" onchange='submitDisable();'>"+"</td>"
										 +"</tr>"
										 
										 +"<tr>"
										 +"<th class='payCol'>연구비</th>"
										 +"<td><span class='showVal'>"+result.researchPay.toLocaleString()+"</span><input type='number' id='modal_researchPay' class='hiddenInput' name='researchPay' value="+result.researchPay+" onchange='submitDisable();'>"+"</td>"
										 +"<th></th>"
										 +"<td>"+"</td>"
										 +"</tr>"
										 
										 +"<tr>"
										 +"<th></th>"
										 +"<td>"+"<input type='hidden' id='modal_payNo' name='payNo' value="+payNo+">"+"</td>"
										 +"<th class='taxCol'>공제액계</th>"
										 +"<td><span class='showVal'>"+result.deductTotal.toLocaleString()+"</span><input type='number' id='modal_deductTotal' class='hiddenInput' name='deductTotal' value="+result.deductTotal+" readonly onchange='submitDisable();'>"+"</td>"
										 +"</tr>"
										 
										 +"<tr>"
										 +"<th class='payCol'>지급액계</th>"
										 +"<td><span class='showVal'>"+result.paymentTotal.toLocaleString()+"</span><input type='number' id='modal_paymentTotal' class='hiddenInput' name='paymentTotal' value="+result.paymentTotal+" readonly onchange='submitDisable();'>"+"</td>"
										 +"<th class='realCol'>실수령액</th>"
										 +"<td><span class='showVal'>"+result.realPay.toLocaleString()+"</span><input type='number' id='modal_realPay' class='hiddenInput' name='realPay' value="+result.realPay+" readonly onchange='submitDisable();'>"+"</td>"
										 +"</tr>";
										 
									$(".modalContent>table").html(str);	
		                    		$(".modal").attr("class","modal show");
                    				
		                    		var str2 = "";
		                    		
			                    	if(status!='지급완료'){ //이미 지급완료된 건에 대해서는 수정/송금 불가 
		                    		str2+="<button class='hiddenBtn btn btn-outline-warning btn-sm' onclick='calPay();'>변경값계산</button> "
			                    		 +"<button class='hiddenBtn btn btn-outline-primary btn-sm' id='submitBtn' onclick='updateSubmit();'>적용</button> "
			                    		 +"<button class='showBtn btn btn-outline-warning btn-sm' onclick='updateMode();'>수정</button> "
			                    		 +"<button class='showBtn btn btn-outline-primary btn-sm' onclick='sendSalary();'>송금</button>";	 
			                    	}
		                    		$("#modalBtns").html(str2);
		                    		$(".showInput").show();
		                    		$(".showVal").show();
		                    		$(".showBtn").show();
		                    		$(".hiddenInput").hide();
		                    		$(".hiddenVal").hide();
		                    		$(".hiddenBtn").hide();
                    			},
                    			error : function(){
                    				alert("통신에러");
                    			}
                    		});
                    	});
                    });
                	
                	
                	function closeModal(){ //모달닫기
                		$(".modal").attr("class","modal");
                	
                		$(".showInput").hide();
                		$(".showVal").hide();
                		$(".hiddenInput").hide();
                		$(".hiddenVal").hide();
                	}
                	
                	function updateMode(){ //값 수정가능한 모달
                		$(".showVal").hide();
                		$(".showBtn").hide();
                		$(".hiddenInput").show(); 
                		$(".hiddenBtn").show();
                	}
                	
                	function calPay(){ //수정한 급여 계산 + 공제
                		var basePay = $("#modal_basePay").val();
                		var positionPay = $("#modal_positionPay").val();
                		var extensionPay = $("#modal_extensionPay").val();
                		var holidayPay = $("#modal_holidayPay").val();
                		var researchPay = $("#modal_researchPay").val();
                		var total = parseInt(basePay) + parseInt(positionPay) + parseInt(extensionPay) + parseInt(holidayPay) + parseInt(researchPay);
                		$("#modal_paymentTotal").val(total);
						
                		calDeduct();
                		submitAble(); //적용버튼 활성화
                	}
                	
                	function calDeduct(){//공제액 계산 + 총합계산
                		var paymentTotal = $("#modal_paymentTotal").val();
                    	
                		var nationalTax = Math.round(paymentTotal * 0.045);
                		$("#modal_nationalTax").val(nationalTax);
                		var healthTax = Math.round(paymentTotal * 0.035);
                		$("#modal_healthTax").val(healthTax);
                		var employTax = Math.round(paymentTotal * 0.009);
                		$("#modal_employTax").val(employTax);
                		
                		
                		var incomeTax = 0;
                		
                		if(paymentTotal<=14000000){
                			incomeTax = Math.round(paymentTotal * 0.033); //0.06 * 0.55 
                		}else if(paymentTotal>14000000){
                			incomeTax = Math.round(paymentTotal * 0.07); //0.15 * 0.55
                		}
                		$("#modal_incomeTax").val(incomeTax);
                		
                		
                		var deductTotal = nationalTax + healthTax + employTax + incomeTax; 
                		$("#modal_deductTotal").val(deductTotal);
                		
                		$("#modal_realPay").val($("#modal_paymentTotal").val() - $("#modal_deductTotal").val());
                	}
                	
                	function updateSubmit(){ //값 수정 보내기,완료
                		var payNo = $("#modal_payNo").val();
                		$.ajax({
                			url : "update.sl",
                			data : {
                				payNo : $("#modal_payNo").val(),
                				
                				basePay : $("#modal_basePay").val(),
                				positionPay : $("#modal_positionPay").val(),
                				extensionPay : $("#modal_extensionPay").val(),
                				holidayPay : $("#modal_holidayPay").val(),
                				researchPay : $("#modal_researchPay").val(),
                				paymentTotal : $("#modal_paymentTotal").val(),
                				
                				nationalTax : $("#modal_nationalTax").val(),
                				healthTax : $("#modal_healthTax").val(),
                				employTax : $("#modal_employTax").val(),
                				incomeTax : $("#modal_incomeTax").val(),
                				deductTotal : $("#modal_deductTotal").val(),
                				
                				realPay : $("#modal_realPay").val()
                			},
                			method : "POST",
                			success : function(result){
                				if(result=='Y'){
                					alert("수정성공");
                				}else{
                					alert("수정실패");
                				}
                			},
                			error : function(){
                				alert("통신 오류");
                			},
                			complete : function(){
                				//재조회
                				$(".showVal").show();
		                		$(".showInput").show();
		                		$(".showBtn").show();
		                		$(".hiddenInput").hide();
		                		$(".hiddenVal").hide();
		                		$(".hiddenBtn").hide();
		                		
                				modalReload(payNo);
                			}
                		});
                		
                		
                	}
                	
                	function modalReload(payNo){ //모달 재조회용 구문
                		$.ajax({
                			url : "modal.sl",
                			data : {
                				payNo : payNo
                			},
                			success : function(result){
								var str = "";
								str +="<tr>"
									 +"<th class='payCol'>기본급</th>"
									 +"<td><span class='showVal'>"+result.basePay.toLocaleString()+"</span><input type='number' id='modal_basePay' class='hiddenInput' name='basePay' value="+result.basePay+" onchange='submitDisable();'>"+"</td>"
									 +"<th class='taxCol'>국민연금</th>"
									 +"<td><span class='showVal'>"+result.nationalTax.toLocaleString()+"</span><input type='number' id='modal_nationalTax' class='hiddenInput' name='nationalTax' value="+result.nationalTax+" onchange='submitDisable();'>"+"</td>"
									 +"</tr>"
									 
									 +"<tr>"
									 +"<th class='payCol'>직책수당</th>"
									 +"<td><span class='showVal'>"+result.positionPay.toLocaleString()+"</span><input type='number' id='modal_positionPay' class='hiddenInput' name='positionPay' value="+result.positionPay+" onchange='submitDisable();'>"+"</td>"
									 +"<th class='taxCol'>건강보험</th>"
									 +"<td><span class='showVal'>"+result.healthTax.toLocaleString()+"</span><input type='number' id='modal_healthTax' class='hiddenInput' name='healthTax' value="+result.healthTax+" onchange='submitDisable();'>"+"</td>"
									 +"</tr>"
									 
									 +"<tr>"
									 +"<th class='payCol'>연장근로수당</th>"
									 +"<td><span class='showVal'>"+result.extensionPay.toLocaleString()+"</span><input type='number' id='modal_extensionPay' class='hiddenInput' name='extensionPay' value="+result.extensionPay+" onchange='submitDisable();'>"+"</td>"
									 +"<th class='taxCol'>고용보험</th>"
									 +"<td><span class='showVal'>"+result.employTax.toLocaleString()+"</span><input type='number' id='modal_employTax' class='hiddenInput' name='employTax' value="+result.employTax+" onchange='submitDisable();'>"+"</td>"
									 +"</tr>"
									 
									 +"<tr>"
									 +"<th class='payCol'>휴일근로수당</th>"
									 +"<td><span class='showVal'>"+result.holidayPay.toLocaleString()+"</span><input type='number' id='modal_holidayPay' class='hiddenInput' name='holidayPay' value="+result.holidayPay+" onchange='submitDisable();'>"+"</td>"
									 +"<th class='taxCol'>소득세</th>"
									 +"<td><span class='showVal'>"+result.incomeTax.toLocaleString()+"</span><input type='number' id='modal_incomeTax' class='hiddenInput' name='incomeTax' value="+result.incomeTax+" onchange='submitDisable();'>"+"</td>"
									 +"</tr>"
									 
									 +"<tr>"
									 +"<th class='payCol'>연구비</th>"
									 +"<td><span class='showVal'>"+result.researchPay.toLocaleString()+"</span><input type='number' id='modal_researchPay' class='hiddenInput' name='researchPay' value="+result.researchPay+" onchange='submitDisable();'>"+"</td>"
									 +"<th></th>"
									 +"<td>"+"</td>"
									 +"</tr>"
									 
									 +"<tr>"
									 +"<th></th>"
									 +"<td>"+"<input type='hidden' id='modal_payNo' name='payNo' value="+payNo+">"+"</td>"
									 +"<th class='taxCol'>공제액계</th>"
									 +"<td><span class='showVal'>"+result.deductTotal.toLocaleString()+"</span><input type='number' id='modal_deductTotal' class='hiddenInput' name='deductTotal' value="+result.deductTotal+" readonly onchange='submitDisable();'>"+"</td>"
									 +"</tr>"
									 
									 +"<tr>"
									 +"<th class='payCol'>지급액계</th>"
									 +"<td><span class='showVal'>"+result.paymentTotal.toLocaleString()+"</span><input type='number' id='modal_paymentTotal' class='hiddenInput' name='paymentTotal' value="+result.paymentTotal+" readonly onchange='submitDisable();'>"+"</td>"
									 +"<th class='realCol'>실수령액</th>"
									 +"<td><span class='showVal'>"+result.realPay.toLocaleString()+"</span><input type='number' id='modal_realPay' class='hiddenInput' name='realPay' value="+result.realPay+" readonly onchange='submitDisable();'>"+"</td>"
									 +"</tr>";
									 
								$(".modalContent>table").html(str);	
	                    		$(".modal").attr("class","modal show");
                				$(".modal").show();
                				
                				$(".showInput").show();
	                    		$(".showVal").show();
	                    		$(".showBtn").show();
	                    		$(".hiddenInput").hide();
	                    		$(".hiddenVal").hide();
	                    		$(".hiddenBtn").hide();
                			},
                			error : function(){
                				alert("통신에러");
                			}
                		});
                	}
                	
                	function sendSalary(){ //급여 송금 (상태값 변경) 
                		var control = confirm("선택된 급여를 송금하시겠습니까?");
                		if(control){
	                		var payNo = $("#modal_payNo").val();
	                		$.ajax({
       			        		url: "pay.sl",
       			        		data:{
       			        			payNo: payNo
       			        		},
       			        		success: function(result){
       			        			if(result=='Y'){
       			        				alert("송금 성공");
       			        			}else{
       			        				alert("송금 실패");
       			        			}
       			        			closeModal();
       			        		},
       			        		error: function(){
       			        			alert("통신 연결 실패");
       			        		},
       			        		complete: function() {
       			                    search();
       			                }
       			        	});  
                		}
                	}
                	//급여정보 삭제
                	function deleteSalary(payNo){
                		var control = confirm("해당 급여정보를 삭제하시겠습니까?");
   						
                		if(control){
                			$.ajax({
       			        		url: "delete.sl",
       			        		data:{
       			        			payNo: payNo
       			        		},
       			        		success: function(result){
       			        			if(result=='Y'){
       		   							alert("선택한 급여정보를 삭제하였습니다.");
       		   						}else{
       		   							alert("급여 삭제 실패!");
       		   						}
       			        		},
       			        		error: function(){
       			        			alert("통신 연결 실패");
       			        		},
       			        		complete: function() {
       			                    search();
       			                }
       			        	}); 
                		}
   						
                	}
                	
                	//입력버튼 비활성화
                	function submitDisable(){
                		$("#submitBtn").attr("disabled",true);
                		$("#submitBtn").attr("class","hiddenBtn btn btn-outline-danger btn-sm");
                		$("#submitBtn").text("입력불가");
                	}
                	//입력버튼 활성화
                	function submitAble(){
                		$("#submitBtn").attr("disabled",false);
                		$("#submitBtn").attr("class","hiddenBtn btn btn-outline-primary btn-sm");
                		$("#submitBtn").text("입력");
                	}
                	
                </script>
                
            </div>
        </div>
    </div>
</body>
</html>