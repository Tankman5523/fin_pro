package com.univ.fin.money.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public RegistPay selectNewRegistInfo(Student st) {
		return registDao.selectNewRegistInfo(sqlSession,st);
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
	public int deactivateRegistPay() {
		return registDao.deactivateRegistPay(sqlSession);
	}
}
