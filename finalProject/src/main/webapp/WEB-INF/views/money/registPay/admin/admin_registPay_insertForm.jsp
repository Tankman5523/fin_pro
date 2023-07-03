<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자_등록금납부조회</title>
    <style>
    	.readonly{
    		background-color : lightgray;
    	}
    </style>
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
                <div class="child_title" style="font-weight:bold;color:#00aeff;">
                    <a href="allList.rg">등록금 관리</a>
                </div>
                <div class="child_title">
                    <a href="allList.sc">장학금 관리</a>
                </div>
                <div class="child_title">
                    <a href="allList.sl">급여 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;">
                    <div style="height:15%;">
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='allList.rg'">등록금 납부 현황</button> <button class="btn btn-outline-primary btn-sm" onclick="location.href='nonPaidList.rg'">미납금 조회</button>
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='insert.rg'">등록금 입력</button>
                        <hr>
                        <h3>등록금 납부 정보 입력</h3>
                    </div>
                    <br>
                    <div style="height:90%;">
                        <table align="center">
                            <tr>
                                <td><label for="classYear">학년도</label></td>
                                <td><input type="text" name="classYear" id="classYear" value="현재년도" readonly class="readonly"></td>
                                <td><label for="classTerm">학기</label></td>
                                <td><input type="text" name="classTerm" id="classTerm" value="현재학기" readonly class="readonly"></td>
                                <td><button class="btn btn-outline-primary btn-sm" onclick="search();">조회 <i class="fa-solid fa-magnifying-glass"></i></button></td>
                            </tr>
                        </table>
                        
                        <table id="periodSetter" align="center" style="width:50%;">
                        	 <tr>
                                <td><label for="startDate">등록시작일</label></td>
                                <td><input type="date" name="startDate" id="startDate" value=""></td>
                                <td><label for="endDate">등록마감일</label></td>
                                <td><input type="date" name="endDate" id="endDate" value=""></td>
                                <td></td>
                            </tr>
                        </table>
                        
                        
                        <br>
                        <hr>
                        <div style="height:70%;overflow-y: auto;">
                            <button class="btn btn-outline-primary btn-sm" id="insertAll">일괄생성</button> 조회결과  [ <span id="countSearch">0</span>건 ]
                            <br>
                            <br>
                            <div id="scrollList" style="height:80%;overflow-y: auto;">
                            <table border="1"  id="studentList" style="text-align: center;width: 100%;">
                                <thead style='background-color: #4fc7ff;'>
                                	<tr>
	                                    <th><input type="checkbox" id="checkAll" name="checkAll"></th>
	                                    <th>학번</th>
	                                    <th>학생명</th>
	                                    <th>등록금액</th>
	                                    <th>장학금액</th>
	                                    <th>실등록금액</th>
	                                    <th>처리</th>
                                    </tr>
                                </thead>
                                <tbody><!--ajax처리-->
                                </tbody>
                            </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    	
    	$(function(){
    		//체크박스 일괄체크
        	$("#checkAll").click(function(){
        		var allcheck = $("#checkAll").is(":checked");
        		
        		if(allcheck){
        			$("input:checkbox").prop("checked",true);
        		}else{
        			$("input:checkbox").prop("checked",false);
        		}
        	});
    		//등록금 정보 일괄 생성
    		$("#insertAll").click(function(){
    			var control = confirm("체크한 등록금정보를 모두 생성하시겠습니까?");
   				var succ = 0;
   				var fail = 0;
    			if(control){
    				$("#studentList>tbody>tr>td>input:checkbox:checked").each(function(index){
 						var studentNo = $(this).parent().siblings().eq(0).text();
    					var mustPay = $(this).parent().siblings().eq(4).text().replace(/,/g,"");
    					var classYear = $("#classYear").val();
    					var classTerm = $("#classTerm").val();
    					var startDate = $("#startDate").val();
    					var endDate = $("#endDate").val();
    					
 						 $.ajax({
			        		url: "insert.rg",
			        		async : false,
			        		data:{
			        			studentNo : studentNo,
								mustPay : mustPay,
								classYear : classYear,
								classTerm : classTerm,
								startDate: startDate,
								endDate : endDate
			        		},
			        		method: "POST",
			        		success: function(result){
			        			if(result=="Y"){
			        				succ+=1;	
			        			}else{
			        				fail+=1;
			        			}
			        		},
			        		error: function(){
			        			alert("통신 연결 실패");
			        		}
			        	});
    				});
    				
    				alert("생성성공 : "+succ+" 건 , 생성실패 : "+fail+" 건");
    				search();
    			}
    		
    		});
    	});
    	/*레디펑션으로 년도 , 학기 추출 */
    	$('document').ready(function(){
    		
    		/*학기 , 학년도 등록*/
    		var today = new Date();
    		var classYear = today.getFullYear();
    		var month = today.getMonth()+1;
    		var classTerm = 0;
    		
    		var startDate = "";
    		var endDate = "";
    		
    		/* 현재 학기가 아닌 차학기로(등록금 내기 전 날짜까지) 넘긴다. */
    		if(month > 1 && month<8){ /*1월말(1학기분) , 8월초(2학기분)에 등록금 납부*/
    			classTerm = 2;
    			startDate = classYear+"-07-10"
    			endDate = classYear+"-07-24"
    		}else{
    			classTerm = 1;
    			startDate = classYear+"-01-10"
    			endDate = classYear+"-01-24"
    		}
    		var thisYear = $("#classYear").val(classYear);
    		var thisTerm = $("#classTerm").val(classTerm);
    		
    		$("#startDate").val(startDate);
    		$("#endDate").val(endDate);
    	});
    	//등록금 생성 정보 일괄 조회 (이번학기 등록금 정보 없을시 생성가능)
    	function search(){
    		
    		var thisYear = $("#classYear").val();
    		var thisTerm = $("#classTerm").val();
    		
    		$.ajax({
    			url : "listForInsert.rg",
    			data : {
    				classYear : $("#classYear").val(),
    				classTerm : $("#classTerm").val()
    					
    			},
    			success : function(list){
    				var count = list.length;
    				$("#countSearch").text(count).css("color","blue").css("font-weight","bold");
    				
    				var str = "";
    				if(list[0]!=null){
	    				for(var i in list){
	    					var collegeRegAmount = list[i].classLevel; 
	        				var schAmount = 0;
	        				if(list[i].post!=null){
	        					schAmount = list[i].post;
	        				}
	        				var realAmount = collegeRegAmount - schAmount;
	        				if(realAmount<0){
	        					realAmount = 0;
	        				}
	    					str +="<tr>"
			    				 +"<td>"+"<input type='checkbox' name='check' id='check'>"+"</td>"
			    				 +"<td>"+list[i].studentNo+"</td>"
			    				 +"<td>"+list[i].studentName+"</td>"
			    				 +"<td>"+collegeRegAmount.toLocaleString()+"</td>" //collegeRegAmount , 필드 빌려씀
			    				 +"<td>"+schAmount.toLocaleString()+"</td>" //schAmount , 필드 빌려씀
			    				 +"<td>"+realAmount.toLocaleString()+"</td>"
			    				 +"<td>"+"<button class='insertBtn'>생성</button>"+"</td>"
	    						 +"</tr>";
	    				}
    				}else{
    					str +="<tr><td colspan='8'>데이터가 없습니다.</td></tr>";
    				}
    				$("#studentList>tbody").html(str);
    			},
    			error : function(){
    				alert("통신 오류");
    			}
    		
    		});
    	}
    	//등록금 정보 개별 생성
    	$(function(){
    		$("#studentList>tbody").on("click","button",function(){
    			var studentNo = $(this).parent().siblings().eq(1).text();
				var mustPay = $(this).parent().siblings().eq(5).text().replace(/,/g,"");
				var classYear = $("#classYear").val();
				var classTerm = $("#classTerm").val();
				var startDate = $("#startDate").val();
				var endDate = $("#endDate").val();
				
				var schAmount = $(this).parent().siblings().eq(4).text().replace(/,/g,"");
				
				$.ajax({
					url : "insert.rg",
					data : {
						studentNo : studentNo,
						mustPay : mustPay,
						classYear : classYear,
						classTerm : classTerm,
						startDate : startDate,
						endDate : endDate,
						schAmount : schAmount	
					},
					method: "POST",
					success : function(result){
						if(result=='Y'){
							alert("등록금정보 입력에 성공했습니다.");
						}else{
  							alert("등록금정보 입력에 실패했습니다! 데이터를 확인하세요.");									
						}
					},
					error : function(){
						alert("서버 오류");
					},
					complete: function() {
	                    search();
	                }
				});
    		});
    	});
    	
    	
    </script>
</body>
</html>