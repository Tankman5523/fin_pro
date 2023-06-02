<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>교수</title>
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
                        <button onclick="">장학금수혜내역</button> <button onclick="">장학금 수여</button>
                        <hr>
                        <h3>장학금 수혜내역 조회</h3>
                    </div>
                    
                    <div class="list">
                        <!--filer / 변경시 ajax로 비동기처리-->
                        <select id="filter" name="filter">
                            <option value="0">==전체==</option>
                            <option value="studentNo">학번</option>
                            <option value="studentName">학생이름</option>
                            <option value="classYear">학년도</option>
                        </select>
                        <input type="text" id="keyword" name="keyword">
                        <button onclick="selectList();">조회</button>
                        <table border="1" style="width: 100%;" id="schList">
                            <thead>
                                <tr>
                                    <th>학번</th>
                                    <th>학생명</th>
                                    <th>학년도</th>
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
			                                    <td>${s.studentNo}</td>
			                                    <td>${s.stduentName}</td>
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
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    	function selectList(){
    		$.ajax({
    			
    			url: "allList.sc",
    			
    			data: {
    				classYear : $(".classYear").val(),
    				keyword : $("#keyword").val()
    			},
    			
    			success : function(list){
    				var str = "";
    				if(list !=null){
    					for(var i=0;i<list.length;i++){
    						str+="<tr>"
    							
    							//+"<td>"+${list[i].studentNo}+"</td>"
    							//+"<td>"+${list[i].stduentName}+"</td>"
    							//+"<td>"+${list[i].classYear}+"</td>"
    							//+"<td>"+${list[i].classTerm}+"</td>"
    							//+"<td>"+${list[i].schCategoryNo}+"</td>"
    							//+"<td>"+${list[i].schAmount}+"</td>"
    							
    							+"</tr>"
    					}
    				}else{
    					str+="<tr><td colspan='9'>데이터가 없습니다.</td></tr>"
    				}
    				$("#schList>tbody").html(str);
    			},
    			
    			error : function(){
    				alert("통신오류");
    			}
    		});
    	}
    </script>
    
</body>
</html>