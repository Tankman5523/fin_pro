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
	public int insertSalary() {
		
		int result=0;
		
		return result;
	}

	@Override
	public int updateSalary() {
		int result=0;
		
		return result;
	}

	@Override
	public int deleteSalary() {
		int result=0;
		
		return result;
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
