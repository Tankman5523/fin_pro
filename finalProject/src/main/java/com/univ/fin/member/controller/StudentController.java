package com.univ.fin.member.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.CalendarVo;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.Graduation;
import com.univ.fin.common.model.vo.Objection;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.model.vo.StudentRest;
import com.univ.fin.common.template.DepartmentCategory;
import com.univ.fin.main.model.vo.Notice;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.vo.RegistPay;

import lombok.Synchronized;

@Controller
public class StudentController {

	@Autowired
	private MemberService memberService;
	
	// 메인페이지
	@RequestMapping("main.st")
	public ModelAndView mainPage(ModelAndView mv, HttpSession session) {
		Student st = (Student)session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		
		ArrayList<HashMap<String, String>> calList = memberService.yearCalendarList(); // 학사일정 조회
		ArrayList<HashMap<String, String>> regList = memberService.selectReg(studentNo); // 등록금 납부 조회
		ArrayList<Notice> nList = memberService.selectMainNotice(); // 공지사항 목록
		HashMap<String, String> map = new HashMap<>();
		map.put("person", "student");
		map.put("personNo", studentNo);
		String filePath = memberService.selectProfile(map);
		
		mv.addObject("filePath", filePath).addObject("regList", regList).addObject("calList", calList)
		  .addObject("nList", nList).setViewName("member/student/mainPage");
		return mv;
	}
	
	// 메인 -> 학생 시간표 조회
	@ResponseBody
	@RequestMapping(value = "getClasses.st", produces = "application/json; charset=UTF-8")
	public String getClasses(HttpSession session) {
		Student st = (Student)session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		
		ArrayList<Classes> cList = memberService.selectStudentAllClasses(studentNo); // 모든 신청강의 조회
		return new Gson().toJson(cList);
	}
	
	//수강신청 기간인지 체크하는 메소드
	public int chkRegCalendar() {
		
		ArrayList<CalendarVo> list = memberService.chkRegCal();
		
		String day = new SimpleDateFormat("yyyyMMdd").format(new Date());
		int today = Integer.parseInt(day);
		int result = 0;
		
		for(CalendarVo c : list) {
			
			int start = Integer.parseInt(c.getStartDate());
			int end = Integer.parseInt(c.getEndDate());
			
			if(start <= today && today <= end) {
				result++;
			}
		}
		return result;
	}

	// 수강신청 폼
	@RequestMapping("registerClassForm.st")
	public ModelAndView registerClassForm(ModelAndView mv, HttpServletRequest request, HttpSession session) {
		
		int result = chkRegCalendar();
		
		if(result > 0) {
			mv.setViewName("member/student/registerClass");
		}else {
			String referer = request.getHeader("Referer");
			session.setAttribute("alertMsg", "지금은 수강신청 기간이 아닙니다.");
			mv.setViewName("redirect:"+referer);
		}
		
		return mv;
	}

	// 예비수강신청 폼
	@GetMapping("preRegisterClassForm.st")
	public String preRegisterClassForm() {
		return "member/student/preRegisterClass";
	}

	// 수강신청 - 수강취소 폼
	@GetMapping("cancelRegClassForm.st")
	public String cancelRegClassForm() {
		return "member/student/cancelRegClass";
	}

	// 수강신청 - 수강신청 내역조회 폼
	@GetMapping("searchRegClassForm.st")
	public String searchRegClassForm(Model model, HttpSession session) {

		Student st = (Student) session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();

		// 수강신청 - 수강신청내역조회 (로그인 학생의 수강신청 년도/학기 추출)
		ArrayList<Classes> list = memberService.searchRegYear(studentNo);
		model.addAttribute("regYear", list);

		return "member/student/searchRegClass";
	}

	// 예비수강신청 - 수강담기
	@ResponseBody
	@PostMapping("preRegisterClass.st")
	public String preRegisterClass(Bucket b) {

		int result = 0;

		// 예비수강 중복체크
		int chkClass = memberService.checkPreReg(b);

		if (chkClass == 0) {
			result = memberService.preRegisterClass(b);
		}

		return new Gson().toJson(result);
	}

