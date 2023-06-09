package com.univ.fin.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.template.DepartmentCategory;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;

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
}
