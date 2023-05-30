package com.univ.fin.salary.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.salary.model.dao.SalaryDao;
import com.univ.fin.salary.model.vo.Salary;

@Service
public class SalaryServiceImpl implements SalaryService{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private SalaryDao salarydao;
	
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
	public ArrayList<Salary> selectSalaryList() {
		
		ArrayList<Salary> slist = null;
		
		return slist;
	}

	@Override
	public Salary selectSalary() {
		// TODO Auto-generated method stub
		return null;
	}

}
