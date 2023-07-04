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
				<form action="insertNoticeForm.ad" id="file-form" method="post" onsubmit="return insertForm()" enctype="multipart/form-data">
					<input type="hidden" name="professorNo" value="${loginUser.professorNo }">
					<table id="select-area">
						<tbody>
							<tr>
								<th>게시판 선택</th>
								<td>
									<select id="field-select" name="field">
										<option  value="0">공지사항</option>
										<option value="1">FAQ</option>
									</select>
								</td>
								<th>카테고리 선택</th>
								<td>
									<select id="category-select" name="noticeCategory">
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
					<input type="file" name="upfile" id="files" class="files" multiple="multiple">
					<label for="files" id="upFile-button">파일찾기</label>
					<div id="files-info"></div>
					
					<input type="text" id="notice-title" name="noticeTitle" placeholder="제목을 입력하세요." required="required">
					<textarea name="noticeContent" id="noticeContent" style="display:none;"></textarea>
					<div id="summernote"></div>
					<div id="btn-area">
						<button type="button" id="back" onclick="history.back();">이전</button>
						<button type="submit" id="submit">등록</button>
						<button type="button" id="submit" onclick="check()">확인</button>
					</div>
				</form>
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
	
	const uploadTag = document.getElementById('files');
	
	uploadTag.addEventListener('change', function(){
		const fileArr = document.getElementById('files').files;
		const fileInfo = document.getElementById('files-info')
		
		if(fileArr != null && fileArr.length>0){
			for(var i=0; i<fileArr.length; i++){
				const pTag = document.createElement('p')
				const btn = document.createElement('button')
				
				pTag.innerHTML += fileArr[i].name
				pTag.setAttribute('class', 'select-file')
				btn.setAttribute('onclick', 'deleteFiles()')
				btn.setAttribute('class', 'delete-btn')
				btn.innerHTML = "<i class='fa-solid fa-xmark'></i>"
				pTag.appendChild(btn)
				fileInfo.append(pTag)
				
				dataTransfer.items.add(fileArr[i])
			}
			document.getElementById('files').files = dataTransfer.files;
		}
		
		
	});
	
	
	
	// 파일 업로드 및 삭제
// 	function uploadFiles(){
		
// 		const fileArr = document.getElementById('files').files;
		
// 		const fileInfo = document.getElementById('files-info')
// 		var fileSize = 0;

// 		if(fileArr != null && fileArr.length>0){
// 			for(var i=0; i<fileArr.length; i++){
// 				console.log(fileArr[i].lastModified)
				
// 				const pTag = document.createElement('p')
// 				const btn = document.createElement('button')
				
// 				pTag.innerHTML += fileArr[i].name
// 				pTag.setAttribute('class', 'select-file')
// 				btn.setAttribute('class', 'delete-btn')
// 				btn.setAttribute('onclick', 'deleteFiles()')
// 				btn.innerHTML = "<i class='fa-solid fa-xmark'></i>"
// 				pTag.appendChild(btn)
// 				fileInfo.append(pTag)
				
// 				dataTransfer.items.add(fileArr[i])
// 			}
// 			document.getElementById('files').files = dataTransfer.files;
// 		}
// 		console.log(fileArr)
// 		const delBtn = document.querySelectorAll('.delete-btn')
// 		const file = document.querySelectorAll('.select-file')
// 		delBtn.forEach(function(btn, idx){
// 			btn.addEventListener('click', function(){
// 				if(dataTransfer.files[idx].lastModified==fileArr[idx].lastModified){
// 					// 총용량에서 삭제
// 					total_file_size-=dataTransfer.files[i].size
					
// 					dataTransfer.items.remove(idx)
// 					console.log(dataTransfer.files[idx])
// 					file[idx].remove()
// 					console.log(fileArr.length)
// 				}
				
				
				
				
// 				console.log(fileArr[idx].val)
// 				fileArr[idx] = '';
// 				dataTransfer.items.remove(idx)
// 				file[idx].remove()
// 			})
// 		})
		
// 	}
	
	function deleteFiles(){
		const files = document.getElementById('files').files;
		const fileArr = Array.from(files);
		const p = document.querySelectorAll('.select-file')
		
		fileArr.forEach(function(file, idx){
			p[idx].remove()
			console.log(p[idx])
// 			fileArr.splice(idx, 1);
// 			console.log(fileArr)
// 			dataTransfer.items.add(file)
		});
// 		fileArr.splice(i, 1);
// 		console.log(fileArr)
// 		const fileArr = $("#files")[0].files;
// 		const file = document.querySelectorAll('.select-file')
// 		delBtn.forEach(function(btn, idx){
// 			btn.addEventListener('click', function(){
// 				console.log('삭제')
// 				fileArr[idx] = '';
// 				dataTransfer.items.remove(idx)
// 				file[idx].remove()
// 			})
// 		})

		
	}
	
	function insertForm(){
		const txtarea = document.getElementById('noticeContent')
		const note = document.querySelector('.note-editable').innerHTML
		txtarea.value = note			
		
		if(note == '<p><br></p>'){
			alert("내용을 입력해주세요.")
			return false;
		}
	}
	
	function check(){
		const upfile = document.querySelectorAll('.files')
		
		console.log(upfile)
	}
	
</script>
</body>
</html>