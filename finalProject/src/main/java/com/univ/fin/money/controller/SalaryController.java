package com.univ.fin.money.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.money.model.service.SalaryService;
import com.univ.fin.money.model.vo.Salary;

@Controller
public class SalaryController {
	
	@Autowired
	private SalaryService salaryService;
	
	//임직원 
	@PostMapping("myselect.sl")//(임직원) 해당월 급여명세서 조회
	public ModelAndView selectmySalary(Salary sl,ModelAndView mv) { 
		Salary payStub = salaryService.selectMySalary(sl);
		mv.addObject("salary", payStub).setViewName("money/salary/professor/professor_salary_detail");
		return mv;
	}
	@GetMapping("mylist.sl")//급여 페이지로 이동
	public String selectMySalaryListPage() { 
		return "money/salary/professor/professor_salary_list";
	}
	
	@ResponseBody
	@PostMapping(value = "mylist.sl" , produces = "application/json;charset=utf-8")
	public String selectMySalaryList(Salary sl) { //(임직원) 내 모든 급여 조회
		ArrayList<Salary> list = salaryService.selectMySalaryList(sl);
		return new Gson().toJson(list);
	}
	
	
	//관리자
	@GetMapping("insert.sl")
	public String insertSalaryForm() {//급여 입력 페이지로
		return "money/salary/admin/admin_salary_insertForm";
	}
	
	@PostMapping("insert.sl")
	public String insertSalary(Salary sl,HttpSession session) {//급여 입력
		int result = salaryService.insertSalary(sl);
		if(result>0) {
			session.setAttribute("alertMsg", "급여 입력이 완료되었습니다.");
		}else {
			session.setAttribute("errorMsg", "급여입력실패! 데이터를 확인하세요.");
		}
		
		return "redirect:allList.sl";
	}
	
	@ResponseBody
	@PostMapping("update.sl")
	public String updateSalary(Salary sl,HttpSession session) {//급여 수정(미지급 상태인 경우만 가능)
		int result = salaryService.updateSalary(sl);
		if(result>0) {
			return "Y";
		}else {
			return "N";
		}
		
	}
	
	@ResponseBody
	@GetMapping("delete.sl")
	public String deleteSalary(int payNo,HttpSession session) {//급여 삭제
		int result = salaryService.deleteSalary(payNo);
		if(result>0) {
			return "Y";
		}else {
			return "N";
		}
	}
	
	@GetMapping("allList.sl")
	public String selectAllSalaryPage() {
		return "money/salary/admin/admin_salary_list";
	}
	
	@ResponseBody
	@PostMapping(value = "allList.sl", produces = "application/json;charset=utf-8")
	public String selectAllSalaryList(Salary sl) { //(관리자) 모든 월급표 조회
		ArrayList<Salary> list = salaryService.selectAllSalaryList(sl);
		return new Gson().toJson(list);
	}
	
	@ResponseBody
	@GetMapping(value="selectPf.sl", produces = "application/json;charset=utf-8")
	public String professorListToSalary(Professor p) { //직번 , 교수이름으로 정보검색
		ArrayList<Salary> list = salaryService.professorListToSalary(p);
		return new Gson().toJson(list);
	}
	
	@ResponseBody
	@GetMapping("pay.sl")
	public String sendSalary(int payNo) { //급여 지급 메소드 (상태만 변경)
		int result=salaryService.sendSalary(payNo);
		if(result>0) {
			return "Y";
		}else {
			return "N";
		}
	}
	
	@ResponseBody
	@GetMapping(value = "modal.sl" , produces = "application/json;charset=utf-8")
	public String viewPayStub(int payNo) { //급여 명세서 모달 
		Salary sal = salaryService.selectOneSalary(payNo);
		return new Gson().toJson(sal);
	} 
	
	
}