	// 예비수강신청 - 수강조회
	@ResponseBody
	@RequestMapping(value = "preRegClass.st", produces = "application/json; charset=UTF-8")
	public String preRegClass(@RequestParam(value = "departmentName", defaultValue = "교양") String departmentName,
			RegisterClass rc) {

		String term = String.valueOf(rc.getClassTerm().charAt(0)); // 학기 추출

		RegisterClass rc2 = RegisterClass.builder().classYear(rc.getClassYear()) // 학년도
				.classTerm(term) // 학기
				.departmentName(departmentName) // 전공
				.professorName(rc.getProfessorName()) // 교수명
				.className(rc.getClassName()) // 과목명
				.studentNo(rc.getStudentNo()) // 학번
				.build();

		ArrayList<RegisterClass> list = memberService.preRegClass(rc2);

		return new Gson().toJson(list);
	}

	// 예비수강신청 - 장바구니 조회
	@ResponseBody
	@RequestMapping(value = "preRegList.st", produces = "application/json; charset=UTF-8")
	public String preRegList(RegisterClass rc) {
		String term = String.valueOf(rc.getClassTerm().charAt(0)); // 학기 추출

		RegisterClass rc2 = RegisterClass.builder().classYear(rc.getClassYear()).classTerm(term)
				.studentNo(rc.getStudentNo()).build();

		ArrayList<RegisterClass> list = memberService.preRegList(rc2);

		return new Gson().toJson(list);
	}

	// 예비수강신청 - 장바구니 수강취소
	@ResponseBody
	@RequestMapping(value = "delPreRegList.st", produces = "application/json; charset=UTF-8")
	public String delPreRegList(RegisterClass rc) {

		int result = memberService.delPreRegList(rc);

		return new Gson().toJson(result);
	}

	// 수강신청 -(전공 카테고리조회)
	@ResponseBody
	@RequestMapping(value = "selectCollegeNo.st", produces = "application/json; charset=UTF-8")
	public String selectCollegeNo(int cno) {

		DepartmentCategory d = new DepartmentCategory();

		ArrayList<String> list = d.departmentCategory(cno);

		return new Gson().toJson(list);
	}

	// 수강신청 - 수강신청 (수강조회)
	@ResponseBody
	@RequestMapping(value = "postRegClass.st", produces = "application/json; charset=UTF-8")
	public String postRegClass(@RequestParam(value = "departmentName", defaultValue = "교양") String departmentName,
			RegisterClass rc) {

		String term = String.valueOf(rc.getClassTerm().charAt(0)); // 학기 추출

		RegisterClass rc2 = RegisterClass.builder().classYear(rc.getClassYear()) // 학년도
				.classTerm(term) // 학기
				.departmentName(departmentName) // 전공
				.professorName(rc.getProfessorName()) // 교수명
				.className(rc.getClassName()) // 과목명
				.studentNo(rc.getStudentNo()) // 학번
				.build();

		ArrayList<RegisterClass> list = memberService.postRegClass(rc2);

		return new Gson().toJson(list);
	}

	// 수강신청 - 수강신청 (장바구니)
	@ResponseBody
	@RequestMapping(value = "postRegBucket.st", produces = "application/json; charset=UTF-8")
	public String postRegBucket(RegisterClass rc) {

		String term = String.valueOf(rc.getClassTerm().charAt(0)); // 학기 추출

		RegisterClass rc2 = RegisterClass.builder().classYear(rc.getClassYear()).classTerm(term)
				.studentNo(rc.getStudentNo()).build();

		ArrayList<RegisterClass> list = memberService.postRegBucket(rc2);

		return new Gson().toJson(list);
	}

