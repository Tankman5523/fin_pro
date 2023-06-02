<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생</title>
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
                <div class="child_title">
                    <a href="#">등록금 납부조회</a>
                </div>
                <div class="child_title">
                    <a href="#">등록금 납입이력</a>
                </div>
                <div class="child_title">
                    <a href="#">장학금 수혜내역</a>
                </div>
            </div>
            <!--컨텐츠 영역 -->
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <div class="info">
                        <h4>장학금 수혜관련 문의</h4>
                        <ul>
                            <li>TEL : 02-580-5141 (장학팀)</li>
                            <li>담당자 : 이레빌딩 20층 장학팀 김장학</li>
                        </ul>
                    </div>
                    <div class="list">
                        <!--loginUser 입학일자 기준으로 최근까지 / 변경시 ajax로 비동기처리-->
                        <select class="classYear">
                            <option value="0">==전체==</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                            <option value="2020">2020</option>
                            <option value="2019">2019</option>
                            <option value="2018">2018</option>
                            <option value="2017">2017</option>
                        </select>
                        <table border="1" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>년도</th>
                                    <th>학기</th>
                                    <th>장학금명</th>
                                    <th>수혜금액</th>
                                    <th>처리상태</th>
                                    <th>처리일자</th>
                                    <th>비고</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:choose>
                            		<c:when test="${not empty list}">
                            			<c:forEach var="s" items="list">
		                           			<tr>
			                                    <td>${s.classYear}</td>
			                                    <td>${s.classTerm}</td>
			                                    <td>${s.schCategoryNo}</td>
			                                    <td>${s.schAmount}</td>
			                                    <td>${s.status}</td>
			                                    <td>${s.proDate}</td>
			                                    <td>${s.etc}</td>
		                                	</tr>
	                                	</c:forEach>
                            		</c:when>
                            		<c:otherwise>
                            			<tr>
                            				<td colspan="7">데이터가 없습니다.</td>
                            			</tr>
                            		</c:otherwise>
                            	</c:choose>
                            </tbody>
                        </table>
                        <span>* 장학금은 차학기 등록금에서 차감되며 금액초과시 입금통장으로 환급됩니다.</span>
                    </div>
                </div>
            </div>
            <!--컨텐트 영역 종료-->
        </div>
    </div>
</body>
</html>