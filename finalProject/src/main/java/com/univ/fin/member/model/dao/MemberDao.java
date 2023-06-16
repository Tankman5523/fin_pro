package com.univ.fin.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.Department;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.model.vo.StudentRest;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.vo.RegistPay;

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
	
	//수강신청 - 수강신청내역조회 (로그인 학생의 수강신청 년도/학기 추출)
	public ArrayList<Classes> searchRegYear(SqlSessionTemplate sqlSession, String studentNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.searchRegYear", studentNo);
	}
	
	//예비수강신청 - 수강조회
	public ArrayList<RegisterClass> preRegClass(SqlSessionTemplate sqlSession, RegisterClass rc2) {
		return (ArrayList)sqlSession.selectList("memberMapper.preRegClass", rc2);
	}
	
	//예비수강신청 - 중복체크
	public int checkPreReg(SqlSessionTemplate sqlSession, Bucket b) {
		return sqlSession.selectOne("memberMapper.checkPreReg", b);
	}

	//예비수강신청 - 수강담기
	public int preRegisterClass(SqlSessionTemplate sqlSession, Bucket b) {
		return sqlSession.insert("memberMapper.preRegisterClass", b);
	}
	
	//예비수강신청 - 장바구니 조회
	public ArrayList<RegisterClass> preRegList(SqlSessionTemplate sqlSession, RegisterClass rc2) {
		return (ArrayList)sqlSession.selectList("memberMapper.preRegList", rc2);
	}
	
	//예비수강신청 - 장바구니 수강취소
	public int delPreRegList(SqlSessionTemplate sqlSession, RegisterClass rc) {
		return sqlSession.delete("memberMapper.delPreRegList", rc);
	}
	
	//수강신청 - 수강신청 (수강조회)
	public ArrayList<RegisterClass> postRegClass(SqlSessionTemplate sqlSession, RegisterClass rc2) {
		return (ArrayList)sqlSession.selectList("memberMapper.postRegClass", rc2);
	}
	
	//수강신청 - 수강신청 (장바구니)
	public ArrayList<RegisterClass> postRegBucket(SqlSessionTemplate sqlSession, RegisterClass rc2) {
		return (ArrayList)sqlSession.selectList("memberMapper.postRegBucket", rc2);
	}
	
	//수강신청 - 수강신청 (해당강의 조회)
	public Classes selectClass(SqlSessionTemplate sqlSession, int classNo) {
		return sqlSession.selectOne("memberMapper.selectClass", classNo);
	}
	
	//수강신청 - 수강신청 (강의 시간 체크)
	public int checkPostReg2(SqlSessionTemplate sqlSession, RegisterClass rc2) {
		return sqlSession.selectOne("memberMapper.checkPostReg2", rc2);
	}
	
	//수강신청 - 수강신청
	public int postRegisterClass(SqlSessionTemplate sqlSession, RegisterClass rc3) {
		return sqlSession.insert("memberMapper.postRegisterClass", rc3);
	}
	
	//수강신청 - 수강신청(2시간짜리 강의)
	public int postRegisterClass2(SqlSessionTemplate sqlSession, RegisterClass rc3) {
		return sqlSession.insert("memberMapper.postRegisterClass2", rc3);
	}
	
	//수강신청 - 수강신청내역 조회
	public ArrayList<RegisterClass> postRegList(SqlSessionTemplate sqlSession, RegisterClass rc2) {
		return (ArrayList)sqlSession.selectList("memberMapper.postRegList", rc2);
	}
	
	//수강신청 - 수강신청 (수강신청내역 수강취소)
	public int delPostRegList(SqlSessionTemplate sqlSession, RegisterClass rc) {
		return sqlSession.delete("memberMapper.delPostRegList", rc);
	}
	
	//수강신청 - 수강신청 내역조회
	public ArrayList<HashMap<String, String>> searchRegList(SqlSessionTemplate sqlSession, HashMap<String, String> h) {
		return (ArrayList)sqlSession.selectList("memberMapper.postRegList", h);
	}
	
	// 강의시간표 -> 학년도,학기 조회
	public ArrayList<String> selectClassTerm(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectClassTerm");
	}
	
	// 강의시간표 -> 단과대학별 전공 조회
	public ArrayList<String> selectDepart(SqlSessionTemplate sqlSession, String college) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectDepart", college);
	}

	// 강의시간표 -> 전공 선택 후 전공수업 조회/교양수업 조회
	public ArrayList<Classes> selectDepartment(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectDepartment", map);
	}
	
	//상담신청 - 학과별 교수 조회
	@Transactional
	public ArrayList<Professor> selectDepartProList(SqlSessionTemplate sqlSession, String departmentNo) {
		
		Department d =sqlSession.selectOne("memberMapper.selectDepartmentNo",departmentNo);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectDepartProList",d);
	}

	//상담신청 - 상담신청 작성
	public int insertCounseling(SqlSessionTemplate sqlSession, Counseling c) {
		
		return sqlSession.insert("memberMapper.insertCounseling",c);
	}

	//상담관리 - 상담내역조회(학생)
	public ArrayList<Counseling> selectCounStuList(SqlSessionTemplate sqlSession, String studentNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectCounStuList",studentNo);
	}

	//상담관리 - 상담상세보기
	public Counseling selectCounseling(SqlSessionTemplate sqlSession, int counselNo) {
		
		return sqlSession.selectOne("memberMapper.selectCounseling", counselNo);
	}

	//직번으로 교수정보조회
	public Professor selectProfessorForNo(SqlSessionTemplate sqlSession, String professorNo) {
		
		return sqlSession.selectOne("memberMapper.selectProfessorForNo",professorNo);
	}
	
	//상담관리 - 상담 요청내용 수정(학생)
	public int updateCounContent(SqlSessionTemplate sqlSession, Counseling c) {
		
		return sqlSession.update("memberMapper.updateCounContent",c);
	}
	
	//상담관리 - 상담 내역 검색
	public ArrayList<Counseling> selectSearchCounseling(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
			
		return (ArrayList)sqlSession.selectList("memberMapper.selectSearchCounList",map);
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


	

	//(학생)휴,복학 신청 리스트 조회
	public ArrayList<StudentRest> selectStuRestList(SqlSessionTemplate sqlSession, String studentNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectStuRestList",studentNo);
	}

	//(학생)휴학횟수 가져옴
	public int selectRestCount(SqlSessionTemplate sqlSession, String studentNo) {
		
		return sqlSession.selectOne("memberMapper.selectRestCount",studentNo);
	}

	//(학생)가장 최근 휴학 정보 가져옴
	public StudentRest selectRestInfo(SqlSessionTemplate sqlSession, String studentNo) {
		
		return sqlSession.selectOne("memberMapper.selectRestInfo",studentNo);
	}

	//(학생)휴학신청할떄 등록금 정보 가져오기
	public RegistPay checkRegPay(SqlSessionTemplate sqlSession, RegistPay rp) {
		
		RegistPay checkRp = sqlSession.selectOne("memberMapper.checkRegPay",rp);
		
		return checkRp;
	}

	//(학생)휴,복학 신청 인서트
	public int insertStuRest(SqlSessionTemplate sqlSession, StudentRest sr) {
		
		return sqlSession.insert("memberMapper.insertStuRest",sr);
	}

	// 개인시간표 -> 학년도,학기 조회
	public ArrayList<String> selectClassTerm2(SqlSessionTemplate sqlSession, String studentNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectClassTerm2", studentNo);
	}

	// 개인시간표 -> 학기 선택 후 시간표 조회
	public ArrayList<Classes> selectTimetable(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectTimetable", map);

	}

	//(교수)강의개설 신청 리스트 조회
	public ArrayList<Classes> selectClassCreateList(SqlSessionTemplate sqlSession, String professorNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectClassCreateList",professorNo);
	}

	//(교수)강의 개설 인서트
	@Transactional
	public int insertClassCreate(SqlSessionTemplate sqlSession, Classes c, Attachment a) {

		//a가 null인지 안보는 이유는 강의계획서는 필수로 넣어야 신청 할 수 있게 하기 때문에
		int	result = sqlSession.insert("memberMapper.insertClassAttachment",a);
		
		if(result>0) {
			result = sqlSession.insert("memberMapper.insertClassCreate",c);
			
		}
		
		
		return result;
	}

	//(관리자) 강의 개설 리스트가져오기
	public ArrayList<Classes> selectClassList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectClassCreateList");
	}

	//(관리자)강의 개설 첨부파일  리스트 가져오기
	public ArrayList<Attachment> selectClasAttachment(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectClassAttList");
	}

}
