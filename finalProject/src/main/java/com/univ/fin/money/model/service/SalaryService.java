package com.univ.fin.money.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.money.model.vo.Salary;

public interface SalaryService {
	
	Salary selectMySalary(Salary sl);
	
	ArrayList<Salary> selectMySalaryList(Salary sl);
	
	int insertSalary(Salary sl);
	
	int updateSalary(Salary sl);
	
	int deleteSalary(int payNo);
	
	ArrayList<Salary> selectAllSalaryList(Salary sl);

	Salary selectOneSalary(int payNo);

	ArrayList<Salary> professorListToSalary(Professor p);

	int sendSalary(int payNo);
	
	
}
