<%@page import="org.springframework.format.Printer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.HashSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/studentCounselingList.css">
</head>
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
                        <a href="counselingList.st" style="color:#00aeff; font-weight: 550;">상담이력조회</a>
                    </div>
                    <div class="child_title">
                        <a href="counselingEnroll.st">상담신청</a>
                    </div>
                </div>
                <div id="content_1">
                	<span id="content_title">상담 신청 이력</span>
                    <div id="search">
                            <ul class="search_ul">
                                <li class="option1">
                                    	학년도 : 
                                    <select name="year" id="">
                                       <option value="">==전체==</option>
                                             
                                        <% HashSet<String> set = new HashSet<String>(); //밑에서 중복 거르기 위한 hashset 선언및 초기화%>
                                        <c:forEach var="c" items="${list }">
	                                       <c:set value="${c.applicationDate }" var="appDate"/>	
                                           <%
                                            	String ADate = pageContext.getAttribute("appDate").toString(); //상담신청날짜
                                            	String year = ADate.substring(0,ADate.indexOf("-")); //상담신청날짜에서 년도만 가져오기
                                            		
                                            	if(!set.contains(year)){//년도가 중복된 년도가 아니라면
                                            		set.add(year); //중복제거를 위해 set에 담고 밑에 옵션 만듬
                                            		System.out.println(set);
                                           %>
                                            	
                                            	<option value="<%=year%>"><%=year%></option>                                        
                                            	<%} %>
                                       </c:forEach>
                                    </select>
                                </li>
                                <li class="option1">
                                    	상담종류 :
                                    <select name="counselArea">
                                        <option value="">==전체==</option>
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
                                    	신청일자 기간조회 :
                                    <input type="text" class="date" id="datepicker1"name="start">
                                     ~ 
                                    <input type="text" class="date" id="datepicker2"name="end">
                                </li>
                                <li class="option3">
                        			<button class="btn btn-secondary btn-sm" type="button" onclick="searchCounseling();">조회</button>
                                
                                </li>
                            </ul>
                    </div>
                    <div style="text-align: right; margin-right:40px">
                    </div>
                    <div align="center">
                        <table border="1" id="board_list" class="table table-bordered">
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
                            	<!-- 테이블 fixed해서 일반적으로 width가 안먹어서 크기 정해주기 -->
                            		<col width="15%">
                            		<col width="15%">
                            		<col width="33%">
                            		<col width="13%">
                            		<col width="14%">
                            		<col width="10%">
                            <tbody>
                            	<c:choose>
                            		<c:when test="${empty list }">
                            			<tr>
                            				<td colspan="6">상담내역이 없습니다.</td>
                            			</tr>
                            		</c:when>
                            		<c:otherwise>
		                            	<c:forEach var="b" items="${ list }">
		                            		<tr>
		                            			<td style="display:none">${b.counselNo}</td>
		                            			<td>${b.applicationDate}</td>
		                            			<td>${b.requestDate}</td>
		                            			<td class="con">${b.counselContent}</td>
		                            			<td>${b.professorName}</td>
		                            			<td>${b.counselArea}</td>
		                            			<td>${b.status eq 'N'?'처리중':b.status eq 'Y'?'상담승인':'비승인'}</td>
		                            		</tr>
		                            	</c:forEach>
                            		</c:otherwise>
                            	</c:choose>
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
			$("#board_list>tbody>tr").click(function(){
				var cno = $(this).children().eq(0).text();
				if(cno!='상담내역이 없습니다.'){
					location.href="stuCounDetail.st?counselNo="+cno;
				}
			});
		});
		
		function searchCounseling(){ //상담 내역 검색 함수
			var studentNo = '${loginUser.studentNo}'; //학생번호
			var year = $('select[name=year]').val();//학년도 
			var counselArea = $('select[name=counselArea]').val(); //상담영역(학사(휴학),기타 등등)
			var start = $("#datepicker1").val(); //기간설정 (시작날짜)
			var end = $("#datepicker2").val(); //기간설정 (마지막 날짜)
			
			var obj = new Object();
			obj.studentNo = studentNo;
			obj.year = year;
			obj.counselArea = counselArea;
			obj.startDate = start!=""?start:'1900-01-01';
			obj.endDate = end!=""?end:'2999-12-31';
			
			$.ajax({
				url:"counselingSearch.st",
				data:{data:JSON.stringify(obj)},
				success:function(list){
					var result = "";
					if(list.length==0){
						result = "<tr>"+"<td colspan='6'>상담내역이 없습니다.</td>"+"</tr>"
					}else{
						for(var i=0; i<list.length; i++){
							result += "<tr>"
									+"<td style='display:none'>"+list[i].counselNo+"</td>"
									+"<td>"+list[i].applicationDate+"</td>"
									+"<td>"+list[i].requestDate+"</td>"
									+"<td class='con'>"+list[i].counselContent+"</td>"
									+"<td>"+list[i].professorName+"</td>"
									+"<td>"+list[i].counselArea+"</td>"
									+"<td>"+list[i].status+"</td>"
									+"</tr>"
						}
						
					}
					$("#board_list tbody").html(result);
					
				},
				error :function(){
					alert("통신실패");
				}
			})			
			
		}
	</script>
</body>
</html>