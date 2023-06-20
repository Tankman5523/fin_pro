<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/counselHistory.css">
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
                    <a href="counselHistory.pr" class="childBtn">●&nbsp;&nbsp;&nbsp;상담이력조회</a>
                </div>
            </div>
            <div id="content_1">
					
				<form action="">
					<div id="select-area">
						<table id="select-table">
							<tr>
								<th>학년도</th>
								<td>
									<select>
										<option>2023</option>
									</select>
								</td>
								<th>학기</th>
								<td>
									<select>
										<option>1학기</option>
									</select>
								</td>
								<th>학년</th>
								<td>
									<select>
										<option>1학년</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>상담종류</th>
								<td>
									<select>
										<option>1학년</option>
									</select>
								</td>
								<th>상담일</th>
								<td>
									<select>
										<option>1학년</option>
									</select>
								</td>
								<th>
									~
								</th>
								<td>
									<select>
										<option>1학년</option>
									</select>
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
					<table id="record-table" border="1">
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
						</tbody>
					</table>
				</div>
				
            </div>
        </div>
	</div>
	
	<script type="text/javascript">
		
		const childTitle = document.querySelectorAll(".child_title")
		const firstBtn = document.querySelectorAll(".childBtn")
		
		window.onload = function(){
			firstBtn[0].style.color = "#13abec"
			firstBtn[0].style.fontWeight = "bold"
		}
	</script>
</body>
</html>