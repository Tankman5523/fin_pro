package com.univ.fin.money.model.service;

import java.util.ArrayList;

import com.univ.fin.money.model.vo.Salary;

public interface SalaryService {
	
	Salary selectMySalary(Salary sl);
	
	ArrayList<Salary> selectMySalaryList(Salary sl);
	
	int insertSalary(Salary sl);
	
	int updateSalary(Salary sl);
	
	int deleteSalary(Salary sl);
	
	ArrayList<Salary> selectAllSalaryList();
	
	
}