	// 수강신청 - 수강신청
	@Synchronized
	@ResponseBody
	@RequestMapping("postRegisterClass.st")
	public String postRegisterClass(RegisterClass rc){

		int result = 0; // 최종 성공여부 변수
		RegisterClass rc2 = null;

		// 해당 강의 조회
		Classes c = memberService.selectClass(rc.getClassNo());

		String term = String.valueOf(rc.getClassTerm().charAt(0)); // 학기 추출

		if (c.getSpareNos() != c.getClassNos()) { // 수강인원 체크 (신청인원이 수강인원보다 적을때)
			rc2 = RegisterClass.builder().day(c.getDay()).period(c.getPeriod()).classHour(c.getClassHour())
					.studentNo(rc.getStudentNo()).classNo(rc.getClassNo()).classYear(rc.getClassYear()).classTerm(term)
					.build();

			// 강의 시간 체크 (0반환이라면 겹치는 강의가 없다라는 의미)
			int check = memberService.checkPostReg2(rc2);

			// 수강신청 가능 여부 판별
			if (check == 0) {
				result = memberService.tranRegClass(rc2);
			}
		}

		return new Gson().toJson(result);
	}

	// 수강신청 - 수강신청 (수강신청내역 조회)
	@ResponseBody
	@RequestMapping(value = "postRegList.st", produces = "application/json; charset=UTF-8")
	public String postRegList(RegisterClass rc) {

		String term = String.valueOf(rc.getClassTerm().charAt(0)); // 학기 추출

		RegisterClass rc2 = RegisterClass.builder().classYear(rc.getClassYear()).classTerm(term)
				.studentNo(rc.getStudentNo()).build();

		ArrayList<RegisterClass> list = memberService.postRegList(rc2);

		return new Gson().toJson(list);
	}

	// 수강신청 - 수강신청 (수강신청내역 수강취소)
	@ResponseBody
	@RequestMapping("delPostRegList.st")
	public String delPostRegList(RegisterClass rc) {

		int result = memberService.delPostRegList(rc);

		return new Gson().toJson(result);
	}

	// 수강신청 - 수강신청 내역조회
	@ResponseBody
	@RequestMapping(value = "searchRegList.st", produces = "application/json; charset=UTF-8")
	public String searchRegList(String studentNo, String classYear, String classTerm) {
		HashMap<String, String> h = new HashMap<String, String>();
		h.put("studentNo", studentNo);
		h.put("classYear", classYear);
		h.put("classTerm", classTerm);

		ArrayList<HashMap<String, String>> list = memberService.searchRegList(h);

		return new Gson().toJson(list);
	}

	// 수강신청 - 강의시간표
	@RequestMapping("classListView.st")
	public ModelAndView classListView(ModelAndView mv) {
		ArrayList<String> classTerm = memberService.selectClassTerm();

		mv.addObject("classTerm", classTerm).setViewName("member/student/classListView");
		return mv;
	}

	// 상담관리 - 상담조회페이지 이동
	@RequestMapping("counselingList.st")
	public String counselingList(HttpSession session, Model m) {

		String studentNo = ((Student) session.getAttribute("loginUser")).getStudentNo();

		ArrayList<Counseling> list = memberService.selectCounStuList(studentNo);

		
		m.addAttribute("list",list);
		
		return "member/student/st_counseling_list";
	}

	// 상담관리 - 상담신청 페이지 이동
	@RequestMapping("counselingEnroll.st")
	public String counselingEnroll(String departmentNo) {
		return "member/student/st_counseling_enrollForm";
	}

	// 상담관리 - 상담신청 페이지 학생 학과 교수 리스트 조회
	@ResponseBody
	@RequestMapping(value = "departmentProList.st", produces = "application/json; charset = UTF-8")
	public String selectDepartProList(String departmentNo) {


		ArrayList<Professor> list = memberService.selectDepartProList(departmentNo);// 학과별 교수 조회해서 가져가기

		return new Gson().toJson(list);
	}

	// 상담신청 - 상담신청 작성
	@RequestMapping(value = "insertCounseling.st", method = RequestMethod.POST)
	public ModelAndView insertCounseling(Counseling c, ModelAndView mv, HttpSession session) {
		Student s = (Student)session.getAttribute("loginUser");
		
		HashMap<String, String> alarm = new HashMap<>();
		alarm.put("cmd", "counselRequest");
		alarm.put("receiverNo", c.getProfessorNo());
		alarm.put("senderName", s.getStudentName());

		int result = memberService.insertCounseling(c, alarm);

		if (result > 0) {
			mv.addObject("alertMsg", "상담신청 성공");
			mv.setViewName("redirect:counselingList.st");
		} else {
			mv.addObject("alertMsg", "상담신청 실패");
			mv.setViewName("redirect:counselingList.st");
		}
		return mv;
	}

