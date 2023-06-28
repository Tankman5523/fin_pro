<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/studentPageStylesheet.css">
</head>
<style>
	.counselingCategory{
        list-style: none;
        
    }
    .counselingCategory>li{
        text-align: center;
        float: left;
        margin: 5px;
        margin-top : 9px;
        margin-left : 30px;
    }
    
    td>input,textarea{
    	text-align:center;
        border: 0px;
    }
    .litle_title{
        width:20%;
    }
    .coun_input{
        width:30%;
    }
    #modalWrap {
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }


    #modalBody {
    width: 500px;
    height: 300px;
    padding: 30px 30px;
    margin: 0 auto;
    border: 1px solid #777;
    background-color: #fff;
    }


    #closeBtn {
    float:right;
    font-weight: bold;
    color: #777;
    font-size:25px;
    cursor: pointer;
    }
</style>
<body>
    <div class="wrap">
    	<%@include file="../../common/student_menubar.jsp" %>
    	<%@include file="../../common/datepicker.jsp" %>
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">상담관리</span>
                </div>
                <div class="child_title">
                    <a href="counselingList.st">상담이력조회</a>
                </div>
                <div class="child_title">
                    <a href="counselingEnroll.st" style="color:#00aeff; font-weight: 550;">상담신청</a>
                </div>
            </div>
            <div id="content_1" align="center" style="padding-top: 5%;">
				<form action="insertCounseling.st" method="post">
                    <input type="hidden" id="pno" name="ProfessorNo">
                    <input type="hidden" name="studentNo" value="${loginUser.studentNo}">
                    <table border="1" style="width: 80%; text-align: center;">
                        <tr style="width: 1;">
                            <td class="litle_title">상담교직원</td>
                            <td class="coun_input" align="right">
                                <input type="text" name="professor" id="pro_name" style="border:0px; margin-right: 13px" readonly >
                                <button type="button" id="pro_modal"><i class="fa-solid fa-magnifying-glass"></i></button>
                                
                            </td>
                            <td class="litle_title">학생명</td>
                            <td class="coun_input"><input type="text" value="${loginUser.studentName}" readonly></td>
                        </tr>
                        <tr>
                            <td class="litle_title">학과</td>
                            <td class="coun_input"><input type="text" id="pro_depa" readonly></td>
                            <td class="litle_title">학과</td>
                            <td class="coun_input"><input type="text" value="${loginUser.departmentNo }" readonly></td>
                        </tr>
                        <tr>
                            <td class="litle_title">직책</td>
                            <td class="coun_input"><input type="text" id="pro_posi" readonly></td>
                            <td class="litle_title">학생번호</td>
                            <td class="coun_input"><input type="text" value="${loginUser.studentNo}" readonly></td>
                        </tr>
                        <tr>
                            <td class="litle_title">이메일</td>
                            <td class="coun_input"><input type="text" id="pro_email" readonly></td>
                            <td class="litle_title">학생 전화번호</td>
                            <td class="coun_input"><input type="text" value="${loginUser.phone}" readonly></td>
                        </tr>
                        <tr>
                            <td class="litle_title">상담희망일자</td>
                            <td class="coun_input"><input type="text" name="requestDate" class="datepicker" required></td>
                            <td class="litle_title">상담신청일자</td>
                            <td class="coun_input"><input type="text"  id="today" readonly></td>
                        </tr>
                        <tr>
                            <td rowspan="2" class="litle_title">상담요청영역</td>
                            <td colspan="3">
                                <ul class="counselingCategory">
                                    <li>
                                        <label>
                                            <input type="radio" name="counselArea" value="진로(취업)" required>
                                            	진로(취업)
                                        </label>
                                    </li>
                                    <li>
                                        <label >
                                            <input type="radio" name="counselArea" value="학교생활">
                                            	학교생활
                                        </label>
                                    </li>
                                    <li>
                                        <label>
                                            <input type="radio" name="counselArea" value="학사(출결)">
                                            	학사(출결)
                                        </label>
                                    </li>
                                    <li>
                                        <label>
                                            <input type="radio" name="counselArea" value="심리정서">
                                            	심리정서
                                        </label>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <ul class="counselingCategory">
                                    <li>
                                        <label>
                                            <input type="radio" name="counselArea" value="학사(제적)">
                                            	학사(제적)
                                        </label>
                                    </li>
                                    <li>
                                        <label>
                                            <input type="radio" name="counselArea" value="학사행정">
                                            	학사행정
                                        </label>
                                    </li>
                                    <li>
                                        <label>
                                            <input type="radio" name="counselArea" value="학사(휴학)">
                                            	학사(휴학)
                                        </label>
                                    </li>
                                    <li>
                                        <label>
                                            <input type="radio" name="counselArea" value="기타">
                                            	기타
                                        </label>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td class="litle_title">상담요청내용</td>
                            <td colspan="3">
                                <textarea name="counselContent" cols="100" rows="10" style="resize: none;" required></textarea>
                            </td>
                        </tr>
                    </table>
                    <div style="margin-top: 5%;">
                        <button type="reset" class="btn btn-secondary">이전</button>
                        <button type="submit" class="btn btn-primary" style="margin-left: 2%;">전송</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="modalWrap" style="display: none;">
        <div id="modalContent">
            <div id="modalBody">
            <h4>상담 교수님을 선택해주세요.</h4>
            <span id="closeBtn">&times;</span> 
                <table border="1" style="width: 100%;text-align: center;" id="pro_list">
                	<thead>
                		<tr>
                            <th>교수명</th>
                            <th>학과</th>
                            <th>직책</th>
                            <th>이메일</th>
                            <th style="display: none;">직번</th>
                        </tr>
                	</thead>
                    <tbody>
                    	
                        
                	</tbody>
                    
                </table>
                
            </div>
        </div>
      </div>
    <script>
        $(function(){         
        
            var today = new Date(); //오늘 날짜 가져옴
            var month = ("0"+(today.getMonth()+1)).slice(-2); //월 앞에 0 붙이고 10이상일수 있으니 뒤에서 2자리로 자름
            var date = ("0"+today.getDate()).slice(-2); // 위와 동일
            var now = today.getFullYear()+"-"+month+"-"+date; //오늘기준 년-월-일
            $("#today").val(now);

            $(".datepicker").datepicker({
                minDate:now
            })
        
        });
        
        function choicePro(){
        	$("#pro_list>tbody>tr").click(function(){
                var pro_name = $(this).children().eq(0).html(); //교수님 이름
                var pro_depa = $(this).children().eq(1).html(); //교수님 학과
                var pro_posi = $(this).children().eq(2).html(); //교수님 직책
                var pro_email = $(this).children().eq(3).html(); //교수님 이메일
                var pno = $(this).children().eq(4).html(); //교수님 직번 학생한테 안보임

                //테이블안에 고른 교수 정보 넣기
                $("#pro_name").val(pro_name);
                $("#pro_depa").val(pro_depa);
                $("#pro_posi").val(pro_posi);
                $("#pro_email").val(pro_email);
                $("#pno").val(pno);//form으로 보낼 교수번호 hidden으로 보내기
                
                
                document.getElementById('modalWrap').style.display = "none"; //골랐으면 모달창 닫기
                
            }) 
        }
        
        //밑에는 모달 위한 스크립트
        const btn = document.getElementById('pro_modal'); //모달 키는 버튼
        const modal = document.getElementById('modalWrap'); //모달
        const closeBtn = document.getElementById('closeBtn'); //모달안에 모달 닫는 버튼
        

        btn.onclick = function() { //모달 키기
        	var departmentNo = "${loginUser.departmentNo}";
        	$.ajax({
        		url:"departmentProList.st",
        		data:{departmentNo:departmentNo},
        		success:function(list){
        			console.log(list);
        			var result = "";
        			
        			for(var i=0; i<list.length; i++){
        				result += "<tr onclick='choicePro();'>"
        						+"<td>"+list[i].professorName+"</td>"
        						+"<td>"+list[i].departmentNo+"</td>"
        						+"<td>"+list[i].position+"</td>"
        						+"<td>"+list[i].email+"</td>"
        						+"<td style='display: none;'>"+list[i].professorNo+"</td>"
        						+"</tr>"
        			}
        			$("#pro_list>tbody").html(result);
        		},
        		error:function(){
        			alert("통신 오류");
        		}
        	})
            modal.style.display = 'block';
        }
        
        closeBtn.onclick = function() { //모달 닫기
            modal.style.display = 'none';
        }
        
		
        window.onclick = function(event) { //모달 밖에 누르면 모달 닫히게 하기
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
		
    </script>
</body>
</html>