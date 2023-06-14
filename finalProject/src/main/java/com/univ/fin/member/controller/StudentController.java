package com.univ.fin.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

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
import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.template.DepartmentCategory;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Controller
public class StudentController {

	@Autowired
	private MemberService memberService;
	
	//수강신청 폼
	@RequestMapping("registerClassForm.st")
	public String registerClassForm() {
		return "member/student/registerClass";
	}
	
	//예비수강신청 폼
	@GetMapping("preRegisterClass.st")
	public String preRegisterClassForm() {
		return "member/student/preRegisterClass";
	}
	
	//수강신청 - 수강취소 폼
	@GetMapping("cancelRegClassForm.st")
	public String cancelRegClassForm() {
		return "member/student/cancelRegClass";
	}
	
	//수강신청 - 수강신청 내역조회 폼
	@GetMapping("searchRegClassForm.st")
	public String searchRegClassForm(Model model,HttpSession session) {
		
		Student st = (Student)session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		
		//수강신청 - 수강신청내역조회 (로그인 학생의 수강신청 년도/학기 추출)
		ArrayList<Classes> list = memberService.searchRegYear(studentNo);
		model.addAttribute("regYear", list);
		
		return "member/student/searchRegClass";
	}
	
	//예비수강신청 - 수강담기
	@ResponseBody
	@PostMapping("preRegisterClass.st")
	public String preRegisterClass(Bucket b) {
		
		int result = 0;
		
		//예비수강 중복체크
		int chkClass = memberService.checkPreReg(b); 
		
		if(chkClass == 0) {
			result = memberService.preRegisterClass(b);
		}
		
		return new Gson().toJson(result);
	}
	
	//예비수강신청 - 수강조회
	@ResponseBody
	@RequestMapping(value="preRegClass.st",produces = "application/json; charset=UTF-8")
	public String preRegClass(@RequestParam(value="departmentName",defaultValue = "교양")String departmentName,RegisterClass rc) {
		
		String term = String.valueOf(rc.getClassTerm().charAt(0)); //학기 추출
		
		RegisterClass rc2 = RegisterClass.builder()
										 .classYear(rc.getClassYear()) //학년도
										 .classTerm(term) //학기
										 .departmentName(departmentName) //전공
										 .professorName(rc.getProfessorName()) //교수명
										 .className(rc.getClassName()) //과목명
										 .studentNo(rc.getStudentNo()) //학번 
										 .studentLevel(rc.getStudentLevel()) //학생 학년
										 .build();
		
		ArrayList<RegisterClass> list = memberService.preRegClass(rc2);
		
		return new Gson().toJson(list);
	}
	
	//예비수강신청 - 장바구니 조회
	@ResponseBody
	@RequestMapping(value="preRegList.st", produces = "application/json; charset=UTF-8")
	public String preRegList(RegisterClass rc) {
		
		String term = String.valueOf(rc.getClassTerm().charAt(0)); //학기 추출
		
		RegisterClass rc2 = RegisterClass.builder()
										 .classYear(rc.getClassYear())
										 .classTerm(term)
										 .studentNo(rc.getStudentNo())
										 .build();
		
		ArrayList<RegisterClass> list = memberService.preRegList(rc2);
		
		return new Gson().toJson(list);
	}
	
	//예비수강신청 - 장바구니 수강취소
	@ResponseBody
	@RequestMapping(value="delPreRegList.st", produces = "application/json; charset=UTF-8")
	public String delPreRegList(RegisterClass rc) {
		
		int result = memberService.delPreRegList(rc); 
		
		return new Gson().toJson(result);
	}
	
	//수강신청 -(전공 카테고리조회)
	@ResponseBody
	@RequestMapping(value="selectCollegeNo.st",produces = "application/json; charset=UTF-8")
	public String selectCollegeNo(int cno) {
		
		DepartmentCategory d = new DepartmentCategory();
		
		ArrayList<String> list = d.departmentCategory(cno);
		
		return new Gson().toJson(list);
	}
	