	// 상담관리 - 상담 상세보기
	@RequestMapping("stuCounDetail.st")
	public String StudentcounDetail(int counselNo, Model m) {

		Counseling c = memberService.selectCounseling(counselNo);

		Professor p = memberService.selectProfessorForNo(c.getProfessorNo());

		m.addAttribute("c", c);
		m.addAttribute("p", p);

		return "member/student/st_counseling_detail";
	}

	// 상담 신청 내용 수정
	@RequestMapping(value = "counselingUpdate.st", method = RequestMethod.POST)
	public ModelAndView StuCounUpdate(Counseling c, ModelAndView mv) {

		int result = memberService.updateCounContent(c);

		if (result > 0) {
			mv.addObject("counselNo", c.getCounselNo());
			mv.setViewName("redirect:stuCounDetail.st");
		} else {
			mv.addObject("errorMsg", "상담신청 실패");
			mv.setViewName("common/errorPage");
		}

		return mv;
	}

	// 학적 정보조회 - 학생
	@RequestMapping("infoStudent.st")
	public ModelAndView infoStudent(ModelAndView mv, HttpSession session) {
		Student s = (Student)session.getAttribute("loginUser");
		String studentNo = s.getStudentNo();
		
		HashMap<String, String> map = new HashMap<>();
		map.put("person", "student");
		map.put("personNo", studentNo);
		String filePath = memberService.selectProfile(map);
		
		mv.addObject("filePath", filePath).setViewName("member/student/infoStudent");

		return mv;
	}

	// 학적 정보수정 - 학생

	@RequestMapping(value = "updateStudent.st", method = RequestMethod.POST)
	public String updateStudent(Student st, Model model, HttpSession session) {
		int result = memberService.updateStudent(st);

		System.out.println("확인 : " + st);

		if (result > 0) {
			// 유저 정보갱신
			Student loginUser = memberService.loginStudent(st);
			session.setAttribute("loginUser", loginUser);
			model.addAttribute("msg", "수정 완료");
		} else { // 정보변경실패
			model.addAttribute("msg", "수정 실패");
		}

		return "member/student/infoStudent";

	}

	// 학생 강의 이의신청 페이지
	@RequestMapping(value = "studentGradeReport.st" , method = RequestMethod.GET)
	public String studentGradeReport(HttpSession session, Model model, Objection obj) {

		Student loginUser = (Student) session.getAttribute("loginUser");
		String studentNo = loginUser.getStudentNo();
		
		ArrayList<String> classTerm = memberService.selectStudentClassTerm(studentNo); // 수강한 학년도, 학기
		String year = classTerm.get(0).substring(0, 4);
		String term = classTerm.get(0).substring(5);
		obj.setClassYear(year);
		obj.setClassTerm(term);
		obj.setStudentNo(studentNo);
		

		ArrayList<Objection> list = memberService.studentGradeReport(obj);
		Objection objc = new Objection();
		objc.setClassYear(year);
		objc.setClassTerm(term);
		objc.setStudentNo(studentNo);
		ArrayList<Objection> resultList = memberService.studentGradeView(objc);
		
		model.addAttribute("classTerm", classTerm);
		model.addAttribute("list", list);
		model.addAttribute("resultList", resultList);

		return "member/student/studentGradeReport";

	}

	// 학생 강의 신청 이후 ajax
	@ResponseBody
	@RequestMapping(value = "studentGradeReport.st", method = RequestMethod.POST , produces = "application/json; charset = UTF-8")
	public HashMap<String , ArrayList<Objection>> studentGradeReport(Objection obj) {
		
		ArrayList<Objection> list = memberService.studentGradeView(obj);
		ArrayList<Objection> commList = memberService.studentGradeReport(obj);
		
		System.out.println(commList);
		
		HashMap<String , ArrayList<Objection>> listMap = new HashMap<String, ArrayList<Objection>>();
		listMap.put("list", list);
		listMap.put("commList", commList);
		
		return listMap;

	}

	// 학생 강의 이의신청 확인

