<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리_급여조회</title>
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
                <div class="child_title">
                    <a href="#">장학금 관리</a>
                </div>
                <div class="child_title">
                    <a href="#">급여 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
					<h2>급여관리</h2>
			        <div id="listHead">
			            <div id="PayAllBtn" style="float:left">
			                <button>일괄지급</button>
			            </div>
			            <div id="search" style="float:right">
				            <form>
				                <label for="keyword">이름검색</label> <input type="text" name="keyword" id="keyword">
				                <select name="payStatus" id="payStatus">
				                    <option value="0">=전체=</option>
				                    <option value="1">미지급</option>
				                    <option value="2">지급오류</option>
				                    <option value="3">지급완료</option>
				                </select>
				                <input type="button" value="조회" onclick="search();"> <input type="reset" value="초기화">
				            </form>
			            </div>
			            <br>
			            <div>
			                <table border="1" style="text-align: center;width: 100%;background-color: antiquewhite;">
			                    <thead>
			                        <tr>
			                            <th><input type="checkbox" name="checkAll" id="checkAll"></th>
			                            <th>직번</th>
			                            <th>직책</th>
			                            <th>교수명</th>
			                            <th>실수령액</th>
			                            <th>지급액</th>
			                            <th>공제액</th>
			                            <th>급여계좌</th>
			                            <th>지급여부</th>
			                            <th>급여지급</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                    
			                    	<%-- <c:choose>
			                    		<c:when test="${not empty list}">
			                    			<c:forEach var="s" items="list">
						                        <tr>
						                            <td><input type="checkbox" name="checkbox" id="checkbox"></td>
						                            <td>${s.professorNo}</td>
						                            <td>${s.position}</td>
						                            <td>${s.professorName}</td>
						                            <td>${s.realPay}</td>
						                            <td>${s.paymentTotal}</td>
						                            <td>${s.deductTotal}</td>
						                            <td>${s.accountNo}</td>
						                            <td>${s.status}</td>
						                            <td><button>지급</button></td>
						                        </tr>
					                        </c:forEach>
			                        	</c:when>
			                        	<c:otherwise>
				                        	<tr>
				                            	<td colspan="10">데이터가 없습니다.</td>
				                       		</tr>
			                        	</c:otherwise>
			                        </c:choose> --%>
			                        
			                    </tbody>
			                    
			                </table>
			            </div>
			        </div>
                </div>
                
                <script>
                	function search(){
                		var keyword = $("#keyword").val();
                		var payStatus = $("#payStatus").val();
                		
                		$.ajax({
                			url : "allList.sl",
                			data : {
                				keyword : keyword,
                				payStatus : payStatus
                			},
                			success : function(list){
                				
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
</body>
</html>