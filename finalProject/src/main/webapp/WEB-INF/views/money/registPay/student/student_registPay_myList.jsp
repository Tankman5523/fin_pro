<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생</title>
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
               <div class="child_title">
                    <a href="onelist.rg">등록금 납부조회</a>
                </div>
                <div class="child_title" style="font-weight:bold;">
                    <a href="listPage.rg">등록금납입 이력</a>
                </div>
                <div class="child_title">
                    <a href="listPage.sc">장학금 수혜내역</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;overflow-y: auto;">
					<h4>등록금 납입 이력</h4>
					<br>
                    <!--이름/학번 로그인 세션에서 가져오기-->
                    <label for="studentNo">학번</label> <input type="text" class="readonly" name="studentNo" id="studentNo" value="${loginUser.studentNo}" readonly>
                    <br>
                    <label for="studentName">이름</label> <input type="text" class="readonly" name="studentName" id="studentName" value="${loginUser.studentName}" readonly>
                    <br>
                    <label for="classYear">학년도</label>
                    <input type="number" name="classYear" id="classYear" style="width:100px;">
                    <label for="classTerm">학기</label>
                    <select name="classTerm" id="classTerm">
                        <option value="0">=전체=</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                    </select>
                    
                    <!--버튼 클릭시 ajax로 값 가지고가서 처리-->
                    <button onclick="searchMyRegist();" class="btn btn-outline-primary btn-sm">조회</button>
                    <br><br>
                    <table id="registList" border="1" style="width: 100%;text-align:center;">
                        <thead style="background-color: #4fc7ff;">
                            <tr>
                                <th>납부일</th>
                                <th>납부시간</th>
                                <th>학번</th>
                                <th>성명</th>
                                <th>입금금액</th>
                                <th>입금계좌</th>
                                <th>입금한계좌(학생)</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody>
                        
                        </tbody>
                    </table>
                </div>
            </div>
            
            <script>
            $('document').ready(function(){//현재 시간 기준 학년도 , 학기 등록
        		
        		/*학기 , 학년도 등록*/
        		var today = new Date();
        		var classYear = today.getFullYear();
        		var month = today.getMonth()+1;
        		var classTerm = 0;
        		
        		/* 현재 학기가 아닌 차학기로(등록금 내기 전 날짜까지) 넘긴다. */
        		if(month > 1 && month<8){ /*1월말(1학기분) , 8월초(2학기분)에 등록금 납부*/
        			classTerm = 2;
        		}else{
        			classYear +=1;
        			classTerm = 1;
        		}
        		
        		var thisYear = $("#classYear").val(classYear);
        		var thisTerm = $("#classTerm").val(classTerm);
        	});	
            
            
           	function searchMyRegist(){ //해당 학생 등록금 기록 조회
           		
           		var studentNo = $("#studentNo").val();
           		var studentName = $("#studentName").val();
           		var classTerm = $("#classTerm").val();
           		var classYear = $("#classYear").val();
           		
           		$.ajax({
           			url : "list.rg",
           			data : {
           				studentNo : studentNo,
           				studentName : studentName,
           				classTerm : classTerm,
           				classYear : classYear,
           			},
           			success : function(list){
           				var str = "";
						var payDate = "-";	            				
						var payTime = "-";
						var studentNo = "";
						var studentName = "";
						var inputPay = 0;
						var regAccountNo = "";
						var payAccountNo = "-";
						var payStatus = "";
						
           				if(list[0]!=null){
           					for(var i in list){
           						if(list[i].payDate!=null){ //null일때 비워주기
           							payDate = list[i].payDate;
           						}
           						if(list[i].payTime!=null) { //null일때 비워주기
           							payTime = list[i].payTime;
           						}
           						if(list[i].payAccountNo!=null){ //null일때 비워주기
           							payAccountNo = list[i].payAccountNo;
           						}
           						inputPay = list[i].inputPay;
           						regAccountNo = list[i].regAccountNo;
           						studentNo = list[i].studentNo;
           						studentName = list[i].studentName;
           						if(list[i].payStatus=='Y'){
           							payStatus = "납부완료";
           						}else if(list[i].payStatus=='O'){
           							payStatus = "초과납부"
           						}else if(list[i].payStatus=='D'){
           							payStatus = "금액미달"
           						}else if(list[i].payStatus=='N'){
           							payStatus = "미납부"
           						}
           						
           						str +="<tr>"
           							 +"<td>"+payDate+"</td>"
           							 +"<td>"+payTime+"</td>"
           							 +"<td>"+studentNo+"</td>"
           							 +"<td>"+studentName+"</td>"
           							 +"<td>"+inputPay+"</td>"
           							 +"<td>"+regAccountNo+"</td>"
           							 +"<td>"+payAccountNo+"</td>"
           							 +"<td>"+payStatus+"</td>"
           							 +"</tr>";
           					}
           				}else{
           					str +="<tr><td colspan='8'>데이터가 없습니다.</td></tr>"
           				}
           				$("#registList>tbody").html(str);
           			},
           			error : function(){
           				alert("통신 오류");
           			}
           		});
           		
           	}
            
            </script>
            
        </div>
    </div>
</body>
</html>