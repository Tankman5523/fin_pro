<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/noticeDetailView.css">
</head>
<body>
	<div class="wrap">
		<%@include file="../common/mainPageHeader.jsp" %>
		 
		<div id="content">
			<div id="content-area">
				<h1 style="margin: 0; margin-left: 20px;">[${f.categoryName }]&nbsp;&nbsp;자주 묻는 질문</h1>
			 	
			 	<div id="btn-area">
			 		<button id="back-btn" onclick="back();"><i class="fa-solid fa-bars"></i>목록</button>
			 	</div>
			 	
				<div id="notice_title">
					<span style="float: left; margin: 0;">${f.noticeTitle }</span>
					
					<div style="float: right; line-height: 50px;">
						 | ${f.count } | ${f.createDate }
					</div>
				</div>
					
				<c:if test="${na ne ''}">
					<ul id="file-container">
						<c:forEach var="i" items="${na }">
							<li class="file-list">
								<a href="${i.filePath}${i.changeName }" download="${i.originName }">
									<i class="fa-solid fa-paperclip"></i>&nbsp;&nbsp;&nbsp;${i.originName }
								</a>
							</li>
						</c:forEach>
					</ul>
				</c:if>
				<div id="notice_content">
					<div id="summernote">${n.noticeContent }</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			function back(){
				history.back();
			}
		</script>
		 
		<%@include file="../common/mainPageFooter.jsp" %>
	</div>
</body>
</html>