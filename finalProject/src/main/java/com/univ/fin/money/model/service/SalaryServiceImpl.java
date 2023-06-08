package com.univ.fin.money.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteSalary(Salary sl) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Salary> selectAllSalaryList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	

}
