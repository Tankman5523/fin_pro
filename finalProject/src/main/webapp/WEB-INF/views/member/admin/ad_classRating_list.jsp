<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자_강의평가통계 조회</title>
    <style>
	    .modal {
	        position: absolute;
	        top: 0;
	        left: 0;
	
	        width: 100%;
	        height: 100%;
	
	        display: none;
	
	        background-color: rgba(0, 0, 0, 0.4);
	      }
	      
	      .modal.show {
	        display: block;
	      }
	      .modalContent{
			position: absolute;
			top: 50%;
			left: 50%;
			
			width: 550px;
			height: 600px;
			
			padding: 40px;
			
			text-align: center;
			
			background-color: rgb(255, 255, 255);
			border-radius: 10px;
			box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
			
			transform: translateX(-50%) translateY(-50%);
	      }
	      #listBody>table>tbody>tr:hover{
	      	background-color : lightgray;
	      	cursor : pointer;
	      }
    </style>
</head>
<body>
    <div class="wrap">
    	<!--===============================메뉴바-===============================-->
		<%@include file="../../common/admin_menubar.jsp" %>
        <!--===============================메뉴바-===============================-->
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">강의관리</span>
                </div>
                <div class="child_title">
                    <a href="classListView.ad">강의시간표</a>
                </div>
                 <div class="child_title">
                    <a href="classManagePage.ad">강의개설관리</a>
                </div>
                <div class="child_title">
                    <a href="classRatingPage.ad" style="color:#00aeff; font-weight: 550;">강의평가 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div style="width: 90%;height: 90%;margin: 5%;overflow-y: auto;">
                    <div>
                        <hr>
                        <h3>강의평가 통계</h3>
                    </div>
                    <br>
                    <div class="list">
                        <div id="listHead">
                            <div class="search" style="float:left">
                                <label for="classYear">학년도</label>
                                <input type="number" name="classYear" id="classYear">
                                <label for="classTerm">학기</label>
                                <select name="classTerm" id="classTerm">
                                    <option value="1">1학기</option>
                                    <option value="2">2학기</option>
                                </select>
                                <label for="className">강의명</label><input type="text" id="className" name="className">
                                <button id="searchBtn" class="btn btn-outline-primary btn-sm">조회 <i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </div>
                        <br>
                        <hr>
                        <div id="listBody">
                            <table border="1" style="width: 100%;text-align: center;">
                                <thead style="background-color:#4fc7ff;">
                                	<tr>
	                                    <th>강의번호</th>
	                                    <th>강의명</th>
	                                    <th>교수명</th>
	                                    <th>학점</th>
	                                    <th>수강인원</th>
	                                    <th>평점</th>
                                    </tr>
                                </thead>
                                <!-- 클릭시 기타건의사항 모달 -->
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="modal">
                        	<div class="modalContent">
	                        	<span onclick="closeModal();" style="float:right;"><b>X</b></span>
	                        	<br>
                        		<span class="modal_title"></span>
                        		<table class="modal_averageList" border="1" style="width: 100%;text-align: center;">
                        			<thead>
                        				<tr style='background-color: #4fc7ff;'>
	            							<th >문항</th>
	            							<th>평균점수</th>
            							</tr>
                        			</thead>
                        			<tbody>
                        				
                        			</tbody>
                        		</table>
                        		<br>
                        		<div id="etc_area" style="overflow-y: auto;height:35%;">
                        		<table class="modal_table" border="1" style="width: 100%;text-align: center;">
                        			<tbody>
                        				
                        			</tbody>
                        		</table>
                        		</div>
                        	</div>
                        </div>
                        
                    </div>  
                </div>
                
                <script>
                	$('document').ready(function(){
                		//학년도, 학기 자동으로 현재날짜에 맞추기
                		
                		var now = new Date();
                		var classYear = now.getFullYear();
                		var month = now.getMonth()+1;
                		
                		var classTerm =0;
                		if(month>=3 || month<=8){
                			classTerm = 1;
                		}else{
                			classTerm = 2;
                		}
                		
                		$("#classYear").val(classYear);
                		$("#classTerm").val(classTerm);
                	});
                	
                	//검색 및  조회
                	$(function(){
                		$("#searchBtn").on("click",function(){
                			
                			var classYear = $("#classYear").val();
                			var classTerm = $("#classTerm").val();
                			var className = $("#className").val();
                			 
                			$.ajax({
                				url : "classRatingList.ad",
                				data : {
                					className : className,
                					classYear : classYear,
                					classTerm : classTerm
                				},
                				success : function(list){
                					var str = "";
                					if(list[0]!=null){
	                					for(var i in list){
	                						str +="<tr onclick='etc("+list[i].classNo+");'>"
	                							 +"<td>"+list[i].classNo+"</td>"
	                							 +"<td>"+list[i].className+"</td>"
	                							 +"<td>"+list[i].professorName+"</td>"
	                							 +"<td>"+list[i].credit+"</td>"
	                							 +"<td>"+list[i].classNos+"</td>"
	                							 +"<td>"+Math.round((list[i].averageRating*100)/100)+"</td>"
	                							 +"</tr>"
	                							 
	                					}
                					}else{
                						str +="<tr><td colspan='6'>데이터가 없습니다.</td></tr>"
                					}
                					$("#listBody>table>tbody").html(str);
                				},
                				error : function(){
                					alert("통신오류");
                				}
                			}); 
                		});
                	});
                	
                	//기타 건의사항 모달로 띄우기
                	function etc(num){
                		var classNo = num;
                		average(classNo);
                		var classYear = $("#classYear").val();
            			var classTerm = $("#classTerm").val();
            			
                		$.ajax({
                			url : "classRatingEtc.ad",
                			data : {
                				classNo : classNo,
                				classYear : classYear,
                				classTerm : classTerm
                			},
                			success : function(list){
                				
                				var str = "";
                				
                				if(list[0]!=null){
                				var className = list[0].className;
                				var professorName = list[0].professorName;
                					for(var i in list){
                						str +="<tr>"
                							 +"<td style='background-color: #4fc7ff;'>"+"기타 건의사항 "+(i+1)+"</td>"
                							 +"</tr>"
                							 +"<tr>"
                							 if(list[i].etc!=null){
	                							 str+="<td>"+list[i].etc+"</td>"
                							 }else{
                								 str+="<td>"+"-"+"</td>"
                							 }
                							 str+="</tr>";
                					}
                					
                					$(".modal_title").html("<span>강의명 : <b>"+className+"</b> / 교수명 : <b>"+professorName+"</b></span>");
                    				$(".modal_table>tbody").html(str);
                    				
                    				$(".modal").attr("class","modal show");
                				}else{
                					alert("조회 오류");
                				}
                				
                			},
                			error : function(){
                				alert("통신오류");
                			}
                		});
                	}
                	
                	//모달닫기
                	function closeModal(){
                		$(".modal").attr("class","modal");
                	}
                	//항목별 평균치 통계
                	function average(num){
                		var classNo = num;
                		
                		var classYear = $("#classYear").val();
            			var classTerm = $("#classTerm").val();
            			
            			$.ajax({
            				url : "classRatingAverage.ad",
            				data : {
            					classNo : classNo,
            					classYear : classYear,
            					classTerm : classTerm
            				},
            				success : function(result){
            					console.log(result);
            					var str = "";
            					
            						str +="<tr>"
            							 +"<td>Q1. 강의계획서 준수</td>"
            							 +"<td>"+result.q1+"</td>"
            							 +"</tr>"
            							 
            							 +"<tr>"
            							 +"<td>Q2. 수업내용의 합리성</td>"
            							 +"<td>"+result.q2+"</td>"
            							 +"</tr>"
            							 
            							 +"<tr>"
            							 +"<td>Q3. 학습 동기유발</td>"
            							 +"<td>"+result.q3+"</td>"
            							 +"</tr>"
            							 
            							 +"<tr>"
            							 +"<td>Q4. 학생참여형 수업방식</td>"
            							 +"<td>"+result.q4+"</td>"
            							 +"</tr>"
            							 
            							 +"<tr>"
            							 +"<td>Q5. 수업시간 준수</td>"
            							 +"<td>"+result.q5+"</td>"
            							 +"</tr>"
            							 
            							 +"<tr>"
            							 +"<td>Q6. 성적평가의 합리성</td>"
            							 +"<td>"+result.q6+"</td>"
            							 +"</tr>"
            							 
            							 +"<tr>"
            							 +"<td>Q7. 수강인원의 적절성</td>"
            							 +"<td>"+result.q7+"</td>"
            							 +"</tr>"
            							 
            							 +"<tr>"
            							 +"<td>Q8. 학생의 수업참여 태도</td>"
            							 +"<td>"+result.q8+"</td>"
            							 +"</tr>"
            							 
            							 +"<tr>"
            							 +"<td><b>총 평균</b></td>"
            							 +"<td>"+Math.round(((result.q1+result.q2+result.q3+result.q4+result.q5+result.q6+result.q7+result.q8)/8)*10)/10+"</td>"
            							 +"</tr>";
            							 
            					$(".modal_averageList>tbody").html(str);		 
            				},
            				error : function(){
            					alert("통신 오류");
            				}
            				
            				
            			});
                	}
                </script>

            </div>
        </div>
    </div>
</body>
</html>