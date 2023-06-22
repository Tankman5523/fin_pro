<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자_장학금수여내역 조회</title>
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
                    <a href="allList.rg">등록금 관리</a>
                </div>
                <div class="child_title" style="font-weight:bold;">
                    <a href="allList.sc">장학금 관리</a>
                </div>
                <div class="child_title">
                    <a href="allList.sl">급여 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;overflow-y: auto;">
                    <div style="height:20%;">
                        <button onclick="location.href='allList.sc'">장학금수혜내역</button> <button onclick="location.href='insert.sc'">장학금 수여</button>
                        <hr>
                        <h3>장학금 수혜내역 조회</h3>
                    </div>
                    
                    <div class="list" style="height:80%;">
                        <!--filer / 변경시 ajax로 비동기처리-->
                        <select id="filter" name="filter">
                            <option value="all">==전체==</option>
                            <option value="classYear">학년도</option>
                            <option value="studentNo">학번</option>
                            <option value="studentName">학생이름</option>
                        </select>
                        <input type="text" id="keyword" name="keyword">
                        <button onclick="selectList();">조회</button>
                       	   조회결과 : <span id="countSearch"></span>
                        <table border="1" style="width:100%;text-align:center;width: 100%;" id="schList">
                            <thead  style='background-color: #4fc7ff;'>
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
                                    <th>처리</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<!-- ajax 처리 -->
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
    			type : "POST",
    			data: {
    				filter : $("#filter").val(),
    				keyword : $("#keyword").val()
    			},
    			//dataType : "json",
    			success : function(list){
    				var countSearch = list.length;
    				$("#countSearch").html(countSearch+" 건")
    				var str = "";
    				if(list[0]!=null){
    					for(var i in list){
    						str+="<tr>"
    							+"<td>"+list[i].studentNo+"</td>"
    							+"<td>"+list[i].studentName+"</td>"
    							+"<td>"+list[i].classYear+"</td>"
    							+"<td>"+list[i].classTerm+"</td>";
    							
    							if(list[i].schCategoryNo==1){
	    							str+="<td>국가장학금</td>";
    							}else if(list[i].schCategoryNo==2){
    								str+="<td>근로장학금</td>";
    							}else if(list[i].schCategoryNo==3){
    								str+="<td>성적장학금</td>";
    							}else if(list[i].schCategoryNo==4){
    								str+="<td>우수장학금</td>";
    							}
    							
    							str+="<td>"+list[i].schAmount.toLocaleString()+" 원 </td>";
    							
    							if(list[i].status=='W'){
    								str+="<td>처리대기</td>";
    							}else if(list[i].status=='N'){
    								str+="<td>취소</td>";	
    							}else{
    								str+="<td>처리완료</td>";
    							}
    							
    							str+="<td>"+list[i].proDate+"</td>";
    							
    							if(list[i].etc==null){
    								str+="<td></td>";
    							}else{
    								str+="<td>"+list[i].etc+"</td>";
    							} 
    							if(list[i].status=='W'){
    								var upLocation = "location.href='update.sc?schNo="+list[i].schNo+"';";
    								
    								str+="<td><input type='hidden' value="+list[i].schNo+">"
    								    +"<button onclick="+upLocation+">수정</button><button class='delBtn' onclick='del("+list[i].schNo+");'>삭제</button></td>";
    								
    							}else{ 
    								str+="<td></td>";
    							}
    							
    							str+="</tr>";
    							
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
    	
    	function del(num){
    		var schNo = num;
    		$.ajax({
    			url : "delete.sc",
    			data : {
    				schNo : schNo
    			},
    			success : function(result){
    				console.log(result);
    				if(result=='Y'){
    					alert("등록금 정보 삭제 성공");
    					selectList();
    				}else{
    					alert("등록금 정보 삭제 실패");
    				}
    			},
    			error : function(){
    				alert("통신 오류");
    			}
    		});
    	}
    		
    </script>
    
    
    
</body>
</html>