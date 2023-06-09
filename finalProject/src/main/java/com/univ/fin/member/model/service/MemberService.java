package com.univ.fin.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.univ.fin.common.model.vo.Classes;
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

	//수강신청 - 학부전공별 조회
	ArrayList<Classes> majorClass(String departmentName);
	
	// 수강신청 - 강의시간표 -> 학년도,학기 조회
	ArrayList<String> selectClassTerm();
	
	// 수강신청 - 강의시간표 -> 단과대학별 전공 조회
	ArrayList<String> selectDepertment(String college);

	// 수강신청 - 강의시간표 -> 전공 선택 후 전공수업 조회
	ArrayList<Classes> selectDepartmentMajor(HashMap<String, String> map);

	//상담신청 - 학과별 교수 전부 조회
	ArrayList<Professor> selectDepartProList(String departmentNo);

	//학적정보 수정 (학생)
	int updateStudent(Student st);
	
	//학적정보 수정 (교수)
	int updateProfessor(Professor pr);

	// 회원추가 (학생)
	int insertStudent(Student st);
	
}
