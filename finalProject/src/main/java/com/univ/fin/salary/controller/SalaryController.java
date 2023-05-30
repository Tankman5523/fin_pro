package com.univ.fin.salary.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.univ.fin.salary.model.service.SalaryService;
import com.univ.fin.salary.model.vo.Salary;

@Controller
public class SalaryController {
	
	@Autowired
	private SalaryService salaryService;
	
	public String insertSalary() {//급여 입력
		
		return "";
	}
	
	public String updateSalary() {//급여 수정
		
		return "";
	}
	
	public String deleteSalary() {//급여 삭제
		
		return "";
	}
	
	public String selectSalaryList() { //(관리자) 월급표 조회
		
		ArrayList<Salary> slist = salaryService.selectSalaryList();
		
		return "";
	}
	
	public String selectSalary() { //(임직원) 급여명세서 조회
		
		return "";
	}
}
