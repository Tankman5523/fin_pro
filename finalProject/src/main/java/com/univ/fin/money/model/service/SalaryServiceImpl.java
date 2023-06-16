package com.univ.fin.money.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.money.model.dao.SalaryDao;
import com.univ.fin.money.model.vo.Salary;

@Service
public class SalaryServiceImpl implements SalaryService{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private SalaryDao salaryDao;

	@Override
	public Salary selectMySalary(Salary sl) {
		return salaryDao.selectMySalary(sqlSession,sl);
	}

	@Override
	public ArrayList<Salary> selectMySalaryList(Salary sl) {
		
		return salaryDao.selectMySalaryList(sqlSession,sl);
	}

	@Override
	public int insertSalary(Salary sl) {
		return salaryDao.insertSalary(sqlSession,sl);
	}

	@Override
	public int updateSalary(Salary sl) {
		return salaryDao.updateSalary(sqlSession,sl);
	}

	@Override
	public int deleteSalary(int payNo) {
		return salaryDao.deleteSalary(sqlSession,payNo);
	}

	@Override
	public ArrayList<Salary> selectAllSalaryList(Salary sl) {
		return salaryDao.selectAllSalaryList(sqlSession,sl);
	}

	@Override
	public Salary selectOneSalary(int payNo) {
		return salaryDao.selectOneSalary(sqlSession,payNo);
	}

	@Override
	public ArrayList<Salary> professorListToSalary(Professor p) {
		return salaryDao.professorListToSalary(sqlSession,p);
	}

	@Override
	public int sendSalary(int payNo) {
		return salaryDao.sendSalary(sqlSession,payNo);
	}
	
	
	
	

}
