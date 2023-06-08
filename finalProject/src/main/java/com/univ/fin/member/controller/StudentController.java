package com.univ.fin.member.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
