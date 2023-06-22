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
                   <span style="margin: 0 auto;">상담관리</span>
               </div>
               <div class="child_title">
                   <a href="counselHistory.pr" class="childBtn">상담이력조회</a>
               </div>
           </div>
           <div id="content_1">
				
			<form action="selectCounsel.pr" method="post">
				<div id="select-area">
					<table id="select-table">
						<tr>
							<th>학년도</th>
							<td>
								<select name="coll-year" id="coll-year">
									<option value="all-year">=== 전체 ===</option>
								</select>
							</td>
							<th>학기</th>
							<td>
								<select name="coll-term">
									<option value="all-term">=== 전체 ===</option>
									<option value="first-term">1학기</option>
									<option value="second-term">2학기</option>
								</select>
							</td>
							<th>학년</th>
							<td>
								<select name="coll-grade">
									<option value="all-grade">=== 전체 ===</option>
									<option value="freshman">1학년</option>
									<option value="sophomore">2학년</option>
									<option value="junior">3학년</option>
									<option value="senior">4학년</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>상담종류</th>
							<td>
								<select name="counsel-type">
									<option value="all-type">=== 전체 ===</option>
									<option value="jinro">진로(취업)</option>
									<option value="attendance">학사(출결)</option>
									<option value="rest">학사(휴학)</option>
									<option value="drop">학사(제적)</option>
									<option value="admin">학사행정</option>
									<option value="affect">심리정서</option>
									<option value="collLife">학교생활</option>
									<option value="etc">기타</option>
								</select>
							</td>
							<th>상담일</th>
							<td>
								<input type="date" name="startDate" min="2019-01-01" max="2060-12-31" placeholder="날짜 선택" required="required">								</td>
							<th>
								~
							</th>
							<td>
								<input type="date" name="endDate" min="2019-01-01" max="2060-12-31" placeholder="날짜 선택" required="required">
							</td>
						</tr>
					</table>
				</div>
				
				<div id="select-btn">
					<button type="submit"><i class="fa-solid fa-magnifying-glass"></i>&nbsp;조회</button>
					<button type="reset"><i class="fa-solid fa-arrow-rotate-left"></i>&nbsp;초기화</button>
				</div>
			</form>
			
			<div id="record-area">
				<table id="record-table">
					<thead>
						<tr>
							<th>학년도</th>
							<th>학년</th>
							<th>학기</th>
							<th>학생명</th>
							<th>상담요청일자</th>
							<th>상담요청구분</th>
							<th>완료여부</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>2023년</td>
							<td>4</td>
							<td>1</td>
							<td>홍길동</td>
							<td>2023-04-07</td>
							<td>진로(취업)</td>
							<td>Y</td>
						</tr>
						<tr>
							<td>2023년</td>
							<td>4</td>
							<td>1</td>
							<td>홍길동</td>
							<td>2023-04-07</td>
							<td>진로(취업)</td>
							<td>Y</td>
						</tr>
					</tbody>
				</table>
			</div>
			
           </div>
       </div>
</div>

	<script type="text/javascript">
		
		const now = new Date();
		const year = [ ];
	
	    for(var i=0; i<4; i++){
	        year[i] = now.getFullYear() - i;
	    }
	
	    year.forEach(function(year, inx){
	    	const select = document.getElementById('coll-year');
	    	const option = document.createElement("option");
	    	
	    	option.className = 'year';
	        option.innerHTML = year;
			
	        select.appendChild(option);
	    })
	
		const childTitle = document.querySelectorAll(".child_title")
		const firstBtn = document.querySelectorAll(".childBtn")
		
		window.onload = function(){
			firstBtn[0].style.color = "#13abec"
			firstBtn[0].style.fontWeight = "bold"
		}
		
		const row = document.querySelectorAll('#record-table > tbody > tr')
		
		row.forEach(function(row, index){
			row.addEventListener('click', function(){
// 				location.href = "detail.mp?noticeNo="+noticeNo;
			})
		})
		
	</script>
</body>
</html>