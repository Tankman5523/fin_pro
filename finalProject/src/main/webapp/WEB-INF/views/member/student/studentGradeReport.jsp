<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#basic_info {
	margin-left: 30px;
	margin-right: 35px;
}

#basic_table {
	right: 15%;
	position: relative;
}

#studentObjection {
	border: 1px solid black;
	text-align: center;
	width: 95%;
	margin-left: 20px;
	border-collapse: collapse;
	border-radius: 10px;
	border-style: hidden;
	box-shadow: 0 0 0 1px #000;
}

#studentObjection2 {
	border: 1px solid black;
	text-align: center;
	width: 95%;
	margin-left: 20px;
	border-collapse: collapse;
	border-radius: 10px;
	border-style: hidden;
	box-shadow: 0 0 0 1px #000;
}

#student_objection>thead>tr>th {
	height: 50px;
}

#student_objection>tbody>tr>td {
	height: 40px;
}

#text-box {
	border: 1px solid gray;
	border-radius: 8px;
	margin-left: 80px;
}

.objectionbtn {
	background-color: darkgray;
	border-radius: 8px;
	color: whitesmoke;
	border-collapse: collapse;
	border-style: hidden;
}

.textTitle {
	margin-left: 450px;
}

.crystal_btn {
	border: 0;
	padding: 12px 18px;
	border-radius: 10px;
	margin-right: 12px;
	font-size: 15px;
	background-color: #4fc7ff;
	color: whitesmoke;
	float: right;
	font-weight: bold;
	position: relative;
	bottom: 10%;
	top: 30px;
}

#grade_report {
	padding-right: 20px;
	height: 10px;
}

#classYear {
	width: 200px;
	height: 40px;
	border-radius: 8px;
	text-align: center;
	appearance: none;
	margin: 30px 15px 15px;
}

#classTerm {
	width: 200px;
	height: 40px;
	border-radius: 8px;
	text-align: center;
	appearance: none;
	margin: 30px 15px 15px;
}

#checkbtn {
	width: 150px;
	height: 40px;
	border-radius: 8px;
	text-align: center;
	appearance: none;
	margin: 20px 15px 15px;
}

