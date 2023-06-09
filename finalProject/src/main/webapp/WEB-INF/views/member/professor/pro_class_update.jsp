<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려 강의 수정 페이지</title>
<link rel="stylesheet" href="/fin/resources/css/classCreateView.css">
</head>
<body>
    <div class="wrap">
    	<%@include file="../../common/professor_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">강의관리</span>
                </div>
                <div class="child_title">
                    <a href="classCreateSelect.pr" style="color:#00aeff; font-weight: 550;">강의개설신청 내역</a>
                </div>
                <div class="child_title">
                    <a href="classCreateEnroll.pr">강의 개설 신청</a>
                </div>
            </div>
            <div id="content_1">
				<span id="content_title">강의개설 신청</span>
                <div style="border-top:2px solid lightblue">
                    <form action="classCreateUpdate.pr" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="classNo" value="${c.classNo}">
                        <table id="class_enroll" class="table">
                            <tr>
                                <td>개설학과 </td>
                                <td><input type="text" value="${c.departmentNo }" disabled></td>
                                <td>교수명</td>
                                <td><input type="text" value="${c.professorNo }" disabled></td>
                                <td>*강의명</td>
                                <td><input type="text"  name="className" value="${c.className }" placeholder="최대 16글자"></td>
                            </tr>
                            <tr>
                                <td>전공여부</td>
                                <td>
                                    <select name="division"  id="division" onchange="changeDivision(this)">
                                        <option value="0">전공</option>
                                        <option value="1">교양</option>
                                    </select>
                                </td>
                                <td>이수학점</td>
                                <td>
                                    <select name="credit"  id="credit">

                                    </select>
                                </td>
                                <td>*수강인원</td>
                                <td><input type="text" name="classNos"  maxlength="2" placeholder="ex)20" value="${c.classNos}"></td>
                            </tr>
                            <tr>
                                <td>학년도</td>
                                <td><input type="text" name="classYear" value="${c.classYear}" readonly></td>
                                <td>학기</td>
                                <td><input type="text" name="classTerm" value="${c.classTerm}" readonly></td>
                                <td>*강의실</td>
                                <td><input type="text" name="classroom" value="${c.classroom}"  placeholder="ex)태양관 101호"></td>
                            </tr>
                            <tr>
                                <td>요일</td>
                                <td>
                                    <select name="day"  id="day">
                                        <option value="1">월요일</option>
                                        <option value="2">화요일</option>
                                        <option value="3">수요일</option>
                                        <option value="4">목요일</option>
                                        <option value="5">금요일</option>
                                    </select>
                                </td>
                                <td>교시</td>
                                <td>
                                    <select name="period" id="period"  onchange="changePeriod(this)">
                                        <option value="1">1교시</option>
                                        <option value="2">2교시</option>
                                        <option value="3">3교시</option>
                                        <option value="4">4교시</option>
                                        <option value="5">5교시</option>
                                        <option value="6">6교시</option>
                                        <option value="7">7교시</option>
                                        <option value="8">8교시</option>
                                        <option value="9">9교시</option>
                                        <option value="10">10교시</option>
                                    </select>
                                </td>
                                <td>수업시간</td>
                                <td>
                                    <select name="classHour"  id="classHour">
                                        <option value="1">1시간</option>
                                        <option value="2">2시간</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>수강대상</td>
                                <td>
                                    <select name="classLevel" id="classLevel">
                                        <option value="0">전학년</option>
                                        <option value="1">1학년</option>
                                        <option value="2">2학년</option>
                                        <option value="3">3학년</option>
                                        <option value="4">4학년</option>
                                    </select>
                                </td>
                                <td>첨부파일</td>
                                <td colspan="2" style="padding:0px;">
                        			<div class="filebox">
                                	<c:choose>
	                                	<c:when test="${not empty a}">
	                                		<a href="${a.filePath}${a.changeName}" id="download" download="${a.originName}">
	                        					<input class="upload-name" placeholder="강의계획서" style="width:58%" value="${a.originName}" required>
	                        				</a>
	                        				<input type="hidden" name="fileNo" value="${a.fileNo}">
	                        				<input type="hidden" name="originFileName" value="${a.changeName}">
	                                	</c:when>
	                                	<c:otherwise>
	                                		<input class="upload-name" placeholder="강의계획서" style="width:58%" value="" required>
	                                	</c:otherwise>
                                	</c:choose>
								    	<label for="file">파일찾기</label> 
								    	<input type="file" name="reUpfile" id="file">
                        			</div>
                                </td>
                            </tr>
                            <tr>
                            	<td><span id="explain">반려사유</span></td>
                            	<td colspan="5">
                            		<textarea rows="2" cols="115" style="resize:none;" readonly>${c.explain }</textarea>
                            	</td>
                            </tr>
                        </table>
                        
                        <div style="text-align:center">
                        	<button type="reset" class="btn btn-secondary btn-lg">되돌리기</button>
                        	<button type="submit" class="btn btn-primary btn-lg">신청</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function(){//신청날짜에 따라 자동으로 학년도,학기 입력
            var division = ${c.division}; //전공(0),교양(1)
            var credit = ${c.credit}; //이수학점 전공이면 3학점, 교양은 2 or 1학점
            var day = "${c.day}"; //수업 요일
            var period = "${c.period}"; //수업 교시
            var classHour = ${c.classHour}; //수업 시간 1 or 2 시간
            var classLevel = ${c.classLevel}; //수업대상 학년 0이면 전학년
            
            console.log("교시"+period);
            console.log("수업대상"+classLevel);
            
            $("#division").val(division).trigger("change");//전공 or 교양 선택
            if(division == 1){//만약 교양이면 1학점 or 2학점 선택해야함
            	$("#credit").val(credit).prop("selected",true);
            }
            $("#day").val(day).prop("selected",true);
            $("#period").val(period).prop("selected",true);
            $("#classHour").val(classHour).prop("selected",true);
            $("#classLevel").val(classLevel).prop("selected",true);
            
            //$("#division").val(division).prop("selected",true);
        	
        })
        
        function changeDivision(target){ //전공or교양 고른거에 따라 학점 옵션 바꿔주기
        	console.log(target);
            var division = target.value;//전공or교양 셀렉트 가져옴
            var credit = document.querySelector("#credit");//학점 셀렉트 가져옴
            
            credit.options.length=0; // 학점 셀렉트 비우기
            if(division==0){
                credit.options[credit.options.length]=new Option("3학점",3);
            }else{
                credit.options[credit.options.length]=new Option("2학점",2);
                credit.options[credit.options.length]=new Option("1학점",1);
            }
        }
        
        $("#file").on('change',function(){//첨부파일 올리면
        	var fileName = $("#file").val().split('/').pop().split('\\').pop();
        	$(".upload-name").val(fileName);//첨부파일 이름 보여주는곳에 올림
        	$("#download").prop("href","javascript:void(0);");//기존 파일 다운로드경로를 막음
        });
        
        function changePeriod(target){//10교시 골랐을때 2시간 수업 없애기
            var p = target.value; //몇교시 골랐는지
            var hour = document.querySelector("#classHour");//교시 셀렉트 가져옴
            
            if(p==10){ //10교시를 골랐다면 
                hour.options[1]=null;
            }else if(hour.options.length==1){//10교시 골랐다가 바꿀경우
                //2교시 추가
                hour.options[hour.options.length]=new Option("2교시",2);
            }
        }
        
        $("button[type='reset']").click(function(){
        	var credit = document.querySelector("#credit");
        	credit.options.length=0;
        	credit.options[credit.options.length]=new Option("3학점",3);
        })
        
    </script>
</body>
</html>