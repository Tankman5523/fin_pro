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
	private SalaryDao salarydao;

	@Override
	public Salary selectMySalary() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Salary> selectMySalaryList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertSalary() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateSalary() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteSalary() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Salary> selectAllSalaryList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	

}
