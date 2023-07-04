package com.univ.fin.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.univ.fin.common.model.vo.AlarmVo;
import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.CalendarVo;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.Grade;
import com.univ.fin.common.model.vo.Graduation;
import com.univ.fin.common.model.vo.Objection;
import com.univ.fin.common.model.vo.ProfessorRest;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.model.vo.StudentRest;
import com.univ.fin.main.model.vo.Notice;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.vo.RegistPay;

public interface MemberService {

	//학생 로그인
	Student loginStudent(Student st);
	
	//임직원 로그인
	Professor loginProfessor(Professor pr);

	//ID조회 - 학생
	Student checkEmail(Student st);

	//ID조회 - 임직원
	Professor checkEmail2(Professor pr);

	//비밀번호 초기화 - 학생
	Student checkPwd(Student st);
	
	//비밀번호 초기화  - 임직원
	Professor checkPwd2(Professor pr);
	
	//비밀번호 초기화 - 비밀번호 변경 메소드 (학생)
	int changePwd(Student st);

	//비밀번호 초기화 - 비밀번호 변경 메소드 (임직원)
	int changePwd2(Professor pr);
	
	//수강신청 - 수강신청내역조회 (로그인 학생의 수강신청 년도/학기 추출)
	ArrayList<Classes> searchRegYear(String studentNo);
	
	//예비수강신청 - 수강조회
	ArrayList<RegisterClass> preRegClass(RegisterClass rc2);
	
	//예비수강신청 - 중복체크
	int checkPreReg(Bucket b);
	
	//예비수강신청 - 수강담기
	int preRegisterClass(Bucket b);
	
	//예비수강신청 - 장바구니 조회
	ArrayList<RegisterClass> preRegList(RegisterClass rc2);
	
	//예비수강신청 - 장바구니 수강취소
	int delPreRegList(RegisterClass rc);
	
	//수강신청 기간인지 체크
	ArrayList<CalendarVo> chkRegCal();
	
	//수강신청 - 수강신청 (수강조회)
	ArrayList<RegisterClass> postRegClass(RegisterClass rc2);
	
	//수강신청 - 수강신청 (장바구니)
	ArrayList<RegisterClass> postRegBucket(RegisterClass rc2);
	
	//수강신청 - 수강신청 (해당강의 조회)
	Classes selectClass(int classNo);
	
	//수강신청 - 수강신청 (강의 시간 체크)
	int checkPostReg2(RegisterClass rc2);
	
	//수강신청 - 수강신청
	int postRegisterClass(RegisterClass rc3);
	
	//수강신청 - 수강신청(해당 과목 장바구니에서 지워주기)
	int postRegDelBucket(RegisterClass rc2);
	
	//수강신청 - 수강신청(2시간짜리 강의)
	int postRegisterClass2(RegisterClass rc3);
	
	//수강신청 - 수강신청 (수강신청내역 조회)
	ArrayList<RegisterClass> postRegList(RegisterClass rc2);
	
	//수강신청 - 수강신청 (수강신청내역 수강취소)
	int delPostRegList(RegisterClass rc);
	
	//수강신청 - 수강신청 내역조회
	ArrayList<HashMap<String, String>> searchRegList(HashMap<String, String> h);
	
	// 강의시간표 -> 학년도,학기 조회
	ArrayList<String> selectClassTerm();
	
	// 강의시간표 -> 단과대학별 전공 조회
	ArrayList<String> selectDepert(String college);

	// 강의시간표 -> 전공 선택 후 전공수업 조회/교양수업 조회
	ArrayList<Classes> selectDepartment(HashMap<String, String> map);

	// 강의시간표 -> 교수명 검색/과목 검색
	ArrayList<Classes> searchClassKeyword(HashMap<String, String> map);

	//상담관리 - 상담내역조회(학생)
	ArrayList<Counseling> selectCounStuList(String studentNo);
	
	//상담신청 - 학과별 교수 전부 조회
	ArrayList<Professor> selectDepartProList(String departmentNo);

	//상담신청 - 상담신청 작성
	int insertCounseling(Counseling c);
	
	//상담관리 - 상담 상세보기(학생)
	Counseling selectCounseling(int counselNo);
	
	//교수정보 조회(직번으로)
	Professor selectProfessorForNo(String professorNo);
	
	//상담관리 - 상담 요청내용 수정(학생)
	int updateCounContent(Counseling c);

	//상담내역 검색
	ArrayList<Counseling> selectSearchCounseling(HashMap<String, String> map);

	//학적정보 수정 (학생)
	int updateStudent(Student st);
	
	//학적정보 수정 (교수)
	int updateProfessor(Professor pr);
	
	//학생추가 (관리자)
	int insertStudent(Student st);
	
	// 학생 개인시간표 -> 학년도,학기 조회
	ArrayList<String> selectStudentClassTerm(String studentNo);

	// 학생 개인시간표 -> 학기 선택 후 시간표 조회
	ArrayList<Classes> selectStudentTimetable(HashMap<String, String> map);
	
	//학사관리 - 졸업사정표
	Graduation graduationInfo(String sno);
	
