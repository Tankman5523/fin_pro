package com.univ.fin.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.member.model.dao.MemberDao;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//학생 로그인
	@Override
	public Student loginStudent(Student st) {
		
		Student loginUser = memberDao.loginStudent(sqlSession,st);
		
		return loginUser;
	}

	//임직원 로그인
	@Override
	public Professor loginProfessor(Professor pr) {
		
		Professor loginUser = memberDao.loginProfessor(sqlSession,pr);
		
		return loginUser;
	}

	//ID조회 - 학생
	@Override
	public Student checkEmail(Student st) {
		
		Student member = memberDao.checkEmail(sqlSession,st);
		
		return member;
	}

	//ID조회 - 임직원
	@Override
	public Professor checkEmail2(Professor pr) {
		
		Professor member2 = memberDao.checkEmail2(sqlSession,pr);
		
		return member2;
	}

	//비밀번호 초기화 - 학생
	@Override
	public Student checkPwd(Student st) {
		
		Student member = memberDao.checkPwd(sqlSession,st);
		
		return member;
	}

	//비밀번호 초기화 - 임직원
	@Override
	public Professor checkPwd2(Professor pr) {
		
		Professor member2 = memberDao.checkPwd2(sqlSession,pr);
		
		return member2;
	}
	
	//비밀번호 초기화 - 비밀번호 변경 메소드 (학생)
	@Override
	public int changePwd(Student st) {
		
		int result = memberDao.changePwd(sqlSession,st);
		
		return result;
	}

	//비밀번호 초기화 - 비밀번호 변경 메소드 (임직원)
	@Override
	public int changePwd2(Professor pr) {
		
		int result = memberDao.changePwd2(sqlSession,pr);
		
		return result;
	}

	//수강신청 - 수강신청
	@Override
	public ArrayList<RegisterClass> majorClass(RegisterClass rc2) {
		
		ArrayList<RegisterClass> list = memberDao.majorClass(sqlSession,rc2);
		
		return list;
	}
	
	// 강의시간표 -> 학년도,학기 조회
	@Override
	public ArrayList<String> selectClassTerm() {
		ArrayList<String> classTerm = memberDao.selectClassTerm(sqlSession);
		return classTerm;
	}
	
	// 강의시간표 -> 단과대학별 전공 조회
	@Override
	public ArrayList<String> selectDepertment(String college) {
		ArrayList<String> dList = memberDao.selectDepartment(sqlSession, college);
		return dList;
	}

	// 강의시간표 -> 전공 선택 후 전공수업 조회
	@Override
	public ArrayList<Classes> selectDepartmentMajor(HashMap<String, String> map) {
		ArrayList<Classes> cList = memberDao.selectDepartmentMajor(sqlSession, map);
		return cList;
	}

	// 강의시간표 -> 교양수업 조회
	@Override
	public ArrayList<Classes> selectElective(HashMap<String, String> map) {
		ArrayList<Classes> cList = memberDao.selectElective(sqlSession, map);
		return cList;
	}

	//상담신청 - 학과별 교수 조회
	@Override
	public ArrayList<Professor> selectDepartProList(String departmentNo) {
		
		ArrayList<Professor> list = memberDao.selectDepartProList(sqlSession,departmentNo);
		
		return list;
	}

	// 강의시간표 -> 교수명 검색/과목 검색
	@Override
	public ArrayList<Classes> searchClassKeyword(HashMap<String, String> map) {
		ArrayList<Classes> cList = memberDao.searchClassKeyword(sqlSession, map);
		return cList;
	}
	
	//학적정보 수정 -학생
	@Override
	public int updateStudent(Student st) {
			
		int result = memberDao.updateStudent(sqlSession,st);
			
		return result;
	}

	@Override
	public int updateProfessor(Professor pr) {
		
		int result = memberDao.updateProfessor(sqlSession,pr);
		
		return result;
	}

	@Override
	public int insertStudent(Student st) {
		
		int result = memberDao.insertStudent(sqlSession,st);
		
		return result;
	}
}
