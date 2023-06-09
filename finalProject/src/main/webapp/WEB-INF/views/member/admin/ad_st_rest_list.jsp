<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생 휴/복학 신청 승인 페이지</title>
<link rel="stylesheet" href="/fin/resources/css/studentRestListView.css">
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/admin_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%>
    	<%@include file="../../common/datepicker.jsp" %>  
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="enrollStudent.ad">학생 관리</a>
                </div>
				<div class="child_title">
                    <a href="enrollProfessor.ad">임직원 관리</a>
                </div>
                <div class="child_title">
                    <a href="calendarView.ad">학사일정 관리</a>
                </div>
                <div class="child_title">
                    <a href="stuRestList.ad" style="color:#00aeff; font-weight: 550;">휴/복학 관리</a>
                </div>
                <div class="child_title">
                    <a href="proRestList.ad">안식/퇴직 관리</a>
                </div>
                <div class="child_title">
				    <a href="selectNotice.ad">공지사항 관리</a>
				</div>
            </div>
            <div id="content_1">
				<span id="content_title">휴복학 목록</span>
                <div  align="center" style="border-top:2px solid lightblue;">
					<div align="left" class="searchCategory">
						처리여부 : 
						<select name="status">
							<option value="">===전체===</option>
							<option value="B" selected>승인대기중</option>
							<option value="Y">승인완료</option>
							<option value="N">비승인</option>
						</select>
						&nbsp;
						신청 목적 :
						<select name="category">
							<option value="">==전체==</option>
							<option value="일반휴학">일반휴학</option>
							<option value="특별휴학">특별휴학</option>
							<option value="복학">복학</option>
							<option value="휴학연장">휴학연장</option>
						</select>
						&nbsp;
						신청일자 :  
						<input style="display:none;" aria-hidden="true">
					<input type="password" style="display:none;" aria-hidden="true">
						<input type="text" name="start" id="datepicker1" readonly>
						~
						<input type="text" name="end" id="datepicker2" readonly>
						
					</div>
					<br>
					<div align="center">
						<select name="searchType">
							<option value="studentNo">학번</option>
							<option value="studentName">학생명</option>
						</select>
						<input type="text" name="keyword" id="keyword" placeholder="입력안하면 전체조회"  style="margin:auto;">
						<button type="button" id="search_btn" class="btn btn-primary btn-sm" style="margin-bottom:4px;" onclick="stuRestSearchList();">
							<i class="fa-solid fa-magnifying-glass" style="margin:auto;"></i>
						</button>
					</div>
                    <table id="rest_list"  class="table" border="2" style="width:90%; text-align: center; margin-top:5%;">
                        <thead>
                            <tr>
                            	<th width="11%">신청번호</th>
                            	<th width="12%">신청일자</th>
                                <th width="11%">학번</th>
                                <th width="11%">학생명</th>
                                <th width="11%">신청 목적</th>
                                <th width="11%">사유</th>
                                <th width="11%">시작일자</th>
                                <th width="11%">복학예정일</th>
                                <th width="11%">처리여부</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:choose>
                        		<c:when test="${not empty list }">
		                        	<c:forEach var="c" items="${list }">
			                        	<tr>
			                        		<td>${c.restNo }</td>
			                        		<td>${c.requestDate }</td>                            
			                                <td>${c.studentNo }</td>
			                                <td>${c.studentName}</td>
			                                <td>${c.category }</td>
			                                <td>${c.reason }</td>
			                                <td>${c.startDate }</td>
			                                <td>${c.endDate }</td>
			                                <td>
			                                	<c:choose>
		                            				<c:when test="${c.status eq 'B'}">
		                            					<span style="color:blue;">승인대기중</span>
		                            				</c:when>
		                            				<c:when test="${c.status eq 'Y'}">
		                            					<span style="color:green;">승인완료</span>
		                            				</c:when>
		                            				<c:otherwise>
		                            					<span style="color:red;">반려</span>
		                            				</c:otherwise>
		                            			</c:choose>
			                                </td>
			                            </tr>
		                        	</c:forEach>
                        		</c:when>
                        		<c:otherwise>
                        			<tr>
                        				<td colspan="9">신청 내역이 없습니다.</td>
                        			</tr>
                        		</c:otherwise>
                        	</c:choose>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script>
    	$(function(){
    		stuRestDetailView();
    	})
    	
    	function stuRestDetailView(){ //휴,복학 신청 상세보기
    		$("#rest_list>tbody>tr").click(function(){
    			var rno = $(this).children().eq(0).html();
    			if(rno>0){//숫자가 아니면 false
		    		location.href="stuRestDetailView.ad?rno="+rno;
    			}
    			
    		})
    	}
    	
    	$("#datepicker1").datepicker();

		$("#datepicker1").datepicker("option", "onClose", function(selectDate) {
			$("#datepicker2").datepicker("option", "minDate", selectDate);
		})
		$("#datepicker2").datepicker();
    	
    	function stuRestSearchList(){//상담 조건 검색 목록 가져오기
    		var status = $("select[name=status]").val(); //처리여부
			var category = $("select[name=category]").val(); //휴학종류 or 복학
			var start = $("#datepicker1").val(); //검색 시작일
			var end = $("#datepicker2").val(); //검색 마지막일
			var searchType = $("select[name=searchType]").val(); //검색 종류 (학번,학생명)
			var keyword = $("input[name=keyword]").val(); //검색 키워드
    		
    		$.ajax({
    			url:"searchStuRestList.ad",
    			data :{
    				status:status,
    				category:category,
    				start:start,
    				end:end,
    				searchType:searchType,
    				keyword:keyword
    			},
    			success:function(list){
    				var result = "";
    				if(list.length!=0){
    					for(var i=0; i<list.length; i++){
	    					result += "<tr>"
    								+"<td>"+list[i].restNo+"</td>"
    								+"<td>"+list[i].requestDate+"</td>"
    								+"<td>"+list[i].studentNo+"</td>"
    								+"<td>"+list[i].studentName+"</td>"
    								+"<td>"+list[i].category+"</td>"
    								+"<td>"+list[i].reason+"</td>"
    								+"<td>"+list[i].startDate+"</td>"
    								+"<td>"+list[i].endDate+"</td>"
    								if(list[i].status=='승인대기중'){
    									result+="<td><span style='color:blue;'>"+list[i].status+"</span></td>"
    								}else if(list[i].status=='승인완료'){
    									result+="<td><span style='color:green;'>"+list[i].status+"</span></td>"
    								}else{
    									result+="<td><span style='color:red;'>"+list[i].status+"</span></td>"
    								}
    						result+="</tr>";
    					}
    				}else{
    					result = "<tr><td colspan='9'>검색된 신청이 없습니다.</td></tr>"
    				}
    				$("#rest_list>tbody").html(result);
    				stuRestDetailView(); //상세보기 페이지 클릭함수 걸기
    			},
    			error:function(){
    				alert("통신실패");
    			}
    		})
    		
    	}
    	
    	$("#keyword").keyup(function(e){//검색할때 엔터키로 조회버튼 누르기
    		if(e.code=='Enter'){
    			$("#search_btn").click();
    		}
    	})
    </script>
</body>
</html>