	//학사관리 - 졸업사정표(전체 이수현황 조회)
	Graduation selectGraStatus(HashMap<String, String> h);
	
	//학사관리 - 졸업사정표 (교양공통 세부조회)
	ArrayList<HashMap<String, String>> detailCommonGra(HashMap<String, String> h);
	
	//학사관리 - 졸업사정표 (교양일반 세부조회)
	ArrayList<HashMap<String, String>> detailNomalGra(HashMap<String, String> h);
	
	//학사관리 - 졸업사정표 (전공심화 세부조회)
	ArrayList<HashMap<String, String>> detailmajorGra(HashMap<String, String> h);
	
	//(학생)휴,복학 신청 리스트 조회
	ArrayList<StudentRest> selectStuRestList(String studentNo);

	//(학생)휴학 횟수 가져옴
	int selectRestCount(String studentNo);

	//(학생)가장 최근 휴학 정보 가져옴
	StudentRest selectRestInfo(String studentNo);

	//(학생)휴학신청할떄 등록금 냈는지 확인
	RegistPay checkRegPay(RegistPay rp);

	//(학생)휴,복학 신청 인서트
	int insertStuRest(StudentRest sr);

	//(교수)강의개설 신청 리스트 조회
	ArrayList<Classes> selectClassCreateList(String professorNo);

	//(교수)강의 개설 인서트 
	int insertClassCreate(Classes c, Attachment a);

	//(관리자)강의 개설 전체 리스트 조회
	ArrayList<Classes> selectClassList();

	//(관리자) 강의 개설 강의계획서 가져오기
	ArrayList<Attachment> selectClassAttachment();
	
	// 교수 개인시간표 -> 학년도,학기 조회
	ArrayList<String> selectProfessorClassTerm(String professorNo);

	// 교수 개인시간표 -> 학기 선택 후 시간표 조회
	ArrayList<Classes> selectProfessorTimetable(HashMap<String, String> map);

	// 기간 확인
	int checkPeriod(String string);
	
	// 성적관리 -> 학점별로 몇명이 해당되는지
	HashMap<String, String> countStudentGrade(int classNo);

	// 성적관리 -> 수강중인 학생 조회
	ArrayList<HashMap<String, String>> selectStudentGradeList(int classNo);
	
	// 성적관리 -> 수강인원*비율에 따른 가능 인원 수
	int checkGradeNos(HashMap<String, String> map);
	
	// 성적관리 -> 실제 몇명이 해당되는지
	int countGradeNos(HashMap<String, String> map);

	// 성적관리 -> 성적 입력
	int gradeInsert(Grade g, HashMap<String, String> alarm);

	// 성적관리 -> 성적 수정
	int gradeUpdate(Grade g, HashMap<String, String> alarm);

	// 강의 이의제기 -> 학생 신청
	ArrayList<Objection> studentGradeReport(String studentNo);

	// 직원 생성하기
	int insertProfessor(Professor pr);

	// (관리자)강의개설 일괄 승인
	int updateClassPermitAll(int[] cArr);

	// (관리자)강의개설 개별 승인
	int updateClassPermit(int cno);

	// (관리자)강의개설 반려 업데이트
	int updateClassReject(Classes c);

	//교수이름으로 교수번호 가져오기
	String selectProfessorNo(String keyword);

	//(관리자)강의 검색
	ArrayList<Classes> selectClassListSearch(Classes c);

	//(교수)반려당한 강의 수정 페이지 이동
	Classes selectRejectedClass(int classNo);

	//(교수)반려당한 강의 첨부파일(강의계획서) 조회
	Attachment selectRejectedClassAtt(String fileNo);

	//(교수)반려된 강의 수정
	int updateClassCreate(Classes c, Attachment a);

	// 학기별 성적 조회 -> 학기 선택 후 강의 조회
	ArrayList<HashMap<String, String>> selectClassList(HashMap<String, String> map);
	
	// 학기별 성적 조회 -> 학기별 성적 계산
	HashMap<String, String> calculatedGrade(HashMap<String, String> map);
	
	// 학기별 성적 조회 -> 학기별석차
	String calculatedTermRank(HashMap<String, String> map);
	
	// 학기별 성적 조회 -> 전체석자
	String calculatedTotalRank(HashMap<String, String> map);

	// 학기별 성적 조회 -> 증명@@ 성적 계산
	HashMap<String, String> selectScoreAB(String studentNo);
	double selectScoreC(String studentNo);
	double selectScoreD(String studentNo);

	// (학생)수강한 강의정보 조회
	ArrayList<RegisterClass> classInfoForRating(ClassRating cr);
	
	// (학생)강의평가 입력
	int insertClassRating(ClassRating cr);
	
	// (관리자) 강의평가 조회
	ArrayList<ClassRating> classRatingList(ClassRating cr);
	
	// (관리자) 강의평가 기타건의 조회
	ArrayList<ClassRating> classRatingEtcList(ClassRating cr);
	
	// (관리자) 강의평가 문항별 평균 점수 조회
	ClassRating classRatingAverage(ClassRating cr);

