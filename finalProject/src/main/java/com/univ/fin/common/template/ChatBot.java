package com.univ.fin.common.template;

import java.util.HashMap;

public class ChatBot {

	public String answer (String que){
		
		//공백 제거
		String question = que.replace(" ", "");
		
		String result = ""; //최종 결과 담을 변수
		int num = 1; //인덱스 처리할 변수
		
		HashMap<Integer, String> h = new HashMap<>(); //사용자가 검색한 관련 값 판별할 맵
		HashMap<Integer, String> resultHash = new HashMap<>(); //사용자가 검색한 관련 값 담을 맵
		
		h.put(1, "학교소개");
		h.put(2, "학사소개");
		h.put(3, "학사일정");
		h.put(4, "공지");
		h.put(5, "종합정보시스템");
		h.put(6, "등록/장학");
		h.put(7, "학사관리");
		h.put(8, "상담관리");
		h.put(9, "수강신청");
		h.put(10, "수업관리");
		h.put(11, "전체");
		
		/* 사용자가 검색한 관련 값 판별 후  담기 */
		for(int i=1; i<=h.size(); i++) {
			
			if(question.contains(h.get(i))) {
				resultHash.put(num, h.get(i));
				num++;
			}else if(h.get(i).contains(question)) {
				resultHash.put(num, h.get(i));
				num++;
			}
		}
		
		/* 최종 변수 생성 */
		for(int i=1; i<=resultHash.size(); i++) {
			
			switch(resultHash.get(i)) {
				case "학교소개" : result += "<button onclick="+"location.href='universityIntro.mp'"+">학교소개 페이지로</button>";
					break;
				case "학사소개" : result += "<button onclick="+"location.href='haksaInfo.mp'"+">학사소개 페이지로</button>";
					break;
				case "학사일정" : result += "<button onclick="+"location.href='haksaInfo.mp'"+">학사일정 페이지로</button>";
					break;
				case "공지" : result += "<button onclick="+"location.href='notice.mp'"+">공지게시판 페이지로</button>";
					break;
				case "종합정보시스템" : result += "<button onclick="+"location.href='infoSystem.mp'"+">종합정보시스템 페이지로</button>";
					break;
				case "등록/장학" : result += detailSelect(1);
					break;
				case "학사관리" : result += detailSelect(2);
					break;
				case "상담관리" : result += detailSelect(3);
					break;
				case "수강신청" : result += detailSelect(4);
					break;
				case "수업관리" : result += detailSelect(5);
					break;
				case "전체" : result += "<button onclick="+"location.href='mainPage.mp'"+">메인 페이지로</button><br>"
									+ "<button onclick='questionBtn(1)'>등록/장학</button>"
									+ "<button onclick='questionBtn(2)'>학사관리</button>"
									+ "<button onclick='questionBtn(3)'>상담관리</button>"
									+ "<button onclick='questionBtn(4)'>수강신청</button>"
									+ "<button onclick='questionBtn(5)'>수업관리</button>";
					break;
				default : result += "<button onclick='questionBtn(0)' style='width : 100%';>이전으로</button>";
			}
			
			if(i != resultHash.size()) {
				result += "<br>";
			}
		}
		if(result == "") {
			return result += "<div>검색결과가 없습니다.<br> 다시 한번 입력해 주세요.</div><br>"
						  + "<button onclick='questionBtn(0)' style='width : 100%';>이전으로</button>";
		}else {
			return result;
		}
	}
	
	public String select() {
		
		String result = "";
		
		result += answer("전체");
		
		return result;
	}
	
	public String detailSelect(int num) {
		
		String result = "";
		
		switch(num) {
			case 1 : result += "<button onclick="+"location.href='onelist.rg'"+">등록금 납부조회</button><br>"
							+ "<button onclick="+"location.href='listPage.rg'"+">등록금 납입이력</button><br>"
							+ "<button onclick="+"location.href='listPage.sc'"+">장학금 수혜내역</button><br>";
				break;
			case 2 : result += "<button onclick="+"location.href='infoStudent.st'"+">학적 정보 조회</button><br>"
							+ "<button onclick="+"location.href='personalTimetable.st'"+">개인시간표</button><br>"
							+ "<button onclick="+"location.href='studentRestEnroll.st'"+">휴/복학 신청</button><br>"
							+ "<button onclick="+"location.href='studentRestList.st'"+">휴/복학 조회</button><br>"
							+ "<button onclick="+"location.href='graduationInfoForm.st'"+">졸업사정표</button><br>";
				break;
			case 3 : result += "<button onclick="+"location.href='counselingList.st'"+">상담이력조회</button><br>"
							+ "<button onclick="+"location.href='counselingEnroll.st'"+">상담신청</button><br>";
				break;
			case 4 : result += "<button onclick="+"location.href='classListView.st'"+">강의시간표</button><br>"
							+ "<button onclick="+"location.href='registerClassForm.st'"+">수강신청</button><br>"
							+ "<button onclick="+"location.href='cancelRegClassForm.st'"+">수강취소</button><br>"
							+ "<button onclick="+"location.href='searchRegClassForm.st'"+">수강신청 내역조회</button><br>"
							+ "<button onclick="+"location.href='preRegisterClassForm.st'"+">예비수강신청</button><br>";
				break;
			case 5 : result += "<button onclick="+"location.href='classManagement.st'"+">학기별 성적 조회</button><br>"
							+ "<button onclick="+"location.href='#'"+">성적 이의신청</button><br>";
				break;
		}
		result += "<button onclick='questionBtn(0)' style='width : 100%';>이전으로</button>";
		
		return result;
	}
	
	
}