	// 수강신청 - 수강신청 (수강조회)
	@ResponseBody
	@RequestMapping(value="postRegClass.st",produces = "application/json; charset=UTF-8")
	public String postRegClass(@RequestParam(value="departmentName",defaultValue = "교양")String departmentName,RegisterClass rc) {
		
		String term = String.valueOf(rc.getClassTerm().charAt(0)); //학기 추출
		
		RegisterClass rc2 = RegisterClass.builder()
										 .classYear(rc.getClassYear()) //학년도
										 .classTerm(term) //학기
										 .departmentName(departmentName) //전공
										 .professorName(rc.getProfessorName()) //교수명
										 .className(rc.getClassName()) //과목명
										 .studentNo(rc.getStudentNo()) //학번 
										 .studentLevel(rc.getStudentLevel()) //학생 학년
										 .build();
		
		ArrayList<RegisterClass> list = memberService.postRegClass(rc2);
		
		return new Gson().toJson(list);
	}
	
	//수강신청 - 수강신청 (장바구니)
	@ResponseBody
	@RequestMapping(value="postRegBucket.st",produces = "application/json; charset=UTF-8")
	public String postRegBucket(RegisterClass rc) {
		
		String term = String.valueOf(rc.getClassTerm().charAt(0)); //학기 추출
		
		RegisterClass rc2 = RegisterClass.builder()
										 .classYear(rc.getClassYear())
										 .classTerm(term)
										 .studentNo(rc.getStudentNo())
										 .build();
		
		ArrayList<RegisterClass> list = memberService.postRegBucket(rc2);
		
		return new Gson().toJson(list);
	}
	
	//수강신청 - 수강신청
	@ResponseBody
	@RequestMapping("postRegisterClass.st")
	public String postRegisterClass(RegisterClass rc) {
		
		int result = 0; //최종 성공여부 변수
		RegisterClass rc2 = null;
		
		//해당 강의 조회
		Classes c = memberService.selectClass(rc.getClassNo());
		
		if(c.getSpareNos() != c.getClassNos()) { // 수강인원 체크 (신청인원이 수강인원보다 적을때)
			rc2 = RegisterClass.builder().day(c.getDay())
										 .period(c.getPeriod())
										 .classHour(c.getClassHour())
										 .studentNo(rc.getStudentNo())
										 .classNo(rc.getClassNo())
										 .classYear(rc.getClassYear())
										 .classTerm(rc.getClassTerm())
										 .build();
			
			//강의 시간 체크 (0반환이라면 가능이라는 의미)
			int check = memberService.checkPostReg2(rc2);
			
			//수강신청 가능 여부 판별
			if(check == 0) {
				result = memberService.postRegisterClass(rc2);
				if(rc2.getClassHour() == 2) { //2시간짜리 강의일 경우
					result *= memberService.postRegisterClass2(rc2);
				}
			}
		}
		
		return new Gson().toJson(result);
	}
	
	//수강신청 - 수강신청 (수강신청내역 조회)
	@ResponseBody
	@RequestMapping(value="postRegList.st",produces = "application/json; charset=UTF-8")
	public String postRegList(RegisterClass rc) {
		
		String term = String.valueOf(rc.getClassTerm().charAt(0)); //학기 추출
		
		RegisterClass rc2 = RegisterClass.builder()
										 .classYear(rc.getClassYear())
										 .classTerm(term)
										 .studentNo(rc.getStudentNo())
										 .build();
		
		ArrayList<RegisterClass> list = memberService.postRegList(rc2);
		
		return new Gson().toJson(list);
	}
	
	//수강신청 - 수강신청 (수강신청내역 수강취소)
	@ResponseBody
	@RequestMapping("delPostRegList.st")
	public String delPostRegList(RegisterClass rc) {
		
		int result = memberService.delPostRegList(rc);
		
		return new Gson().toJson(result);
	}
	
	//수강신청 - 수강신청 내역조회
	@ResponseBody
	@RequestMapping(value="searchRegList.st",produces = "application/json; charset=UTF-8")
	public String searchRegList(String studentNo,String classYear, String classTerm) {
		HashMap<String, String> h = new HashMap<String, String>();
		h.put("studentNo", studentNo);
		h.put("classYear",classYear);
		h.put("classTerm",classTerm);
		
		ArrayList<HashMap<String, String>> list = memberService.searchRegList(h);
		
		return new Gson().toJson(list);
	}
	
	// 수강신청 - 학기별 성적 조회
	@RequestMapping("classManagement.st")
	public String student_classManagement() {
		return "member/student/gradeListView";
	}
	
	// 수강신청 - 강의시간표
	@RequestMapping("classListView.st")
	public ModelAndView classListView(ModelAndView mv) {
		ArrayList<String> classTerm = memberService.selectClassTerm();
		System.out.println(classTerm);
		
		mv.addObject("classTerm", classTerm).setViewName("member/student/classListView");
		return mv;
	}

