<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<title>Insert title here</title>
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 주소API 다음(카카오) -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<style>
	div{
	    box-sizing: border-box;
	}
	.wrap{
	    width: 1400px;
	    height: 1100px;
	    margin: auto;
	}
	.wrap>div{
	    width: 100%;
	}
	#header{
	    height: 15%;
	}
	#menubar{
	    height: 6%;
	    background-color: #4fc7ff
	}
	#content{
	    width: 100%;
	    height: 78%;
	}
	#header_1{
	    height: 65%;
	}
	#category{
		border : 1px solid gray;
	    width: 20%;
	    height: 100%;
	    float: left;
	}
	#content_1{
		border : 1px solid gray;
	    width: 80%;
	    height: 100%;
	    float: right;
	}
	/*=========메뉴바 영역===========*/
    #nav{
        margin: 0%;
        padding: 0%;
        list-style-type: none;
		
		
    }
    #nav>li{
        width: 9.5%;
        height: 100%;
        display: inline-block;
        line-height: 70px;
        text-align: center;
        vertical-align: top;
    }
    #menubar a{
        width: 100%;
        height: 100%;
        display: block;
        text-decoration: none;
        font-size: 23px;
        font-weight: bold;
        color: whitesmoke;
    }
    /*===============로그인 유저============*/
	#user_log{
	    margin: 0 50px;
	    float: right;
	    line-height: 137px;
	}
	#user_log td{
	    text-align: right;
	}
	#logout-btn{
	    width: 80px;
	    height: 30px;
	    border: none;
	    border-radius: 5px;
	    background-color: #4fc7ff;
	    /* color: white; */
	    font-weight: bold;
	}


    /*===========카테고리 영역=============*/
    #cate_title{
        width: 100%;
        height: 9%;
        font-size: 25px;
        border-bottom: 1px solid black;
        position: relative;
    }
    #cate_title>h3{
        margin: 0%;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
    }
    .child_title{
        display: flex;
        align-items: center;
        width: 100%;
        height: 7%;
        border-bottom: 1px solid black;
        text-align: center;
        font-size: 25px;
    }
    .child_title a{
        margin-left: 50px;
        text-decoration: none;
        color: black;
    }
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


 	  function insertProfessor(){
		 var flag = confirm("교직원을 생성 하시겠습니까??");
				 
		 var validArr = [];
	
		 validArr.push($("#entranceDate"));
		 validArr.push($("#professorName"));
		 /* validArr.push($("#collegeNo"));
		 validArr.push($("#departmentNo")); */
		 /* validArr.push($("#professorNo")); */
		 validArr.push($("#professorPwd"));
		 validArr.push($("#admin"));
		 validArr.push($("#position"));
		 validArr.push($("#phone"));
		 validArr.push($("#email"));
		 validArr.push($("#address")); 
		 validArr.push($("#accountNo")); 
		 
		 
		var validInput;
		var loopFlag = true;
		
		
		for(var i = 0 ; i < validArr.length ; i++){
			if(!loopFlag) return false;
			
			validInput = validArr[i];
			if(!validInput.val()){
				alert(validInput.data("name") + "를(을) 입력해주세요.");
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
 		  var depart0 = ["교양"]
 		  var depart1 = ["국어영문학과","영어영문학과","일어일문학과","사학과"];
 		  var depart2 = ["경제경영학과","회계학과","법학과","행정학과"];
 		  var depart3 = ["초등교육과","유아교육과"];
 		  var depart4 = ["생명공학과","수학과","물리학과","통계학과"];
 		  var depart5 = ["건축학과","기계학과","컴퓨터공학과","전자전기과","화학공학과"];
 		  var depart6 = ["시각디자인학과","패션디자인학과"];
 		  var depart7 = ["연극영화과","실용음악과"];
 		  var target = document.getElementById("departmentNo");
 		 
 		 var departmentNo = parseInt(e.value, 10);
 		  
 		  if(e.value=="0") var d = depart0;
 		  else if(e.value=="1") var d =depart1;
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
 	  
 	 function adminChange(e){
		  var admin1 = ["관리자"]
		  var admin2 = ["정교수","부교수","명예교수"]
		  var admin3 = ["행정직원"]
		  var target = document.getElementById("position");
		 
		 var admin = parseInt(e.value, 10);
		  
		  if(e.value=="0") var a = admin1;
		  else if(e.value=="1") var a =admin2;
		  else if(e.value=="2") var a =admin3;
		
		 target.options.length = 0;
		  
		  for (x in a) {
				var opt = document.createElement("option");
				
				opt.value = a[x];
				
				opt.innerHTML = a[x];
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
	    
	    var professorPwd = document.getElementById("professorPwd");
	    if (professorPwd) {
	    	professorPwd.value = randomStr;
	    }
	}
	
	
</script>
</head>
<body>
    <div class="wrap">
		<%@include file="../../common/professor_menubar.jsp" %>
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <h3>학사관리</h3>
                </div>
                <div class="child_title">
                    <a href="#">학생 관리</a>
                </div>
				<div class="child_title">
                    <a href="#" style="color:#00aeff; font-weight: 550;">임직원 관리</a>
                </div>
                <div class="child_title">
                    <a href="#">학사일정 관리</a>
                </div>
            </div>
            <div id="content_1">
            	<br>
					<th><button id="randombtn" onclick="randomPasswordBtn()">비밀번호 생성하기</button></th>
					<form id="insertForm" action="insertProfessor.ad" method="post">
					<div id="basic_info">
						<table class="basic_table">
						<tr>
							<th>기본 정보</th>
							<button id="crystalBtn" onclick="insertProfessor()">등록하기</button>
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
									<th width="100px" height="30px">채용 일자 : </th>
									<th><input type="date" class="user_info3" name="entranceDate" id="entranceDate" data-name="채용 일자"></th>
									<th width="110px" height="30px">이름 : </th>
									<th><input type="text" class="user_info3" id="professorName" maxlength="4" name="professorName"  onkeyup="characterCheck3(this)" onkeydown="characterCheck3(this)" data-name="이름"></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">대학(원) : </th>
									<th>
										<select id="collegeNo" name="collegeNo" class="user_info3" onChange="collegeChange(this)" data-name="대학(원)">
                                            <option>-선택-</option>
                                            <option value="0">교양</option>
                                            <option value="1">인문대학</option>
                                            <option value="2">사회과학대학</option>
                                            <option value="3">교육대학</option>
                                            <option value="4">자연대학</option>
                                            <option value="5">공학대학</option>
                                            <option value="6">미술대학</option>
                                            <option value="7">예술대학</option>
                                        </select>
									</th>
									<th width="120px" height="30px">학과(부) : </th>
									<th>
										<select id="departmentNo" name="departmentNo" class="user_info3" data-name="학과(부)">
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
									<th width="100px" height="30px">교번 : </th>
									<th><input type="text" class="user_info3" name="professorNo" id="professorNo" onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" data-name="교번" readonly placeholder="자동으로 생성"></th>
									<th width="105px" height="30px">비밀번호 : </th>
									<th><input type="text" class="user_info3" id="professorPwd" name="professorPwd" data-name="비밀번호"><th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">부서 : </th>
									<th>
									<select id="admin" name="admin" class="user_info3" onChange="adminChange(this)" data-name="부서">
                                            <option>-선택-</option>
                                            <option value="0">관리자</option>
                                            <option value="1">교수</option>
                                            <option value="2">행정직원</option>
                                    </select>
                                    </th>
									<th width="120px" height="30px">직책 : </th>
									<th>
									<select id="position" name="position" class="user_info3" data-name="직책">
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
									<th width="100px" height="30px">전화번호 : </th>
									<th><input type="text"  class="user_info3" id="phone" name="phone" placeholder="숫자만 입력하세요." maxlength="11" onkeyup="characterCheck2(this)" onkeydown="characterCheck2(this)" data-name="전화번호"/></th>
									<th width="110px" height="30px">E-MAIL : </th>
									<th><input type="text" id="email" name="email" class="user_info3" placeholder="example@example.com" onkeyup="characterCheck4(this)" onkeydown="characterCheck4(this)" data-name="E-MAIL"></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">주소 : </th>
									<th><input type="text" id="address" name="address" class="user_info4" data-name="주소"></th>
									<th width="100px" height="30px">우편번호 : </th>
									<th><input type="text" id="post" name="post" class="user_info4" readonly></th>
									<th width="100px" height="30px">계좌번호 : </th>
									<th><input type="text" id="accountNo" name="accountNo" placeholder="-사용하여 입력해주세요" class="user_info4" maxlength="20" onkeyup="characterCheck5(this)" onkeydown="characterCheck5(this)" data-name="계좌번호"></th>
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