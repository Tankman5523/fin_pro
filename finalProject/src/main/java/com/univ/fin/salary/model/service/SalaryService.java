package com.univ.fin.salary.model.service;

import java.util.ArrayList;

import com.univ.fin.salary.model.vo.Salary;

public interface SalaryService {
	
	int insertSalary();
	
	int updateSalary();
	
	int deleteSalary();
	
	ArrayList<Salary> selectSalaryList();
	
	Salary selectSalary();
}
