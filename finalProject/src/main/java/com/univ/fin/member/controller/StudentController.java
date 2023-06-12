package com.univ.fin.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Classes;
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
	
	//수강신청 - 수강신청(전공 카테고리조회)
	@ResponseBody
	@RequestMapping(value="selectCollegeNo.st",produces = "application/json; charset=UTF-8")
	public String selectCollegeNo(int cno) {
		
		DepartmentCategory d = new DepartmentCategory();
		
		ArrayList<String> list = d.departmentCategory(cno);
		
		return new Gson().toJson(list);
	}
	
	//수강신청 - 수강신청 (학부전공별 조회)
	@ResponseBody
	@RequestMapping(value="majorClass.st",produces = "application/json; charset=UTF-8")
	public String majorClassList(String departmentName) {
		
		ArrayList<RegisterClass> list = memberService.majorClass(departmentName);
		
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
	
			//학생등록 페이지
			@RequestMapping("enrollStudent.ad")
			public String enrollStudent() {		
				
				return "member/student/enrollStudent";
			}
			
			//학생등록 페이지 등록
			@RequestMapping("insertStudent.ad")
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
