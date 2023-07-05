<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 개설 관리 페이지</title>
<link rel="stylesheet" href="/fin/resources/css/classManegeListView.css">
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
                    <span id="content_title">개설 신청된 강의</span>
					<div id="class_type" style="border-top:2px solid lightblue">
	                    	전공/교양 : 
	                    <select name="division" id="division">
	                       <option value="2">==전체==</option>
	                       <option value="0">전공</option>
	                       <option value="1" >교양</option>
	                    </select>
	                    	학년도 : 
	                    <select name="classYear">
	                    	<option value="">==전체==</option>
		                    <c:forEach var="y" items="${ylist}">
		                    	<option value="${y}">${y}년</option>
		                    </c:forEach>
	                    </select>
	                    	학기 : 
	                    <select name="classTerm">
	                    	<option value="">==전체==</option>
	                    	<option value="1">1학기</option>
	                    	<option value="2">2학기</option>
	                    </select>
	                    	개설 여부 : 
	                    <select name="status" id="status">
	                       <option value="">=====전체=====</option>
	                       <option value="B">개설처리중</option>
	                       <option value="C">반려</option>
	                       <option value="Y">개설</option>
	                       <option value="N">학기종료</option>
	                       <option value="B,C">개설처리중/반려</option>
	                       <option value="Y,N">개설완료/학기종료</option>
	                    </select>
	                </div>
	                <br>
	                <div style="float: right; width:33%;" align="center">
	                    <select name="category" style="margin-top:5px;">
	                        <option value="department">학과</option>
	                        <option value="professor">교수명</option>
	                        <option value="class">강의명</option>
	                    </select>
	                    <input type="text" name="keyword" id="keyword">
	                    <button type="button" id="search_btn" onclick="searchClassList();" class="btn btn-secondary btn-sm" style="margin-bottom:5px;">조회</button>
	                </div>
                
                <div style="margin-left:20px; margin-bottom:10px;">
                	<button type="button" class="btn btn-primary" id="allPermit">선택 개설</button>
                	<button type="button" class="btn btn-danger" id="termFinish">선택 학기종료</button>
                </div>
                <div id="table_div" class="table-response">
                    <table id="board_list" class="table" border="1" style="text-align: center;">
                        <thead>
                            <tr>
                                <th class="stiky" style="width:1%"><input type="checkbox" id="allCheck"></th>
                                <th class="stiky" style="width:2%"></th>
                                <th class="stiky" style="width:5%">종류</th>
                                <th class="stiky" style="width:10%">학과</th>
                                <th class="stiky" style="width:6.9%">신청교수</th>
                                <th class="stiky" style="width:11.8%">강의명</th>
                                <th class="stiky" style="width:6.9%">학년도</th>
                                <th class="stiky" style="width:5.9%">학기</th>
                                <th class="stiky" style="width:10.8%">강의실</th>
                                <th class="stiky" style="width:7%">강의시간</th>
                                <th class="stiky" style="width:6.9%">수강대상</th>
                                <th class="stiky" style="width:6.9%">수강인원</th>
                                <th class="stiky" style="width:6.9%">이수학점</th>
                                <th class="stiky" style="width:12%">개설여부</th>
                                
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
			                                <td>
			                                	<c:if test="${not empty c.fileNo}">
				                                	<a href="${c.fileNo }" download><i class="fa-solid fa-download fa-2xs"></i></a>
			                                	</c:if>
			                                </td>
			                                <td>${c.division eq 0 ? '전공':'교양'}</td>
			                                <td>${c.departmentNo}</td>
			                                <td>${c.professorNo}</td>
			                                <td>${c.className}</td>
			                                <td>${c.classYear}년</td>
			                                <td>${c.classTerm}학기</td>
			                                <td style="white-space: nowrap;">${c.classroom}</td>
			                                <td>
			                                    ${c.period}<br>
			                                   ( ${c.day} )
			                                </td>
			                                <td>${c.classLevel eq 0 ? '전':c.classLevel}학년</td>
			                                <td>${c.classNos}명</td>
			                                <td>${c.credit}학점</td>
			                                <td>
			                                <c:choose>
				                                <c:when test="${c.status eq 'Y'}">
				                                	<span class="resultMsg" style="color:blue;">개설</span>
				                                </c:when>
				                                <c:when test="${c.status eq 'N'}">
				                                	<span class="resultMsg" style="color:red;">학기종료</span>
				                                </c:when>
				                                <c:when test="${c.status eq 'C'}">
				                                	<span class="resultMsg" style="color:#FFA500;">반려</span>
				                                </c:when>
				                                <c:otherwise>
					                                    <button type="button" class="btn btn-primary" onclick="updateClassPermit(${c.classNo});">개설</button>
					                                    <button type="button" class="btn btn-warning"  data-toggle="modal" data-target="#exampleModal">반려</button>
				                                </c:otherwise>
			                                </c:choose>
			                                </td>
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
	    	checkbox(); //전체 체크박스 기능 실행함수
	    	trcheck(); //테이블 클릭시 체크 함수
	    	allPermit(); //일괄개설 함수
	    	termFinish(); //일괄 학기종료 함수
	    	
    	})
    	
    	function allCheckbox(){
    		var is_checked = true; //나중에 넣을 변수
		    
		    $("#board_list input[name=check]").each(function(){
		        is_checked = is_checked && $(this).is(":checked"); //내가 누른 버튼이 true인지
		    });
		    
		    $("#allCheck").prop("checked", is_checked); //전체선택 변화
    	}
    	
    	function trcheck(){//테이블 tr클릭시 체크박스 체크 또는 해제
    		 $('#board_list>tbody').on('click', 'tr td:not(:first-child,:nth-child(2),:nth-child(14))',function () {
    			var checkbox = $(this).parent().children().eq(0).children();
    			
    			if(checkbox.is(':checked')){
    				checkbox.prop("checked",false);
    				allCheckbox();
    			}else{
	    			checkbox.prop("checked",true);
	    			allCheckbox();
    			}
    		})
    	}
    	
    	function checkbox(){
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
	    			allCheckbox();
	    		})
    	}
    	function allPermit(){
    		var check = $("input[name=check]"); //강의 개별 선택
	    	$("#allPermit").click(function(){//일괄개설 눌렀을때
	    		var chkArr = []; //배열 초기화
	    		var count = 0; //카운트
	    		check.each(function(){
	    			var already = $(this).parent().parent().children().eq(13).children().text();
	    			if(already=='개설반려'){//이미 개설되었거나 반려된 강의가 체크 안되어있는지
		    			if($(this).is(":checked")){//체크되었는지
		    				var val = $(this).val(); //선택된 강의번호
		    				chkArr.push(val); //배열에 담기
		    			}
	    			}else {
	    				if($(this).is(":checked")){//체크되었는지
	    					count++;//이미 처리된 강의를 체크했다는 판별을 위해
	    				}
	    			}
	    				
	    		})
	    		if(chkArr.length == 0){//아무것도 선택안하고 일괄개선 눌렀을때
	    			if(count==0){
		    			alert("개설할 강의를 선택해주세요");
	    			}else{
	    				alert("개설처리중인 강의가 없습니다.");
	    			}
	    		}else{//선택된 강의가 있을때
	    			if(confirm('개설처리중인 강의들만 개설 됩니다.\n선택하신 강의들을 일괄 개설하시겠습니까?')){
	    				location.href="permitAllClassCreate.ad?cArr="+chkArr;
		    		}else{//취소 눌렀을때
		    			alert("일괄 개설을 취소하셨습니다.");
		    		}
	    		}
	    	})
    	}
    	function termFinish(){
    		$("#termFinish").click(function(){
    			var chkArr = [];
    			$("input[name=check]").each(function(){
    				if($(this).is(":checked")){//체크되었는지
	    				var val = $(this).val(); //선택된 강의번호
	    				chkArr.push(val); //배열에 담기
	    			}
    			})
    			if(chkArr.length==0){
    				alert("선택된 강의가 없습니다.");
    			}else{
    				if(confirm('선택된 강의들을 정말 학기종료 하시겠습니까? \n한번 종료하면 바꿀 수 없습니다.')){
    					location.href="classTermFinish.ad?cArr="+chkArr;
    				}else{
    					alert("취소하셨습니다.");
    				}
    			}
    		})
    	}
    		
    	
    	
    	function updateClassPermit(cno){
    		if(confirm('이 강의를 정말 개설 하시겠습니까?')){
    			location.href="permitClassCreate.ad?cno="+cno;
	    	}else{
	    		console.log("취소");
	    	}
    	}
    	
    	function searchClassList(){//검색했을때 리스트 가져와서 붙이기
    		//$("#allCheck").prop("checked",false);
    		var division = $("#division").val();
    		var classYear = $("select[name=classYear]").val();
    		//console.log(typeof classYear);
    		var classTerm = $("select[name=classTerm]").val();
    		//console.log(typeof classTerm);
    		var status = $("#status").val();
    		var category = $("select[name=category]").val();
    		var keyword = $("#keyword").val();
    		$.ajax({
    			url:"classSearchList.ad",
    			data:{
    				division:division,
    				classYear:classYear,
    				classTerm:classTerm,
    				status:status,
    				category:category,
    				keyword:keyword
    			},
    			success:function(list){
    				var result = "";
    				var st = "";
    				if(list.length != 0){
	    				for(var i=0; i<list.length; i++){
	    					var fileNo;
	    					if(list[i].fileNo==undefined){
	    						fileNo='javascript:void(0)';
	    					}
	    					result += "<tr>"
	                        +"<td><input type='checkbox' name='check' value="+list[i].classNo+"></td>"
	                        +"<td><a href='"+fileNo+"' download><i class='fa-solid fa-download fa-2xs'></i></a></td>"
	                        +"<td>"+(list[i].division == 0 ? "전공":"교양")+"</td>"
	                        +"<td>"+list[i].departmentNo+"</td>"
	                        +"<td>"+list[i].professorNo+"</td>"
	                        +"<td>"+list[i].className+"</td>"
	                        +"<td>"+list[i].classYear+"년</td>"
	                        +"<td>"+list[i].classTerm+"학기</td>"
	                        +"<td style='white-space: nowrap;'>"+list[i].classroom+"</td>"
	                        +"<td>"
	                           +list[i].period+"<br>"
	                           +"( "+list[i].day+" )"
	                        +"</td>"
	                        +"<td>"+(list[i].classLevel == 0 ? '전':list[i].classLevel)+"학년</td>"
	                        +"<td>"+list[i].classNos+"명</td>"
	                        +"<td>"+list[i].credit+"학점</td>"
	                        switch(list[i].status){
	                    	case "Y" : result+="<td><span class='resultMsg' style='color:blue;'>개설</span></td>"
	                    	break;
	                    	case "N" : result+="<td><span class='resultMsg' style='color:red;'>학기종료</span></td>"
	                    	break;
	                    	case "C" : result+="<td><span class='resultMsg' style='color:#FFA500;'>반려</span></td>"
	                    	break;
	                    	case "B" : result+="<td>"
	                    					+"<button type='button' class='btn btn-primary' onclick='updateClassPermit("+list[i].classNo+");'>개설</button>"
	                        				+"<button type='button' class='btn btn-warning'  data-toggle='modal' data-target='#exampleModal'>반려</button>"
	                    				+"</td>"
	                    	}
	                    +"</tr>";
	    				}
	    			}else{
    					result += "<tr><td colspan='14'>검색된 강의가 없습니다.</td></tr>";	
	    				
    				}
    				$("#board_list>tbody").html(result);
    				checkbox();
    				allCheckbox();
    			},
    			error:function(){
    				alert("통신 실패");
    			}
    		})
    	}
    	
    	$("#board_list>tbody ").on("click","tr",function(){//반려 눌렀을때 번호 가져오기
    		var cno = $(this).children().eq(0).children().val();
    		
    		$("#cno").val(cno);
    	})
    	
    	function rejectClass(){//강의 반려
    		var cno = $("#cno").val();
    		var explain = $("#explain").val();
    		
    		location.href="rejectClassCreate.ad?classNo="+cno+"&explain="+explain;
    	}
    	
    	$("#keyword").keyup(function(e){
    		if(e.code=='Enter'){
    			$("#search_btn").click();
    		}
    	})
    		
    	
    	
    </script>
</body>
</html>