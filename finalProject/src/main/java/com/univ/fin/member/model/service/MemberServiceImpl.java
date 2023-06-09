package com.univ.fin.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
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

	//수강신청 - 수강신청 (학부전공별 조회)
	@Override
	public ArrayList<RegisterClass> majorClass(String departmentName) {
		
		ArrayList<RegisterClass> list = memberDao.majorClass(sqlSession,departmentName);
		
		return list;
	}
	
	// 수강신청 - 강의시간표 -> 학년도,학기 조회
	@Override
	public ArrayList<String> selectClassTerm() {
		ArrayList<String> classTerm = memberDao.selectClassTerm(sqlSession);
		return classTerm;
	}
	
	// 수강신청 - 강의시간표 -> 단과대학별 전공 조회
	@Override
	public ArrayList<String> selectDepertment(String college) {
		ArrayList<String> dList = memberDao.selectDepartment(sqlSession, college);
		return dList;
	}

	// 수강신청 - 강의시간표 -> 전공 선택 후 전공수업 조회
	@Override
	public ArrayList<Classes> selectDepartmentMajor(HashMap<String, String> map) {
		ArrayList<Classes> cList = memberDao.selectDepartmentMajor(sqlSession, map);
		return cList;
	}

	//상담신청 - 학과별 교수 조회
	@Override
	public ArrayList<Professor> selectDepartProList(String departmentNo) {
		
		ArrayList<Professor> list = memberDao.selectDepartProList(sqlSession,departmentNo);
		
		return list;
	}

	//상담신청 - 상담신청 작성
	@Override
	public int insertCounseling(Counseling c) {
		
		int result = memberDao.insertCounseling(sqlSession,c);
		
		return result;
	}

	//상담관리 - 상담내역 조회
	@Override
	public ArrayList<Counseling> selectCounStuList(String studentNo) {
		
		ArrayList<Counseling> list = memberDao.selectCounStuList(sqlSession,studentNo);
		
		return list;
	}

	//상담관리 - 상담 상세보기
	@Override
	public Counseling selectCounseling(int counselNo) {
		
		Counseling c = memberDao.selectCounseling(sqlSession,counselNo);
		
		return c;
	}

	//직번으로 교수정보 조회
	@Override
	public Professor selectProfessorForNo(String professorNo) {
		
		Professor p = memberDao.selectProfessorForNo(sqlSession,professorNo);
		
		return p;
	}

	//상담관리 - 상담 요청내용 수정(학생)
	@Override
	public int updateCounContent(Counseling c) {
		
		int result = memberDao.updateCounContent(sqlSession,c);
		
		return result;
	}
	
}