	@ResponseBody
	@PostMapping(value = "insertReport.st")
	public String insertGradeRequest(HttpSession session, Objection obj) {
		
		HashMap<String, String> alarm = new HashMap<>();
		alarm.put("cmd", "reportRequest");
		alarm.put("receiverNo", obj.getProfessorNo());
		alarm.put("senderName", obj.getStudentName());

		int result = memberService.studentGradeRequest(obj, alarm);

		if (result > 0) {
			return "Y";
		} else {
			return "N";
		}

	}
	
	//년도 학기별 이의 신청
	@PostMapping(value = "searchReport.st")
	public String searchGradeReport(HttpSession session, Objection obj ,Model model) {
		
		Student loginUser = (Student) session.getAttribute("loginUser");

		String studentNo = loginUser.getStudentNo();

		ArrayList<Objection> list = memberService.studentGradeReport(obj);
		Objection objc = new Objection();
		objc.setStudentNo(studentNo);
		ArrayList<Objection> resultList = memberService.studentGradeView(objc);
		
		model.addAttribute("list", list);
		model.addAttribute("resultList", resultList);

		return "member/student/studentGradeReport";
		
	}
	

	// 상담 관리 - 상담 내역 검색
	@ResponseBody
	@RequestMapping(value = "counselingSearch.st", produces = "application/json; charset = UTF-8")
	public String counSearchList(String data) {

		HashMap<String, String> map = new HashMap<String, String>();

		JsonObject con = (JsonObject) JsonParser.parseString(data);
		String studentNo = con.get("studentNo").getAsString();
		String year = con.get("year").getAsString();
		String counselArea = con.get("counselArea").getAsString();
		String startDate = con.get("startDate").getAsString();
		String endDate = con.get("endDate").getAsString();
		
		map.put("studentNo",studentNo);
		map.put("year",'%'+year+'%' );
		map.put("counselArea", '%'+counselArea+'%');
		map.put("startDate",startDate);
		map.put("endDate",endDate);
			
		ArrayList<Counseling> list = memberService.selectSearchCounseling(map);
		
		return new Gson().toJson(list);
		

	}

	// 학사관리 - 개인시간표
	@RequestMapping("personalTimetable.st")
	public ModelAndView personalTimetable(ModelAndView mv, HttpSession session) {
		Student st = (Student) session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		ArrayList<String> classTerm = memberService.selectStudentClassTerm(studentNo); // 수강한 학년도, 학기

		mv.addObject("classTerm", classTerm).setViewName("member/student/personalTimetableView");
		return mv;
	}

	// 개인시간표 -> 학기 선택 후 시간표 조회
	@ResponseBody
	@RequestMapping(value = "selectStudentTimetable.st", produces = "application/json; charset=UTF-8;")
	public String selectStudentTimetable(@RequestParam HashMap<String, String> map, HttpSession session) {
		Student st = (Student) session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		map.put("studentNo", studentNo);

		ArrayList<Classes> cList = memberService.selectStudentTimetable(map);
		return new Gson().toJson(cList);
	}

	// 학사관리 - 졸업사정표
	@GetMapping("graduationInfoForm.st")
	public String graduationInfoForm(Model model, HttpSession session) {

		Student st = (Student) session.getAttribute("loginUser");

		String sno = st.getStudentNo();

		Graduation g = memberService.graduationInfo(sno);

		model.addAttribute("student", g);

		return "member/student/graduationInfo";
	}

	// 학사관리 - 졸업사정표(전체 이수현황 조회)
	@ResponseBody
	@RequestMapping(value = "selectGraStatus.st", produces = "application/json; charset=UTF-8")
	public String selectGraStatus(String studentNo, String graDate, String departmentName) {

		String year = graDate.substring(0, 4);
		int month = Integer.parseInt(graDate.substring(5, 7));

		String term = "";
		if (month > 2 && month < 9) {
			term = "1";
		} else {
			term = "2";
		}

		HashMap<String, String> h = new HashMap<>();
		h.put("studentNo", studentNo);
		h.put("departmentName", departmentName);
		h.put("year", year);
		h.put("term", term);

		Graduation g = memberService.selectGraStatus(h);

		return new Gson().toJson(g);
	}

