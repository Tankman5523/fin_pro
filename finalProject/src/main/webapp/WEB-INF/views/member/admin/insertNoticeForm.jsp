<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/insertNoticeForm.css">

<!-- 서머노트 쓰기위한 CDN(jQuery, 서머노트cdn) -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<!-- 메뉴바에 있는 jquery와 충돌이 나기 때문에 필요한 js는 $대신 변수를 지정해서 써준다. -->
<script > var jb = jQuery.noConflict(); </script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


</head>
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
		
			<h3 style="width: 95%; margin: 50px auto; text-align: center;">공지사항 등록</h3>
			<div id="editor-container">
				<input type="hidden" name="user" value="${loginUser.professorNo }">
				<table id="select-area">
					<tbody>
						<tr>
							<th>게시판 선택</th>
							<td>
								<select id="field-select">
									<option  value="0">공지사항</option>
									<option value="1">FAQ</option>
								</select>
							</td>
							<th>카테고리 선택</th>
							<td>
								<select id="category-select">
									<option value="1">학사</option>
									<option value="2">장학</option>
									<option value="3">입학</option>
									<option value="4">채용</option>
									<option value="5">기타</option>
								</select>
							</td>
						</tr>
					</tbody>						
				</table>
				<div id="summernote"></div>
				<div id="btn-area">
					<button type="button" id="back" onclick="history.back();">이전</button>
					<button type="button" id="submit" onclick="insert();">등록</button>
				</div>
			</div>
			
		</div>
	</div>
</div>
<script>
	$(document).ready(function () {
		jb('#summernote').summernote({
	        placeholder: '내용을 작성하세요',
	        width: '100%',
	        height: 500,
	        maxHeight: 500,
			callbacks: {
				onImageUpload: function(files, editor, welEditable){
					// 파일 업로드(다중업로드를 위해 반복문 사용)
					for (var i = files.length - 1; i >= 0; i--) {
						uploadSummernoteImageFile(files[i], this);
					}
				}
			} 
	    });
	});
	
	function uploadSummernoteImageFile(file, el) {
        var data = new FormData();	
        data.append("file",file);
        $.ajax({
			url: '/../summer_image.do',
         	type: "POST",
			enctype: 'multipart/form-data',
			data: data,
			cache: false,
			contentType : false,
			processData : false,
			success : function(data) {
		       var json = JSON.parse(data);
		       $(el).summernote('editor.insertImage',json["url"]);
	           jsonArray.push(json["url"]);
	           jsonFn(jsonArray);
			},
			error : function(e) {
			    console.log(e);
			}
		});
	}
	
	function jsonFn(jsonArray){
		console.log(jsonArray);
	}
	
	
	function insert(){
		const fieldSelect = document.getElementById('field-select');
		const categorySelect = document.getElementById('category-select');
		
		const field = fieldSelect.options[fieldSelect.selectedIndex].value;
		const category = categorySelect.options[categorySelect.selectedIndex].value;
		
		const user = "${loginUser.professorNo}";

		const note = document.querySelector('.note-editable').innerHTML
		
		$.ajax({
			url: "insertNoticeForm.ad",
			data: {
				field : field,
				category : category,
				user : user,
				note : note
			},
			type: "post",
			success: function(){
				
			},
			error: function(){
				
			}
		})
	}
</script>
</body>
</html>