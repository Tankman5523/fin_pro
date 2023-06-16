package com.univ.fin.money.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.vo.RegistPay;

@Repository
public class RegistDao {

	public ArrayList<RegistPay> selectMyRegistList(SqlSession sqlSession, RegistPay r) {
		return (ArrayList)sqlSession.selectList("moneyMapper.selectMyRegistList", r);
	}

	public RegistPay selectNewRegistInfo(SqlSession sqlSession, Student st) {
		return sqlSession.selectOne("moneyMapper.selectNewRegistInfo", st);
	}

	public int updateInputPay(SqlSession sqlSession, RegistPay r) {
		return sqlSession.update("moneyMapper.updateInputPay", r);
	}

	public ArrayList<RegistPay> searchRegistList(SqlSession sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("moneyMapper.searchRegistList", map);
	}
	
	public int insertRegistPay(SqlSession sqlSession, RegistPay r) {
		return sqlSession.insert("moneyMapper.insertRegistPay", r);
	}
	
	public RegistPay selectOneRegistPay(SqlSession sqlSession, int regNo) {
		return sqlSession.selectOne("moneyMapper.selectOneRegistPay", regNo);
	}
	
	public int updateRegistPay(SqlSession sqlSession, RegistPay r) {
		return sqlSession.update("moneyMapper.updateRegistPay",r);
	}
	
	public ArrayList<RegistPay> selectRegistNonPaidList(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("moneyMapper.selectRegistNonPaidList");
	}
	
	public ArrayList<RegistPay> selectRegistNonPaidListSearch(SqlSession sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("moneyMapper.selectRegistNonPaidListSearch", map);
	}
	
	public int refundOverPaid(SqlSession sqlSession, RegistPay r) {
		return sqlSession.update("moneyMapper.refundOverPaid", r);
	}
	
	public int activateRegistPay(SqlSession sqlSession, Date time) {
		return sqlSession.update("moneyMapper.activateRegistPay",time);
	}

	public int deactivateRegistPay(SqlSession sqlSession) {
		return sqlSession.update("moneyMapper.deactivateRegistPay");
	}

	public ArrayList<RegistPay> studentListToInsert(SqlSession sqlSession, HashMap<String, Integer> map) {
		return (ArrayList)sqlSession.selectList("moneyMapper.studentListToInsert",map);
	}

	public String selectAccountNo(SqlSession sqlSession, String studentNo) {
		return sqlSession.selectOne("moneyMapper.selectAccountNo", studentNo);
	}

	public int accountCheck(SqlSession sqlSession, String regAccountNo) {
		return sqlSession.selectOne("moneyMapper.accountCheck",regAccountNo);
	}
}
