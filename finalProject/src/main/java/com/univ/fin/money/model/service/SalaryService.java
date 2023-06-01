package com.univ.fin.money.model.service;

import java.util.ArrayList;

import com.univ.fin.money.model.vo.Salary;

public interface SalaryService {
	
	int insertSalary();
	
	int updateSalary();
	
	int deleteSalary();
	
	ArrayList<Salary> selectSalaryList();
	
	Salary selectSalary();
}
