package com.univ.fin.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.univ.fin.common.model.vo.AlarmVo;
import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.CalendarVo;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.Department;
import com.univ.fin.common.model.vo.Dissent;
import com.univ.fin.common.model.vo.Grade;
import com.univ.fin.common.model.vo.Graduation;
import com.univ.fin.common.model.vo.ProfessorRest;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.model.vo.StudentRest;
import com.univ.fin.main.model.vo.Notice;
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
	
	//수강신청 기간인지 체크
	public ArrayList<CalendarVo> chkRegCal(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.chkRegCal");
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
	
	//수강신청 - 수강신청(해당 과목 장바구니에서 지워주기)
	public int postRegDelBucket(SqlSessionTemplate sqlSession, RegisterClass rc2) {
		return sqlSession.delete("memberMapper.postRegDelBucket", rc2);
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
		System.out.println(d);
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

		return sqlSession.insert("memberMapper.insertStudent",st);
	}

	// 강의시간표 -> 교수명 검색/과목 검색
	public ArrayList<Classes> searchClassKeyword(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.searchClassKeyword", map);
	}

	//학사관리 - 졸업사정표
	public Graduation graduationInfo(SqlSessionTemplate sqlSession, String sno) {
		return sqlSession.selectOne("memberMapper.graduationInfo", sno);
	}
	
	//학사관리 - 졸업사정표(전체 이수현황 조회)
	public Graduation selectGraStatus(SqlSessionTemplate sqlSession, HashMap<String, String> h) {
		return sqlSession.selectOne("memberMapper.selectGraStatus", h);
	}
	
	//학사관리 - 졸업사정표 (교양공통 세부조회)
	public ArrayList<HashMap<String, String>> detailCommonGra(SqlSessionTemplate sqlSession,HashMap<String, String> h) {
		return (ArrayList)sqlSession.selectList("memberMapper.detailCommonGra", h);
	}
	
	//학사관리 - 졸업사정표 (교양일반 세부조회)
	public ArrayList<HashMap<String, String>> detailNomalGra(SqlSessionTemplate sqlSession, HashMap<String, String> h) {
		return (ArrayList)sqlSession.selectList("memberMapper.detailNomalGra", h);
	}
	
	//학사관리 - 졸업사정표 (전공심화 세부조회)
	public ArrayList<HashMap<String, String>> detailmajorGra(SqlSessionTemplate sqlSession, HashMap<String, String> h) {
		return (ArrayList)sqlSession.selectList("memberMapper.detailmajorGra", h);
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

	// 학생 개인시간표 -> 학년도,학기 조회
	public ArrayList<String> selectStudentClassTerm(SqlSessionTemplate sqlSession, String studentNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectStudentClassTerm", studentNo);
	}

	// 학생 개인시간표 -> 학기 선택 후 시간표 조회
	public ArrayList<Classes> selectStudentTimetable(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectStudentTimetable", map);
	}

	// 교수 개인시간표 -> 학년도,학기 조회
	public ArrayList<String> selectProfessorClassTerm(SqlSessionTemplate sqlSession, String professorNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectProfessorClassTerm", professorNo);
	}

	// 교수 개인시간표 -> 학기 선택 후 시간표 조회
	public ArrayList<Classes> selectProfessorTimetable(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectProfessorTimetable", map);
	}
	
	// 기간 확인
	public int checkPeriod(SqlSessionTemplate sqlSession, String string) {
		return sqlSession.selectOne("memberMapper.checkPeriod", string);
	}
	
	// 성적관리 -> 학점별로 몇명이 해당되는지
	public HashMap<String, String> countStudentGrade(SqlSessionTemplate sqlSession, int classNo) {
		return sqlSession.selectOne("memberMapper.countStudentGrade", classNo);
	}

	// 성적관리 -> 수강중인 학생 조회
	public ArrayList<HashMap<String, String>> selectStudentGradeList(SqlSessionTemplate sqlSession, int classNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectStudentGradeList", classNo);
	}

	// 성적관리 -> 수강인원*비율에 따른 가능 인원 수
	public int checkGradeNos(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.checkGradeNos", map);
	}

	// 성적관리 -> 실제 몇명이 해당되는지
	public int countGradeNos(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.countGradeNos", map);
	}

	// 성적관리 -> 성적 입력
	public int gradeInsert(SqlSessionTemplate sqlSession, Grade g) {
		return sqlSession.insert("memberMapper.gradeInsert", g);
	}

	// 성적관리 -> 성적 수정
	public int gradeUpdate(SqlSessionTemplate sqlSession, Grade g) {
		return sqlSession.update("memberMapper.gradeUpdate", g);
	}

	// 학기별 성적 조회 -> 학기 선택 후 강의 조회
	public ArrayList<HashMap<String, String>> selectClassList(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectClassList", map);
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


	//강의 이의제기 - 학생
	public ArrayList<Dissent> studentGradeReport(SqlSessionTemplate sqlSession, String studentNo) {

		return (ArrayList)sqlSession.selectList("memberMapper.studentGradeReport");
		
	}
	
	//임직원 생성
	public int insertProfessor(SqlSessionTemplate sqlSession, Professor pr) {
		
	return sqlSession.insert("memberMapper.insertProfessor",pr);
	}
	// (관리자)강의개설 일괄 승인
	public int updateClassPermitAll(SqlSessionTemplate sqlSession, int[] cArr) {
		
		return sqlSession.update("memberMapper.updateClassPermitAll",cArr);
	}

	// (관리자)강의개설 개별 승인
	public int updateclassPermit(SqlSessionTemplate sqlSession, int cno) {
		
		return sqlSession.update("memberMapper.updateClassPermit",cno);
	}

	// (관리자)강의개설 반려 업데이트
	public int updateClassReject(SqlSessionTemplate sqlSession, Classes c) {
		
		return sqlSession.update("memberMapper.updateClassReject",c);
	}
	
	// 학기별 성적 조회 -> 학기별 성적 계산
	public HashMap<String, String> calculatedGrade(SqlSessionTemplate sqlSession,
			HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.calculatedGrade", map);
	}
	
	// 학기별 성적 조회 -> 학기별석차
	public String calculatedTermRank(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.calculatedTermRank", map);
	}
	
	// 학기별 성적 조회 -> 전체석차
	public String calculatedTotalRank(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.calculatedTotalRank", map);
	}

	// 교수이름으로 교수 직번 가져오기
	public String selectProfessorNo(SqlSessionTemplate sqlSession, String keyword) {
		
		return sqlSession.selectOne("memberMapper.selectProfessorNo",keyword);
	}

	// (관리자) 강의 관리 검색
	public ArrayList<Classes> selectClassListSearch(SqlSessionTemplate sqlSession, Classes c) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectSearchClassList",c);
	}

	//(교수)반려당한 강의 수정 페이지 이동
	public Classes selectRejectedClass(SqlSessionTemplate sqlSession, int classNo) {
		
		return sqlSession.selectOne("memberMapper.selectRejectedClass",classNo);
	}

	//(교수)반려당한 강의 첨부파일(강의계획서) 조회
	public Attachment selectRejectedClassAtt(SqlSessionTemplate sqlSession, String fileNo) {
		
		return sqlSession.selectOne("memberMapper.selectRejectedClassAtt",fileNo);
	}

	//(교수)반려 강의 수정(새로운 첨부파일이 없는 경우)
	public int updateClassCreateNoAtt(SqlSessionTemplate sqlSession, Classes c) {
		
		return sqlSession.update("memberMapper.updateClassCreateNoAtt",c);
	}

	//(교수)반려 강의 수정(새로운 첨부파일이 있고 기존 첨부파일이 있는 경우)
	@Transactional
	public int updateClassCreate(SqlSessionTemplate sqlSession, Classes c, Attachment a) {
		int result = sqlSession.update("memberMapper.updateClassAttachment",a);
		
		if(result>0) {
			result =sqlSession.update("memberMapper.updateClassCreateNoAtt",c);
		}
		return result;
	}
	
	//(교수)반려 강의 수정(새로운 첨부파일이 있고 기존 첨부파일이 없는 경우)
	@Transactional
	public int updateClassCreateNew(SqlSessionTemplate sqlSession, Classes c, Attachment a) {
		int	result = sqlSession.insert("memberMapper.insertClassAttachment",a);
		
		if(result>0) {
			result = sqlSession.insert("memberMapper.UpdateClassNewAttNoOrigin",c);
		}
		return result;
	}

	// 학기별 성적 조회 -> 증명신청학점
	public HashMap<String, String> selectScoreAB(SqlSessionTemplate sqlSession, String studentNo) {
		return sqlSession.selectOne("memberMapper.selectScoreAB", studentNo);
	}

	// 학기별 성적 조회 -> 증명취득학점
	public int selectScoreB(SqlSessionTemplate sqlSession, String studentNo) {
		return sqlSession.selectOne("memberMapper.selectScoreB", studentNo);
	}

	// 학기별 성적 조회 -> 증명평점평균
	public double selectScoreC(SqlSessionTemplate sqlSession, String studentNo) {
		return sqlSession.selectOne("memberMapper.selectScoreC", studentNo);
	}

	// 학기별 성적 조회 -> 증명산술평균
	public double selectScoreD(SqlSessionTemplate sqlSession, String studentNo) {
		return sqlSession.selectOne("memberMapper.selectScoreD", studentNo);
	}
	
	// (학생)수강한 강의정보 조회
	public ArrayList<RegisterClass> classInfoForRating(SqlSessionTemplate sqlSession, ClassRating cr) {
		return (ArrayList)sqlSession.selectList("memberMapper.classInfoForRating", cr);
	}
	
	// (학생)강의평가 입력
	public int insertClassRating(SqlSessionTemplate sqlSession, ClassRating cr) {
		return sqlSession.insert("memberMapper.insertClassRating", cr);
	}
	
	// (관리자) 강의평가 조회
	public ArrayList<ClassRating> classRatingList(SqlSessionTemplate sqlSession, ClassRating cr) {
		return (ArrayList)sqlSession.selectList("memberMapper.classRatingList", cr);
	}

	// (관리자) 강의평가 기타건의사항 조회
	public ArrayList<ClassRating> classRatingEtcList(SqlSessionTemplate sqlSession, ClassRating cr) {
		return (ArrayList)sqlSession.selectList("memberMapper.classRatingEtcList",cr);
	}
	
	// (관리자) 강의평가 문항별 평균 점수 조회
	public ClassRating classRatingAverage(SqlSessionTemplate sqlSession, ClassRating cr) {
		return sqlSession.selectOne("memberMapper.classRatingAverage", cr);
	}


	//(교수) 안식,퇴직 신청 등록
	public int insertProRest(SqlSessionTemplate sqlSession, ProfessorRest pr) {
		
		return sqlSession.insert("memberMapper.insertProRest",pr);
	}

	//(교수) 안식,퇴직 신청 목록 가져오기
	public ArrayList<ProfessorRest> selectRestListPro(SqlSessionTemplate sqlSession, String professorNo) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectRestListPro",professorNo);
	}
	
	// (교수) 상담조회
	public ArrayList<Counseling> professorSelectCounseling(SqlSessionTemplate sqlSession, HashMap<String, String> counselMap) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.professorSelectCounseling", counselMap);
	}
	
	// 학사일정 관리 -> 학사일정 조회
	public ArrayList<HashMap<String, String>> calendarList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.calendarList");
	}

	// 학사일정 관리 -> 학사일정 추가
	public int insertCalendar(SqlSessionTemplate sqlSession, CalendarVo c) {
		return sqlSession.insert("memberMapper.insertCalendar", c);
	}

	//(관리자) 학생 휴,복학 신청 리스트 조회
	public ArrayList<Counseling> selectCounAllStuList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectCounAllStuList");
	}

	//(관리자) 임직원 안식,퇴직 신청 리스트 조회
	public ArrayList<ProfessorRest> selectCounAllProList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectCounAllProList");
	}

	//(관리자) 학생 휴,복학 신청 상세보기
	public StudentRest selectStuRestDetail(SqlSessionTemplate sqlSession, int rno) {
		return sqlSession.selectOne("memberMapper.selectStuRestDetail",rno);
	}

	// 학번으로 학생 정보 조회 해오기
	public Student selectStudentInfo(SqlSessionTemplate sqlSession, String studentNo) {
		return sqlSession.selectOne("memberMapper.selectStudentInfo",studentNo);
	}

	// (관리자)생 휴,복학 승인
	@Transactional
	public int updateStuRestPermit(SqlSessionTemplate sqlSession, StudentRest sr) {
		int result = sqlSession.update("memberMapper.updateStuRestPermit",sr);
		if(result>0) {
			result = sqlSession.update("memberMapper.updateStudentStatus",sr);
		}
		return result;
	}

	// (관리자)생 휴,복학 반려(비허가)
	public int updateStuRestRetire(SqlSessionTemplate sqlSession, int restNo) {
		return sqlSession.update("memberMapper.updateStuRestRetire",restNo);
	}

	//(관리자) 임직원 안식,퇴직 정보 조회
	public ProfessorRest selectProRestDetail(SqlSessionTemplate sqlSession, int restNo) {
		return sqlSession.selectOne("memberMapper.selectProRestDetail",restNo);
	}

	// (관리자) 임직원 안식,퇴직 업데이트
	public int updateProfessorRest(SqlSessionTemplate sqlSession, ProfessorRest pr) {
		return sqlSession.update("memberMapper.updateProfessorRest",pr);
	}

	// (관리자) 학생 휴,복학 목록 검색
	public ArrayList<StudentRest> selectSearchStuRestList(SqlSessionTemplate sqlSession, HashMap<String, String> set) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectSearchStuRestList",set);
	}
	
	// (교수) 상담 상세 조회
	public Counseling selectCounselDetail(SqlSessionTemplate sqlSession, String counselNo) {
		 
		return sqlSession.selectOne("memberMapper.selectCounselDetail", counselNo);
	}
	
	// 학사일정 관리 -> 학사일정 수정
	public int updateCalendar(SqlSessionTemplate sqlSession, CalendarVo c) {
		return sqlSession.update("memberMapper.updateCalendar", c);
	}

	// 학사일정 관리 -> 학사일정 삭제
	public int deleteCalendar(SqlSessionTemplate sqlSession, CalendarVo c) {
		return sqlSession.update("memberMapper.deleteCalendar", c);
	}
	
	// 메인 -> 프로필 사진 조회
	public String selectProfile(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.selectProfile", map);
	}
	
	// 메인 -> 등록금 납부 조회
	public ArrayList<HashMap<String, String>> selectReg(SqlSessionTemplate sqlSession, String studentNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectReg", studentNo);
	}
	
	// 메인 -> 상담신청 조회
	public ArrayList<Counseling> selectCounceling(SqlSessionTemplate sqlSession, String professorNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectCounceling", professorNo);
	}
	
	// 메인 -> 학사일정 조회
	public ArrayList<HashMap<String, String>> yearCalendarList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.yearCalendarList");
	}

	// 메인 -> 공지사항 조회
	public ArrayList<Notice> selectMainNotice(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectMainNotice");
	}

	//(교수) 상담 상태 변경
	public int updateCounselStatus(SqlSessionTemplate sqlSession, HashMap<String, String> statusMap) {
		return sqlSession.update("memberMapper.updateCounselStatus", statusMap);
	}

	// 알람 발신
	public int alarmInsert(SqlSessionTemplate sqlSession, HashMap<String, String> alarm) {
		return sqlSession.insert("memberMapper.alarmInsert", alarm);
	}
	
	// 알람 수신
	public ArrayList<AlarmVo> alarmReceive(SqlSessionTemplate sqlSession, String studentNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.alarmReceive", studentNo);
	}

	// 알람 확인
	public int alarmCheck(SqlSessionTemplate sqlSession, String studentNo) {
		return sqlSession.update("memberMapper.alarmCheck", studentNo);
	}


}
