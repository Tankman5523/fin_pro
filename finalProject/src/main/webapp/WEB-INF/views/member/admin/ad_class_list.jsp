<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#board-list{
		white-space: nowrap;
	}
	 #content_1>div{
        margin: auto;
        width:95%;
        
        
    }
    #class_type{
        text-align: center;
    }
    #class_type>ul{
        list-style: none;
    }
    #class_type>ul>li{
        float: left;
        margin-left: 15%;
    }
</style>
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/admin_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">강의관리</span>
                </div>
                <div class="child_title">
                    <a href="classManagePage.ad">강의개설관리</a>
                </div>
            </div>
            <div id="content_1">
				<div id="class_type">
                    <ul>
                        <li>전체</li>
                        <li>전공</li>
                        <li>교양</li>
                        
                    </ul>
                </div>
                <br>
                <div>
                    <h3>개설 신청된 강의</h3>
                </div>
                <div style="float: right; width:30%;">
                    <select name="" id="">
                        <option value="">교수명</option>
                        <option value="">학과</option>
                        <option value="">과목명</option>
                    </select>
                    <input type="text" name="" id="">
                    <button type="button" class="btn btn-secondary">조회</button>
                </div>
                
                <div>

                    <table id="board_list" border="1" style="width:100%; text-align: center; margin-top:5%">
                        <thead>
                            
                            <tr>
                                <th><input type="checkbox" id="allCheck"></th>
                                <th style="width:7%">강의번호</th>
                                <th style="width:7%">전공/교양</th>
                                <th>학과</th>
                                <th>강의명</th>
                                <th style="width:6%">학년도</th>
                                <th style="width:5%">학기</th>
                                <th style="width:7%">강의실</th>
                                <th style="width:7%">강의시간</th>
                                <th style="width:7%">수강대상</th>
                                <th style="width:7%">수강인원</th>
                                <th style="width:7%">이수학점</th>
                                <th style="width:15%">개설여부</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                        	<c:choose>
                        		<c:when test="${empty list }">
                        			<tr>
                        				<td colspan="14">강의 개설 신청 내역이 없습니다.</td>
                        			</tr>
                        		</c:when>
	                        	<c:otherwise>
			                        <c:forEach var="c" items="${list}">
			                        	<tr>
			                                <td><input type="checkbox" name="check" value="${c.classNo}"></td>
			                                <td>${c.classNo}</td>
			                                <td>${c.division eq 0 ? '전공':'교양'}</td>
			                                <td>${c.departmentNo}</td>
			                                <td>${c.className}</td>
			                                <td>${c.classYear}년</td>
			                                <td>${c.classTerm}학기</td>
			                                <td>${c.classroom}</td>
			                                <td>
			                                    ${c.period}<br>
			                                   ( ${c.day} )
			                                </td>
			                                <td>${c.classLevel eq 0 ? '전':c.classLevel}학년</td>
			                                <td>${c.classNos}</td>
			                                <td>${c.credit}</td>
			                                <td>
			                                    <button class="btn btn-primary" onclick="updateClassPermit(${c.classNo});">개설</button>
			                                    <button class="btn btn-warning">반려</button>
			                                </td>
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
    		var allCheck = $("#allCheck");
    		var check = $("input[name=check]");
    		
    		allCheck.click(function(){//전체체크 클릭
    			if(allCheck.is(":checked")){//눌렀을때 체크가 되었다면
	    			check.attr("checked",true); //전체체크
    			}else{//눌럿을때 체크가 해제
    				check.attr("checked",false); //전체 체크 해제
    			}
    		})
    		
    		$(document).on("change", check, function(){
				console.log(check);
    			console.log("클릭");
    			if(allCheck.is(":checked")){
    				allCheck.attr("checked",false);
    			}
			
			});
    		
    	})
    	function updateClassPermit(cno){
    		console.log(document.getElementById("board_list").children[1].children[0]);
    		/*
    		$.ajax({
    			url:"updateClassPermit.ad",
    			data:{classNo:cno},
    			success:function(){
    				
    			},
    			error:function(){
    				alert("통신오류");
    			}
    		})
    		*/
    	}
    </script>
</body>
</html>