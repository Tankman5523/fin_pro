<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 주소API 다음(카카오) -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<style>
	/*======================수정======================*/
	input:read-only{
		background-color: #D3D3D3;
	}

	#basic_info{
		margin-left: 30px;
		margin-right: 35px;
	}
	#basic_table{
		right: 15%;
		position: relative;
	}
	.user_info3{
		border-radius: 6px;
		width: 330px;
		height: 30px;
	}
	.user_info4{
		border-radius: 6px;
		width: 280px;
		height: 30px;
	}
	.user_info5{
		border-radius: 6px;
		width: 450px;
		height: 30px;
	}
	.user_info2{
		padding: 20px;
		margin-left: 30px;
		border-radius: 8px;
		box-shadow: 0 0 0 1px #000;
		border-collapse : collapse;
	}
	#crystalBtn{
		border: 0;
        padding: 12px 18px;
        border-radius: 10px;
        margin-right: 12px;
        font-size: 15px;
        background-color:#4fc7ff;
        color: whitesmoke;
		float: right;
		font-weight: bold;
 	}
 	
 	/*!important 다무시하고 먼저실행*/
	#content_1 table {
	border-collapse: separate !important;
	}

	#profile {
		border: 1px solid black; 
		border-radius: 15px; 
		margin: 13px 0 0 15px;  
		width: 150px; 
		height: 150px;
	}

</style>


<script>
	
		var msg = "${msg}";
		
		 function updateProfessor(){
			 var flag = confirm("수정하시겠습니까?");
			 
			 if(flag){
				 $("#updateForm").submit();	 
			 }else{
				 return false;
			 }
			 }
		
		 function convertReadonly(){
			 $("#crystalBtn").attr("onclick", "updateProfessor()");
		 }
	
	window.onload = function(){
		if(msg != ""){
			alert(msg);
		}
		
	    document.getElementById("address").addEventListener("click", function(){ //주소입력칸을 클릭하면
	        //카카오 지도 발생
	        new daum.Postcode({
	            oncomplete: function(data) { //선택시 입력값 세팅
	            	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("address").value = extraAddr;
	                
	                } else {
	                    document.getElementById("post").value = '';
	                }
	                 document.getElementById("address").value = data.address; // 주소 넣기
	                document.getElementById("post").value= data.zonecode; // 우편번호 넣기 
	                console.log(data.post);
	            }
	        }).open();
	    });
	}
	
</script>
</head>
<body>
    <div class="wrap">
		<%@include file="../../common/professor_menubar.jsp" %>
		
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="infoProfessor.pr" style="color:#00aeff; font-weight: 550;">교수 정보 관리</a>
                </div>
				<div class="child_title">
                    <a href="classListView.pr">강의 시간표</a>
                </div>
				<div class="child_title">
                    <a href="personalTimetable.pr">개인 시간표</a>
                </div>
				<div class="child_title">
                    <a href="professorRestList.pr">안식/퇴직 신청 조회</a>
                </div>
				<div class="child_title">
                    <a href="professorRestEnroll.pr">안식/퇴직 신청</a>
                </div>
            </div>
            <div id="content_1">
					<div>
					</div>
					<div id="basic_info">
						<table class="basic_table">
						<br>
							<th>기본 정보</th>
							<button id="crystalBtn" onclick="updateProfessor()">수정하기</button>
						</table>
						<br>
						<hr>
					</div>
					<form id="updateForm" action="updateProfessor.pr" method="post">
					<input type="hidden" id="professorNo" name="professorNo" value="${loginUser.professorNo }">
					<div id="user_infomation">
						<div style="width: 80%; float: left;">
							<table class="user_info2">
								<thead>
									<tr>
										<th width="100px" height="30px">입사 년도 : </th>
										<th><input type="text"  class="user_info3" value="${loginUser.entranceDate}" readonly></th>
										<th style="padding-left: 10px;" width="100px" height="30px">대학(원) : </th>
										<th><input type="text" class="user_info4" value="${professorNo.collegeName}" readonly></th>
									</tr>
								</thead>
							</table>
							<br>
							<table class="user_info2">
								<thead>
									<tr>
										<th width="100px" height="30px">교번 : </th>
										<th><input type="text" class="user_info3" value="${loginUser.professorNo}" readonly></th>
										<th style="padding-left: 10px;" width="100px" height="30px">학과(부) : </th>
										<th><input type="text" class="user_info4" value="${professorNo.departmentName}" readonly></th>
									</tr>
								</thead>
							</table>
							<br>
						</div>
						<c:choose>
							<c:when test="${!empty filePath }">
								<img id="profile" alt="프로필사진" src="${filePath }">
							</c:when>
							<c:otherwise>
								<img id="profile" alt="프로필사진" src="resources/icon/profileImg.png">
							</c:otherwise>
						</c:choose>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">이름 : </th>
									<th><input type="text" class="user_info3" value="${loginUser.professorName}" readonly></th>
									<th style="padding-left: 10px;" width="100px" height="30px">직급 : </th>
									<th><input type="text" id="position" class="user_info5" value="${loginUser.position}" readonly></th>
									
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">전화번호 : </th>
									<th><input type="text" name="phone" id="phone" class="user_info3" value="${loginUser.phone}" maxlength="11" onkeyup="characterCheck2(this)" onkeydown="characterCheck2(this)"></th>
									<th style="padding-left: 10px;" width="100px" height="30px">E-MAIL : </th>
									<th><input type="text" name="email" id="email" class="user_info5" value="${loginUser.email}" onkeyup="characterCheck4(this)" onkeydown="characterCheck4(this)"></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">주소 : </th>
									<th><input type="text" name="address" id="address"class="user_info3" value="${loginUser.address}"></th>
									<th style="padding-left: 10px;" width="100px" height="30px">우편번호 : </th>
									<th><input type="text" name="post" id="post"class="user_info5" value="${loginUser.post}" readonly></th>
								</tr>
							</thead>
						</table>
					</form>
					</div>
				</div>
            </div>
        </div>
    </div>
</body>
</html>