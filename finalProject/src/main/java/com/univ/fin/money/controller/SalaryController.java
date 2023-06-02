package com.univ.fin.money.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.univ.fin.money.model.service.SalaryService;
import com.univ.fin.money.model.vo.Salary;

@Controller
public class SalaryController {
	
	@Autowired
	private SalaryService salaryService;
	
	//임직원 
	@GetMapping("myselect.sl")
	public ModelAndView selectmySalary(ModelAndView mv) { //(임직원) 해당월 급여명세서 조회
		
		Salary payStub = salaryService.selectMySalary();
		
		return mv;
	}
	@GetMapping("mylist.sl")
	public ModelAndView selectMySalaryList(ModelAndView mv) { //(임직원) 내 모든 급여 조회
		
		ArrayList<Salary> slist = salaryService.selectMySalaryList();
	
		return mv;
	}
	
	
	//관리자
	@GetMapping("insert.sl")
	public String insertSalaryForm() {//급여 입력 페이지로
		
		return "";
	}
	@PostMapping("insert.sl")
	public String insertSalary() {//급여 입력
		
		return "";
	}
	
	@GetMapping("update.sl")
	public String updateSalaryForm() {//급여 수정 페이지로
		
		return "";
	}
	@PostMapping("update.sl")
	public String updateSalary() {//급여 수정
		
		return "";
	}
	
	@GetMapping("delete.sl")
	public String deleteSalary() {//급여 삭제
		
		return "";
	}
	
	@GetMapping("allList.sl")
	public ModelAndView selectAllSalaryList(ModelAndView mv) { //(관리자) 모든 월급표 조회
		
		
		
		return mv;
	}
	
	
}