.reasonText {
	width: 100%;
}
</style>
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/student_menubar.jsp"%>
		<div id="content">
			<div id="category">
				<div id="cate_title">
					<span style="margin: 0 auto;">수업관리</span>
				</div>
				<div class="child_title">
					<a href="classManagement.st">학기별 성적 조회</a>
				</div>
				<div class="child_title">
					<a href="studentGradeReport.st">성적 이의신청</a>
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
							<th id="grade_head">학년도 :</th>
							<th><label for="classYear"> 
								<select name="classYear" id="classYear" onchange="changeYear(this);">
									<c:set var="previous" value="0"/>
									<c:forEach var="y" items="${classTerm}">
										<c:if test="${fn:substring(y, 0, 4) ne previous }">
											<option value="${fn:substring(y, 0, 4) }">${fn:substring(y, 0, 4) }년도</option>
										</c:if>
										<c:set var="previous" value="${fn:substring(y, 0, 4) }"/>
									</c:forEach>
                                </select>
							</label></th>
							<th>학기 :</th>
							<th><label for="classTear"> 
								<select name="classTerm" id="classTerm"></select>
							</label>
							</th>
							<th>
								<button type="button" id="checkbtn" onclick="gradeCheck()">조회하기</button>
							</th>
						<tr>
					</table>
					<hr>
				</div>
				<div style="text-align: center;">
					<b>이의신청</b>
				</div>
				<br>
				<table border="1" id="studentObjection">
					<thead>
						<tr>
							<th>학번</th>
							<th>강의이름</th>
							<th>교수</th>
							<th>학점</th>
							<th>사유</th>
							<th>이의신청</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="c" items="${list}">
							<tr>
								<td>${c.studentNo}</td>
								<td>${c.className }</td>
								<td>${c.professorName }</td>
								<td>${c.credit }</td>
								<td><input type="text" class="reasonText" id="reason"
									name="reason" style="border: none; background: transparent;"></td>
								<td><button class="objectionbtn"
										onclick="insertDissent('${c.className }','${c.professorName}','${c.credit}');">이의신청</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br>

				<hr>
				<div style="text-align: center;"></div>
				<div id="ajaxResult">
					<div style="text-align: center;">
						<b>처리상태</b>
					</div>
					<br>
					<table border="1" id="studentObjection2">
						<thead>
							<tr>
								<th>학번</th>
								<th>강의이름</th>
								<th>교수</th>
								<th>학점</th>
								<th>처리상태</th>
								<th>교수의견</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="c" items="${resultList}">
							<tr>
								<td>${c.studentNo}</td>
								<td>${c.className }</td>
								<td>${c.professorName }</td>
								<td>${c.credit }</td>
								<td>${c.status }</td>
								<td>${c.opinion }</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<br>
				<hr>
				<div class="textTitle">
					<b>이의신청 시 유의사항(필독)</b>
				</div>
				<br>
				<div>
					<table id="text-box">
						<tr>
							<th>교수자의 성적 입력 오타, 명백한 평가오류에 한하여 이의 신청 가능 <br> 상기 사유 외
								이의신청은 부정청탁 및 금품 등 수수의 금지에 관한 법률에 저촉되므로 불이익 처분을 받지 않도록 각별히 주의하시기
								바람 <br> 부적절한 이의신청은 교수자가 회신하지 않음 <br> 상기 사유에 해당하는 이의사항은
								본 시스템을 이용하거나, 교수자에게 직접 연락하는 등의 방법을 택할 수 있음. <br> 본 시스템에 등록한
								이의신청종료 전일까지 처리되지 않은 경우, 교수자에게 직접 연락하시기 바람
							</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script>
		/* var arr = ${classTerm};
		
		$(function() {
			$("select[name=classYear]").children().first().prop("selected", true).change();
			clear();
			gradeCheck();
            
        	$(".basic_table>tbody>th").on("change", "#classTerm", function() {
        		clear();
        	});
		}) */
		
		function changeYear(e) {
        	var $year = e.value;
        	var str = "";
        	
        	for(var i=0;i<arr.length;i++) {
        		var tmp = arr[i].toString().substr(0,4); // 2022
        		if(tmp.includes($year)) {
        			var tmp2 = arr[i].toString().substr(5,);
	        		if(tmp2 == "1") {
	        			str += "<option value='1'>1학기</option>";
	        		}
	        		if(tmp2 == "2") {
	        			str += "<option value='2'>2학기</option>";
	        		}
        		}
        	}
        	
        	$("#classTerm").empty();
        	$("#classTerm").append(str);
        	$("#classTerm").children().first().prop("selected", true).change();
        	clear();
        }
		
		function clear() {
			$("#studentObjection>tbody").empty();
			$("#studentObjection2>tbody").empty();
		}
	
		function reasonRequest() {
			var studentNo = "${loginUser.studentNo}";
			var classYear = $("#classYear").val();
			var classTerm = $("#classTerm").val();

			$.ajax({
				url : 'studentGradeReport.st',
				type : 'post',
				data : {

					studentNo : studentNo,
					classYear : classYear,
					classTerm : classTerm
				},
				success : function(data) {
					var innerHtml = '';
					innerHtml += '<table border="1" id="studentObjection2">';
					innerHtml += '<div style="text-align: center;">';
					innerHtml += '<b>신청내역</b>';
					innerHtml += '</div>';
					innerHtml += '<br>';
					innerHtml += '<thead>';
					innerHtml += '<tr>';
					innerHtml += '<th>학번</th>';
					innerHtml += '<th>강의이름</th>';
					innerHtml += '<th>교수</th>';
					innerHtml += '<th>학점</th>';
					innerHtml += '<th>처리상태</th>';
					innerHtml += '<th>교수의견</th>';
					innerHtml += '</tr>';
					innerHtml += '</thead>';
					innerHtml += '<tbody>';

					for (var i = 0; i < data.list.length; i++) {
						innerHtml += '<tr>';
						innerHtml += '<td>' + data.list[i].studentNo + '</td>';
						innerHtml += '<td>' + data.list[i].className + '</td>';
						innerHtml += '<td>' + data.list[i].professorName + '</td>';
						innerHtml += '<td>' + data.list[i].credit + '</td>';
						innerHtml += '<td>' + data.list[i].status + '</td>';
						var opinion = data.list[i].opinion;
						if(!opinion) opinion = ''; 
						innerHtml += '<td>' + opinion + '</td>';
						innerHtml += '</tr>';
					}

					innerHtml += '</tbody>';
					innerHtml += '</table>';
					$("#ajaxResult").html(innerHtml);
				},
				error : function(request) {
					alert('실패');
				}
			});

		}

		function insertDissent(a, b, c) {
			var loginUser = "${loginUser}";
			var flag = confirm("이의신청을 하시겠습니까?");

			if (flag) {
				var studentNo = "${loginUser.studentNo}";
				var className = a;
				var professorName = b;
				var credit = c;
				var reason = document.querySelector('input[name="reason"]').value;

				$.ajax({
					url : "insertReport.st",
					data : {
						studentNo : studentNo,
						className : className,
						professorName : professorName,
						credit : credit,
						reason : reason
					},
					method : "post",
					success : function(result) {
						if (result == 'Y') {
							alert("이의신청에 성공하였습니다.");
							reasonRequest();
						} else {
							alert("이의신청에 실패하였습니다.");
						}
					},
					error : function() {
						alert("통신 실패");
					}
				});
			}

		}
		
		/* function gradeCheck() {
			  var classYear = document.getElementById("classYear").value;
			  var classTerm = document.getElementById("classTerm").value;
			
			  reasonRequest(); // reasonRequest() 함수 호출
			  
			  console.log(classYear);
			  console.log(classTerm);

			  if (classYear === "2023" && (classTerm === "1" || classTerm === "2")) {
			    console.log("조회하기 기능 수행");
			  }
			} */
	</script>
</body>
</html>