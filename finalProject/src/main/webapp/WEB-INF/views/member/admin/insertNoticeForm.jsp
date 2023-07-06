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
				<form action="insertNoticeForm.ad?professorNo=${loginUser.professorNo }" id="file-form" method="post" onsubmit="return insertForm()" enctype="multipart/form-data">
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
					<ul id="files-info"></ul>
					
					<input type="text" id="notice-title" name="noticeTitle" placeholder="제목을 입력하세요." required="required">
					<textarea name="noticeContent" id="noticeContent" style="display:none;"></textarea>
					<div id="summernote"></div>
					<div id="btn-area">
						<button type="button" id="back" onclick="history.back();">이전</button>
						<button type="submit" id="submit">등록</button>
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
	
	
	let dataTransfer = new DataTransfer();
	
	function upload(){
		var fileArr = document.getElementById("files").files
		const fileInfo = document.getElementById('files-info')
		
		if(fileArr != null && fileArr.length>0){
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
				
				dataTransfer.items.add(fileArr[i])
            }
            document.getElementById("files").files = dataTransfer.files;
            console.log("dataTransfer =>",dataTransfer.files)
            console.log("input FIles =>", document.getElementById("files").files)
		}
	}
	
	function deleteFile(event){
		const fileArr = document.getElementById("files").files
		
		if(event.target.className == 'fa-solid fa-xmark'){
			console.log('click')
            const removeTargetId = event.target.dataset.index;
            console.log("removeTargetId => ", removeTargetId);
           
            const files = Array.from(fileArr).filter(file => file.lastModified != removeTargetId);
            files.splice(removeTargetId, 1);
           
            dataTransfer.items.clear()
          	
            files.forEach(function(file){
            	dataTransfer.items.add(file);
            });
           
            document.querySelector('#files').files = dataTransfer.files;
           
            removeTargetId.remove;
			event.target.parentNode.parentNode.remove();
			event.target.parentNode.remove();
			event.target.remove();

	        console.log("dataTransfer 삭제후=>",dataTransfer.files)
	        console.log('input FIles 삭제후=>',document.getElementById("files").files)
        }
	    
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
	
	
</script>
</body>
</html>