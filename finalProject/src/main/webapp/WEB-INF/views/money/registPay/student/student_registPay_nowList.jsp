<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생_이번학기등록금</title>
    <style>
    	.readonly{
    		background-color : lightgray;
    	}
    </style>
</head>
<body>
    <div class="wrap">
        <!--===============================메뉴바-===============================-->
        <%@include file="../../../common/student_menubar.jsp" %>
        <!--===============================메뉴바-===============================-->
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">등록/장학</span>
                </div>
                <div class="child_title" style="font-weight:bold;">
                    <a href="onelist.rg">등록금 납부조회</a>
                </div>
                <div class="child_title">
                    <a href="listPage.rg">등록금납입 이력</a>
                </div>
                <div class="child_title">
                    <a href="listPage.sc">장학금 수혜내역</a>
                </div>
            </div>
            <!--컨텐츠 영역-->
            <div id="content_1">
            	
				<div style="width: 90%;height: 90%;margin: 5%;overflow-y: auto;">
					<h4>등록금 납입 이력</h4>
					<br>
                    <label for="classNo">학번</label> <input type="text" name="classNo" id="classNo" value="${loginUser.studentNo}" readonly class="readonly">
                    <br>
                    <label for="studentName">이름</label> <input type="text" name="studentName" id="studentName" value="${loginUser.studentName}" readonly class="readonly">
                    <br>
                    <label for="startDate">납부기간</label> <input type="date" name="startDate" id="startDate" value="${RegistPay.startDate}" readonly class="readonly"> ~ <input type="date" name="endDate" id="endDate" value="${RegistPay.endDate}" readonly class="readonly">
                    <br><br>
                    <table border="1" style="width: 100%;text-align:center;">
                        <thead style="background-color: #4fc7ff;">
                            <tr>
                                <th>납부일</th>
                                <th>납부시간</th>
                                <th>학번</th>
                                <th>성명</th>
                                <th>등록금액</th>
                                <th>입금계좌</th>
                                <th>입금한계좌(학생)</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<!-- 단일 객체 -->
                            <tr>
                                <td>${RegistPay.payDate}
                                	<c:if test="${RegistPay.payDate eq null}">
                                	-
                                	</c:if>
                                </td>
                                <td>${RegistPay.payTime}
                                	<c:if test="${RegistPay.payTime eq null}">
                                	-
                                	</c:if>
                                </td>
                                <td>${RegistPay.studentNo}</td>
                                <td>${RegistPay.studentName}</td>
                                <td>
                                	<fmt:formatNumber type="number" maxFractionDigits="3" value="${RegistPay.mustPay}" />
                                	원		
                                </td>
                                <td>${RegistPay.regAccountNo}</td>
                                <td>${RegistPay.payAccountNo}
                                	<c:if test="${RegistPay.payAccountNo eq null}">
                                	-
                                	</c:if>
                                </td>
                                <td>
                                	<c:choose>
                                		<c:when test="${RegistPay.payStatus eq 'O'}">
	                                		금액초과
                                		</c:when>
                                		<c:when test="${RegistPay.payStatus eq 'Y'}">
                                			등록완료
                                		</c:when>
                                		<c:when test="${RegistPay.payStatus eq 'D'}">
                                			금액미달
                                		</c:when>
                                		<c:otherwise>
                                			미납부
                                		</c:otherwise>
                                	</c:choose>
                                </td>
                            </tr>
                        </tbody>
                    </table>
            		<br><br>
                    <fieldset>
                        <ul>
                            <li>등록금 납부는 학기 시작 전 2달 이내 부터 2주이며 당일부터 문자발송됩니다. 
                            	<br>납부기한 만료시 입학/등록이 취소될 수 있으니 반드시 기한 지켜주시기 바랍니다.</li>
                            <li>등록금 입금 계좌는 본인이 학과 내 조사간 입력 , 혹은 입학처에 문의한 해당은행 가상계좌입니다.</li>
                            <li>금액 초과시에는 초과금이 입금하신 계좌로 환급되오니 이점 인지바랍니다.</li>
                            <li>미납/입금액이 부족할 경우 독촉문자/이메일이 발송되며 3일의 유예기간 초과시 자동 등록취소 처리됩니다. </li>
                            <li style="color:red">시스템 오류가 아닌 본인 과실에 의한 등록 / 입학 취소는 등록처에서 책임지지 않으니 이점 유의바랍니다.</li>
                        </ul>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    	
    </script>
</body>
</html>