	//상담관리 - 상담조회페이지 이동
	@RequestMapping("counselingList.st")
	public String counselingList(HttpSession session,Model m) {
		
		String studentNo =((Student)session.getAttribute("loginUser")).getStudentNo();
		
		ArrayList<Counseling> list = memberService.selectCounStuList(studentNo);
		
		m.addAttribute("list",list);
		
		return "member/student/st_counseling_list";
	}
	
	//상담관리 - 상담신청 페이지 이동
	@RequestMapping("counselingEnroll.st")
	public String counselingEnroll(String departmentNo) {
		return "member/student/st_counseling_enrollForm";
	}
	
	//상담관리 - 상담신청 페이지 학생 학과 교수 리스트 조회
	@ResponseBody
	@RequestMapping(value="departmentProList.st",produces = "application/json; charset = UTF-8")
	public String selectDepartProList(String departmentNo) {
		
		//학과별 교수 조회해서 가져가기
		ArrayList<Professor> list = memberService.selectDepartProList(departmentNo);
		
		return new Gson().toJson(list);
	} 
	
	//상담신청 - 상담신청 작성
	@RequestMapping(value="insertCounseling.st",method =RequestMethod.POST)
	public ModelAndView insertCounseling(Counseling c,ModelAndView mv) {
		
		int result = memberService.insertCounseling(c);
		
		if(result>0) {
			mv.addObject("alertMsg", "상담신청 성공");
			mv.setViewName("redirect:counselingList.st");
		}else {
			mv.addObject("errorMsg", "상담신청 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	//상담관리 - 상담 상세보기
	@RequestMapping("stuCounDetail.st")
	public String StudentcounDetail(int counselNo,Model m) {
		
		Counseling c = memberService.selectCounseling(counselNo);
		
		Professor p = memberService.selectProfessorForNo(c.getProfessorNo());
		
		m.addAttribute("c",c);
		m.addAttribute("p",p);
		
		return "member/student/st_counseling_detail";
	}
	
	
	@RequestMapping(value="counselingUpdate.st",method =RequestMethod.POST)
	public ModelAndView StuCounUpdate(Counseling c,ModelAndView mv) {
		
		
		
		int result = memberService.updateCounContent(c);
		
		if(result>0) {
			mv.addObject("counselNo",c.getCounselNo());
			mv.setViewName("redirect:stuCounDetail.st");
		}else {
			mv.addObject("errorMsg", "상담신청 실패");
			mv.setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	
		//학적 정보조회 - 학생
			@RequestMapping("infoStudent.st")
			public String infoStudent() {		
				
				return "member/student/infoStudent";
			}
			
			
			//학적 정보수정 - 학생
			
			@RequestMapping(value="updateStudent.st" , method = RequestMethod.POST)
			public String updateStudent(Student st,
											Model model,
											HttpSession session) {
				int result = memberService.updateStudent(st);
				
				System.out.println("확인 : "+result);
				
				if(result>0) {
					//유저 정보갱신
					Student loginUser = memberService.loginStudent(st);
					session.setAttribute("loginUser", loginUser);
					model.addAttribute("msg", "수정 완료");
				}else { //정보변경실패
					model.addAttribute("msg", "수정 실패");
				}
				
			return "member/student/infoStudent";
				
			}
	
	// 학사관리 - 개인시간표
	@RequestMapping("personalTimetable.st")
	public ModelAndView personalTimetable(ModelAndView mv, HttpSession session) {
		Student st = (Student)session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		ArrayList<String> classTerm = memberService.selectStudentClassTerm(studentNo); // 수강한 학년도, 학기
		
		mv.addObject("classTerm", classTerm).setViewName("member/student/personalTimetableView");
		return mv;
	}

	// 개인시간표 -> 학기 선택 후 시간표 조회
	@ResponseBody
	@RequestMapping(value = "selectStudentTimetable.st", produces = "application/json; charset=UTF-8;")
	public String selectStudentTimetable(@RequestParam HashMap<String,String> map, HttpSession session) {
		Student st = (Student)session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		map.put("studentNo", studentNo);
		
		ArrayList<Classes> cList = memberService.selectStudentTimetable(map);
		return new Gson().toJson(cList);
	}

}
