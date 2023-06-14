package com.univ.fin.money.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.univ.fin.member.model.vo.Professor;
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
		return sqlSession.insert("moneyMapper.insertSalary", sl);
	}

	public int updateSalary(SqlSession sqlSession, Salary sl) {
		return sqlSession.update("moneyMapper.updateSalary", sl);
	}

	public int deleteSalary(SqlSession sqlSession, int payNo) {
		return sqlSession.delete("moneyMapper.deleteSalary", payNo);
	}

	public ArrayList<Salary> selectAllSalaryList(SqlSession sqlSession, Salary sl) {
		return (ArrayList)sqlSession.selectList("moneyMapper.selectAllSalaryList", sl);
	}

	public Salary selectOneSalary(SqlSession sqlSession, int payNo) {
		return sqlSession.selectOne("moneyMapper.selectOneSalary", payNo);
	}

	public ArrayList<Salary> professorListToSalary(SqlSession sqlSession, Professor p) {
		return (ArrayList)sqlSession.selectList("moneyMapper.professorListToSalary", p);
	}

	public int sendSalary(SqlSession sqlSession, int payNo) {
		return sqlSession.update("moneyMapper.sendSalary", payNo);
	}
	
}
