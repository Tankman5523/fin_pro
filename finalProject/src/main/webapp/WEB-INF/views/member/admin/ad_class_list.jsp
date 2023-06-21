<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#board-list{
		white-space: nowrap;
	}
	 #content_1>div{
        margin: auto;
        width:95%;
        
        
    }
    #class_type{
        text-align: center;
    }
    #class_type>ul{
        list-style: none;
    }
    #class_type>ul>li{
        float: left;
        margin-left: 15%;
    }
</style>
</head>
<body>
	<div class="wrap">
    	<%@include file="../../common/admin_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
        <div id="content">
            <div id="category">
                <div id="cate_title">
                    <span style="margin: 0 auto;">강의관리</span>
                </div>
                <div class="child_title">
                    <a href="classListView.ad">강의시간표</a>
                </div>
                <div class="child_title">
                    <a href="classManagePage.ad" style="color:#00aeff; font-weight: 550;">강의개설관리</a>
                </div>
                 <div class="child_title">
                    <a href="classRatingPage.ad">강의평가 관리</a>
                </div>
            </div>
            <div id="content_1">
				<div id="class_type">
                    <ul>
                        <li>전체</li>
                        <li>전공</li>
                        <li>교양</li>
                        <li>개설대기/반려</li>
                        <li>개설완료</li>
                    </ul>
                </div>
                <br>
                <div>
                    <h3>개설 신청된 강의</h3>
                </div>
                <div style="">
                	<button type="button" class="btn btn-primary" id="allPermit">일괄 개설</button>
                </div>
                <div style="float: right; width:30%;">
                    <select name="" id="">
                        <option value="">교수명</option>
                        <option value="">학과</option>
                        <option value="">과목명</option>
                    </select>
                    <input type="text" name="" id="">
                    <button type="button" class="btn btn-secondary">조회</button>
                </div>
                
                <div>
	
                    <table id="board_list" border="1" style="width:100%; text-align: center; margin-top:5%">
                        <thead>
                            
                            <tr>
                                <th><input type="checkbox" id="allCheck"></th>
                                <th style="width:7%">강의번호</th>
                                <th style="width:7%">전공/교양</th>
                                <th>학과</th>
                                <th>강의명</th>
                                <th style="width:6%">학년도</th>
                                <th style="width:5%">학기</th>
                                <th style="width:7%">강의실</th>
                                <th style="width:7%">강의시간</th>
                                <th style="width:7%">수강대상</th>
                                <th style="width:7%">수강인원</th>
                                <th style="width:7%">이수학점</th>
                                <th style="width:15%">개설여부</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                        	<c:choose>
                        		<c:when test="${empty list }">
                        			<tr>
                        				<td colspan="14">강의 개설 신청 내역이 없습니다.</td>
                        			</tr>
                        		</c:when>
	                        	<c:otherwise>
			                        <c:forEach var="c" items="${list}">
			                        	<tr>
			                                <td><input type="checkbox" name="check" value="${c.classNo}"></td>
			                                <td>${c.classNo}</td>
			                                <td>${c.division eq 0 ? '전공':'교양'}</td>
			                                <td>${c.departmentNo}</td>
			                                <td>${c.className}</td>
			                                <td>${c.classYear}년</td>
			                                <td>${c.classTerm}학기</td>
			                                <td>${c.classroom}</td>
			                                <td>
			                                    ${c.period}<br>
			                                   ( ${c.day} )
			                                </td>
			                                <td>${c.classLevel eq 0 ? '전':c.classLevel}학년</td>
			                                <td>${c.classNos}</td>
			                                <td>${c.credit}</td>
			                                <c:choose>
				                                <c:when test="${c.status=='Y'}">
				                                	<td>개설완료</td>
				                                </c:when>
				                                <c:when test="${c.status=='N'}">
				                                	<td>학기끝</td>
				                                </c:when>
				                                <c:when test="${c.status=='C'}">
				                                	<td>반려</td>
				                                </c:when>
				                                <c:otherwise>
					                                <td>
					                                    <button type="button" class="btn btn-primary" onclick="updateClassPermit(${c.classNo});">개설</button>
					                                    <button type="button" class="btn btn-warning"  data-toggle="modal" data-target="#exampleModal">반려</button>
					                                </td>
				                                </c:otherwise>
			                                </c:choose>
			                            </tr>
			                        </c:forEach>
	                        	</c:otherwise>
                        	</c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">정말 반려하시겠습니까?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h3>반려사유</h3>
        <textarea rows="3" cols="60" id="explain" style="resize:none;"></textarea>
        <input type="hidden" id="cno">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-warning" onclick="rejectClass();">반려</button>
      </div>
    </div>
  </div>
</div>
    <script>
    	$(function(){
    		var allCheck = $("#allCheck"); //강의 전체 선택
    		var check = $("input[name=check]"); //강의 개별 선택
    		var chkArr = new Array();//번호 담아갈 배열
    		
    		allCheck.click(function(){//전체체크 클릭
    			if(allCheck.is(":checked")){//전체선택 눌렀을때 체크가 되었다면
    				check.prop("checked",true); //전체 체크 선택
    			}else{//눌럿을때 체크가 해제
    				check.prop("checked",false); //전체 체크 해제
    			}
    		});
    		
    		$("#board_list").on("click","input[name=check]",function(){//개별 체크 했을때 전체선택 반응
    			var is_checked = true; //나중에 넣을 변수
    		    
    		    $("#board_list input[name=check]").each(function(){
    		        is_checked = is_checked && $(this).is(":checked"); //내가 누른 버튼이 true인지
    		    });
    		    
    		    $("#allCheck").prop("checked", is_checked); //전체선택 변화
    		})
    		
    		$("#allPermit").click(function(){//일괄개설 눌렀을때
    			chkArr = []; //배열 초기화
    			check.each(function(){
    				if($(this).is(":checked")){
    					var val = $(this).val(); //선택된 강의번호
    					chkArr.push(val); //배열에 담기
    				}
    			})
    			if(chkArr.length == 0){//아무것도 선택안하고 일괄개선 눌렀을때
    				alert("개설할 강의를 선택해주세요");
    			}else{//선택된 강의가 있을때
	    			if(confirm('선택하신 강의들을 일괄 개설하시겠습니까?')){//확인 누르면
		    			location.href="permitAllClassCreate.ad?cArr="+chkArr;
	    			}else{//취소 눌렀을때
	    				alert("일괄 개설를 취소하셨습니다.");
	    				return false;
	    			}
    			}
    		})
    		
    	})
    	function updateClassPermit(cno){
    		if(confirm('이 강의를 정말 개설 하시겠습니까?')){
    			
	    		$.ajax({
	    			url:"permitClassCreate.ad",
	    			data:{cno:cno},
	    			
	    			success:function(result){
	    				if(result>0){
	    					console.log(result);
	    					alert("개설 성공");
	    				}else{
	    					alert("개설 승인 실패");
	    				}
	    			},
	    			error:function(){
	    				alert("통신오류");
	    			}
	    		})
	    	}else{
	    		console.log("취소");
	    	}
    	}
    	
    	$("#board_list>tbody ").on("click","tr",function(){
    		var cno = $(this).children().eq(0).children().val();
    		
    		$("#cno").val(cno);
    	})
    	
    	function rejectClass(){
    		var cno = $("#cno").val();
    		var explain = $("#explain").val();
    		
    		location.href="rejectClassCreate.ad?classNo="+cno+"&explain="+explain;
    	}
    	
    </script>
</body>
</html>