<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/fin/resources/css/adminSelectNotice.css">
<script src="https://kit.fontawesome.com/7f4a340891.js" crossorigin="anonymous"></script>
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
			
			<div id="search-box">
				<div style="margin-bottom: 30px;">
					<select id="field-select">
						<option value="all-field">=== 공지사항 전체 ===</option>
						<option value="0">공지사항</option>
						<option value="1">FAQ</option>
					</select>
					<select id="category-select">
						<option value="all-category">=== 카테고리 전체 ===</option>
						<option value="1">학사</option>
						<option value="2">장학</option>
						<option value="3">입학</option>
						<option value="4">채용</option>
						<option value="5">기타</option>
					</select>
					<select id="search-type">
						<option value="all-type">=== 전체 ===</option>
						<option value="title">제목만</option>
						<option value="content">내용만</option>
					</select>
				</div>
				<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해 주세요.">				
				<button id="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
			</div>
			
			<div style="width: 90%; margin: auto;">
				<button id="insert" onclick="insert();">등록</button>
			</div>
			
			<div id="result-area">
				<table id="result-table">
					<thead>
						<tr>
							<th><input type='checkBox' id='allChk' name='allChk' onclick="selectAll(this)"></th>
							<th>No.</th>
							<th>분류</th>
							<th>카테고리</th>
							<th>제목</th>
							<th>첨부파일</th>
							<th>게시일</th>	
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div id="btn-area">
				<button id="delete" onclick="deleteVal()">삭제</button>
				<button id="update" onclick="update()">수정</button>
			</div>

		</div>
	</div>
</div>

<script type="text/javascript">
	
	window.onload = function(){
		
		$.ajax({
			url: "selectNoticeList.ad",
			type: "post",
			success: function(result){
				var str = "";
				
				result.forEach(function(result){
					str += "<tr>"
						+"<td>"+"<input type='checkBox' class='chkRows' name='chkRows'>"+"</td>"
						+"<td>"+result.noticeNo+"</td>";
						
						if(result.field == 0){
							str +="<td>"+"공지사항"+"</td>"
								+"<td>"+result.categoryName+"</td>"
								+"<td>"+result.noticeTitle+"</td>";							
						}else{
							str +="<td>"+"FAQ"+"</td>"
								+"<td>"+result.categoryName+"</td>"
								+"<td>"+result.noticeTitle+"</td>";
						}
						
						if (result.originName != null) {
							str += "<td style='width: 80px;'>"+"<i class='fa-solid fa-paperclip'></i>"+"</td>"
							+"<td>"+result.createDate+"</td>"
							+"</tr>"
						}else{
							str += "<td></td>"
							+"<td>"+result.createDate+"</td>"
							+"</tr>"
						}
				})
				
				$('#result-table > tbody').html(str);
				
				selectRow()
			},
			error: function(){
				alert("현재 페이지를 로드할 수 없습니다.");
			}
		})
		
		var submit = document.getElementById('submit')
	
		submit.addEventListener('click', function(){
			var fieldSelect = document.getElementById('field-select');
			var categorySelect = document.getElementById('category-select');
			var searchType = document.getElementById('search-type')
			
			var field = fieldSelect.options[fieldSelect.selectedIndex].value;
			var category = categorySelect.options[categorySelect.selectedIndex].value;
			var type = searchType.options[searchType.selectedIndex].value;
			var keyword = document.getElementById('keyword').value;
			
			if(keyword == ''){
				alert("검색어를 입력해주세요.");
				location.reload();
			}else{
				$.ajax({
					url: "searchNotice.ad",
					type: "post",
					data: {
						field : field,
						category : category,
						keyword : keyword,
						type : type
					},
					success: function(data){
						var str = "";
						
						data.forEach(function(data){
							str += "<tr>"
								+"<td>"+"<input type='checkBox' class='chkRows' name='chkRows'>"+"</td>"
								+"<td>"+data.noticeNo+"</td>";
								
								if(data.field == 0){
									str +="<td>"+"공지사항"+"</td>"
									+"<td>"+data.categoryName+"</td>"
									+"<td>"+data.noticeTitle+"</td>";
								}else{
									str +="<td>"+"FAQ"+"</td>"
									+"<td>"+data.categoryName+"</td>"
									+"<td>"+data.noticeTitle+"</td>";
								}
								
								if (data.originName != null) {
									str += "<td style='width: 80px;'>"+"<i class='fa-solid fa-paperclip'></i>"+"</td>"
									+"<td>"+data.createDate+"</td>"
									+"</tr>"
								}else{
									str += "<td></td>"
									+"<td>"+data.createDate+"</td>"
									+"</tr>"
								}
							
						})
						
						alert("검색 결과는 총 "+data.length+" 건 입니다.");
						$('#result-table > tbody').html(str);
					},
					error: function(){
						console.log("통신오류");
					}
				})		
			}
		})
			
	}
	
	function selectRow(){
		const tr = document.querySelectorAll('#result-table tbody tr')
		
		tr.forEach(function(tr){
			tr.addEventListener('click', function(){
				const noticeNo = tr.childNodes[1].innerText
				location.href = 'detailNoticeView.ad?noticeNo='+noticeNo;
			});
		});
	}
	
	function selectAll(selectAll){
		const checkBoxes = document.getElementsByName('chkRows')
		
		checkBoxes.forEach(function(checkBox){
			checkBox.checked = selectAll.checked
		})
	}
	
	function insert(){
		location.href = 'insertNotice.ad';
	}
	
	function update(){
		const query = 'input[name="chkRows"]:checked';
		const selectBox = document.querySelectorAll(query);
		const tr = document.querySelectorAll('#result-table tbody tr')
		
		if(selectBox.length > 1){
			alert("게시글을 한 개만 선택해주세요.")
		}else{
			tr.forEach(function(tr){
				const checkBox = tr.children[0].children[0];
				
				if(checkBox.checked == true){
					const noticeNo = tr.children[1].innerHTML
					location.href = "updateNotice.ad?noticeNo="+noticeNo;
				}
			})
		}
	}
	
	function deleteVal(){
		const allChk = $('#allChk').is(':checked');
		const query = 'input[name="chkRows"]:checked';
		const selectBox = document.querySelectorAll(query);
		const tr = document.querySelectorAll('#result-table tbody tr')
		
		if(selectBox.length < 1){
			alert("게시글을 한 개 이상 선택해주세요.")
		}
		
		var noticeNo = new Array();
		
		if(allChk == true){
			noticeNo = [];
		}else{
			tr.forEach(function(tr, idx){
				const checkBox = tr.children[0].children[0];

				if(checkBox.checked == true){
					noticeNo.push(tr.children[1].innerHTML)
				}
			})
		}
		console.log(noticeNo)
		$.ajax({
			url: "deleteNotice.ad",
			data: {
				noticeNo : noticeNo
			},
			traditional: true,
			type: "post",
			success: function(data){
				alert(data);
				location.reload();
			},
			error: function(data){
				alert(data);
			}
		})
	}
	
	//행 선택 시 체크박스 체크
// 	$(document).on('click', '#result-table tbody tr', function(e){
// 		if($(e.target).is('input[type="checkBox"]')){
// 			return;
// 		}
// 		const chkBox = $(this).find('input[type="checkBox"]')
// 		chkBox.prop('checked', !chkBox.prop('checked'))
// 	})
	
	
</script>
</body>
</html>