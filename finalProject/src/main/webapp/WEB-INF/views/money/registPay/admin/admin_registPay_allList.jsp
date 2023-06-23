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
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <div>
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='allList.rg'">등록금 납부 현황</button> <button class="btn btn-outline-primary btn-sm" onclick="location.href='nonPaidList.rg'">미납금 조회</button>
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='insert.rg'">등록금 입력</button>
                        <hr>
                        <h3>등록금 납부 조회</h3>
                    </div>
                    
                    <div class="list">
                        <div class="listHead">
                            <div class="AllBtnArea" style="float:left">
                                <!-- <button id="" class="btn btn-outline-primary btn-sm">일괄 환급</button> --> <!-- 미구현 -->
                            </div>
                            <div class="search" style="float:right">
                                <label for="studentName">이름검색</label> <input type="text" name="studentName" id="studentName">
                                <select name="payStatus" id="payStatus">
                                    <!--미입금 / 금액부족은 미납에서 처리-->
                                    <option value="0">입금여부</option>
                                    <option value="1">입금완료</option>
                                    <option value="2">금액초과</option>
                                    <option value="3">금액미달</option>
                                    <option value="4">미납부</option>
                                </select>
                                <button class="btn btn-outline-primary btn-sm" onclick="selectRegistPay()">조회 <i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </div>
                        <br><br>
                        <span>조회결과 [ <span id="countSearch">-</span> 건 ]</span>
                        <div class="listBody" style="height:70%;overflow-y: auto;">
	                        <table border="1" style="width: 100%;text-align: center;" id="registPayList">
	                            <thead>
	                            	<tr style='background-color: #4fc7ff;'>
		                                <th><input type="checkbox" name="checkAll" id="checkAll"></th>
		                                <th>No.</th>
		                                <th>학번</th>
		                                <th>학생명</th>
		                                <th>실납부금액</th>
		                                <th>등록금액</th>
		                                <th>상태</th>
		                                <th>납입계좌</th>
		                                <th>상태변경</th>
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
                           						var studentNo = list[i].studentNo;
                           						var classYear = list[i].classYear;
                           						var classTerm = list[i].classTerm;
                           						
                           						str +="<tr>"
                           							 +"<td><input type='checkbox' name='check' class='check'></td>"
                           							 +"<td>"+list[i].regNo+"</td>"
                           							 +"<td>"+list[i].studentNo+"</td>"
                           							 +"<td>"+list[i].studentName+"</td>"
                           							 +"<td>"+list[i].inputPay.toLocaleString()+"</td>"
                           							 +"<td>"+list[i].mustPay.toLocaleString()+"</td>";
                           							 
                      							 if(list[i].payStatus=='O'){
                       								 str+="<td style='color:blue;'>"+"금액초과"+"</td>"
                       									+"<td>"+list[i].payAccountNo+"</td>"
                       									+"<td><button class='refundBtn btn btn-outline-warning btn-sm'>환급</button><input type='hidden' name='regNo' class='regNoHidden' value="+list[i].regNo+"></td>";
                      							 }else if(list[i].payStatus=='N'){
                      								str+="<td style='color:red;'>"+"미입금"+"</td>"
                   									+"<td>"+"-"+"</td>"
                   									+"<td>"
                   									+`<button class='deleteBtn btn btn-outline-danger btn-sm' onclick="delReg('\${studentNo}','\${classYear}','\${classTerm}');">삭제</button>`
                   									+"</td>";
                      							 }else if(list[i].payStatus=='D'){
                      								str+="<td style='color:orange;'>"+"금액미달"+"</td>"
                   									+"<td>"+list[i].payAccountNo+"</td>"
                   									+"<td><input type='hidden' name='regNo' class='regNoHidden' value="+list[i].regNo+">-</td>";
                      							 }else{
                       								str+="<td style='color:green;'>"+"입금완료"+"</td>"
                   									+"<td>"+list[i].payAccountNo+"</td>"
                   									+"<td><input type='hidden' name='regNo' class='regNoHidden'>-</td>";
                       							 }
                           							str+="</tr>";
                           					}
                           				}else{
                           					str +="<tr><td colspan='9'>데이터가 없습니다.</td></tr>"
                           				}
                           				$("#registPayList>tbody").html(str);
                           				$("#countSearch").html(list.length).css("color","blue").css("font-weight","bold");
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
                       			var inputPay = $(this).parent().siblings().eq(4).text().replace(/,/g,"");
                       			var mustPay = $(this).parent().siblings().eq(5).text().replace(/,/g,"");
                       			var overValue = inputPay - mustPay;
                       			
                       			var regNo = $(this).siblings().eq(0).val();
                       			
                       			var control = comfirm("초과금액 "+overValue+"(원) 을 환급하시겠습니까?");
                       			
                       			console.log(inputPay);
                       			console.log(mustPay);
                       			console.log(overvalue);
                       			
                       			console.log(regNo);
                       			if(true){
                       				//overValue 환급 처리
                       			}
                       			
                       			//등록금 정상화
                       			/*
                       			$.ajax({
                       				url : "refund.rg",
                       				data : {
                       					
                       					inputPay : inputPay
                       					mustPay : mustPay
                       					regNo : regNo 
                       				
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
                       		});
                       	});
                        
						function delReg(a,b,c){
							
							var studentNo = a;
							var classYear = b;
							var classTerm = c;
							
							$.ajax({
								url : "delete.rg",
								data : {
									studentNo : studentNo,
									classYear : classYear,
									classTerm : classTerm
								},
								success : function(result){
									if(result=='Y'){
										alert("등록금 정보 삭제에 성공했습니다.");
										selectRegistPay();
									}else{
										alert("등록금 정보 삭제 실패!");
									}
								},
								error : function(){
									alert("통신 에러");
								}
							});
							
							
                   		}
						
						$("#payStatus").on("change",function(){
							var filter = $("#payStatus").val();
							var str = ""
							if(filter==2){//필터가 금액초과 일때
								str = "<button id='refundAllBtn' class='btn btn-outline-warning btn-sm'>일괄 환급</button>";	
							}else if(filter==4){
								str = "<button id='delAllBtn' class='btn btn-outline-danger btn-sm'>일괄 삭제</button>";
							}
							$(".AllBtnArea").html(str);
						})
                          	
                        </script>
                
                    </div>    
                </div>
            </div>
        </div>
    </div>
</body>
</html>