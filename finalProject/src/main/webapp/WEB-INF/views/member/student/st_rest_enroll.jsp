<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴,복학 신청</title>
<link rel="stylesheet" href="/fin/resources/css/studentRestFormView.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/student_menubar.jsp"%>
		<%--알아서 수정해서 쓰기 --%>
		<%@include file="../../common/datepicker.jsp"%>
		<div id="content">
			<div id="category">
				<div id="cate_title">
					<span style="margin: 0 auto;">학사관리</span>
				</div>
				<div class="child_title">
					<a href="infoStudent.st">학적
						정보 조회</a>
				</div>
				<div class="child_title">
					<a href="personalTimetable.st">개인 시간표</a>
				</div>
				<div class="child_title">
					<a href="studentRestEnroll.st" style="color:#00aeff; font-weight: 550;">휴/복학 신청</a>
				</div>
				<div class="child_title">
					<a href="studentRestList.st">휴/복학 조회</a>
				</div>
				<div class="child_title">
					<a href="graduationInfoForm.st">졸업 사정표</a>
				</div>
			</div>
			<div id="content_1" align="center">
				<span id="content_title">휴학/복학 신청</span>
				<div style="border-top: 2px solid lightblue;">
					<form action="studentRestInsert.st" id="stuRest" method="POST">
					<div id="board_border">
						<br>
							<h5>학생 정보</h5>
							<table border="2" class="board_list table">
								<tr>
									<td>학생명</td>
									<td><input type="text" value="${loginUser.studentName }"
										readonly></td>
									<td>학번</td>
									<td><input type="text" value="${loginUser.studentNo }"
										name="studentNo" readonly></td>
								</tr>
								<tr>
									<td>학과</td>
									<td><input type="text" value="${loginUser.departmentNo }"
										readonly></td>
									<td>이메일</td>
									<td><input type="text" value="${loginUser.email }"
										readonly></td>
								</tr>
								<tr>
									<td>학년</td>
									<td><input type="text" value="${loginUser.classLevel }"
										readonly></td>
									<td>연락처</td>
									<td><input type="text" value="${loginUser.phone }"
										readonly></td>
								</tr>
							</table>
							<h5>신청 정보</h5>
							<table border="2" id="enrollTable" class="board_list table">
								<tr>
									<td>*신청 구분</td>
									<td><select name="category" id="reason">
											<c:choose>
												<c:when test="${empty sr}">
													<option value="일반휴학">일반휴학</option>
													<option value="특별휴학">특별휴학</option>
												</c:when>
												<c:otherwise>
													<option value="복학">복학</option>
													<option value="휴학연장">휴학연장</option>
												</c:otherwise>
											</c:choose>
									</select></td>

									<td>*신청 사유</td>
									<td><select name="reason" id="reason2">

									</select></td>
								</tr>
								<c:choose>
									<c:when test="${empty sr}">
										<tr>
											<td>*휴학 시작일</td>
											<td><input type="date" name="startDate" id="datepicker1" maxlength="10" data-placeholder="날짜 선택" required></td>
											<td>*복학 예정</td>
											<td><input type="date" name="endDate" id="datepicker2" maxlength="10" data-placeholder="날짜 선택" required></td>
										</tr>

									</c:when>
									<c:otherwise>
										<tr>
											<td>휴학 시작일</td>
											<td><input type="text" name="startDate" id="startedDate" maxlength="10" value="${sr.startDate}" readonly></td>
											<td>복학 예정</td>
											<td><input type="text" name="endDate" id="returnDate" maxlength="10" value="${sr.endDate}" readonly></td>
										</tr>
										<tr id="newDate">
											<td>*휴학 연장 시작일</td>
											<td><input type="date" name="startDate" id="datepicker1" maxlength="10" data-placeholder="날짜 선택" required></td>
											<td>*연장 복학 예정</td>
											<td><input type="date" name="endDate" id="datepicker2" maxlength="10" data-placeholder="날짜 선택" required></td>
										</tr>
									</c:otherwise>
								</c:choose>
								<tr>
									<td>휴학 횟수</td>
									<td><input type="text" value="${rcount}" readonly></td>
									<td>*등록여부</td>
									<td><select id="regCheck">
											<option value="yes">등록휴학</option>
											<option value="no">미등록휴학</option>
									</select></td>
								</tr>
							</table>
					</div>
					</form>
					<br>
					<p>*필요 서류는 행정실 이메일 kh@naver.com으로 보내주시거나 방문제출 해주셔야 합니다.</p>
					<br>
						<div>
							<button type="submit" id="sm_btn" form="stuRest" class="btn btn-primary btn-lg">전송</button>
						</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$("#reason").trigger("change");//처음에 카테고리 트리거 작동
			$("#regCheck").change(function() {//등록,미등록휴학 고를때마다 작동

				if ($(".reg").css("display") == "none") {//등록 휴학을 골랐다면
					$(".reg").css("display", ""); //등록금 부분을 보여줌
					var must = $("#mustPay").text(); //내야하는 등록금
					var input = $("#inputPay").text(); //낸 등록금
					if (input >= must) { //등록금을 냈다면
						$("#sm_btn").attr("disabled", false); //전송 누를수 있게 함
					} else { //등록금을 안냈다면
						$("#sm_btn").attr("disabled", true); // 전송 못누르게 함
					}
				} else { //미등록 휴학을 골랐다면
					$(".reg").css("display", "none"); //등록금 부분을 안보여줌
					$("#sm_btn").attr("disabled", false); //전송 누를수 있게 함
				}
			});
		})
		var select = document.querySelector("#reason"); //카테고리 셀렉트 가져오기
		select.onchange = function() { //카테고리 셀렉트가 바뀔때마다
			var reason = document.querySelector("#reason2"); //사유 셀렉트 가져오기
			var mainReason = select.options[select.selectedIndex].innerText; //카테고리 셀렉트 고른 옵션 값 가져오기
			var newDateArea = document.getElementById("newDate"); //휴학연장 골랐을때 나오는 연장기간 선택창
			var oldDateArea = document.getElementById("oldDate"); //복학,휴학연장했을때 기존 휴학기간 보여주는창 가져오기
			var returnDate = document.getElementById("returnDate"); //복학,휴학연장했을때 기존 복학날짜 가져오기
			//console.log(returnDate.value);
			//휴학연장할때 새로 날짜를 받아야 해서 기존 기간설정 name을 바꿔야함
			var sDate = $("#startedDate"); //기존 startDate 시작날짜
			var eDate = $("#returnDate"); //기존 endDate 복학날짜

			var subReason = {//사유 옵션에 넣을 것들
				normal : [ "개인사유", "병가휴학" ],
				special : [ "군입대휴학", "출산휴학", "창업휴학" ],
				reschool : [ "복학" ],
				extend : [ "질병연장", "휴학중입대", "기타사유" ]
			}
			
			$("#datepicker1").datepicker("option", "minDate",0);
			
			switch (mainReason) {//카테고리 골랐을때 맞는 옵션을 넣어주고 그 밖에 작용
			case "일반휴학":subReason = subReason.normal;
				break;
			case "특별휴학": subReason = subReason.special;
				break;
			case "복학": subReason = subReason.reschool;
					    newDateArea.style.display = "none"; //기간연장 설정 가리기
					    sDate.attr("name", "startDate"); //기존 기간 설정 name 만들어주기
					    eDate.attr("name", "endDate"); //기존 기간 설정 name 만들어주기2
				break;
			case "휴학연장" : subReason = subReason.extend;
							newDateArea.style.display = "";
							$("#datepicker1").datepicker("option", "minDate",returnDate.value); //연장 휴학기간 시작날짜 기존 복학예정날짜 이상으로 고르게 하기
							sDate.removeAttr("name"); //기존 기간 설정 name 없애기
							eDate.removeAttr("name"); //기존 기간 설정 name 없애기
				break;
			}

			reason.options.length = 0; //옵션 비우기

			for (var i = 0; i < subReason.length; i++) {//옵션 채워주기
				var option = document.createElement("option");
				option.innerText = subReason[i];
				option.value = subReason[i];
				reason.append(option);
			}
		}
		$("#datepicker1").datepicker({
			//minDate : 0,
			//maxDate : "+1M"

		});

		$("#datepicker1").datepicker("option","onClose",function(selectDate) { //시작기간 창이 닫혔을때 작동
					$("#datepicker2").datepicker("option", "minDate",selectDate); //시작기간날짜 이상으로 고르게 하기
					var status = "${loginUser.status}";//현재 로그인학생 상태(재학,휴학,퇴학,졸업 등등)
					
					if (status != "휴학") {//현재 상태가 휴학이라면 등록,미등록휴학을 안따짐
						//휴학시작날짜 고르면 그 날짜를 기준으로 등록금 조회
						var year = selectDate.slice(0, 4); //학년도
						var month = selectDate.slice(5, 7); //학기 고르기위한 달            
						var term;//학기 담을 변수
						var regCheck = $("#regCheck").val(); //미등록휴학인지 등록휴학인지 판별

						if (month > 6) { //6월이상이면 
							term = 2 //2학기
						} else {
							term = 1 //1학기
						}
						$.ajax({ //등록금 납부했는지 가져오기
							url : "studentCheckRegistPay.st",
							data : {
								studentNo : "${loginUser.studentNo}",
								classYear : year,
								classTerm : term
							},
							success : function(rp) {
								console.log(rp);
								var result = "";
								if (rp == null) { //등록금 납부기간이 아님
									console.log("등록금 납부기간이 아님");
								} else { //등록금 정보 보여주는 창 만들기
									result += "<tr class='reg'>"
											+ "<td>납부할금액</td>"
											+ "<td id='mustPay'>" + rp.mustPay+ "</td>" 
											+ "<td>납부한금액</td>"
											+ "<td id='inputPay'>"+ rp.inputPay + "</td>" 
											+ "</tr>"
											+ "<tr class='reg'>"
											+ "<td colspan='2'>" + year + "년 "+ term + "학기" + " 등록금 납부할 계좌</td>"
											+ "<td colspan='2'>"+ rp.regAccountNo + "</td>"
											+ "</tr>"

								}
								$(".reg").remove(); //기존 등록금 정보 창 지우기(안하면 셀렉트 고를때마다 늘어남)
								$("#enrollTable>tbody").append(result); //등록금 정보 창 테이블에 붙이기
								if (regCheck == "no") {//미등록휴학을 골라놓고 휴학 시작날짜를 고른경우
									$(".reg").css("display", "none");
								}
								if (rp.inputPay >= rp.mustPay|| regCheck == "no") {
									$("#sm_btn").attr("disabled", false);
								} else {
									$("#sm_btn").attr("disabled", true);
								}
							},
							error : function() {
								alert("통신실패");
							}
						})

					}
				})

		$("#datepicker2").datepicker();
	</script>
</body>
</html>