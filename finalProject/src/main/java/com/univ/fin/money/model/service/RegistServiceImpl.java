package com.univ.fin.money.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.dao.RegistDao;
import com.univ.fin.money.model.vo.RegistPay;

@Service
public class RegistServiceImpl implements RegistService{

	@Autowired
	RegistDao registDao;
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public ArrayList<RegistPay> selectMyRegistList(RegistPay r) {
		return registDao.selectMyRegistList(sqlSession,r);
	}

	@Override
	public RegistPay selectNewRegistInfo(ClassRating cr) {
		return registDao.selectNewRegistInfo(sqlSession,cr);
	}

	@Override
	public int updateInputPay(RegistPay r) {
		return registDao.updateInputPay(sqlSession,r);
	}

	@Override
	public ArrayList<RegistPay> searchRegistList(HashMap<String, String> map) {
		return registDao.searchRegistList(sqlSession,map);
	}
	
	@Override
	public int insertRegistPay(RegistPay r) {
		return registDao.insertRegistPay(sqlSession,r);
	}
	
	@Override
	public RegistPay selectOneRegistPay(int regNo) {
		return registDao.selectOneRegistPay(sqlSession,regNo);
	}
	
	@Override
	public int updateRegistPay(RegistPay r) {
		return registDao.updateRegistPay(sqlSession,r);
	}
	
	@Override
	public ArrayList<RegistPay> selectRegistNonPaidList() {
		return registDao.selectRegistNonPaidList(sqlSession);
	}
	
	@Override
	public ArrayList<RegistPay> selectRegistNonPaidListSearch(HashMap<String, String> map) {
		return registDao.selectRegistNonPaidListSearch(sqlSession,map);
	}
	
	@Override
	public int refundOverPaid(RegistPay r) {
		return registDao.refundOverPaid(sqlSession,r);
	}
	
	@Override
	public int activateRegistPay(Date time) {
		return registDao.activateRegistPay(sqlSession,time);
	}

	@Override
	public int deactivateRegistPay(Date date) {
		return registDao.deactivateRegistPay(sqlSession,date);
	}

	@Override
	public ArrayList<RegistPay> studentListToInsert(HashMap<String, Integer> map) {
		return registDao.studentListToInsert(sqlSession, map);
	}

	@Override
	public String selectAccountNo(String studentNo) {
		return registDao.selectAccountNo(sqlSession,studentNo);
	}

	@Override
	public int accountCheck(String regAccountNo) {
		return registDao.accountCheck(sqlSession,regAccountNo);
	}
}
