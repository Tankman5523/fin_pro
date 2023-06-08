<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학기별 성적 조회</title>
<style>
    .b_line {
        border: 0.5px solid lightgray;
        margin: 20px 0px;
    }

    .page_title {
        margin-top: 5px;
        margin-left: 5px;
        margin-bottom: 0px;
        font-weight: bold;
    }

    .wholeGrade-area {
        width: 100%;
        height: 25%;
        overflow: auto;
    }
    
    .wholeGrade-table {
        width: 100%;
        height: 100%;
        text-align: center;
    }
    
    .wholeGrade-table>thead {
        background-color: rgb(250, 250, 133);
        position: sticky;
        top: 0;
    }
    
    .transcript {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    
    .transcript * {
        margin: 0 5px;
    }

    .transcript>input {
        width: 150px;
    }

    .selectTerm {
        display: flex;
        align-items: center;
    }

    .selectTerm * {
        margin-left: 10px;
    }

    button[class*=btn] {
        border-radius: 10px;
    }

    .prev-btn {
        margin-left: 30px;
    }

    .next-btn {
        margin-left: 10px;
    }

    .termGrade-area {
        width: 100%;
        height: 25%;
        overflow: auto;
    }

    .termGrade-table {
        width: 100%;
        height: 100%;
        text-align: center;
    }

    .termGrade-table>thead {
        background-color: rgb(250, 250, 133);
        position: sticky;
        top: 0;
    }
</style>
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/student_menubar.jsp" %>
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">수업관리</span>
                </div>
                <div class="child_title">
                    <a href="student_classManagement.bo" style="color:#00aeff; font-weight: 550;">학기별 성적 조회</a>
                </div>
                <div class="child_title">
                    <a href="#">성적 이의신청</a>
                </div>
            </div>
            <div id="content_1">
                <br>
				<span class="page_title">학기별 성적</span>
                <div class="b_line"></div>

                <div class="wholeGrade-area">
                    <table class="wholeGrade-table">
                        <thead>
                            <tr>
                                <th>학년도</th>
                                <th>학기</th>
                                <th>신청학점</th>
                                <th>취득학점</th>
                                <th>평점계</th>
                                <th>학기별석차</th>
                                <th>전체석차</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>2022</td>
                                <td>2학기</td>
                                <td>18</td>
                                <td>18</td>
                                <td>3.81</td>
                                <td>6/32</td>
                                <td>28/120</td>
                            </tr>
                            <tr>
                                <td>2022</td>
                                <td>1학기</td>
                                <td>18</td>
                                <td>18</td>
                                <td>3.81</td>
                                <td>6/32</td>
                                <td>28/120</td>
                            </tr>
                            <tr>
                                <td>2021</td>
                                <td>2학기</td>
                                <td>18</td>
                                <td>18</td>
                                <td>3.81</td>
                                <td>6/32</td>
                                <td>28/120</td>
                            </tr>
                            <tr>
                                <td>2021</td>
                                <td>1학기</td>
                                <td>18</td>
                                <td>18</td>
                                <td>3.81</td>
                                <td>6/32</td>
                                <td>28/120</td>
                            </tr>
                            <tr>
                                <td>2020</td>
                                <td>2학기</td>
                                <td>18</td>
                                <td>18</td>
                                <td>3.81</td>
                                <td>6/32</td>
                                <td>28/120</td>
                            </tr>
                            <tr>
                                <td>2020</td>
                                <td>1학기</td>
                                <td>18</td>
                                <td>18</td>
                                <td>3.81</td>
                                <td>6/32</td>
                                <td>28/120</td>
                            </tr>
                            <tr>
                                <td>2020</td>
                                <td>1학기</td>
                                <td>18</td>
                                <td>18</td>
                                <td>3.81</td>
                                <td>6/32</td>
                                <td>28/120</td>
                            </tr>
                            <tr>
                                <td>2020</td>
                                <td>1학기</td>
                                <td>18</td>
                                <td>18</td>
                                <td>3.81</td>
                                <td>6/32</td>
                                <td>28/120</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="b_line"></div>
                
                <div class="transcript">
                    <span>증명신청학점:</span> <input type="text" id="" value="130" readonly>
                    <span>증명취득학점:</span> <input type="text" id="" value="130" readonly> 
                    <span>증명평점계:</span> <input type="text" id="" value="3.8"eadonly>
                    <span>증명평점평균:</span> <input type="text" id="" value="92" readonly>
                </div>
                <div class="b_line"></div>

                <div class="selectTerm">
                    <span>학년도: </span> <select name="year" id="year" onchange="changeYear();">
                                            <option value="2022">2022학년도</option>
                                            <option value="2021">2021학년도</option>
                                            <option value="2020">2020년도</option>
                                        </select>
                    <span>학기: </span> <select name="term" id="term">
                                            <option value="1">1학기</option>
                                            <option value="2">2학기</option>
                                       </select>
                    <button type="button" class="btn btn-primary btn-sm prev-btn">&lt; 이전학기</button>
                    <button type="button" class="btn btn-primary btn-sm next-btn">다음학기 &gt;</button>
                </div>
                <br>

                <div class="termGrade-area">
                    <table class="termGrade-table"> <!--셀렉트박스에 해당되는 성적들 ajax로 가져오기-->
                        <thead>
                            <tr>
                                <th>이수학년도</th>
                                <th>이수학기</th>
                                <th>과목번호</th>
                                <th>과목명</th>
                                <th>과목학점</th>
                                <th>성적</th>
                                <th>등급</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>2022년도</td>
                                <td>2학기</td>
                                <td>12345678</td>
                                <td>프로그래밍언어</td>
                                <td>3.0</td>
                                <td>78</td>
                                <td>C0</td>
                            </tr>
                            <tr>
                                <td>2022년도</td>
                                <td>2학기</td>
                                <td>12345678</td>
                                <td>프로그래밍언어</td>
                                <td>3.0</td>
                                <td>78</td>
                                <td>C0</td>
                            </tr>
                            <tr>
                                <td>2022년도</td>
                                <td>2학기</td>
                                <td>12345678</td>
                                <td>프로그래밍언어</td>
                                <td>3.0</td>
                                <td>78</td>
                                <td>C0</td>
                            </tr>
                            <tr>
                                <td>2022년도</td>
                                <td>2학기</td>
                                <td>12345678</td>
                                <td>프로그래밍언어</td>
                                <td>3.0</td>
                                <td>78</td>
                                <td>C0</td>
                            </tr>
                            <tr>
                                <td>2022년도</td>
                                <td>2학기</td>
                                <td>12345678</td>
                                <td>프로그래밍언어</td>
                                <td>3.0</td>
                                <td>78</td>
                                <td>C0</td>
                            </tr>
                            <tr>
                                <td>2022년도</td>
                                <td>2학기</td>
                                <td>12345678</td>
                                <td>프로그래밍언어</td>
                                <td>3.0</td>
                                <td>78</td>
                                <td>C0</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <script>
                    $(function() {
                        
                    })

                    function changeYear() { // 해당 년도에 맞는 학기만 띄워줘야함
                        // $("<option value='3'>3학기</option>").appendTo("#term");
                    }
                </script>
            </div>
        </div>
    </div>
</body>
</html>