	// 학사관리 - 졸업사정표 (교양공통 세부조회)
	@ResponseBody
	@RequestMapping(value = "detailCommonGra.st", produces = "application/json; charset=UTF-8")
	public String detailCommonGra(String studentNo, String year, String term) {

		HashMap<String, String> h = new HashMap<>();
		h.put("studentNo", studentNo);
		h.put("year", year);

		ArrayList<HashMap<String, String>> list = memberService.detailCommonGra(h);

		return new Gson().toJson(list);
	}

	// 학사관리 - 졸업사정표 (교양일반 세부조회)
	@ResponseBody
	@RequestMapping(value = "detailNomalGra.st", produces = "application/json; charset=UTF-8")
	public String detailNomalGra(String studentNo, String departmentName, String year, String term) {

		HashMap<String, String> h = new HashMap<>();
		h.put("studentNo", studentNo);
		h.put("departmentName", departmentName);
		h.put("year", year);

		ArrayList<HashMap<String, String>> list = memberService.detailNomalGra(h);

		return new Gson().toJson(list);
	}

	// 학사관리 - 졸업사정표 (전공심화 세부조회)
	@ResponseBody
	@RequestMapping(value = "detailmajorGra.st", produces = "application/json; charset=UTF-8")
	public String detailmajorGra(String studentNo, String departmentName, String year, String term) {

		HashMap<String, String> h = new HashMap<>();
		h.put("studentNo", studentNo);
		h.put("departmentName", departmentName);
		h.put("year", year);

		ArrayList<HashMap<String, String>> list = memberService.detailmajorGra(h);

		return new Gson().toJson(list);
	}

	// 휴,복학 신청 조회(리스트) 페이지 이동(학생)
	@RequestMapping("studentRestList.st")
	public String selectStuRestList (HttpSession session,Model model) {
		
		
		String studentNo = ((Student)session.getAttribute("loginUser")).getStudentNo();
		
		ArrayList<StudentRest> list = memberService.selectStuRestList(studentNo);
		
		model.addAttribute("list", list);
		return "member/student/st_rest_list";
	}

	// 휴,복학 신청 페이지 이동
	@RequestMapping("studentRestEnroll.st")
	public String StuRestForm(HttpSession session, Model model) {

		//int result =memberService.checkPeriod("휴,복학 신청"); //학사일정에서 신청기간인지 판별
		int result = 1; //임시
		
		Student loginUser = (Student) session.getAttribute("loginUser");

		String studentNo = loginUser.getStudentNo();

		// 휴학 횟수 가져옴
		int restCount = memberService.selectRestCount(studentNo);
		// 현재 휴학중인지 알기위해 상태가져옴
		String status = loginUser.getStatus();

		if(status.equals("휴학")) {// 만약 휴학중이면 복학or휴학연장이기 때문에 휴학 정보 가져감
			if(result<=0) {//휴,복학 기간이 아니라면
				model.addAttribute("alertMsg","복학 신청 기간이 아닙니다. 휴학연장만 가능합니다.");
			}
			StudentRest sr = memberService.selectRestInfo(studentNo);//가장 최근 상담정보
			int checkReg = memberService.selectCheckReg(studentNo);//가장 최근 등록금 납부여부
			model.addAttribute("sr", sr);
			model.addAttribute("reg",checkReg);
		}else if(status.equals("재학") ){//재학상태라면 
			if(result<=0) {//휴,복학 기간이 아니라면 
				model.addAttribute("alertMsg","휴,복학 신청 기간이 아닙니다. 특별휴학만 가능합니다.");
			}
		}else{//졸업 or 중퇴 인 사람
			model.addAttribute("alertMsg","재,휴학생만 신청 가능합니다.");
			return "member/student/st_rest_list";
		}
		
		model.addAttribute("result",result);
		model.addAttribute("rcount", restCount);

		return "member/student/st_rest_enroll";
	}

	// 휴학하는 학기 등록금 납부 여부
	@ResponseBody
	@RequestMapping(value="studentCheckRegistPay.st",produces = "application/json; charset=UTF-8")
	public String checkReg (RegistPay rp) {
		
		RegistPay checkRp = memberService.checkRegPay(rp);
		return new Gson().toJson(checkRp);
	}
	
