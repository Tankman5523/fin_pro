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
import com.univ.fin.common.template.DepartmentCategory;
import com.univ.fin.member.model.service.MemberService;

@Controller
public class StudentController {

	@Autowired
	private MemberService memberService;
	
	//수강신청 폼
	@RequestMapping("registerClassForm.st")
	public String registerClassForm() {
		return "member/student/registerClass";
	}
	
	//수강신청 -전공 카테고리조회
	@ResponseBody
	@RequestMapping(value="selectCollegeNo.st",produces = "application/json; charset=UTF-8")
	public String selectCollegeNo(int cno) {
		
		DepartmentCategory d = new DepartmentCategory();
		
		ArrayList<String> list = d.departmentCategory(cno);
		
		return new Gson().toJson(list);
	}
	
	//수강신청 - 학부전공별 조회
	@ResponseBody
	@RequestMapping(value="majorClass.st",produces = "application/json; charset=UTF-8")
	public String majorClassList(String departmentName) {
		
		ArrayList<Classes> list = memberService.majorClass(departmentName);
		
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

	// 수강신청 - 강의시간표 -> 단과대학별 전공 조회
	@ResponseBody 
	@RequestMapping(value = "selectDepart.me", produces = "application/json; charset=UTF-8;")
	public String selectDepartment(String college) {
		ArrayList<String> dList = memberService.selectDepertment(college);
		return new Gson().toJson(dList);
	}
	
	// 수강신청 - 강의시간표 -> 전공 선택 후 전공수업 조회
	@ResponseBody
	@RequestMapping(value = "selectDepartmentMajor.st", produces = "application/json; charset=UTF-8;")
	public String selectDepartmentMajor(@RequestParam HashMap<String,String> map) {
		ArrayList<Classes> cList = memberService.selectDepartmentMajor(map);
		return new Gson().toJson(cList);
	}
	
}
