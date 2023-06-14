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
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.model.vo.StudentRest;
import com.univ.fin.common.template.DepartmentCategory;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.vo.RegistPay;

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
	
	//예비수강신청 - 수강담기
	@ResponseBody
	@PostMapping("preRegisterClass.st")
	public String preRegisterClass(Bucket b) {
		
		int result = 0;
		
		//예비수강 중복체크
		int chkClass = memberService.checkPre(b); 
		
		if(chkClass == 0) {
			result = memberService.preRegisterClass(b);
		}
		
		return new Gson().toJson(result);
	}
	
	//수강신청 - 수강신청(전공 카테고리조회)
	@ResponseBody
	@RequestMapping(value="selectCollegeNo.st",produces = "application/json; charset=UTF-8")
	public String selectCollegeNo(int cno) {
		
		DepartmentCategory d = new DepartmentCategory();
		
		ArrayList<String> list = d.departmentCategory(cno);
		
		return new Gson().toJson(list);
	}
	
	//수강신청 - 수강신청
	@ResponseBody
	@RequestMapping(value="majorClass.st",produces = "application/json; charset=UTF-8")
	public String majorClassList(@RequestParam(value="departmentName",defaultValue = "교양")String departmentName,RegisterClass rc) {
		
		String term = String.valueOf(rc.getClassTerm().charAt(0));
		
		RegisterClass rc2 = RegisterClass.builder()
										 .classYear(rc.getClassYear())
										 .classTerm(term)
										 .departmentName(departmentName)
										 .professorName(rc.getProfessorName())
										 .className(rc.getClassName())
										 .studentNo(rc.getStudentNo())
										 .build();
		
		ArrayList<RegisterClass> list = memberService.preClass(rc2);
//		ArrayList<RegisterClass> list = memberService.majorClass(rc2);
		
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
		
	
	ArrayList<Professor> list = memberService.selectDepartProList(departmentNo);//학과별 교수 조회해서 가져가기
	
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
	
	
	//상담 신청 내용 수정
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
	
	//상담 관리 - 상담 내역 검색
	@ResponseBody
	@RequestMapping(value="counselingSearch.st",produces = "application/json; charset = UTF-8")
	public String counSearchList(String data) {
								
		HashMap<String,String> map = new HashMap<String, String>();

		JsonObject con = (JsonObject) JsonParser.parseString(data);
		String studentNo = con.get("studentNo").getAsString();
		String year = con.get("year").getAsString();
		String counselArea = con.get("counselArea").getAsString();
		String startDate = con.get("startDate").getAsString();
		String endDate = con.get("endDate").getAsString();
		
		map.put("studentNo",studentNo);
		map.put("year",'%'+year+'%' );
		map.put("counselArea", '%'+counselArea+'%');
		//map.put("startDate",startDate!=""?startDate:"1900-01-01");
		map.put("startDate",startDate);
		//map.put("endDate",endDate!=null?endDate:"2999-12-31");
		map.put("endDate",endDate);
			
		ArrayList<Counseling> list = memberService.selectSearchCounseling(map);
		
		return new Gson().toJson(list);
		
		
	}
	
	//학적 정보조회 - 학생
	@RequestMapping("infoStudent.me")
	public String infoStudent() {		
		
		return "member/student/infoStudent";
	}
	
	
	//학적 정보수정 - 학생
	@RequestMapping("updateStudent.me")
	public ModelAndView updateStudent(Student st,
			ModelAndView mv,
			HttpSession session) {
		int result = memberService.updateStudent(st);
		
		System.out.println("확인 : "+result);
		
		if(result>0) {
			//유저 정보갱신
			Student loginUser = memberService.loginStudent(st);
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "수정 완료");
			mv.setViewName("redirect:infoStudent.me");
		}else { //정보변경실패
			mv.addObject("errorMsg","수정 실패함요").setViewName("redirect:infoStudent.me");
		}
		
		return mv;
		
	}
	
	//학생등록 페이지
	@RequestMapping("enrollStudent.me")
	public String enrollStudent() {		
		
		return "member/student/enrollStudent";
	}
	
	//학생등록 페이지 등록
	@RequestMapping("insertStudent.me")
	public String insertStudent(Student st,
			Model model,
			HttpSession session) {
		
		int result = memberService.insertStudent(st);
		
		if(result>0) {
			session.setAttribute("alertMsg", "회원가입 성공");
			return "redirect:enrollStudent";
		}else {
			model.addAttribute("errorMsg","회원가입 실패");
		}
		return "member/student/infoStudent";
		
	}
	
	//휴,복학 신청 조회(리스트) 페이지 이동(학생)
	@RequestMapping("studentRestList.st")
	public String selectStuRestList (HttpSession session,Model model) {
		
		
		String studentNo = ((Student)session.getAttribute("loginUser")).getStudentNo();
		
		ArrayList<StudentRest> list = memberService.selectStuRestList(studentNo);
		
		model.addAttribute("list",list);
		
		return "member/student/st_rest_list";
	}
	
	//휴,복학 신청 페이지 이동
	@RequestMapping("studentRestEnroll.st")
	public String StuRestForm (HttpSession session,Model model) {
		
		Student loginUser =(Student)session.getAttribute("loginUser");
		
		String studentNo = loginUser.getStudentNo();
		
		//휴학 횟수 가져옴
		int restCount = memberService.selectRestCount(studentNo);
		//현재 휴학중인지 알기위해 상태가져옴
		String status = loginUser.getStatus();
		
		if(status.equals("휴학")) {//만약 휴학중이면 복학or휴학연장이기 때문에 휴학 정보 가져감
			StudentRest sr = memberService.selectRestInfo(studentNo);
			model.addAttribute("sr",sr);
		}
		
		model.addAttribute("rcount",restCount);
		
		return "member/student/st_rest_enroll";
	}
	
	//휴학하는 학기 등록금 납부 여부
	@ResponseBody
	@RequestMapping(value="studentCheckRegistPay.st",produces = "application/json; charset=UTF-8")
	public String checkReg (RegistPay rp) {
		
		
		RegistPay checkRp = memberService.checkRegPay(rp);
		
		
		return new Gson().toJson(checkRp);
	}
	
	//휴,복학 신청 인서트
	@RequestMapping(value="studentRestInsert.st",method = RequestMethod.POST)
	public String insertStuRest(StudentRest sr,Model model) {
		
		System.out.println("인서트 자료"+sr);
		
		int result = memberService.insertStuRest(sr);
		
		if(result>0) {
			model.addAttribute("alertMsg","신청 성공");
		}else {
			model.addAttribute("errorMsg","신청 실패");
		}
		
		return "redirect:studentRestList.st";
	}
	
	
}
