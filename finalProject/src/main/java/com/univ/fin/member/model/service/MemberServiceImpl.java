package com.univ.fin.member.model.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.CalendarVo;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.Dissent;
import com.univ.fin.common.model.vo.Grade;
import com.univ.fin.common.model.vo.Graduation;
import com.univ.fin.common.model.vo.ProfessorRest;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.model.vo.StudentRest;
import com.univ.fin.main.model.vo.Notice;
import com.univ.fin.member.model.dao.MemberDao;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.vo.RegistPay;

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

	//수강신청 기간인지 체크
	@Override
	public ArrayList<CalendarVo> chkRegCal() {
		
		ArrayList<CalendarVo> list = memberDao.chkRegCal(sqlSession);
		
		return list;
	}
	
	//예비수강신청 - 수강조회
	@Override
	public ArrayList<RegisterClass> preRegClass(RegisterClass rc2) {
		ArrayList<RegisterClass> list = memberDao.preRegClass(sqlSession,rc2);
		return list;
	}
	
	//수강신청 - 수강신청내역조회 (로그인 학생의 수강신청 년도/학기 추출)
	@Override
	public ArrayList<Classes> searchRegYear(String studentNo) {
		
		ArrayList<Classes> list = memberDao.searchRegYear(sqlSession,studentNo);
		
		return list;
	}
	
	//예비수강신청 - 중복체크
	@Override
	public int checkPreReg(Bucket b) {
		
		int chkClass = memberDao.checkPreReg(sqlSession,b);
		
		return chkClass;
	}
	
	//예비수강신청 - 수강담기
	@Override
	public int preRegisterClass(Bucket b) {
		
		int result = memberDao.preRegisterClass(sqlSession,b);
		
		return result;
	}
	
	//예비수강신청 - 장바구니 조회
	@Override
	public ArrayList<RegisterClass> preRegList(RegisterClass rc2) {
		
		ArrayList<RegisterClass> list = memberDao.preRegList(sqlSession,rc2);
		
		return list;
	}
	
	//예비수강신청 - 장바구니 수강취소
	@Override
	public int delPreRegList(RegisterClass rc) {
		
		int result = memberDao.delPreRegList(sqlSession,rc);
		
		return result;
	}
	
	//수강신청 - 수강신청 (수강조회)
	@Override
	public ArrayList<RegisterClass> postRegClass(RegisterClass rc2) {
		
		ArrayList<RegisterClass> list = memberDao.postRegClass(sqlSession,rc2);
		
		return list;
	}
	
	//수강신청 - 수강신청 (장바구니)
	@Override
	public ArrayList<RegisterClass> postRegBucket(RegisterClass rc2) {
		
		ArrayList<RegisterClass> list = memberDao.postRegBucket(sqlSession,rc2);
		
		return list;
	}
	
	//수강신청 - 수강신청 (해당강의 조회)
	@Override
	public Classes selectClass(int classNo) {
		
		Classes c = memberDao.selectClass(sqlSession,classNo);
		
		return c;
	}
	
	//수강신청 - 수강신청 (강의 시간 체크)
	@Override
	public int checkPostReg2(RegisterClass rc2) {
		
		int result2 = memberDao.checkPostReg2(sqlSession,rc2);
		
		return result2;
	}
	
	//수강신청 - 수강신청
	@Override
	public int postRegisterClass(RegisterClass rc3) {
		
		int result = memberDao.postRegisterClass(sqlSession,rc3);
		
		return result;
	}
	
	//수강신청 - 수강신청(해당 과목 장바구니에서 지워주기)
	@Override
	public int postRegDelBucket(RegisterClass rc2) {
		
		int result = memberDao.postRegDelBucket(sqlSession,rc2);
		
		return result;
	}
	
	//수강신청 - 수강신청(2시간짜리 강의)
	@Override
	public int postRegisterClass2(RegisterClass rc3) {
		
		int result = memberDao.postRegisterClass2(sqlSession,rc3);
		
		return result;
	}
	
	//수강신청 - 수강신청내역 조회
	@Override
	public ArrayList<RegisterClass> postRegList(RegisterClass rc2) {
		
		ArrayList<RegisterClass> list = memberDao.postRegList(sqlSession,rc2);
		
		return list;
	}
	
	//수강신청 - 수강신청 (수강신청내역 수강취소)
	@Override
	public int delPostRegList(RegisterClass rc) {
		
		int result = memberDao.delPostRegList(sqlSession,rc);
		
		return result;
	}
	
	//수강신청 - 수강신청 내역조회
	@Override
	public ArrayList<HashMap<String, String>> searchRegList(HashMap<String, String> h) {
		
		ArrayList<HashMap<String, String>> list = memberDao.searchRegList(sqlSession,h);
		
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
	public ArrayList<String> selectDepert(String college) {
		ArrayList<String> dList = memberDao.selectDepart(sqlSession, college);
		return dList;
	}

	// 강의시간표 -> 전공 선택 후 전공수업 조회/교양수업 조회
	@Override
	public ArrayList<Classes> selectDepartment(HashMap<String, String> map) {
		ArrayList<Classes> cList = memberDao.selectDepartment(sqlSession, map);
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
	
	//상담관리 - 상담내역 검색
	@Override
	public ArrayList<Counseling> selectSearchCounseling(HashMap<String, String> map) {
		ArrayList<Counseling> list = memberDao.selectSearchCounseling(sqlSession,map);
			
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
	
	

	// 학생 개인시간표 -> 학년도,학기 조회
	@Override
	public ArrayList<String> selectStudentClassTerm(String studentNo) {
		ArrayList<String> classTerm = memberDao.selectStudentClassTerm(sqlSession, studentNo);
		return classTerm;
	}

	// 학생 개인시간표 -> 학기 선택 후 시간표 조회
	@Override
	public ArrayList<Classes> selectStudentTimetable(HashMap<String, String> map) {
		ArrayList<Classes> cList = memberDao.selectStudentTimetable(sqlSession, map);
		return cList;
	}
	
	//학사관리 - 졸업사정표
	@Override
	public Graduation graduationInfo(String sno) {
		
		Graduation g = memberDao.graduationInfo(sqlSession,sno);
		
		return g;
	}
	
	//학사관리 - 졸업사정표(전체 이수현황 조회)
	@Override
	public Graduation selectGraStatus(HashMap<String, String> h) {
		
		Graduation g = memberDao.selectGraStatus(sqlSession,h);
		
		return g;
	}
	
	//학사관리 - 졸업사정표 (교양공통 세부조회)
	@Override
	public ArrayList<HashMap<String, String>> detailCommonGra(HashMap<String, String> h) {
		
		ArrayList<HashMap<String, String>> list = memberDao.detailCommonGra(sqlSession,h);
		
		return list;
	}

	//학사관리 - 졸업사정표 (교양일반 세부조회)
	@Override
	public ArrayList<HashMap<String, String>> detailNomalGra(HashMap<String, String> h) {
		
		ArrayList<HashMap<String,String>> list = memberDao.detailNomalGra(sqlSession,h);
		
		return list;
	}
	
	//학사관리 - 졸업사정표 (전공심화 세부조회)
	@Override
	public ArrayList<HashMap<String, String>> detailmajorGra(HashMap<String, String> h) {
		
		ArrayList<HashMap<String,String>> list = memberDao.detailmajorGra(sqlSession,h);
		
		return list;
	}
	
	//(학생)휴,복학 신청 리스트 조회
	@Override
	public ArrayList<StudentRest> selectStuRestList(String studentNo) {
		
		ArrayList<StudentRest> list = memberDao.selectStuRestList(sqlSession,studentNo);
		
		return list;
	}
	
	//휴학횟수 가져옴
	@Override
	public int selectRestCount(String studentNo) {
		
		int restCount = memberDao.selectRestCount(sqlSession,studentNo);
		
		return restCount;
	}
	
	//(학생)가장 최근 휴학 정보 가져옴
	@Override
	public StudentRest selectRestInfo(String studentNo) {
		StudentRest sr = memberDao.selectRestInfo(sqlSession,studentNo);
		return sr;
	}
	
	//(학생)휴학신청할떄 등록금 냈는지 확인
	@Override
	public RegistPay checkRegPay(RegistPay rp) {
		RegistPay checkRp = memberDao.checkRegPay(sqlSession,rp);
		return checkRp;
	}
	
	//(학생)휴,복학 신청 인서트
	@Override
	public int insertStuRest(StudentRest sr) {
		int result = memberDao.insertStuRest(sqlSession,sr);
		return result;
	}

	//(교수)강의개설 신청 리스트 조회
	@Override
	public ArrayList<Classes> selectClassCreateList(String professorNo) {
		
		ArrayList<Classes> list = memberDao.selectClassCreateList(sqlSession,professorNo);
		
		return list;
	}

	//(교수)강의 개설 인서트 
	@Override
	public int insertClassCreate(Classes c, Attachment a) {
		int result = memberDao.insertClassCreate(sqlSession,c,a);
		return result;
	}

	//(관리자)강의 개설 전체 리스트 조회
	@Override
	public ArrayList<Classes> selectClassList() {
		ArrayList<Classes> list = memberDao.selectClassList(sqlSession);
		
		return list;
	}

	//(관리자)강의 개설 첨부파일 가져오기
	@Override
	public ArrayList<Attachment> selectClassAttachment() {
		
		ArrayList<Attachment> alist = memberDao.selectClasAttachment(sqlSession);
		
		return alist;
	}
	
	// 교수 개인시간표 -> 학년도,학기 조회
	@Override
	public ArrayList<String> selectProfessorClassTerm(String professorNo) {
		ArrayList<String> classTerm = memberDao.selectProfessorClassTerm(sqlSession, professorNo);
		return classTerm;
	}

	// 교수 개인시간표 -> 학기 선택 후 시간표 조회
	@Override
	public ArrayList<Classes> selectProfessorTimetable(HashMap<String, String> map) {
		ArrayList<Classes> cList = memberDao.selectProfessorTimetable(sqlSession, map);
		return cList;
	}
	
	// 기간 확인
	@Override
	public int checkPeriod(String string) {
		int result = memberDao.checkPeriod(sqlSession, string);
		return result;
	}
	
	// 성적관리 -> 학점별로 몇명이 해당되는지
	@Override
	public HashMap<String, String> countStudentGrade(int classNo) {
		HashMap<String, String> list = memberDao.countStudentGrade(sqlSession, classNo);
		return list;
	}

	// 성적관리 -> 수강중인 학생 조회
	@Override
	public ArrayList<HashMap<String, String>> selectStudentGradeList(int classNo) {
		ArrayList<HashMap<String, String>> sList = memberDao.selectStudentGradeList(sqlSession, classNo);
		return sList;
	}
	
	// 성적관리 -> 수강인원*비율에 따른 가능 인원 수
	@Override
	public int checkGradeNos(HashMap<String, String> map) {
		int check = memberDao.checkGradeNos(sqlSession, map);
		return check;
	}

	// 성적관리 -> 실제 몇명이 해당되는지
	@Override
	public int countGradeNos(HashMap<String, String> map) {
		int count = memberDao.countGradeNos(sqlSession, map);
		return count;
	}

	// 성적관리 -> 성적 입력
	@Override
	public int gradeInsert(Grade g) {
		int result = memberDao.gradeInsert(sqlSession, g);
		return result;
	}

	// 성적관리 -> 성적 수정
	@Override
	public int gradeUpdate(Grade g) {
		int result = memberDao.gradeUpdate(sqlSession, g);
		return result;
	}
	
	// 학기별 성적 조회 -> 학기 선택 후 강의 조회
	@Override
	public ArrayList<HashMap<String, String>> selectClassList(HashMap<String, String> map) {
		ArrayList<HashMap<String, String>> cList = memberDao.selectClassList(sqlSession, map);
		return cList;
	}


	@Override
	public ArrayList<Dissent> studentGradeReport(String studentNo) {
		ArrayList<Dissent> list = memberDao.studentGradeReport(sqlSession,studentNo);
		
		return list;
	}

	@Override
	public int insertProfessor(Professor pr) {
		
		int result = memberDao.insertProfessor(sqlSession,pr);
		
		return result;
	}


	// (관리자)강의개설 일괄 승인
	@Override
	public int updateClassPermitAll(int[] cArr) {
		int result = memberDao.updateClassPermitAll(sqlSession,cArr);
		return result;
	}

	// (관리자)강의개설 개별 승인
	@Override
	public int updateClassPermit(int cno) {
		int result = memberDao.updateclassPermit(sqlSession,cno);
		return result;
	}

	// (관리자)강의개설 반려 업데이트
	@Override
	public int updateClassReject(Classes c) {
		int result = memberDao.updateClassReject(sqlSession,c);
		return result;
	}

	// 교수이름으로 교수직번 가져오기
	@Override
	public String selectProfessorNo(String keyword) {
		String professorNo = memberDao.selectProfessorNo(sqlSession,keyword);
		return professorNo;
	}

	//(관리자) 강의 관리 검색
	@Override
	public ArrayList<Classes> selectClassListSearch(Classes c) {
		ArrayList<Classes> list = memberDao.selectClassListSearch(sqlSession,c);
		return list;
	}

	//(교수)반려당한 강의 수정 페이지 이동
	@Override
	public Classes selectRejectedClass(int classNo) {
		Classes c = memberDao.selectRejectedClass(sqlSession,classNo);
		return c;
	}

	//(교수)반려당한 강의 첨부파일(강의계획서) 조회
	@Override
	public Attachment selectRejectedClassAtt(String fileNo) {
		Attachment a = memberDao.selectRejectedClassAtt(sqlSession,fileNo);
		return a;
	}

	//(교수)반려된 강의 수정
	@Override
	public int updateClassCreate(Classes c, Attachment a) {
		int result =0;
		if(a==null) {//새로운 첨부파일이 없는경우
			result = memberDao.updateClassCreateNoAtt(sqlSession,c);
		}else {//새로운 첨부파일이 있는 경우
			if(a.getFileNo()!=0) {//기존 첨부파일이 있는 경우(기존 파일번호로 첨부파일 업데이트)
				result = memberDao.updateClassCreate(sqlSession,c,a);
			}else {//기존 첨부파일이 없는 경우(첨부파일 새로 인서트
				result = memberDao.updateClassCreateNew(sqlSession,c,a);
			}
		}
		return result;
	}
	
	// 학기별 성적 조회 -> 학기별 성적 계산
	@Override
	public HashMap<String, String> calculatedGrade(HashMap<String, String> map) {
		HashMap<String, String> gList = memberDao.calculatedGrade(sqlSession, map);
		return gList;
	}
	
	// 학기별 성적 조회 -> 학기별석차
	@Override
	public String calculatedTermRank(HashMap<String, String> map) {
		String rank = memberDao.calculatedTermRank(sqlSession, map);
		return rank;
	}
	
	// 학기별 성적 조회 -> 전체석차
	@Override
	public String calculatedTotalRank(HashMap<String, String> map) {
		String rank = memberDao.calculatedTotalRank(sqlSession, map);
		return rank;
	}

	// 학기별 성적 조회 -> 증명신청학점, 증명취득학점
	@Override
	public HashMap<String, String> selectScoreAB(String studentNo) {
		HashMap<String, String> scoreAB = memberDao.selectScoreAB(sqlSession, studentNo);
		return scoreAB;
	}

	// 학기별 성적 조회 -> 증명평점평균
	@Override
	public double selectScoreC(String studentNo) {
		double scoreC = memberDao.selectScoreC(sqlSession, studentNo);
		return scoreC;
	}

	// 학기별 성적 조회 -> 증명산술평균
	@Override
	public double selectScoreD(String studentNo) {
		double scoreD = memberDao.selectScoreD(sqlSession, studentNo);
		return scoreD;
	}
	// (학생)수강한 강의정보 조회
	@Override
	public ArrayList<RegisterClass> classInfoForRating(ClassRating cr) {
		return memberDao.classInfoForRating(sqlSession,cr);
	}
	
	// (학생)강의평가 입력
	@Override
	public int insertClassRating(ClassRating cr) {
		return memberDao.insertClassRating(sqlSession,cr);
	}
	
	// (관리자) 강의평가 조회
	@Override
	public ArrayList<ClassRating> classRatingList(ClassRating cr) {
		return memberDao.classRatingList(sqlSession,cr);
	}
	
	// (관리자) 강의평가 기타건의사항 조회
	@Override
	public ArrayList<ClassRating> classRatingEtcList(ClassRating cr) {
		return memberDao.classRatingEtcList(sqlSession,cr);
	}
	
	// (관리자) 강의평가 문항별 평균 점수 조회
	@Override
	public ClassRating classRatingAverage(ClassRating cr) {
		return memberDao.classRatingAverage(sqlSession,cr);	
		
	}

	//(교수) 안식,퇴직 신청 등록
	@Override
	public int insertProRest(ProfessorRest pr) {
		int result = memberDao.insertProRest(sqlSession,pr);
		return result;
	}

	//(교수) 안식,퇴직 신청 목록 가져오기
	@Override
	public ArrayList<ProfessorRest> selectRestListPro(String professorNo) {
		ArrayList<ProfessorRest> list = memberDao.selectRestListPro(sqlSession,professorNo);
		
		return list;
	}
	
	// 학사일정 관리 -> 학사일정 조회
	@Override
	public ArrayList<HashMap<String, String>> calendarList() {
		return memberDao.calendarList(sqlSession);
	}

	// 학사일정 관리 -> 학사일정 추가
	@Override
	public int insertCalendar(CalendarVo c) {
		return memberDao.insertCalendar(sqlSession, c);
	}

	//(관리자) 학생 휴,복학 신청 리스트 조회
	@Override
	public ArrayList<Counseling> selectCounAllStuList() {
		ArrayList<Counseling> list = memberDao.selectCounAllStuList(sqlSession);
		return list;
	}

	//(관리자) 임직원 안식,퇴직 신청 리스트 조회
	@Override
	public ArrayList<ProfessorRest> selectCounAllProList() {
		ArrayList<ProfessorRest> list = memberDao.selectCounAllProList(sqlSession);
		return list;
	}

	//(관리자) 학생 휴,복학 신청 상세보기
	@Override
	public StudentRest selectStuRestDetail(int rno) {
		StudentRest sr = memberDao.selectStuRestDetail(sqlSession,rno);
		return sr;
	}

	// 학번으로 학생 정보 조회 해오기
	@Override
	public Student selectStudentInfo(String studentNo) {
		Student s = memberDao.selectStudentInfo(sqlSession,studentNo);
		return s;
	}

	// (관리자)생 휴,복학 승인
	@Override
	public int updateStuRestPermit(StudentRest sr) {
		int result = memberDao.updateStuRestPermit(sqlSession,sr);
		return result;
	}

	// (관리자)생 휴,복학 반려(비허가)
	@Override
	public int updateStuRestRetire(int restNo) {
		int result = memberDao.updateStuRestRetire(sqlSession,restNo);
		return result;
	}

	//(관리자) 임직원 안식,퇴직 정보 조회
	@Override
	public ProfessorRest selectProRestDetail(int restNo) {
		ProfessorRest pr = memberDao.selectProRestDetail(sqlSession,restNo);
		return pr;
	}

	// (관리자) 임직원 안식,퇴직 업데이트
	@Override
	public int updateProfessorRest(ProfessorRest pr) {
		int result = memberDao.updateProfessorRest(sqlSession,pr);
		return result;
	}

	// (관리자) 학생 휴,복학 목록 검색 
	@Override
	public ArrayList<StudentRest> selectSearchStuRestList(HashMap<String, String> set) {
		return memberDao.selectSearchStuRestList(sqlSession,set);
	}
	
	// (교수) 상담조회
	@Override
	public ArrayList<Counseling> professorSelectCounseling(HashMap<String, String> counselMap) {
		return memberDao.professorSelectCounseling(sqlSession, counselMap);
	}
	
	// (교수) 상담 상세 조회
	@Override
	public Counseling selectCounselDetail(HashMap<String, String> counselDtMap) {

		return memberDao.selectCounselDetail(sqlSession, counselDtMap);
	}

	// 학사일정 관리 -> 학사일정 수정
	@Override
	public int updateCalendar(CalendarVo c) {
		return memberDao.updateCalendar(sqlSession, c);
	}

	// 학사일정 관리 -> 학사일정 삭제
	@Override
	public int deleteCalendar(CalendarVo c) {
		return memberDao.deleteCalendar(sqlSession, c);
	}
	
	// 메인 -> 학사일정 조회
	@Override
	public ArrayList<HashMap<String, String>> yearCalendarList() {
		return memberDao.yearCalendarList(sqlSession);
	}

	// 메인 -> 공지사항 조회
	@Override
	public ArrayList<Notice> selectMainNotice() {
		return memberDao.selectMainNotice(sqlSession);
	}

	//(교수) 상담 상태 변경
	@Override
	public int updateCounselStatus(HashMap<String, String> statusMap) {
		return memberDao.updateCounselStatus(sqlSession, statusMap);
	}

	// (교수) 업데이트 후 재조회
	@Override
	public Counseling selectUpdateCounsel(String counselNo) {
		return memberDao.selectUpdateCounsel(sqlSession, counselNo);
	}

}

