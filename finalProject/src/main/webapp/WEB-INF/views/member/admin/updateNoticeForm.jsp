<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/updateNoticeForm.css">

<!--  jQuery, bootstrap -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> -->
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<body>
<div class="wrap">
	<%@include file="../../common/admin_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
	<div id="content">
		<div id="category">
			<div id="cate_title">
				<span style="margin: 0 auto;">학사관리</span>
			</div>
			<div class="child_title">
			    <a href="enrollStudent.ad">학생관리</a>
			</div>
			<div class="child_title">
			    <a href="enrollProfessor.ad">임직원 관리</a>
			</div>
			<div class="child_title">
			    <a href="calendarView.ad">학사일정 관리</a>
			</div>
			<div class="child_title">
				<a href="stuRestList.ad">휴/복학 신청 관리</a>
			</div>
			<div class="child_title">
				<a href="proRestList.ad">안식/퇴직 관리</a>
			</div>
			<div class="child_title">
			    <a href="selectNotice.ad" style="color:#00aeff; font-weight: 550;">공지사항 관리</a>
			</div>
	    </div>
		<div id="content_1">
		
			<h1>Summernote</h1>
			<div id="summernote"></div>
			
		</div>
	</div>
</div>
<script>
$(document).ready(function () {
    $('#summernote').summernote({
        placeholder: '내용을 작성하세요',
        height: 400,
        maxHeight: 400
    });
});
</script>
</body>
</html>