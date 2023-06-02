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
                    <button>일괄발송</button>
                    <table border="1" style="width:100%;text-align: center;">
                        <thead>
                            <tr>
                                <th><input type="checkbox" name="checkAll" id="checkAll"></th>
                                <th>학번</th>
                                <th>학생명</th>
                                <th>미납액</th>
                                <th>입금/취소</th>
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
				                                <td>${r.studentName}</td>
				                                <td>${r.NonPaidAmount}</td>
				                                <td>${r.payStatus}</td>
				                                <td>${r.regAccountNo}</td>
				                                <td>${r.studentEmail}</td>
				                                <td>${r.studentPhone}</td>
				                                <td><button>발송</button></td>
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
</body>
</html>