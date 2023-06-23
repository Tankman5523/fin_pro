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
	
	#user_info{
		padding: 10px;
		border : 1px solid gray;
		border-radius : 6px;
		margin-left: 30px;
	}
	.user_info3{
		border-radius: 6px;
		width: 400px;
		height: 30px;
	}
	.user_info4{
		border-radius: 6px;
		width: 234px;
		height: 30px;
	}
	.user_info2{
		padding: 10px;
		border : 1px solid gray;
		margin-left: 30px;
		border-radius: 8px;
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
 	
 	    select{
        -moz-appearance: none;
        -webkit-appearance: none;
        appearance: none;
        font-size: 12px;
        font-weight: 400;
        line-height: 1.5;    
        width: 405px;
        height: 30px;
        border-radius: 8px;
        text-align: center;
    }
    
    #randombtn{
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
	table {
	border-collapse: separate !important;
	}
 	


</style>


<script>

	var msg = "${msg}";
	
	$(document).ready(function(){
		if(msg != ""){
			alert(msg);
		}
		
		$("#crystalBtn").click(function(e){
			return false;
		})
	});


 	  function insertStudent(){
		 var flag = confirm("학생 생성 하시겠습니까??");
		 
				 
		 var validArr = [];
	
		 validArr.push($("#entranceDate"));
		 validArr.push($("#collegeNo"));
		 validArr.push($("#departmentNo"));
		 /* validArr.push($("#studentNo")); */
		 validArr.push($("#studentPwd"));
		 validArr.push($("#studentName"));
		 validArr.push($("#classLevel"));
		 validArr.push($("#phone"));
		 validArr.push($("#email"));
		 validArr.push($("#address")); 
		 
		 
		var validInput;
		var loopFlag = true;
		
		
		for(var i = 0 ; i < validArr.length ; i++){
			if(!loopFlag) return false;
			
			validInput = validArr[i];
			if(!validInput.val()){
				alert(validInput.data("name") + "를(을) 압력해주세요.");
				loopFlag = false;
				validInput.focus();
			}
		}
		 
		 
		 
		 
		 if(flag){
			 $("#insertForm").submit();	 
		 }else{
			 return false;
		 } 
 	 }  
	 
 	 
 	  function collegeChange(e){
 		  var depart1 = ["국어영문학과","영어영문학과","일어일문학과","사학과"];
 		  var depart2 = ["경제경영학과","회계학과","법학과","행정학과"];
 		  var depart3 = ["초등교육과","유아교육과"];
 		  var depart4 = ["생명공학과","수학과","물리학과","통계학과"];
 		  var depart5 = ["건축학과","기계학과","컴퓨터공학과","전자전기과","화학공학과"];
 		  var depart6 = ["시각디자인학과","패션디자인학과"];
 		  var depart7 = ["연극영화과","실용음악과"];
 		  var target = document.getElementById("departmentNo");
 		 
 		 var departmentNo = parseInt(e.value, 10);
 		  
 		  if(e.value=="1") var d = depart1;
 		  else if(e.value=="2") var d =depart2;
 		  else if(e.value=="3") var d =depart3;
 		  else if(e.value=="4") var d =depart4;
 		  else if(e.value=="5") var d =depart5;
 		  else if(e.value=="6") var d =depart6;
 		  else if(e.value=="7") var d =depart7;
 		
 		 target.options.length = 0;
		  
		  for (x in d) {
				var opt = document.createElement("option");
				
				opt.value = d[x];
				
				opt.innerHTML = d[x];
				target.appendChild(opt);
			}
 	  }
 	 
	
 	 window.onload = function(){
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
 	
 	
 	// 특수문자 한글 입력 막기
 	function characterCheck(obj) {
 	    var regExp = /[^\w\d\s]/g;
 	    if (regExp.test(obj.value)) {
 	        alert("특수문자와 한글은 입력하실 수 없습니다.");
 	        obj.value = obj.value.replace(regExp, ''); // 특수문자와 한글을 제거
 	    }
 	}
 	
 	 //영어, 특수문자, 한글 입력 막기
 	function characterCheck2(obj) {
     var regExp = /[^0-9]/g;
     if (regExp.test(obj.value)) {
         alert("영어, 특수문자, 한글은 입력하실 수 없습니다.");
         obj.value = obj.value.replace(regExp, ''); // 숫자 이외의 문자를 제거
     } 
 }
 	function characterCheck3(obj) {
 	    var regExp = /[^a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ\s]/g;
 	    if (regExp.test(obj.value)) {
 	        alert("특수문자는 입력하실 수 없습니다.");
 	        obj.value = obj.value.replace(regExp, ''); // 특수문자를 제거
 	    }    
 }
 	
 	function characterCheck4(obj) {
 	    var regExp = /[^a-zA-Z0-9\s\^\-_.!@#$%&*()+=]/g;
 	    if (regExp.test(obj.value)) {
 	        alert("한글은 입력하실 수 없습니다.");
 	        obj.value = obj.value.replace(regExp, ''); // 한글을 제거
 	    }    
 	}
 	
 	function characterCheck5(obj) {
 	    var regExp = /[^0-9\s\^\-_.!@#$%&*()+=]/g;
 	    if (regExp.test(obj.value)) {
 	        alert("한글과 영어는 입력하실 수 없습니다.");
 	        obj.value = obj.value.replace(regExp, ''); // 한글과 영어를 제거
 	    }    
 	}
	
	
	function randomPasswordBtn() {
	    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@";
	    
	    var randomStr = "";
	    
	    for (var i = 0; i < 10; i++) {
	        var randomIndex = Math.floor(Math.random() * chars.length);
	        randomStr += chars[randomIndex];
	        console.log(randomStr);
	    }
	    console.log(randomStr);
	    
	    var studentPwd = document.getElementById("studentPwd");
	    if (studentPwd) {
	        studentPwd.value = randomStr;
	    }
	}
	
	
</script>
</head>
<body>
    <div class="wrap">
		<%@include file="../../common/admin_menubar.jsp" %>
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <h3>학사관리</h3>
                </div>
                <div class="child_title">
                    <a href="enrollStudent.ad" style="color:#00aeff; font-weight: 550;">학생 관리</a>
                </div>
				<div class="child_title">
                    <a href="enrollProfessor.ad">임직원 관리</a>
                </div>
                <div class="child_title">
                    <a href="calendarView.ad">학사일정 관리</a>
                </div>
            </div>
            <div id="content_1">
            	<br>
					<th><button id="randombtn" onclick="randomPasswordBtn()">비밀번호 생성하기</button></th>
					<form id="insertForm" action="insertStudent.ad" method="post">
					<div id="basic_info">
						<table class="basic_table">
						<tr>
							<th>기본 정보</th>
							<button id="crystalBtn" onclick="insertStudent()">등록하기</button>
						</tr>
						</table>
						<br>
						<hr>
					</div>
					<input type="hidden" id="professorNo" name="professorNo" value="${loginUser.professorNo }">
					<div id="user_infomation">
						<table id="user_info">
							<thead>
								<tr>
									<th width="100px" height="30px">입학 년도 : </th>
									<th><input type="date" class="user_info4" name="entranceDate" id="entranceDate" data-name="입학년도"></th>
									<th width="100px" height="30px">대학(원) : </th>
									<th>
										<select id="collegeNo" name="collegeNo" class="user_info4" onChange="collegeChange(this)" data-name="대학(원)">
                                            <option value="">-선택-</option>
                                            <option value="1">인문대학</option>
                                            <option value="2">사회과학대학</option>
                                            <option value="3">교육대학</option>
                                            <option value="4">자연대학</option>
                                            <option value="5">공학대학</option>
                                            <option value="6">미술대학</option>
                                            <option value="7">예술대학</option>
                                        </select>
									</th>
									<th width="100px" height="30px">학과(부) : </th>
									<th>
										<select id="departmentNo" name="departmentNo" class="user_info4" data-name="학과(부)">
                                            	<option>-선택-</option>
                                            </select>
									</th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">학번 : </th>
									<th><input type="text" class="user_info3" name="studentNo" id="studentNo" maxlength="9" onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" data-name="학번" readonly placeholder="자동으로 생성"></th>
									<th width="100px" height="30px">비밀번호 : </th>
									<th><input type="text" class="user_info3" id="studentPwd" name="studentPwd" data-name="비밀번호"><th>
									<!-- <th width="212px" height="30px">랜덤 비밀번호:</th>
									<th><button id="passwordBtn" onclick="randomPasswordBtn()">생성하기</button></th> -->
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">이름 : </th>
									<th><input type="text" class="user_info3" id="studentName" name="studentName" maxlength="4" onkeyup="characterCheck3(this)" onkeydown="characterCheck3(this)" data-name="이름"></th>
									<th width="100px" height="30px">학년 : </th>
									<th><input type="text" id="classLevel" name="classLevel" class="user_info3" maxlength="1" onkeyup="characterCheck2(this)" onkeydown="characterCheck2(this)" data-name="학년"></th>
									
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">전화번호 : </th>
									<th><input type="text"  class="user_info3" id="phone" name="phone" placeholder="숫자만 입력하세요." maxlength="11" onkeyup="characterCheck2(this)" onkeydown="characterCheck2(this)" data-name="전화번호"/></th>
									<th width="100px" height="30px">E-MAIL : </th>
									<th><input type="text" id="email" name="email" class="user_info3" placeholder="example@example.com" required="이메일을 입력해주세요" onkeyup="characterCheck4(this)" onkeydown="characterCheck4(this)" data-name="E-MAIL"></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">우편번호 : </th>
									<th><input type="text" id="post" name="post" class="user_info3" readonly></th>
									<th width="100px" height="30px">주소 : </th>
									<th><input type="text" id="address" name="address" class="user_info3" data-name="주소"></th>
								</tr>
							</thead>
						</table>
						</div>
					</form>
					</div>
				</div>
            </div>
</body>
</html>