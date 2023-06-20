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
				<h1 style="margin: 0; margin-left: 20px;">${n.categoryName }&nbsp;&nbsp;공지사항</h1>
			 	
			 	<div id="btn-area">
			 		<button id="back-btn" onclick="back();"><i class="fa-solid fa-bars"></i>목록</button>
			 	</div>
			 	
				<div id="notice_title">
					<span style="float: left; margin: 0;">${n.noticeTitle }</span>
					
					<div style="float: right; line-height: 50px;">
						 | ${n.count } | ${n.createDate }
					</div>
				</div>
					<c:choose>
						<c:when test="${not empty files}">
							<c:forEach var="f" items="${files }">
								<c:if test="${null ne f.originName }">
									<div id="files">
										<span>
											<i class="fa-solid fa-file"></i>
											${f.originName }
										</span>
									</div>
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div id="files">
								<span>첨부파일이 없습니다.</span>
							</div>
						</c:otherwise>
					</c:choose>
				<div id="notice_content">
					<textarea readonly="readonly">${n.noticeContent }</textarea>
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