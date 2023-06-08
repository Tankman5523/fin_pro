<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의시간표</title>
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

        .selectTerm {
            display: flex;
            align-items: center;
        }

        .selectTerm * {
            margin-left: 10px;
        }

        #selectList {
            border-radius: 10px;
            margin-left: 30px;
        }

        input[name=search_category] {
            opacity: 0;
            margin: 0 10px;
        }

        input[name=search_category]+label:hover {
            cursor: pointer;
        }

        input[name=search_category]:checked+label {
            color:#00aeff;
        }

        div[class*=content] {
            margin: 0 auto;
            width: 95%;
            height: 77%;
            display: none;
            border: 1px solid red;
        }

        /* .content1 {
            background-color: tomato;
        }

        .content2 {
            background-color: yellow;
        }

        .content3 {
            background-color: yellowgreen;
        }

        .content4 {
            background-color: skyblue;
        } */
    </style>
</head>
<body>
	<div class="wrap">
		<%@include file="../../common/student_menubar.jsp" %>
		<div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">수강신청</span>
                </div>
                <div class="child_title">
                    <a href="#" style="color:#00aeff; font-weight: 550;">강의시간표</a>
                </div>
                <div class="child_title">
                    <a href="#">수강신청</a>
                </div>
                <div class="child_title">
                    <a href="#">수강취소</a>
                </div>
                <div class="child_title">
                    <a href="#">수강신청 내역조회</a>
                </div>
                <div class="child_title">
                    <a href="#">예비수강신청</a>
                </div>
            </div>
            <div id="content_1">
				<br>
                <span class="page_title">전체 강의 목록 조회</span>
                <div class="b_line"></div>

                <div class="selectTerm">
                    <span>학년도: </span> <select name="year" id="year" onchange="changeYear();">
                                            <option value="2023">2023학년도</option>
                                            <option value="2022">2022학년도</option>
                                            <option value="2021">2021학년도</option>
                                            <option value="2020">2020년도</option>
                                        </select>
                    <span>학기: </span> <select name="term" id="term">
                                            <option value="1">1학기</option>
                                            <option value="2">2학기</option>
                                       </select>
                    <button type="button" class="btn btn-primary btn-sm" id="selectList">조회</button>
                </div>
                <br>

                <input type="radio" name="search_category" id="major" onchange="selectCategory();" checked> <label for="major">학부 전공별</label>
                <input type="radio" name="search_category" id="elective" onchange="selectCategory();"> <label for="elective">교양</label>
                <input type="radio" name="search_category" id="search_pro" onchange="selectCategory();"> <label for="search_pro">교수명 검색</label>
                <input type="radio" name="search_category" id="search_sub" onchange="selectCategory();"> <label for="search_sub">과목 검색</label>
                <br>
                <div class="content_major">
                    <select name="colleage" id="college" onchange="selectCollege(this);">
                        <option value=""> ==단과대학== </option>
                        <option value="인문대학">인문대학</option>
                        <option value="사회과학대학">사회과학대학</option>
                        <option value="교육대학">교육대학</option>
                        <option value="자연대학">자연대학</option>
                        <option value="공학대학">공학대학</option>
                        <option value="미술대학">미술대학</option>
                        <option value="예술대학">예술대학</option>
                    </select>
                    <select name="department" id="department">
                        <option value=""> ==전공== </option>
                    </select>
                    <button>조회</button>
                </div>
                <div class="content_elective"></div>
                <div class="content_searchPro"></div>
                <div class="content_searchSub"></div>

                <script>
	                $(function() {
	                    $(".content_major").css("display", "block");
	                })
	
	                function selectCategory() {
	                    if($('#major').is(':checked')){
	                        $("div[class*=content]").each(function() {
	                            $(this).css("display", "none");
	                        });
	                        $(".content_major").css("display", "block");
	                    }
	                    else if($('#elective').is(':checked')) {
	                        $("div[class*=content]").each(function() {
	                            $(this).css("display", "none");
	                        });
	                        $(".content_elective").css("display", "block");
	                    }
	                    else if($('#search_pro').is(':checked')) {
	                        $("div[class*=content]").each(function() {
	                            $(this).css("display", "none");
	                        });
	                        $(".content_searchPro").css("display", "block");
	                    }
	                    else if($('#search_sub').is(':checked')) {
	                        $("div[class*=content]").each(function() {
	                            $(this).css("display", "none");
	                        });
	                        $(".content_searchSub").css("display", "block");
	                    }
	                }
	
	                function selectCollege(e) {
	                    var $college = e.value;
	                    
	                    $.ajax({
	                    	url: "selectDepart.me",
	                    	data: {college: $college},
	                    	headers: { 
	                    	    Accept : "application/json",
	                    	  	ContentType : "application/json; charset=UTF-8"
	                    	    
	                    	},
	                    	type: "post",
	                    	dataType: "json",
// 	                    	contentType: "application/	json; charset=UTF-8;",
	                    	success: function(dList) {
	                    		console.log(dList);
	                    	},
	                    	error: function() {
	                    		console.log("통신 오류");
	                    	}
	                    })
	                }
                </script>
            </div>
        </div>
	</div>
</body>
</html>