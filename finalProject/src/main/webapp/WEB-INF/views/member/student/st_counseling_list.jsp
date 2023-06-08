<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
		.search_ul{
            
            list-style: none;
        }
        .option{
            margin-top: 10px;
            width:33%;
            height:50%;
            float: left;
            
        }
        #datepicker1,#datepicker2{
            width: 35%;
        }
</style>
<body>
    <div class="wrap">
    	<%@include file="../../common/student_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%>
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
                        <a href="counselingEnroll.st">상담신청</a>
                    </div>
                </div>
                <div id="content_1">
                    <div id="search" style="border-bottom:1px solid black; height:10%">
                        <form action="counselingSearch.st" id="searchForm">
                            <ul class="search_ul">
                                <li class="option">
                                    	학년도 
                                    <select name="" id="">
                                            <option value="">===전체===</option>
                                            <option value=""></option>
                                    </select>
                                </li>
                                <li class="option">
                                    	상담종류 
                                    <select name="" id="">
                                        <option value="">===전체===</option>
                                        <option value="">진로(취업)</option>
                                        <option value="">학사(제적)</option>
                                        <option value="">학사(휴학)</option>
                                        <option value="">학사(출결)</option>
                                        <option value="">학사행정</option>
                                        <option value="">학교생활</option>
                                        <option value="">심리정서</option>
                                        <option value="">기타</option>
                                    </select>
                                </li>
                                <li class="option">
                                    	상담일 
                                    <input type="text" id="datepicker1"name="start">
                                     ~ 
                                    <input type="text" id="datepicker2"name="end">
                                </li>
                            </ul>
                            
                        
                        </form>
                    </div>
                    <div style="text-align: right; margin-right:40px">
                        <button type="submit" form="searchForm">조회</button>
                    </div>
                    <div align="center">
                        <table border="1" style="width:80%; text-align: center;" >
                            <thead>
                                <tr>
                                    <th>상담요청일자</th>
                                    <th>상담요청내용</th>
                                    <th>상담교수</th>
                                    <th>상담요청구분</th>
                                    <th>완료여부</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>2023-04-27</td>
                                    <td></td>
                                    <td>어문경</td>
                                    <td>진로(취업)</td>
                                    <td>N</td>
                                </tr>
                                <tr>
                                    <td>2023-04-01</td>
                                    <td></td>
                                    <td>어문경</td>
                                    <td>기타</td>
                                    <td>N</td>
                                </tr>
                                <tr>
                                    <td>2023-04-27</td>
                                    <td></td>
                                    <td>어문경</td>
                                    <td>학사(출결)</td>
                                    <td>N</td>
                                </tr>
                            </tbody>
                            
                        </table>
                    </div>
                </div>
    
            </div>
                ${loginUser }
            </div>
    <script>
		$("#datepicker1").datepicker();

		$("#datepicker1").datepicker("option", "onClose", function(selectDate) {
			$("#datepicker2").datepicker("option", "minDate", selectDate);
		})
		$("#datepicker2").datepicker();
	</script>
</body>
</html>