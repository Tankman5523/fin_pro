package com.univ.fin.common.template;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;

public class ChatBot {

	public String answer (String que){
		
		HashMap<Integer, String> resultHash = new HashMap<>(); //사용자가 검색한 관련 값 담을 맵
		String result = ""; //최종 결과 담을 변수
		if(que.equals("전체")) {
			resultHash.put(0, "전체");
		}else {
			//공백 제거
			String question = que.replace(" ", "");
			
			HashMap<Integer, String> h = new HashMap<>(); //사용자가 검색한 관련 값 판별할 맵
			
			
			h.put(0, "학교소개");
			h.put(1, "학사소개");
			h.put(2, "학사일정");
			h.put(3, "공지");
			h.put(4, "종합정보시스템");
			h.put(5, "등록장학");
			h.put(6, "등록금납부조회");
			h.put(7, "등록금납입이력");
			h.put(8, "장학금수혜내역");
			h.put(9, "학사관리");
			h.put(10, "학적정보조회");
			h.put(11, "개인 시간표");
			h.put(12, "휴학복학신청");
			h.put(13, "휴학복학조회");
			h.put(14, "졸업사정표");
			h.put(15, "상담관리");
			h.put(16, "상담이력조회");
			h.put(17, "상담신청");
			h.put(18, "수강신청");
			h.put(19, "강의시간표");
			h.put(20, "수강취소");
			h.put(21, "수강신청내역조회");
			h.put(22, "예비수강신청");
			h.put(23, "수업관리");
			h.put(24, "학기별성적조회");
			h.put(25, "성적이의신청");
			h.put(26, "강의평가");
			h.put(27, "전체");
			
			
			HashMap<Integer, String> test = new HashMap<>();
			int num = 0; //인덱스 처리할 변수
			
			/* 사용자 입력값 경우의 수 처리 */
			for(int i=0; i<question.length(); i++) {
				
				String setText = String.valueOf(question.charAt(i));
				for(int j=0; j<question.length(); j++) {
					String resultText = setText+question.charAt(j);
					test.put(num, resultText);
					num++;
				}
			}
			
			/* 해당 값 담아주기 */
			HashMap<Integer, String> setHash = new HashMap<>(); //사용자가 검색한 관련 값 담을 맵
			int count = 0;
			for(int i=0; i<h.size(); i++) {
				for(int j=0; j<test.size(); j++) {
					if(h.get(i).contains(test.get(j))) {
						setHash.put(count, h.get(i));
						count++;
					}
				}
			}
			
			ArrayList<Integer> list = new ArrayList<>();
			int listCount = 0;
			
			int chkCount2 = 0;
			for(int i=0; i<setHash.size(); i++) {
				for(int j=0; j<setHash.size(); j++) {
					if(i!=j && setHash.get(i).equals(setHash.get(j))) {
						chkCount2++;
					}
					if(chkCount2 == 2) {
						list.add(listCount, j);
						listCount++;
						chkCount2 = 0;
					}
				}
			}
			
			for(int i=0; i<list.size(); i++) {
				setHash.remove(list.get(i));
			}
			
			/*
			int resultCount = 0;
			for(int i=0; i<setHash.size(); i++) {
				resultHash.put(resultCount, setHash.get(i));
				setHash.
			}
			*/
			
		}
		/* 최종 변수 생성 */
		for(int i=0; i<resultHash.size(); i++) {
			
			switch(resultHash.get(i)) {
				case "학교소개" : result += "<button onclick="+"location.href='universityIntro.mp'"+">학교소개 페이지로</button><br>";
					break;
				case "학사소개" : result += "<button onclick="+"location.href='haksaInfo.mp'"+">학사소개 페이지로</button><br>";
					break;
				case "학사일정" : result += "<button onclick="+"location.href='haksaSchedule.mp'"+">학사일정 페이지로</button><br>";
					break;
				case "공지" : result += "<button onclick="+"location.href='notice.mp'"+">공지게시판 페이지로</button><br>";
					break;
				case "종합정보시스템" : result += "<button onclick="+"location.href='infoSystem.mp'"+">종합정보시스템 페이지로</button><br>";
					break;
				case "등록장학" : result += "<button onclick='questionBtn(1)'>등록/장학</button><br>";
					break;
				case "등록금납부조회" : result += "<button onclick="+"location.href='onelist.rg'"+">등록금 납부조회</button><br>";
					break;
				case "등록금납입이력" : result += "<button onclick="+"location.href='listPage.rg'"+">등록금 납입이력</button><br>";
					break;
				case "장학금수혜내역" : result += "<button onclick="+"location.href='listPage.sc'"+">장학금 수혜내역</button><br>";
					break;
				case "학사관리" : result += "<button onclick='questionBtn(2)'>학사관리</button><br>";
					break;
				case "학적정보조회" : result += "<button onclick="+"location.href='infoStudent.st'"+">학적 정보 조회</button><br>";
					break;
				case "개인시간표" : result += "<button onclick="+"location.href='personalTimetable.st'"+">개인시간표</button><br>";
					break;
				case "휴학복학신청" : result += "<button onclick="+"location.href='studentRestEnroll.st'"+">휴/복학 신청</button><br>";
					break;
				case "휴학복학조회" : result += "<button onclick="+"location.href='studentRestList.st'"+">휴/복학 조회</button><br>";
					break;
				case "졸업사정표" : result += "<button onclick="+"location.href='graduationInfoForm.st'"+">졸업사정표</button><br>";
					break;
				case "상담관리" : result += "<button onclick='questionBtn(3)'>상담관리</button><br>";
					break;
				case "상담이력조회" : result += "<button onclick="+"location.href='counselingList.st'"+">상담이력조회</button><br>";
					break;
				case "상담신청" : result += "<button onclick="+"location.href='counselingEnroll.st'"+">상담신청</button><br>";
					break;
				case "수강신청" : result += "<button onclick='questionBtn(4)'>수강신청</button><br>";
					break;
				case "강의시간표" : result += "<button onclick="+"location.href='classListView.st'"+">강의시간표</button><br>";
					break;
				case "수강취소" : result += "<button onclick="+"location.href='cancelRegClassForm.st'"+">수강취소</button><br>";
					break;
				case "수강신청내역조회" : result += "<button onclick="+"location.href='searchRegClassForm.st'"+">수강신청 내역조회</button><br>";
					break;
				case "예비수강신청" : result += "<button onclick="+"location.href='preRegisterClassForm.st'"+">예비수강신청</button><br>";
					break;
				case "수업관리" : result += "<button onclick='questionBtn(5)'>수강신청</button><br>";
					break;
				case "학기별성적조회" : result += "<button onclick="+"location.href='classManagement.st'"+">학기별 성적 조회</button><br>";
					break;
				case "성적이의신청" : result += "<button onclick="+"location.href='#'"+">성적 이의신청</button><br>";
					break;
				case "강의평가" : result += "<button onclick="+"location.href='#'"+">강의평가</button><br>";
					break;
				case "전체" : result += "<button onclick="+"location.href='mainPage.mp'"+">메인 페이지로</button><br>"
									+ "<button onclick='questionBtn(1)'>등록/장학</button>"
									+ "<button onclick='questionBtn(2)'>학사관리</button>"
									+ "<button onclick='questionBtn(3)'>상담관리</button>"
									+ "<button onclick='questionBtn(4)'>수강신청</button>"
									+ "<button onclick='questionBtn(5)'>수업관리</button>";
					break;
			}
			
		}
		if(result == "") {
			return result += "<div>검색결과가 없습니다.<br> 다시 한번 입력해 주세요.</div><br>";
		}else {
			return result;
		}
	}
	
	public String select() {
		
		String result = "";
		
		result += answer("전체");
		
		return result;
	}
	
	/* 큰 카테고리 */
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
							+ "<button onclick="+"location.href='#'"+">성적 이의신청</button><br>"
							+ "<button onclick="+"location.href='#'"+">강의평가</button><br>";
				break;
		}
		
		
		return result;
	}
	
	
}
