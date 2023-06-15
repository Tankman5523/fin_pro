package com.univ.fin.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.Graduation;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.model.vo.StudentRest;
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

	// 회원추가 (학생)
	int insertStudent(Student st);
	
	// 학생 개인시간표 -> 학년도,학기 조회
	ArrayList<String> selectStudentClassTerm(String studentNo);

	// 학생 개인시간표 -> 학기 선택 후 시간표 조회
	ArrayList<Classes> selectStudentTimetable(HashMap<String, String> map);
	
	//학사관리 - 졸업사정표
	Graduation graduationInfo(String sno);
	
	//학사관리 - 졸업사정표(전체 이수현황 조회)
	Graduation selectGraStatus(HashMap<String, String> h);
	
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

	// 교수 개인시간표 -> 학년도,학기 조회
	ArrayList<String> selectProfessorClassTerm(String professorNo);

}
