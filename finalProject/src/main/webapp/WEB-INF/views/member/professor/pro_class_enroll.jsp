<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="wrap">
    	<%@include file="../../common/professor_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">큰제목</span>
                </div>
                <div class="child_title">
                    <a href="#">소제목</a>
                </div>
            </div>
            <div id="content_1">
				<h3>강의개설 신청</h3>
                <div style="border-top:1px solid black">
                    <form action="">
                        
                        <table id="class_enroll">
                            <tr>
                                <td>개설학과 </td>
                                <td><input type="text" name="" id="" value="정보가져와서 넣을예정" readonly></td>
                                <td>교수명</td>
                                <td><input type="text" name="" id="" value="정보가져와서 넣을예정" readonly></td>
                                <td>강의명</td>
                                <td><input type="text" name="className" id=""></td>
                            </tr>
                            <tr>
                                <td>전공여부</td>
                                <td>
                                    <select name="division" id="division" onchange="changeDivision(this)">
                                        <option value="1">전공</option>
                                        <option value="0">교양</option>
                                    </select>
                                </td>
                                <td>이수학점</td>
                                <td>
                                    <select name="credit" id="credit">

                                    </select>
                                </td>
                                <td>수강인원</td>
                                <td><input type="text" name="classNos" id=""></td>
                            </tr>
                            <tr>
                                <td>학년도</td>
                                <td><select name="classYear" id="classYear"></select></td>
                                <td>학기</td>
                                <td><select name="classTerm" id="classTerm"></select></td>
                                <td>강의실</td>
                                <td><input type="text" name="classroom" id=""></td>
                            </tr>
                            <tr>
                                <td>요일</td>
                                <td>
                                    <select name="day" id="day">
                                        <option value="1">월요일</option>
                                        <option value="2">화요일</option>
                                        <option value="3">수요일</option>
                                        <option value="4">목요일</option>
                                        <option value="5">금요일</option>
                                    </select>
                                </td>
                                <td>교시</td>
                                <td>
                                    <select name="period" onchange="changePeriod(this)">
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
                                    <select name="classHour" id="classHour">
                                        <option value="1">1시간</option>
                                        <option value="2">2시간</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>수강대상</td>
                                <td>
                                    <select name="" id="">
                                        <option value="0">전학년</option>
                                        <option value="1">1학년</option>
                                        <option value="2">2학년</option>
                                        <option value="3">3학년</option>
                                        <option value="4">4학년</option>
                                    </select>
                                </td>
                                <td>첨부파일</td>
                                <td colspan="2"><input type="file" name="" id=""></td>
                                
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function(){//신청날짜에 따라 자동으로 학년도,학기 입력
            var today = new Date(); //오늘 날짜 가져옴
            var now = new Date(today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate()); //오늘기준 월-일
            var year = today.getFullYear();//학년도에 붙일 연도 가져옴
            //var one = new Date("1-1");  
            var two = new Date(today.getFullYear()+"-"+"6-30"); //2학기 신청기준, 학사일정 생기면 대체 가능
            var select = document.querySelector("#classTerm");//학기 가져옴
            var classYear = document.querySelector("#classYear");//학년도 가져옴
        
            if(now.getTime()>two.getTime()){ //2학기 신청기준이 넘었으면(getTime은 시간끼리 >비교하게 해줌)
                select.options[select.options.length]=new Option("1학기",1);
                classYear.options[classYear.options.length]=new Option((year+1+"년"),year+1);
            }else{
                select.options[select.options.length]=new Option("2학기",2);
                classYear.options[classYear.options.length]=new Option((year+"년"),year);
            };
            $("#division").val(1).trigger("change");//기본으로 전공 골라져있으니 전공옵션띄우기
        })
        
        function changeDivision(target){ //전공or교양 고른거에 따라 학점 옵션 바꿔주기
            var division = target.value;//전공or교양 셀렉트 가져옴
            var credit = document.querySelector("#credit");//학점 셀렉트 가져옴
            
            credit.options.length=0; // 학점 셀렉트 비우기
            if(division==1){
                credit.options[credit.options.length]=new Option("3학점",3);
            }else{
                credit.options[credit.options.length]=new Option("2학점",2);
                credit.options[credit.options.length]=new Option("1학점",1);
            }
        }
        
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
        
    </script>
</body>
</html>