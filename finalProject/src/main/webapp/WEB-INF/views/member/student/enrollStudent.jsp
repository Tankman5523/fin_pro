<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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


</style>
<script>

	$(document).ready(function(){
		
	});
	
	function insertStudent(){
		$("#crystalBtn").attr("form", "insertForm");
		$("insertForm").submit();
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

</script>
</head>
<body>
    <div class="wrap">
		<div id="header">
			<div id="header_1">
				<table id="user_log">
					 <tr>
						 <td>
							 님 환영합니다.
						 </td>
						 <td style="padding-left: 50px;">
							 <button id="logout-btn" onclick="">로그아웃</button>
						 </td>
					 </tr>
				 </table>
			</div>
		</div>
		<div id="menubar">
			<ul id="nav">
				<li><a href="#">홈</a></li>
				<li><a href="#">급전관리</a></li>
				<li><a href="#">학사관리</a></li>
				<li><a href="#">강의관리</a></li>
			</ul>
		</div>


        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <h3>학사관리</h3>
                </div>
                <div class="child_title">
                    <a href="enrollStudent.ad">학생관리</a>
                </div>
				<div class="child_title">
                    <a href="#">임직원관리</a>
                </div>
            </div>
            <div id="content_1">
					<div>
						<ul>
							<img src="https://item.kakaocdn.net/do/1bc37545ead4d1b5ccf3af23d5bce5714022de826f725e10df604bf1b9725cfd" style="width:100px; height:100px;" alt="학생얼굴">
						</ul>
					</div>
					<form id="insertForm" action="insertStudent.me" method="post"></form>
					<div id="basic_info">
						<table class="basic_table">
							<th>기본 정보</th>
							<button id="crystalBtn" type="submit">학생등록</button>
						</table>
						<br>
						<hr>
					</div>
					<div id="user_infomation">
						<table id="user_info">
							<thead>
								<tr>
									<th width="100px" height="30px">입학 년도 : </th>
									<th><input type="text" class="user_info3" id="entranceDate" placeholder="숫자로만 입력하세요 (ex)2023"></th>
									<th width="100px" height="30px">대학(원) : </th>
									<th>
                                        <label for="department">
                                            <select name="collage" id="collage">
                                            <option value="">인문대학</option>
                                            <option value="">사회과학대학</option>
                                            <option value="">교육대학</option>
                                            <option value="">자연대학</option>
                                            <option value="">공학대학</option>
                                            <option value="">미술대학</option>
                                            <option value="">예술대학</option>
                                        </select>
                                        </label>
                                    </th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">학번 : </th>
									<th><input type="text" class="user_info3" id="studentNo" placeholder="(ex)P20230001"></th>
									<th width="100px" height="30px">학과(부) : </th>
									<th>
                                        <label for="department">
                                            <select name="collage" id="department">
                                                <option value="">국어국문학과</option>
                                                <option value="">영어영문학과</option>
                                                <option value="">일어일문학과</option>
                                                <option value="">사학과</option>
                                                <option value="">경제경영학과</option>
                                                <option value="">회계학과</option>
                                                <option value="">법학과</option>
                                                <option value="">행정학과</option>
                                                <option value="">초등교육과</option>
                                                <option value="">유아교육과</option>
                                                <option value="">생명공학과</option>
                                                <option value="">수학과</option>
                                                <option value="">물리학과</option>
                                                <option value="">통계학과</option>
                                                <option value="">건축학과</option>
                                                <option value="">기계학과</option>
                                                <option value="">컴퓨터공학과</option>
                                                <option value="">전자전기과</option>
                                                <option value="">화학공학과</option>
                                                <option value="">시각디자인학과</option>
                                                <option value="">패션디자인학과</option>
                                                <option value="">연극영화과</option>
                                                <option value="">실용음악과</option>
                                            </select>
                                        </label>
                                    </th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">이름 : </th>
									<th><input type="text" class="user_info3" id="name"></th>
									<th width="100px" height="30px">비밀번호 : </th>
									<th><input type="password" class="user_info3" id="password" placeholder="비밀번호를 입력하세요"></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">전화번호 : </th>
									<th><input type="tel" class="user_info3" id="phone" placeholder="(-없이) 입력하세요"></th>
									<th width="100px" height="30px">E-MAIL : </th>
									<th><input type="email" class="user_info3" id="email" placeholder="Email"></th>
								</tr>
							</thead>
						</table>
						<br>
						<table class="user_info2">
							<thead>
								<tr>
									<th width="100px" height="30px">우편번호 : </th>
									<th><input type="text" class="user_info3" id="post"></th>
									<th width="100px" height="30px">주소 : </th>
									<th><input type="text" class="user_info3" id="address"></th>
								</tr>
							</thead>
						</table>
						<br>
					</div>

            </div>
        </div>
    </div>
</body>
</html>