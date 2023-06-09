package com.univ.fin.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

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

	//수강신청 - 수강신청
	ArrayList<RegisterClass> majorClass(RegisterClass rc2);
	
	// 강의시간표 -> 학년도,학기 조회
	ArrayList<String> selectClassTerm();
	
	// 강의시간표 -> 단과대학별 전공 조회
	ArrayList<String> selectDepertment(String college);

	// 강의시간표 -> 전공 선택 후 전공수업 조회
	ArrayList<Classes> selectDepartmentMajor(HashMap<String, String> map);

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

	// 강의시간표 -> 교양수업 조회
	ArrayList<Classes> selectElective(HashMap<String, String> map);

	

	// 강의시간표 -> 교수명 검색/과목 검색
	ArrayList<Classes> searchClassKeyword(HashMap<String, String> map);

	//학적정보 수정 (학생)
	int updateStudent(Student st);
	
	//학적정보 수정 (교수)
	int updateProfessor(Professor pr);

	// 회원추가 (학생)
	int insertStudent(Student st);
	

}
