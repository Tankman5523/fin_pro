<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>교수_급여조회</title>
    <style>
    	.readonly{
    		background-color : lightgray;
    	}
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
       .modalContent input{
      	 text-align:center;
       }
       #payList>tbody>tr:hover{
      	 background-color : lightgray;
      	 cursor : pointer;
       }
    </style>
</head>
<body>
    <div class="wrap">
    	<!--===============================메뉴바-===============================-->
        <%@include file="../../../common/professor_menubar.jsp" %>
        <!--===============================메뉴바-===============================-->
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">급여관리</span>
                </div>
                <div class="child_title">
                    <a href="mylist.sl" style="font-weight:bold;">급여조회</a>
                </div>
            </div>
            <!--내용 시작-->
            <div id="content_1">
                <div style="width: 90%;height: 90%;margin: 5%;overflow-y: auto;">
                    <div>
                        <table border="1" style="width: 100%;">
                            <!--로그인유저 자동입력-->
                            <tr>
                                <th>교수명</th>
                                <td><input type="text" name="professorName" value="${loginUser.professorName}" readonly class="readonly"></td>
                                <th>소속</th>
                                <!-- 값 나중에 departmet로 변경 -->
                                <td><input type="text" name="department" value="${loginUser.departmentNo}" readonly class="readonly"></td>
                                
                            </tr>
                            <tr>
                                <th>급여 계좌번호</th>
                                <td><input type="text" name="accountNo" value="${loginUser.accountNo}" readonly class="readonly"></td>
                                <th>연락처</th>
                                <td><input type="text" name="phone" value="${loginUser.phone}" readonly class="readonly"></td>
                            </tr>
                            <tr>
                                <!--기간 설정 후 조회 클릭-->
                                <td colspan="4">조회기간 
                                <input type="date" name="startDate" id="startDate" value="${loginUser.entranceDate}" required> ~ <input type="date" name="endDate" id="endDate" value="" required>
                                <button onclick="searchSalary()">조회</button></td>
                            </tr>
                        </table>
                        
                        <script>
                        /*현재 시간 추출*/
                        $("document").ready(function(){
                        	
                        	var today = new Date();
                        	var year = today.getFullYear();
                        	var month = ('0' + (today.getMonth() + 1)).slice(-2);
                        	var day = ('0' + today.getDate()).slice(-2);
                        	
                        	var endDate = year+"-"+month+"-"+day;
                       		$("#endDate").val(endDate);
                        });
                        </script>
                        
                    </div>
                    <br>
                    <div>
                        <table border="1" id="payList" style="width: 100%;text-align:center;">
                            <thead>
                                <tr style="background-color: #4fc7ff;">
                                    <th>No.</th>
                                    <th>지급일자</th>
                                    <th>지급액</th>
                                    <th>공제액</th>
                                    <th>실수령금액</th>
                                    <th>처리상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            </tbody>
                        </table>
                        
                        <script>
                        	function searchSalary(){ 
                        		//본인 급여 조회
                        		//현재 날짜보다 월급일이 나중이라 새로 추가한거 조회 안되는거 정상임~ 날짜바꾸면조회됩니다
                        		
                        		var profNo = "${loginUser.professorNo}";
                        		
                        		$.ajax({
                        			
                        			url : "mylist.sl",
                        			
                        			data : {
                        				professorNo : profNo,
                        				startDate : $("#startDate").val(),
                        				endDate	: $("#endDate").val()
                        			},
                        			method: "POST",
                        			success : function(list){
                        				var str = "";
                        				var status = "";
                        				if(list[0]!=null){
                        					for(var i in list){
                        						var payNo = list[i].payNo;
                        						
                        						if(list[i].status=='Y'){
                        							status = "지급완료";
                        						}else if(list[i].status=='E'){
                        							status = "지급오류";
                        						}else if(list[i].status='N'){
                        							status = "미지급";
                        						}
                        						
                        						str +="<tr onclick='modalOpen("+payNo+")'>"
                        							 +"<td>"+payNo+"</td>"
                        							 +"<td>"+list[i].paymentDate+"</td>"
                        							 +"<td>"+list[i].paymentTotal.toLocaleString()+" 원</td>"
                        							 +"<td>"+list[i].deductTotal.toLocaleString()+" 원</td>"
                        							 +"<td>"+list[i].realPay.toLocaleString()+" 원</td>"
                        							 +"<td>"+status+"</td>"
                        							 +"</tr>";
                        					}
                        					
                        				}else{
                        					str +="<tr><td  colspan='6'>데이터가 없습니다.</td></tr>";
                        				}
                        				$("#payList>tbody").html(str);	
                        			},
                        			error : function(){
                        				alert("통신오류");
                        			}
                        		});
                        	}
                        	
                        	function modalOpen(num){
                        		var payNo = num;
                        		$.ajax({
                        			url : "modal.sl",
                        			data : {
                        				payNo : payNo
                        			},
                        			success : function(result){
    									var str = "";
    									str +="<tr>"
    										 +"<th class='payCol'>기본급</th>"
    										 +"<td><span class='showVal'>"+result.basePay.toLocaleString()+"</span>"+"</td>"
    										 +"<th class='taxCol'>국민연금</th>"
    										 +"<td><span class='showVal'>"+result.nationalTax.toLocaleString()+"</span>"+"</td>"
    										 +"</tr>"
    										 
    										 +"<tr>"
    										 +"<th class='payCol'>직책수당</th>"
    										 +"<td><span class='showVal'>"+result.positionPay.toLocaleString()+"</span>"+"</td>"
    										 +"<th class='taxCol'>건강보험</th>"
    										 +"<td><span class='showVal'>"+result.healthTax.toLocaleString()+"</span>"+"</td>"
    										 +"</tr>"
    										 
    										 +"<tr>"
    										 +"<th class='payCol'>연장근로수당</th>"
    										 +"<td><span class='showVal'>"+result.extensionPay.toLocaleString()+"</span>"+"</td>"
    										 +"<th class='taxCol'>고용보험</th>"
    										 +"<td><span class='showVal'>"+result.employTax.toLocaleString()+"</span>"+"</td>"
    										 +"</tr>"
    										 
    										 +"<tr>"
    										 +"<th class='payCol'>휴일근로수당</th>"
    										 +"<td><span class='showVal'>"+result.holidayPay.toLocaleString()+"</span>"+"</td>"
    										 +"<th class='taxCol'>소득세</th>"
    										 +"<td><span class='showVal'>"+result.incomeTax.toLocaleString()+"</span>"+"</td>"
    										 +"</tr>"
    										 
    										 +"<tr>"
    										 +"<th class='payCol'>연구비</th>"
    										 +"<td><span class='showVal'>"+result.researchPay.toLocaleString()+"</span>"+"</td>"
    										 +"<th></th>"
    										 +"<td>"+"</td>"
    										 +"</tr>"
    										 
    										 +"<tr>"
    										 +"<th></th>"
    										 +"<td>"+"<input type='hidden' id='modal_payNo' name='payNo' value="+payNo+">"+"</td>"
    										 +"<th class='taxCol'>공제액계</th>"
    										 +"<td><span class='showVal'>"+result.deductTotal.toLocaleString()+"</span>"+"</td>"
    										 +"</tr>"
    										 
    										 +"<tr>"
    										 +"<th class='payCol'>지급액계</th>"
    										 +"<td><span class='showVal'>"+result.paymentTotal.toLocaleString()+"</span>"+"</td>"
    										 +"<th class='realCol'>실수령액</th>"
    										 +"<td><span class='showVal'>"+result.realPay.toLocaleString()+"</span>"+"</td>"
    										 +"</tr>";
    										 
    									$(".modalContent>table").html(str);	
    		                    		$(".modal").attr("class","modal show");
                        			},
                        			error : function(){
                        				alert("통신 오류");
                        			}
                        			
                        		});
                        	}
                        	
                        	function closeModal(){ //모달닫기
                        		$(".modal").attr("class","modal");
                        	}
                        </script>
                        
                        
                    </div>
                    <div class="modal">
			        	<div class="modalContent">
			        		<span style="float:right;curser:pointer;" onclick="closeModal();"><b>X</b></span>
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
            </div>
            <!---->
        </div>
    </div>
</body>
</html>