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
                    <div>
                        <button>장학금수혜내역</button> <button>장학금 입력</button>
                        <hr>
                        <h3>등록금 납부 조회</h3>
                    </div>
                    
                    <div class="list">
                        <div class="listHead">
                            <div class="refundAllBtn" style="float:left">
                                <button>일괄 환급</button><br>
                            </div>
                
                            <div class="search" style="float:right">
                                <label for="studentName">이름검색</label><input type="text" name="studentName">
                                <select name="payStatus" id="">
                                    <!--미입금 / 금액부족은 미납에서 처리-->
                                    <option value="0">입금여부</option>
                                    <option value="1">입금</option>
                                    <option value="2">금액초과</option>
                                </select>
                                <button>조회</button>
                            </div>
                        </div>
                        <br>
                        <div class="listBody">
                        <table border="1" style="width: 100%;text-align: center;">
                            <thead>
                            	<tr>
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
                            	<c:choose>
                            		<c:when test="${not empty list}">
                            			<c:forEach var="r" items="list">
		                            	<tr>
			                                <td><input type="checkbox" name="check" class="check"></td>
			                                <td>${r.payDate}</td>
			                                <td>${r.studentNo}</td>
			                                <td>${r.studentName}</td>
			                                <td>${r.inputPay}</td>
			                                <td>${r.mustPay}</td>
			                                <td>${r.payStatus}</td>
			                                <td>${r.payAccountNo}</td>
			                                <td><button>환급</button></td>
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
                
                        <script>
                            var checkAll = document.querySelector("#checkAll");
                			
                        </script>
                
                    </div>    
                </div>
            </div>
        </div>
    </div>
</body>
</html>