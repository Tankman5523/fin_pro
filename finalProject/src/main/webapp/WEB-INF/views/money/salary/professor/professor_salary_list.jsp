<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>교수_급여조회</title>
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
                    <a href="mylist.sl">급여조회</a>
                </div>
            </div>
            <!--내용 시작-->
            <div id="content_1">
                <div style="width: 90%;height: 90%;margin: 5%;">
                    <div>
                        <table border="1" style="width: 100%;">
                            <!--로그인유저 자동입력-->
                            <tr>
                                <th>교수명</th>
                                <td><input type="text" name="professorName" value="${loginUser.professorName}" readonly></td>
                                <th>소속</th>
                                <!-- 값 나중에 departmet로 변경 -->
                                <td><input type="text" name="department" value="${loginUser.departmentNo}" readonly></td>
                                
                            </tr>
                            <tr>
                                <th>급여 계좌번호</th>
                                <td><input type="text" name="accountNo" value="${loginUser.accountNo}" readonly></td>
                                <th>연락처</th>
                                <td><input type="text" name="phone" value="${loginUser.phone}" readonly></td>
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
                        $(function(){
                        	var today = new Date();
                       		$("#endDate").val(today);
                        });
							
                        
                        </script>
                        
                    </div>
                    <br>
                    <div>
                        <table border="1" id="payList" style="width: 100%;">
                            <thead>
                                <tr>
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
                        		
                        		var profNo = ${loginUser.professorNo};
                        		
                        		$.ajax({
                        			
                        			url : "mylist.sl",
                        			
                        			data : {
                        				professorNo : profNo,
                        				startDate : $("#startDate").val(),
                        				endDate	: $("#endDate").val()
                        			},
                        			success : function(list){
                        				console.log(list);
                        				var str = "";
                        				var status = "";
                        				if(!list.isEmpty){
                        					for(var i in list){
                        						if(list[i].status=='Y'){
                        							status = "지급완료";
                        						}else if(list[i].status=='E'){
                        							status = "지급오류";
                        						}else if(list[i].status='N'){
                        							status = "미지급";
                        						}
                        						
                        						str +="<tr>"
                        							 +"<td>"+list[i].payNo+"</td>"
                        							 +"<td>"+list[i].paymentDate+"</td>"
                        							 +"<td>"+list[i].paymentTotal+"</td>"
                        							 +"<td>"+list[i].deductTotal+"</td>"
                        							 +"<td>"+list[i].realPay+"</td>"
                        							 +"<td>"+status+"</td>"
                        							 +"</tr>"
                        					}
                        					
                        				}else{
                        					str +="<tr><td  colspan='6'>데이터가 없습니다.</td></tr>"
                        				}
                        				$("#payList>tbody").html(str);	
                        			},
                        			error : function(){
                        				alert("통신오류");
                        			}
                        		});
                        	}
                        </script>
                        
                        
                    </div>
                </div>
            </div>
            <!---->
        </div>
    </div>
</body>
</html>