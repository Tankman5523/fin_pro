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
<div class="wrap" style="height: auto;">
	<%@include file="../../common/admin_menubar.jsp" %> <%--알아서 수정해서 쓰기 --%> 
	<div id="content" style="height: 1100px;">
		<div id="category">
			<div id="cate_title" style="height: 94px;">
				<span style="margin: 0 auto;">학사관리</span>
			</div>
			<div class="child_title" style="height: 77px;">
			    <a href="enrollStudent.ad">학생관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
			    <a href="enrollProfessor.ad">임직원 관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
			    <a href="calendarView.ad">학사일정 관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
				<a href="stuRestList.ad">휴/복학 신청 관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
				<a href="proRestList.ad">안식/퇴직 관리</a>
			</div>
			<div class="child_title" style="height: 77px;">
			    <a href="selectNotice.ad" style="color:#00aeff; font-weight: 550;">공지사항 관리</a>
			</div>
	    </div>
		<div id="content_1">
		
			<p id="sub-title">공지사항 등록</p>
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
<!-- 				<form id="file-form" method="post" enctype="multipart/form-data"> -->
					<input type="file" name="upfile" id="files" class="files" onchange="uploadFiles()" multiple="multiple">
					<label for="files" id="upFile-button">파일찾기</label>
					<div id="files-info"></div>
<!-- 				</form> -->
				<input type="text" id="notice-title" placeholder="제목을 입력하세요.">
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
	        maxHeight: 500
	    });
        jb('.note-insert').css('display', 'none')
        jb('.note-table').css('display', 'none')
        jb('.note-view').css('display', 'none')
	});
	
	const dataTransfer = new DataTransfer();
	
	function uploadFiles(){
		const fileArr = document.getElementById('files').files;
		
		const fileInfo = document.getElementById('files-info')
		

		if(fileArr != null && fileArr.length>0){
			for(var i=0; i<fileArr.length; i++){
				const pTag = document.createElement('p')
				const btn = document.createElement('button')
				
				pTag.innerHTML += fileArr[i].name
				pTag.setAttribute('class', 'select-file')
				btn.setAttribute('class', 'delete-btn')
				btn.innerHTML = "<i class='fa-solid fa-xmark'></i>"
				pTag.appendChild(btn)
				fileInfo.append(pTag)
				
				dataTransfer.items.add(fileArr[i])
			}
			document.getElementById('files').files = dataTransfer.files;
		}
		
		const delBtn = document.querySelectorAll('.delete-btn')
		const file = document.querySelectorAll('.select-file')
		
		delBtn.forEach(function(btn, idx){
			btn.addEventListener('click', function(){
				dataTransfer.items.remove(idx)
				file[idx].remove()
			})
		})
	}
	
	function insert(){
		const fieldSelect = document.getElementById('field-select');
		const categorySelect = document.getElementById('category-select');
		
		const field = fieldSelect.options[fieldSelect.selectedIndex].value;
		const category = categorySelect.options[categorySelect.selectedIndex].value;
		
		const user = "${loginUser.professorNo}";

		const title = document.getElementById('notice-title').value
		const content = document.querySelector('.note-editable').innerHTML

// 		var data = {   
// 			"fiels" :field,
// 		    "category" : category,
// 		    "user" : user,
// 		    "title" : title,
// 		    "content" : content
// 		}
		
// 		var formData = new FormData($('#file-form')[0]);
		
// 		const fileInput = document.getElementsByClassName('	files')
// 		for (var i = 0; i < fileInput.length; i++) {
// 			if (fileInput[i].files.length > 0) {
// 				for (var j = 0; j < fileInput[i].files.length; j++) {
// 					formData.append('upfile', $('.files')[i].files[j]);
// 				}
// 			}
// 		}

// 		formData.append('key', new Blob([ JSON.stringify(data) ], {type : "application/json"}));
		
// 		const upfile = document.getElementById('files').files
// 		console.log(upfile)
		
		const formData = new FormData();
		var inputFile = $("input[name='upfile']");
		var files = inputFile[0].files;
	
		for(var i=0; i<files.length; i++){
			formData.append("upfile", files[i])
		}
		
		$.ajax({
			url: "insertNoticeForm.ad",
			data: {
				field : field,
				category : category,
				user : user,
				title : title,
				content : content,
// 				upfile :  upfile
				formData : formData
			},
			contentType: false,
			processData: false,
// 			enctype : 'multipart/form-data',
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