package com.univ.fin.money.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.univ.fin.money.model.vo.Salary;

@Repository
public class SalaryDao {

	public Salary selectMySalary(SqlSession sqlSession, Salary sl) {
		return sqlSession.selectOne("moneyMapper.selectMySalary", sl);
	}

	public ArrayList<Salary> selectMySalaryList(SqlSession sqlSession, Salary sl) {
		return (ArrayList)sqlSession.selectList("moneyMapper.selectMySalaryList", sl);
	}

	public int insertSalary(SqlSession sqlSession, Salary sl) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
