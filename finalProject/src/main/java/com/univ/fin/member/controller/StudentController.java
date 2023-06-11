package com.univ.fin.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Bucket;
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
										 .build();
		
		ArrayList<RegisterClass> list = memberService.majorClass(rc2);
		
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
	public String counselingList() {
		
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
	
}
