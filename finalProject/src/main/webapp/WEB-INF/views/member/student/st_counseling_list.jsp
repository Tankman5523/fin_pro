<%@page import="org.springframework.format.Printer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.HashSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
		.search_ul{
            
            list-style: none;
        }
        .option1{
            margin-top: 10px;
            width:25%;
            height:50%;
            float: left;
            
        }
        .option2{
            margin-top: 10px;
            width:50%;
            height:50%;
            float: left;
            
        }
        
        #datepicker1,#datepicker2{
            width: 35%;
        }
        .con{
        	overflow: hidden;
        	text-overflow: ellipsis;
        	white-space:nowrap;
        	
        }
</style>
<body>
    <div class="wrap">
    	<%@include file="../../common/student_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%>
    	<%@include file="../../common/datepicker.jsp" %> 
        <div id="content">
                <div id="category">
                    <div id="cate_title">
                        <span style="margin: 0 auto;">상담관리</span>
                    </div>
                    <div class="child_title">
                        <a href="counselingList.st">상담이력조회</a>
                    </div>
                    <div class="child_title">
                        <a href="counselingEnroll.st">상담신청</a>
                    </div>
                </div>
                <div id="content_1">
                    <div id="search" style="border-bottom:1px solid black; height:10%">
                        <form action="counselingSearch.st" id="searchForm">
                            <ul class="search_ul">
                                <li class="option1">
                                    	학년도 
                                    <select name="" id="">
                                            <option value="*">===전체===</option>
                                            <!-- 
                                            <c:forEach var="c" items="${list }">
                                            <c:set value="${c.applicationDate }" var="appDate"/>	
                                            			<%
                                            				String ADate = pageContext.getAttribute("appDate").toString();
                                            				String year = ADate.substring(0,ADate.indexOf("-"));
                                            				
                                            				HashSet<String> set = new HashSet<String>();
                                            				set.add(year);
                                            			%>
												<c:if test="">
                                            		<option value="${c.applicationDate}">
                                            			<%= %>
                                            		</option>                                            
													
												</c:if>                                            			
                                            </c:forEach>
                                             -->
                                            		
                                            
                                            
                                    </select>
                                </li>
                                <li class="option1">
                                    	상담종류 
                                    <select name="" id="">
                                        <option value="*">===전체===</option>
                                        <option value="진로(취업)">진로(취업)</option>
                                        <option value="학사(제적)">학사(제적)</option>
                                        <option value="학사(휴학)">학사(휴학)</option>
                                        <option value="학사(출결)">학사(출결)</option>
                                        <option value="학사행정">학사행정</option>
                                        <option value="학교생활">학교생활</option>
                                        <option value="심리정서">심리정서</option>
                                        <option value="기타">기타</option>
                                    </select>
                                </li>
                                <li class="option2">
                                    	신청일자 기간조회
                                    <input type="text" class="date" id="datepicker1"name="start">
                                     ~ 
                                    <input type="text" class="date" id="datepicker2"name="end">
                                </li>
                            </ul>
                            
                        
                        </form>
                    </div>
                    <div style="text-align: right; margin-right:40px">
                        <button class="btn btn-secondary" type="submit" form="searchForm">조회</button>
                    </div>
                    <div align="center">
                        <table border="1" style="width:80%; text-align: center;table-layout: fixed;" id="board_list" >
                            <thead>
                                <tr>
                                	<th>상담신청일자</th>
                                    <th>상담희망날짜</th>
                                    <th>상담요청내용</th>
                                    <th>상담교수</th>
                                    <th>상담요청구분</th>
                                    <th>완료여부</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:choose>
                            		<c:when test="${empty list }">
                            			<tr>
                            				<td colspan="6">상담내역이 없습니다.</td>
                            			</tr>
                            		</c:when>
                            		<c:otherwise>
                            		<!-- 테이블 fixed해서 일반적으로 width가 안먹어서 크기 정해주기 -->
                            		<col width="15%">
                            		<col width="15%">
                            		<col width="40%">
                            		<col width="13%">
                            		<col width="13%">
                            		<col width="4%">
		                            	<c:forEach var="b" items="${ list }">
		                            		<tr>
		                            			<td style="display:none">${b.counselNo}</td>
		                            			<td>${b.applicationDate}</td>
		                            			<td>${b.requestDate}</td>
		                            			<td class="con">${b.counselContent}</td>
		                            			<td>${b.professorNo}</td>
		                            			<td>${b.counselArea}</td>
		                            			<td>${b.status}</td>
		                            		</tr>
		                            	</c:forEach>
                            		</c:otherwise>
                            	</c:choose>
                            <!-- 
                                <tr>
                                    <td>2023-04-27</td>
                                    <td></td>
                                    <td>어문경</td>
                                    <td>진로(취업)</td>
                                    <td>N</td>
                                </tr>
                             -->
                                
                            </tbody>
                            
                        </table>
                    </div>
                </div>
    
            </div>
                
        </div>
    <script>
    	//datepicker 구문
		$("#datepicker1").datepicker();

		$("#datepicker1").datepicker("option", "onClose", function(selectDate) {
			$("#datepicker2").datepicker("option", "minDate", selectDate);
		})
		$("#datepicker2").datepicker();
		
		//리스트 누르면 상세보기 페이지 이동 구문
		$(function(){
			$("tbody>tr").click(function(){
				var cno = $(this).children().eq(0).text();
				location.href="stuCounDetail.st?counselNo="+cno;
			});
		});
	</script>
</body>
</html>