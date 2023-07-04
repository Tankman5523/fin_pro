<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#basic_info{
		margin-left: 30px;
		margin-right: 35px;
	}
	#basic_table{
		right: 15%;
		position: relative;
	}
	#studentObjection{
		border: 1px solid black;
		text-align: center;
		width: 95%;
		margin-left : 20px;
		border-collapse: collapse;
		border-radius: 10px;
		border-style: hidden;
		box-shadow: 0 0 0 1px #000;
	}
	#studentObjection2{
		border: 1px solid black;
		text-align: center;
		width: 95%;
		margin-left : 20px;
		border-collapse: collapse;
		border-radius: 10px;
		border-style: hidden;
		box-shadow: 0 0 0 1px #000;
	}

	#student_objection>thead>tr>th{
		height: 50px;
	}
	#student_objection>tbody>tr>td{
		height: 40px;
	}
	#text-box{
		border: 1px solid gray;
		border-radius: 8px;
		margin-left: 80px;
	}
	#objectionbtn{
		background-color : darkgray;
		border-radius: 8px;
		color: whitesmoke;
		border-collapse: collapse;
 		border-style: hidden;
	}
	.textTitle{
		margin-left :450px;
	}
	#crystal_btn{
		border: 0;
        padding: 12px 18px;
        border-radius: 10px;
        margin-right: 12px;
        font-size: 15px;
        background-color:#4fc7ff;
        color: whitesmoke;
		float: right;
		font-weight: bold;
		position: relative;
		bottom: 10%;
		top: 30px;
 	}
	#grade_report{
        padding-right: 20px;
        height: 10px;
	}
	#classYear{
        width: 200px;
        height: 40px;
        border-radius: 8px;
        text-align: center;
        appearance: none;
        margin: 30px 15px 15px;
    }
    #classTerm{
        width: 200px;
        height: 40px;
        border-radius: 8px;
        text-align: center;
        appearance: none;
        margin: 30px 15px 15px;
    }
    #checkbtn{
        width: 150px;
        height: 40px;
        border-radius: 8px;
        text-align: center;
        appearance: none;
        margin: 20px 15px 15px;
    }
    #status{
    	width: 100px;
        height: 40px;
        border-radius: 8px;
        text-align: center;
        appearance: none;
    	border-style: none;
    }
    .objectionbtn{
    	width: 100px;
        height: 40px;
        border-radius: 8px;
    }
    .opinion{
    	width: 150px;
        height: 20px;
    }
    .reasonText{
    	width : 100%;
    	
    }
    input:focus {outline: none;}
    
</style>
<script>
</script>
</head>
<body>
    <div class="wrap">
    	<%@include file="../../common/professor_menubar.jsp" %>
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">수업관리</span>
                </div>
                <div class="child_title">
                    <a href="">학기별 성적 조회</a>
                </div>
                <div class="child_title">
                    <a href="professorGradeReport">성적 이의신청</a>
                </div>
                <div class="child_title">
                    <a href="classRatingInfo.st">강의평가</a>
                </div>
            </div>
            <div id="content_1">
					<div id="basic_info">
						<table class="basic_table">
						<tr>
						<th id="grade_report">성적 이의신청</th>
                        <th id="grade_head">학년도 : </th>
                        <th>
                            <label for="class_year">
                                <select name="classYear" id="classYear">
                                    <option value="2023">2023</option>
                                </select>
                            </label>
                        </th>
                        <th>학기 : </th>
                        <th>
                            <label for="class_year">
                                <select name="classTerm" id="classTerm">
                                    <option value="1">1학기</option>
                                    <option value="2">2학기</option>
                                </select>
                            </label>
                        </th>
                        <th>
                            <button id="checkbtn" onclick="gradecheck()">조회하기</button>
                         </th>
                         <tr>
					</table>
                     <hr>
			    </div>
			    <div style="text-align: center;">
					  <b>이의신청 현황</b>
				</div>
				<br>
			    <table border="1" id="studentObjection">
					<thead>
						<tr>
							<th>교과목명</th>
							<th>과목번호</th>
							<th>학생명</th>
							<th>학번</th>
							<th>사유</th>
							<th>처리상태</th>
							<th>교수의견</th>
							<th>회신버튼</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="c" items="${list}">
							<tr>
								<td>${c.className}</td>
								<td>${c.classNo }</td>
								<td>${c.studentName }</td>
								<td>${c.studentNo }</td>
								<td>${c.reason }</td>
								<td>
									<select id="status" name="status">
											<option value="">처리상태</option>
                                            <option value="N">N</option>
                                            <option value="Y">Y</option>
									</select>
								</td>
								<td><input type="text" class="opinion" id="opinion" name="opinion" style="border: none; background: transparent;"></td>
								<td><button class="objectionbtn" onclick="updateDissent('${c.classNo }','${c.studentNo }');">회신버튼</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
					<br>
					<hr>
					<div class="textTitle">
						<b>이의신청 시 유의사항(필독)</b>
					</div>
					<br>
					<div>
						<table id="text-box">
							<th>
								교수자의 성적 입력 오타, 명백한 평가오류에 한하여 이의 신청 가능
								<br>
								상기 사유 외 이의신청은 부정청탁 및 금품 등 수수의 금지에 관한 법률에 저촉되므로 불이익 처분을 받지 않도록 각별히 주의하시기 바람
								<br>
								부적절한 이의신청은 교수자가 회신하지 않음
								<br>
								상기 사유에 해당하는 이의사항은 본 시스템을 이용하거나, 교수자에게 직접 연락하는 등의 방법을 택할 수 있음.
								<br>
								본 시스템에 등록한 이의신청종료 전일까지 처리되지 않은 경우, 교수자에게 직접 연락하시기 바람
							</th>
						</table>
					</div>
    		</div>
      </div>
 </div>
<script>
 function updateDissent(classNo,studentNo) {
	 var msg = "${msg}";
		
		 var flag = confirm("수정하시겠습니까?");
		 var status = $("#status").val();
		 var opinion = $("#opinion").val();
		 var studentNo = studentNo;
		 var classNo = classNo;
		 
		 console.log(opinion);
		 console.log(status);
		 
		 $.ajax({
			 url : "professorGradeRequest.pr",
			 data : {
				 status : status,
				 opinion : opinion,
				 studentNo : studentNo,
				 classNo : classNo
			 },
			 success : function(result){
				 if(result=="Y"){
						 alert("수정 완료");
						 location.reload();
				 }else{
					 	alert("수정 실패");
				 }
			 }
			 ,error : function(){
				alert("수신 오류");  	
			 } 
		 });
		 
		}
 </script> 
</body>
</html>