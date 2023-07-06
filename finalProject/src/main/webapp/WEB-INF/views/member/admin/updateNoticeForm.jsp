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
		
			<p id="sub-title">공지사항 수정</p>
			<div id="editor-container">			
				<form action="updateNoticeForm.ad?noticeNo=${n.noticeNo }" id="file-form" method="post" onsubmit="return insertForm()" enctype="multipart/form-data">
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
					<input type="file" name="upfile" id="files" class="files" onchange="upload()" multiple="multiple">
					<label for="files" id="upFile-button">파일찾기</label>
					<ul id="files-info">
						<c:forEach var="i" items="${list }">
							<li class="list-file">
								<input type="hidden" name="fileNo" id="fileNo" value="${i.fileNo }">
								<button type="button" class="list-del"><i class='fa-solid fa-xmark'></i></button>
								${i.originName }
							</li>
						</c:forEach>
					</ul>
					
					<input type="text" id="notice-title" name="noticeTitle" value="${n.noticeTitle }" placeholder="제목을 입력하세요." required="required">
					<textarea name="noticeContent" id="noticeContent" style="display:none;"></textarea>
					<div id="summernote"></div>
					<div id="btn-area">
						<button type="button" id="back" onclick="location.href='selectNotice.ad'">이전</button>
						<button type="submit" id="submit">수정</button>
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
        
        const noticeContent = '${n.noticeContent}'
       
        if('${n.noticeContent}' != null){
	        jb('.note-placeholder').remove()    	
        }
        jb('.note-editable').html(noticeContent)
        
        const fieldSelect = document.getElementById('field-select');
        const fieldLength = fieldSelect.options.length;
        const field = '${n.field}'
        
         for(var i=0; i<fieldLength; i++){
        	 if(fieldSelect.options[i].value == field){
        		 fieldSelect.options[i].selected = true;
        	 }
         }
        
		const categorySelect = document.getElementById('category-select');
		const cateLength = categorySelect.options.length;
		const category = '${n.noticeCategory}'
		
		for(var i=0; i<cateLength; i++){
        	 if(categorySelect.options[i].value == category){
        		 categorySelect.options[i].selected = true;
        	 }
         }
		
	});
	
	//조회한 첨부파일 삭제
	const delBtn = document.querySelectorAll('.list-del');
	const form = document.getElementById('file-form');
	
	delBtn.forEach(function(btn, i){			
		btn.addEventListener('click', function(){
			const input = document.createElement('input');
			input.setAttribute('type', 'hidden');
			input.setAttribute('name', 'delFileNo');
			input.setAttribute('value', btn.previousElementSibling.value);
			form.appendChild(input);
			btn.parentNode.style.display = 'none';
		});
	});
	
	const dataTransfer1 = new DataTransfer();
	const dataTransfer2 = new DataTransfer();
	
	function upload(){
		var fileArr = document.getElementById("files").files
		const fileInfo = document.getElementById('files-info')
		
		if(dataTransfer2.files.length != 0){
			//파일 리스트에서 삭제한 값이 있을 때
			if(fileArr != null && fileArr.length>0){
	
	          // =====DataTransfer 파일 관리========
	            for(var i=0; i<fileArr.length; i++){
	            	const li = document.createElement('li')
					const btn = document.createElement('button')
	
					li.innerHTML = fileArr[i].name
					li.setAttribute('class', 'select-file')
					btn.setAttribute('type', 'button')
					btn.setAttribute('class', 'remove-btn')
					btn.innerHTML = "<i class='fa-solid fa-xmark' onclick='deleteFile(event)' data-index="+fileArr[i].lastModified+"></i>"
					li.appendChild(btn)
					fileInfo.append(li)
	            	
	                dataTransfer2.items.add(fileArr[i])
	            }
	            document.getElementById("files").files = dataTransfer2.files;
	            console.log("dataTransfer =>",dataTransfer2.files)
	            console.log("input FIles =>", document.getElementById("files").files)
			}
			
		}else{
			if(fileArr != null && fileArr.length>0){
			//파일 리스트에서 삭제한 값이 있을 때
			
	            for(var i=0; i<fileArr.length; i++){
	            	const li = document.createElement('li')
					const btn = document.createElement('button')
	
					li.innerHTML = fileArr[i].name
					li.setAttribute('class', 'select-file')
					btn.setAttribute('type', 'button')
					btn.setAttribute('class', 'remove-btn')
					btn.innerHTML = "<i class='fa-solid fa-xmark' onclick='deleteFile(event)' data-index="+fileArr[i].lastModified+"></i>"
					li.appendChild(btn)
					fileInfo.append(li)
	            	
	                dataTransfer1.items.add(fileArr[i])
	            }
	            document.getElementById("files").files = dataTransfer1.files;
	            console.log("dataTransfer =>",dataTransfer1.files)
	            console.log("input FIles =>", document.getElementById("files").files)
			}
		} 
	}
	
	
	
	function deleteFile(event){
		const fileArr = document.getElementById("files").files
		
		console.log(event.target.className)
		if(dataTransfer2.files.length != 0){
	        if(event.target.className == 'fa-solid fa-xmark'){
	            const removeTargetId = event.target.dataset.index;
	            console.log("removeTargetId => ", removeTargetId);
	            
	            const files = Array.from(fileArr).filter(file => file.lastModified != removeTargetId);
	            files.splice(removeTargetId, 1);
	            
	            dataTransfer2.items.clear()
	           	
	            files.forEach(function(file){
	            	dataTransfer2.items.add(file);
	            });
	            
	            document.querySelector('#files').files = dataTransfer2.files;
	            
	            removeTargetId.remove;
				event.target.parentNode.parentNode.remove();
				event.target.parentNode.remove();
				event.target.remove();
	
		        console.log("dataTransfer 삭제후=>",dataTransfer2.files)
		        console.log('input FIles 삭제후=>',document.getElementById("files").files)
	        }
		}else{
			if(event.target.className == 'fa-solid fa-xmark'){
	            const removeTargetId = event.target.dataset.index;
	            console.log("removeTargetId => ", removeTargetId);
	            
	            const files = Array.from(fileArr).filter(file => file.lastModified != removeTargetId);
	            
	            files.splice(removeTargetId, 1);
	           	
	            files.forEach(function(file){
	            	dataTransfer2.items.add(file);
	            });
	            
	            document.querySelector('#files').files = dataTransfer2.files;
	            
	            removeTargetId.remove;
				event.target.parentNode.parentNode.remove();
				event.target.parentNode.remove();
				event.target.remove();
	
		        console.log("dataTransfer 삭제후=>",dataTransfer2.files)
		        console.log('input FIles 삭제후=>',document.getElementById("files").files)
	        }
		}
	}
	
	function insertForm(){
		const txtarea = document.getElementById('noticeContent')
		const note = document.querySelector('.note-editable').innerHTML
		txtarea.value = note
		
		if(note == ''){
			alert("내용을 입력해주세요.")
			return false;
		}
	}
	
	const msg = '${msg }'
	
	if(msg != ''){
		alert(msg);
	}
	
</script>
</body>
</html>