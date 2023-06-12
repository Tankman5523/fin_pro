<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
 	


</style>


<script>
	var msg = "${msg}";
	
	$(document).ready(function(){
		if(msg != ""){
			alert(msg);
		}
	});
	
	
	 function updateStudent(){
		 var flag = confirm("수정하시겠습니까?");
		 
		 if(flag){
			 $("#updateForm").submit();	 
		 }else{
			 return false;
		 }
 	  }
	
	 function convertReadonly(){
		 $("#crystalBtn").attr("onclick", "updateStudent()");
	 }
	 
	
	/* function convertReadonly(){
		$("#phone").prop("readonly" , false);
		$("#email").prop("readonly" , false);
		$("#post").prop("readonly" , false);
		$("#address").prop("readonly" , false );
		
		$("#crystalBtn").attr("onclick", "updateStudent()");
		
	}
	
	
	function changeReadonly(){
		
	} */ 
	
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
	
</script>
</head>
<body>
    <div class="wrap">
		<%@include file="../../common/student_menubar.jsp" %>

        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">학사관리</span>
                </div>
                <div class="child_title">
                    <a href="#" style="color:#00aeff; font-weight: 550;">학적 정보 조회</a>
                </div>
				<div class="child_title">
                    <a href="personalTimetable.st">개인 시간표</a>
                </div>
				<div class="child_title">
                    <a href="#">휴/복학 신청</a>
                </div>
				<div class="child_title">
                    <a href="#">휴/복학 조회</a>
                </div>
				<div class="child_title">
                    <a href="#">졸업사정표</a>
                </div>
				<div class="child_title">
                    <a href="#">졸업 확정 신고</a>
                </div>
            </div>
            <div id="content_1">
					<div>
						<ul>
							<img src="https://item.kakaocdn.net/do/1bc37545ead4d1b5ccf3af23d5bce5714022de826f725e10df604bf1b9725cfd" style="width:100px; height:100px;" alt="학생얼굴">
						</ul>
					</div>
					<div id="basic_info">
						<table class="basic_table">
							<th>기본 정보</th>
							<!-- <button id="crystalBtn" onclick="convertReadonly()">수정하기</button> -->
							<button id="crystalBtn" onclick="updateStudent()">수정하기</button>
						
							
						</table>
						<br>
						<hr>
					</div>
					<form id="updateForm" action="updateStudent.st" method="post">
					<input type="hidden" id="studentNo" name="studentNo" value="${loginUser.studentNo }">
					<div id="user_infomation">
						<table id="user_info">
							<thead>
								<tr>
									<th width="100px" height="30px">입학 년도 : </th>
									<th><input type="text" class="user_info3" value="${loginUser.entranceDate}" readonly></th>
									<th width="100px" height="30px">대학(원) : </th>
									<th><input type="text" class="user_info3" value="${loginUser.collegeNo}" readonly></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">학번 : </th>
									<th><input type="text" class="user_info3" value="${loginUser.studentNo}" readonly></th>
									<th width="100px" height="30px">학과(부) : </th>
									<th><input type="text" class="user_info3" value="${loginUser.departmentNo}" readonly></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">이름 : </th>
									<th><input type="text" class="user_info3" value="${loginUser.studentName}" readonly></th>
									<th width="100px" height="30px">비밀번호 : </th>
									<th><input type="password" id="studentPwd" name="studentPwd" class="user_info3" value="${loginUser.studentPwd}" readonly></th>
									
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">학년 : </th>
									<th><input type="text" class="user_info3" value="${loginUser.classLevel}" readonly></th>
									<th width="100px" height="30px">학기 : </th>
									<th><input type="text" class="user_info3" value="${loginUser.entranceDate}" readonly></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">전화번호 : </th>
									<th><input type="text" id="phone" name="phone" class="user_info3" value="${loginUser.phone}"></th>
									<th width="100px" height="30px">E-MAIL : </th>
									<th><input type="text" id="email" name="email" class="user_info3" value="${loginUser.email}"></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">우편번호 : </th>
									<th><input type="text" id="post" name="post" class="user_info3" value="${loginUser.post}"></th>
									<th width="100px" height="30px">주소 : </th>
									<th><input type="text" id="address" name="address" class="user_info3" value="${loginUser.address}" ></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">졸업년도 : </th>
									<th><input type="text" class="user_info3" value="${loginUser.graduationDate}" readonly></th>
									<th width="100px" height="30px">학적상태 : </th>
									<th><input type="text" class="user_info3" value="${loginUser.status}" readonly></th>
								</tr>
							</thead>
						</table>
					</form>
					</div>

            </div>
        </div>
    </div>
</body>
</html>