	//(교수) 안식,퇴직 신청 목록 가져오기
	ArrayList<ProfessorRest> selectRestListPro(String professorNo);

	//(교수) 안식,퇴직 신청 등록
	int insertProRest(ProfessorRest pr);
	
	// (교수) 상담조회교수 상담조회
	ArrayList<Counseling> professorSelectCounseling(HashMap<String, String> counselMap);

	// 학사일정 관리 -> 학사일정 조회
	ArrayList<HashMap<String, String>> calendarList();

	// 학사일정 관리 -> 학사일정 추가
	int insertCalendar(CalendarVo c);

	// (교수) 상담 상세 조회
	Counseling selectCounselDetail(String counselNo);

	// 학사일정 관리 -> 학사일정 수정
	int updateCalendar(CalendarVo c);

	// 학사일정 관리 -> 학사일정 삭제
	int deleteCalendar(CalendarVo c);
	
	// 메인 -> 프로필 사진 조회
	String selectProfile(HashMap<String, String> map);
	
	// 메인 -> 학생 시간표 조회
	ArrayList<Classes> selectStudentAllClasses(String studentNo);
	
	// 메인 -> 교수 시간표 조회
	ArrayList<Classes> selectProfessorAllClasses(String professorNo);
	
	// 메인 -> 등록금 납부 조회
	ArrayList<HashMap<String, String>> selectReg(String studentNo);
	
	// 메인 -> 상담신청 조회
	ArrayList<Counseling> selectCounceling(String professorNo);

	// 메인 -> 학사일정 조회
	ArrayList<HashMap<String, String>> yearCalendarList();
	
	// 메인 -> 공지사항 조회
	ArrayList<Notice> selectMainNotice();

	// (교수) 상담 상태 변경
	int updateCounselStatus(HashMap<String, String> statusMap, HashMap<String, String> alarm);

	// (관리자) 학생 휴,복학 신청 리스트 조회
	ArrayList<Counseling> selectCounAllStuList();

	// (관리자) 임직원 안식,퇴직 신청 리스트 조회
	ArrayList<ProfessorRest> selectCounAllProList();

	// (관리자) 학생 휴,복학 신청 상세보기
	StudentRest selectStuRestDetail(int rno);

	// 학번으로 학생 정보 조회 해오기
	Student selectStudentInfo(String studentNo);

	// (관리자)학생 휴,복학 승인
	int updateStuRestPermit(StudentRest sr);
	
	// (관리자)학생 휴,복학 반려(비허가)
	int updateStuRestRetire(int restNo);

	// (관리자) 학생 휴,복학 목록 검색 
	ArrayList<StudentRest> selectSearchStuRestList(HashMap<String, String> set);
	
	// (관리자) 임직원 안식,퇴직 정보 조회
	ProfessorRest selectProRestDetail(int restNo);

	// (관리자) 임직원 안식,퇴직 업데이트
	int updateProfessorRest(ProfessorRest pr);

	// (관리자) 임직원 안식,퇴직 검색 리스트 조회
	ArrayList<ProfessorRest> selectSearchProRestList(HashMap<String, String> set);	
	
	// 알람 수신
	ArrayList<AlarmVo> alarmReceive(String studentNo);

	// 알람 전체확인
	int alarmAllCheck(String studentNo);
	
	// 알람 확인
	int alarmCheck(int alarmNo);

	// (관리자) 공지사항 관리 - 전체 공지사항 조회
	ArrayList<Notice> selectNoticeAllList();
	
	// (관리자) 메인페이지 -> 강의신청 목록 조회
	ArrayList<Classes> selectAdMainClasses();

	// (관리자) 메인페이지 -> 학생 휴학 및 퇴학 신청 목록 조회
	ArrayList<StudentRest> selectMainStudentRest();

	// (관리자) 메인페이지 -> 교수 안식 및 퇴직 신청 목록 조회
	ArrayList<ProfessorRest> selectMainProfessorRest();
	
	// (관리자) 공지사항 관리 - 공지사항 검색
	ArrayList<Notice> searchNotice(HashMap<String, String> noticeMap);

	// (관리자) 공지사항 관리 - 공지사항 전체 삭제
	int allDeleteNotice();

	// (관리자) 공지사항 관리 - 공지사항 선택 삭제
	int selectDeleteNotice(String[] noticeNo);
	
	//이의 신청 넘기기
	int studentGradeRequest(Objection obj);

	//이의 신청 확인
	ArrayList<Objection> studentGradeView(Objection obj);
		
	//이의 신청 패이지 검색
	int searchGradeReport(Objection objc);
	
	// (관리자) 공지사항 관리 - 공지사항 수정 페이지 이동
	Notice selectUpdateNotice(String noticeNo);

	// (교수) 전체 상담 신청 조회
	ArrayList<Counseling> selectAllCounseling(String user);

	//교수 이의신청 페이지
	ArrayList<Objection> professorGradeReport(String professorNo);
		
	//교수 이의신청 회신
	int professorGradeRequest(Objection obj);


}
