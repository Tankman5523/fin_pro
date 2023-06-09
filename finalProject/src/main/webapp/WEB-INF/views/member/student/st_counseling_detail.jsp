<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/studentPageStylesheet.css">
<style>
	.counselingCategory{
        list-style: none;
        
    }
    .counselingCategory>li{
        text-align: center;
        float: left;
        margin: 5px;
        margin-left : 30px
    }
    
    td>input,textarea{
        border: 0px;
    }
    .litle_title{
        width:20%;
    }
    .coun_input{
        width:30%;
    }
 
</style>
</head>
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
            <div id="content_1" align="center" style="padding-top: 5%;">
				
               <table border="1" style="width: 80%; text-align: center;">
                

                    <tr style="width: 1;">
                        <td class="litle_title">상담교직원</td>
                        <td class="coun_input">                          
                            <input type="text" name="" id="" readonly>                  
                        </td>
                        <td style="width:20%;">학생명</td>
                        <td class="coun_input"><input type="text" name="" id="" readonly></td>
                    </tr>
                    <tr>
                        <td class="litle_title">단과대학</td>
                        <td class="coun_input"><input type="text" name="" id="" readonly></td>
                        <td>학과</td>
                        <td class="coun_input"><input type="text" name="" id="" readonly></td>
                    </tr>
                    <tr>
                        <td class="litle_title">학과</td>
                        <td class="coun_input"><input type="text" name="" id="" readonly></td>
                        <td>학생번호</td>
                        <td class="coun_input"><input type="text" name="" id="" readonly></td>
                    </tr>
                    <tr>
                        <td class="litle_title">이메일</td>
                        <td class="coun_input"><input type="text" name="" id="" ></td>
                        <td >학생 전화번호</td>
                        <td class="coun_input"><input type="text" name="" id=""></td>
                    </tr>
                    <tr>
                        <td class="litle_title">상담요청일자</td>
                        <td class="coun_input"><input type="text" name="" id="" class="datepicker"></td>
                        <td>상담신청일자</td>
                        <td class="coun_input"><input type="text" name="" id=""></td>
                    </tr>
                    <tr>
                        <td rowspan="2" class="litle_title">상담요청영역</td>
                        <td colspan="3">
                            <ul class="counselingCategory">
                                <li>
                                    <label>
                                        <input type="radio" name="coun_category" id="">
                                       	 진로(취업)
                                    </label>
                                </li>
                                <li>
                                    <label >
                                        <input type="radio" name="coun_category" id="">
                                        	학교생활
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="radio" name="coun_category" id="">
                                        	학사(출결)
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="radio" name="coun_category" id="">
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
                                        <input type="radio" name="coun_category" id="">
                                        	학사(제적)
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="radio" name="coun_category" id="">
                                        	학사행정
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="radio" name="coun_category" id="">
                                        	학사(휴학)
                                    </label>
                                </li>
                                <li>
                                    <label>
                                        <input type="radio" name="coun_category" id="">
                                       		기타
                                    </label>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td class="litle_title">상담요청내용</td>
                        <td colspan="3">
                            <textarea name="" id="" cols="100" rows="10" style="resize: none;"></textarea>
                        </td>
                    </tr>
                
                </table>
                <div style="margin-top: 5%;">
                    <button type="reset" class="btn btn-secondary">이전</button>
                    <button type="submit" class="btn btn-primary" style="margin-left: 2%;">수정</button>
                </div>
            </div>
        </div>
    </div>
    
    
</body>
</html>