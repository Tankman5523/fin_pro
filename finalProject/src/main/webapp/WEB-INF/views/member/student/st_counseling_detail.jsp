<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/studentCounselingEnroll.css">
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
                    <a href="counselingList.st" style="color:#00aeff; font-weight: 550;">상담이력조회</a>
                </div>
                <div class="child_title">
                    <a href="counselingEnroll.st">상담신청</a>
                </div>
            </div>
            <div id="content_1" align="center">
            	<span id="content_title">상담 신청 상세보기</span>
            	<div id="content_top">
				<form action="counselingUpdate.st" method="post">
					<input type="hidden" name="counselNo" value="${c.counselNo}">
	               <table id="coun_list" class="table">
	                    <tr>
	                        <td class="litle_title">상담교직원</td>
	                        <td>                          
	                            <input type="text" value="${p.professorName }" readonly>                  
	                        </td>
	                        <td class="litle_title">학생명</td>
	                        <td><input type="text" value="${loginUser.studentName}" readonly></td>
	                    </tr>
	                    <tr>
	                        <td class="litle_title">학과</td>
	                        <td><input type="text" value="${p.departmentNo}" readonly></td>
	                        <td class="litle_title">학과</td>
	                        <td><input type="text" value="${loginUser.departmentNo }" readonly></td>
	                    </tr>
	                    <tr>
	                        <td class="litle_title">직책</td>
	                        <td><input type="text" value="${p.position }" readonly></td>
	                        <td class="litle_title">학생번호</td>
	                        <td><input type="text" value="${loginUser.studentNo}" readonly></td>
	                    </tr>
	                    <tr>
	                        <td class="litle_title">이메일</td>
	                        <td><input type="text" value="${p.email }" readonly ></td>
	                        <td class="litle_title">학생 전화번호</td>
	                        <td><input type="text" value="${loginUser.phone}" readonly></td>
	                    </tr>
	                    <tr>
	                        <td class="litle_title">상담희망일자</td>
	                        <td><input type="text" value="${c.requestDate }" class="datepicker" readonly></td>
	                        <td class="litle_title">상담신청일자</td>
	                        <td><input type="text" value="${c.applicationDate }" readonly></td>
	                    </tr>
	                    <tr>
	                        <td rowspan="2" class="litle_title">상담요청영역</td>
	                        <td colspan="3">
	                            <ul class="counselingCategory">
	                                <li>
	                                   <label>
	                                       <input type="radio" name="counselArea" value="진로(취업)">
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
	                    	<c:choose>
	                    	<c:when test="${empty c.counselResult}">
		                        <td class="litle_title">상담요청내용</td>
		                        <td colspan="3">
		                            <textarea name="counselContent" id="counselContent" cols="88" rows="10" style="resize: none;">${c.counselContent }</textarea>
		                        </td>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<td class="litle_title" style="color:red;">상담반려이유</td>
		                        <td colspan="3">
		                            <textarea name="counselContent" id="counselContent" cols="88" rows="10" style="resize: none;">${c.counselResult }</textarea>
		                        </td>
	                    	</c:otherwise>
	                    	</c:choose>
	                    </tr>
	                </table>
	                <div style="margin-top: 5%;">
	                    <button type="reset" class="btn btn-secondary">이전</button>
	                    <button type="submit" class="btn btn-primary" id="subBtn" style="margin-left: 2%;">수정</button>
	                </div>
                </form>
                </div>
            </div>
        </div>
    </div>
    <script>
    	var area = '${c.counselArea}'; //선택했었던 상담영역
    	var status = '${c.status}'; //상담완료 여부
    	$(function(){ //작성할떄 상담영역 골라주고 못바꾸게 하기
    		$("input[name=counselArea]").each(function(){
    			if($(this).eq(0).val()==area){
    				$(this).attr("checked",true);	
    			}
    			$(this).attr("disabled",true);
    		})
    		//상담 완료거나 취소 상태라면 수정못하게
    		if(status != 'N'){
    			$("#counselContent").attr("disabled",true);
    			$("#subBtn").attr("disabled",true);
    		}
    		
    	})
    	
    	
    	
    </script>
</body>
</html>