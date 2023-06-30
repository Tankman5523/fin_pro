<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/adminProfessorRestList.css">
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/admin_menubar.jsp" %>
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
                    <a href="stuRestList.ad">휴/복학 관리</a>
                </div>
                <div class="child_title">
                    <a href="proRestList.ad" style="color:#00aeff; font-weight: 550;">안식/퇴직 관리</a>
                </div>
            </div>
            <div id="content_1">
            <span id="content_title">안식/퇴직 조회</span>
            <div align="center" style="border-top:2px solid lightblue;">
            	<div align="left" class="searchCategory">
					처리여부 : 
					<select name="status">
						<option value="">===전체===</option>
						<option value="B" selected>승인대기중</option>
						<option value="Y">승인완료</option>
						<option value="N">비승인</option>
					</select>
					&nbsp;
					종류 :
					<select name="category">
						<option value="">==전체==</option>
						<option value="0">퇴직신청</option>
						<option value="1">안식휴가</option>
					</select>
					&nbsp;
					신청일자 :
					<input type="text" name="start" id="datepicker1" readonly>
					~
					<input type="text" name="end" id="datepicker2" readonly>
				</div>
				<br>
				<div align="center">
					<select name="searchType">
						<option value="professorNo">직번</option>
						<option value="professorName">직원명</option>
					</select>
					<input type="text" name="keyword" id="keyword" placeholder="입력안하면 전체조회"  style="margin:auto;">
					<button type="button" id="search_btn" class="btn btn-primary btn-sm" style="margin-bottom:4px;" onclick="proRestSearchList();">
						<i class="fa-solid fa-magnifying-glass" style="margin:auto;"></i>
					</button>
				</div>
                    <table id="rest_list" class="table " border="2" style="width: 80%;margin-top:2%;text-align: center;">
                        <thead>
                            <tr>
                            	<th width="11%">신청번호</th>
                                <th width="14%">신청일자</th>
                                <th width="11%">직번</th>
                                <th width="9%">직원명</th>
                                <th width="16%">종류(안식/퇴직)</th>
                                <th width="13%">예정일</th>
                                <th width="13%">복귀일</th>
                                <th width="13%">처리상태</th>
                            </tr>
                        </thead>
                        <tbody>
                          <c:choose>
                              	<c:when test="${empty list}">
                            		<tr>
                            			<td colspan="8">조회된 신청 내역이 없습니다.</td>
                            		</tr>
                            	</c:when>
                            	<c:otherwise>
                            		<c:forEach var="r" items="${list}">
                            		<tr>
                            			<td>${r.restNo}</td>
                            			<td>${r.requestDate }</td>
                            			<td>${r.professorNo }</td>
                            			<td>${r.professorName }
                            			<td>${r.category eq 0 ?'퇴직신청':'안식휴가' }</td>
                            			<td>${r.startDate }</td>
                            			<td>${r.endDate eq null ?'퇴직': r.endDate}</td>
                            			<td>${r.status eq 'B'? '승인대기중':r.status eq 'Y'? '승인완료':'비승인'}</td>
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
	    
		
    	$(function(){
    		stuRestDetailView();//클릭시 상세보기 페이지 이동 걸기
    	})
    	
    	function stuRestDetailView(){
    		$("#rest_list>tbody>tr").click(function(){
    			var restNo = $(this).children().eq(0).text();
    			if(restNo!='조회된 신청 내역이 없습니다.'){
    				location.href="proRestDetail.ad?restNo="+restNo;
    			}
    		})
    		$("#datepicker1").prop('type','text');
    		$("#datepicker2").prop('type','text');
    		$("#datepicker1").removeAttr('autocomplete');
    		$("#datepicker2").removeAttr('autocomplete');
    	}
    	
    	$("#datepicker1").datepicker();
    	
		$("#datepicker1").datepicker("option", "onClose", function(selectDate) {
			$("#datepicker2").datepicker("option", "minDate", selectDate);
		})
		$("#datepicker2").datepicker();
    	
    	function proRestSearchList(){//안식,퇴직 조건 검색 목록 가져오기
    		var status = $("select[name=status]").val(); //처리여부
			var category = $("select[name=category]").val(); //안식 or 퇴직
			var start = $("#datepicker1").val(); //검색 신청일자 시작일
			var end = $("#datepicker2").val(); //검색 신청일자 마지막일
			var searchType = $("select[name=searchType]").val(); //검색 종류 (직번,직원명)
			var keyword = $("input[name=keyword]").val(); //검색 키워드
    		
    		$.ajax({
    			url:"searchProRestList.ad",
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
    								+"<td>"+list[i].professorNo+"</td>"
    								+"<td>"+list[i].professorName+"</td>"
    						if(list[i].category == 1){//종류가 안식휴가라면
    							result +="<td>안식휴가</td>"
    									+"<td>"+list[i].startDate+"</td>"
    						}else{ //종류가 퇴직신청이라면
    							result +="<td>퇴직신청</td>"
									+"<td>"+list[i].startDate+"</td>"
    						}		
    						if(list[i].endDate === undefined){ //복귀일이 없다면
    							result +="<td>퇴직</td>" //퇴직
	    							    +"<td>"+list[i].status+"</td>"
	    							    +"</tr>"
    						}else{ //복귀일이 있다면
    							result +="<td>"+list[i].endDate+"</td>" //복귀일 넣어줌
		    						    +"<td>"+list[i].status+"</td>"
									    +"</tr>"
    						}
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