	//휴,복학 신청 인서트
	@RequestMapping(value="studentRestInsert.st",method = RequestMethod.POST)
	public String insertStuRest(StudentRest sr,Model model) {
		
		int result = memberService.insertStuRest(sr);

		if (result > 0) {
			model.addAttribute("alertMsg", "신청 성공");
		} else {
			model.addAttribute("errorMsg", "신청 실패");
		}

		return "redirect:studentRestList.st";
	}

	// 수업관리 - 학기별 성적 조회
	@RequestMapping("classManagement.st")
	public ModelAndView classManagement(ModelAndView mv, HttpSession session) {
		Student st = (Student) session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();

		ArrayList<String> classTerm = memberService.selectStudentClassTerm(studentNo);
		ArrayList<HashMap<String, String>> gList = new ArrayList<>();
		for (int i = 0; i < classTerm.size(); i++) {
			HashMap<String, String> map = new HashMap<>();
			map.put("year", classTerm.get(i).substring(0, 4));
			map.put("term", classTerm.get(i).substring(5, classTerm.get(i).length()));
			map.put("studentNo", studentNo);

			HashMap<String, String> termGrade = memberService.calculatedGrade(map);
			String termRank = memberService.calculatedTermRank(map); // 학기별석차
			termGrade.put("termRank", termRank);
			String totalRank = memberService.calculatedTotalRank(map); // 전체석차
			termGrade.put("totalRank", totalRank);

			gList.add(termGrade);
			
		}
		HashMap<String, String> scoreAB = memberService.selectScoreAB(studentNo); // 증명신청학점, 증명취득학점
		double scoreC = memberService.selectScoreC(studentNo); // 증명평점평균
		double scoreD = memberService.selectScoreD(studentNo); // 증명산술평균

		mv.addObject("classTerm", classTerm).addObject("gList", gList).addObject("scoreAB", scoreAB)
				.addObject("scoreC", scoreC).addObject("scoreD", scoreD).setViewName("member/student/gradeListView");
		return mv;
	}

	// 학기별 성적 조회 -> 학기 선택 후 강의 조회
	@ResponseBody
	@RequestMapping(value = "selectClassList.st", produces = "application/json; charset=UTF-8")
	public String selectClassList(@RequestParam HashMap<String, String> map, HttpSession session) {
		Student st = (Student) session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		map.put("studentNo", studentNo);

		ArrayList<HashMap<String, String>> cList = memberService.selectClassList(map);
		return new Gson().toJson(cList);
	}

	// 강의평가에 필요한 본인이 수강한 강의정보 셀렉트
	@GetMapping("classRatingInfo.st")
	public ModelAndView classInfoForRating(ModelAndView mv,HttpSession session) {
		if(memberService.checkPeriod("강의평가")>0) { //현재 날짜가 강의평가 기간이면 (캘린터 DB에 데이터가 1개 이상이면)
			Student st = (Student)session.getAttribute("loginUser");
			
			//현재 날짜정보로 현재학기 , 년도 찾기
			LocalDate now = LocalDate.now();
			String classYear = Integer.toString(now.getYear());
			int month = now.getMonthValue();
			String classTerm = "";
			
			
			if(month<2 && month>8) {
				classTerm = "2";
			}else{
				classTerm = "1";
			}
			
			ClassRating cr = ClassRating.builder()
										.studentNo(st.getStudentNo())
										.classTerm(classTerm)
										.classYear(classYear)
										.build();
			
			ArrayList<RegisterClass> list = memberService.classInfoForRating(cr);
			mv.addObject("list", list).setViewName("member/student/classRating");
		}else {//현재 날짜가 강의평가 기간이 아니면
			session.setAttribute("alertMsg", "강의평가 기간이 아닙니다.");
			mv.setViewName("redirect:classManagement.st");
		}
		return mv;
	}

	// 강의별 강의평가 인서트
	@ResponseBody
	@PostMapping(value = "insertRating.st")
	public String insertClassRating(ClassRating cr) {
		int result = memberService.insertClassRating(cr);
		if (result > 0) {
			return "Y";
		} else {
			return "N";
		}
	}
	
}