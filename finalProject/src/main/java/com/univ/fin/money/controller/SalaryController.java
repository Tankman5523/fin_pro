package com.univ.fin.money.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.money.model.service.SalaryService;
import com.univ.fin.money.model.vo.Salary;

@Controller
public class SalaryController {
	
	@Autowired
	private SalaryService salaryService;
	
	//임직원 
	@PostMapping("myselect.sl")
	public ModelAndView selectmySalary(Salary sl,ModelAndView mv) { //(임직원) 해당월 급여명세서 조회
		
		Salary payStub = salaryService.selectMySalary(sl);
		
		mv.addObject("salary", payStub).setViewName("money/salary/professor/professor_salary_detail");
		return mv;
	}
	@GetMapping("mylist.sl")
	public String selectMySalaryListPage() { //급여 페이지로 이동
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
		return "money/salary/admin/admin_salary_list";
	}
	@PostMapping("insert.sl")
	public String insertSalary(Salary sl,HttpSession session) {//급여 입력
		
		int result = salaryService.insertSalary(sl);
		
		if(result>0) {
			session.setAttribute("alertMsg", "급여 입력이 완료되었습니다.");
		}else {
			session.setAttribute("errorMsg", "급여입력실패! 데이터를 확인하세요.");
		}
		
		return "redirect:/";
	}
	
	@GetMapping("update.sl")
	public String updateSalaryForm() {//급여 수정 페이지로
		
		return "";
	}
	@PostMapping("update.sl")
	public String updateSalary() {//급여 수정(미지급 상태인 경우만 가능)
		
		return "";
	}
	
	@GetMapping("delete.sl")
	public String deleteSalary() {//급여 삭제
		
		return "";
	}
	
	@ResponseBody
	@GetMapping("allList.sl")
	public String selectAllSalaryList(String keyword,String payStatus) { //(관리자) 모든 월급표 조회
		
		return "";
	}
	
	
}
