package com.univ.fin.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Department;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Repository
public class MemberDao {

	//학생 로그인
	public Student loginStudent(SqlSessionTemplate sqlSession, Student st) {
		return sqlSession.selectOne("memberMapper.loginStudent", st);
	}

	//임직원 로그인
	public Professor loginProfessor(SqlSessionTemplate sqlSession, Professor pr) {
		return sqlSession.selectOne("memberMapper.loginProfessor", pr);
	}
	
	//ID조회 - 학생
	public Student checkEmail(SqlSessionTemplate sqlSession, Student st) {
		return sqlSession.selectOne("memberMapper.checkEmail", st);
	}

	//ID조회 - 임직원
	public Professor checkEmail2(SqlSessionTemplate sqlSession, Professor pr) {
		return sqlSession.selectOne("memberMapper.checkEmail2", pr);
	}
	
	//비밀번호 초기화 - 학생
	public Student checkPwd(SqlSessionTemplate sqlSession, Student st) {
		return sqlSession.selectOne("memberMapper.checkPwd", st);
	}
	
	//비밀번호 초기화 - 임직원
	public Professor checkPwd2(SqlSessionTemplate sqlSession, Professor pr) {
		return sqlSession.selectOne("memberMapper.checkPwd2", pr);
	}

	//비밀번호 초기화 - 비밀번호 변경 메소드 (학생)
	public int changePwd(SqlSessionTemplate sqlSession, Student st) {
		return sqlSession.update("memberMapper.changePwd", st);
	}

	//비밀번호 초기화 - 비밀번호 변경 메소드 (임직원)
	public int changePwd2(SqlSessionTemplate sqlSession, Professor pr) {
		return sqlSession.update("memberMapper.changePwd2", pr);
	}
	
	//예비수강신청 - 중복체크
	public int checkPre(SqlSessionTemplate sqlSession, Bucket b) {
		return sqlSession.selectOne("memberMapper.checkPre", b);
	}

	//예비수강신청 - 수강담기
	public int preRegisterClass(SqlSessionTemplate sqlSession, Bucket b) {
		return sqlSession.insert("memberMapper.preRegisterClass", b);
	}
	
	//수강신청 - 수강신청
	public ArrayList<RegisterClass> majorClass(SqlSessionTemplate sqlSession, RegisterClass rc2) {
		return (ArrayList)sqlSession.selectList("memberMapper.majorClass", rc2);
	}
	
	// 강의시간표 -> 학년도,학기 조회
	public ArrayList<String> selectClassTerm(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectClassTerm");
	}
	
	// 강의시간표 -> 단과대학별 전공 조회
	public ArrayList<String> selectDepartment(SqlSessionTemplate sqlSession, String college) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectDepartment", college);
	}

	// 강의시간표 -> 전공 선택 후 전공수업 조회
	public ArrayList<Classes> selectDepartmentMajor(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectDepartmentMajor", map);
	}
	
	//상담신청 - 학과별 교수 조회
	@Transactional
	public ArrayList<Professor> selectDepartProList(SqlSessionTemplate sqlSession, String departmentNo) {
		
		Department d =sqlSession.selectOne("memberMapper.selectDepartmentNo",departmentNo);
		System.out.println(d);
		return (ArrayList)sqlSession.selectList("memberMapper.selectDepartProList",d);
	}

	// 강의시간표 -> 교양수업 조회
	public ArrayList<Classes> selectElective(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectElective", map);
	}
	
	//학적정보 수정 - 학생
	public int updateStudent(SqlSessionTemplate sqlSession, Student st) {

		return sqlSession.update("memberMapper.updateStudent",st);
	}

	public int updateProfessor(SqlSessionTemplate sqlSession, Professor pr) {
		
		return sqlSession.update("memberMapper.updateProfessor",pr);
	}

	public int insertStudent(SqlSessionTemplate sqlSession, Student st) {

		return sqlSession.insert("memberMapper.insertMapper",st);
	}

	// 강의시간표 -> 교수명 검색/과목 검색
	public ArrayList<Classes> searchClassKeyword(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.searchClassKeyword", map);
	}




}
