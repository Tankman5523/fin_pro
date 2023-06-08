<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자_장학금수여</title>
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
                <div class="child_title" style="font-weight:bold;">
                    <a href="allList.sc">장학금 관리</a>
                </div>
                <div class="child_title">
                    <a href="#">급여 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <div>
                        <button onclick="location.href='allList.sc'">장학금수혜내역</button> <button onclick="location.href='insert.sc'">장학금 수여</button>
                        <hr>
                        <h2>장학금 수여</h2>
                    </div>
                    <br>
                    <div>
                    	<form action="insert.sc" method="post">
	                        <table align="center">
	                            <tr>
	                                <td><label for="classYear">학년도</label></td>
	                                <td><input type="text" name="classYear" id="classYear" value="현재년도" readonly></td>
	                                <td><label for="classTerm">학기</label></td>
	                                <td><input type="text" name="classTerm" id="classTerm" value="다음학기" readonly></td>
	                            </tr>
	                            <tr>
	                                <td><label for="studentName">학생명</label></td>
	                                <td><input type="text" name="studentName" id="studentName" value="학번으로 조회" readonly></td>
	                                <td><label for="studentNo">학번</label></td>
	                                <td><input type="text" name="studentNo" id="studentNo"> <button type="button" onclick="selectStudent();">조회</button></td>
	                            </tr>
	                            <tr>
	                                <td><label for="schAmount">수혜금액</label></td>
	                                <td><input type="text" name="schAmount" id="schAmount" value="자동입력"></td>
	                                <td><label for="schCategoryNo">장학금명</label></td>
	                                <td>
	                                    <select name="schCategoryNo" id="schCategory">
	                                        <option value="1">국가장학금</option>
	                                        <option value="2">근로장학금</option>
	                                        <option value="3">성적장학금</option>
	                                        <option value="4">우수장학금</option>
	                                    </select>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td><label for="etc">비고</label></td>
	                                <td colspan="4">
	                                    <textarea name="etc" id="etc" cols="60" rows="5" style="resize:none" placeholder="수혜 사유 또는 처리예정값 입력"></textarea>
	                                </td>
	                            </tr>
	                            <tr>
	                            	<td colspan="3" align="center"><input type="submit" value="입력"></td>
	                            </tr>
	                        </table>
                        </form>
                        <br>
                        <hr>
                        
                        <h3>장학금 부여시 유의사항 (필독)</h3>
                        <fieldset>
                            <ul>
                                <li>장학금 규정테이블 확인하여 명확하게 수여할것</li>
                                <li>기타 사유로인한 장학금 수여시 비고란에 명확한 사유 부여바람</li>
                            </ul>
                            
                            <br>
                            <a href="#">장학금 규정 테이블</a>
                        </fieldset>
                         
            			
                    </div>
                    
                    <script>
                    	function selectStudent(){
                    		var studentNo = $("#studentNo").val();
                    		
                    		/*학기 , 학년도 등록*/
                    		var today = new Date();
                    		var classYear = today.getFullYear();
                    		var month = today.getMonth()+1;
                    		var classTerm = 0;
                    		/* 현재 학기가 아닌 차학기로(등록금 내기 전 날짜까지) 넘긴다. */
                    		if(month >= 2 && month<=7){ /*1월말(1학기분) , 8월초(2학기분)에 등록금 납부*/
                    			classTerm = 2;
                    		}else{
                    			classTerm = 1;
                    		}
                    		
                    		$.ajax({
                    			url : /*스튜던트 셀렉트 매핑*/"",
                    			
                    			data : {
                    				studentNo : studentNo
                    			},
                    			success : function(result){
                    				$("#studentName").html(result.studentName);
                    				$("#classYear").val(classYear);
                    				$("#classTerm").val(classTerm);
                    			},
                    			error: function(){
                    				alert("통신오류");
                    			}
                    		});
                    	}
                    	
                    	
                    
                    </script>
                    
                </div>
            </div>
        </div>
    </div>
</body>
</html>