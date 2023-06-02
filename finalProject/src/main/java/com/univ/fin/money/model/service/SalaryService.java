package com.univ.fin.money.model.service;

import java.util.ArrayList;

import com.univ.fin.money.model.vo.Salary;

public interface SalaryService {
	
	Salary selectMySalary();
	
	ArrayList<Salary> selectMySalaryList();
	
	int insertSalary();
	
	int updateSalary();
	
	int deleteSalary();
	
	ArrayList<Salary> selectAllSalaryList();
	
	
}
