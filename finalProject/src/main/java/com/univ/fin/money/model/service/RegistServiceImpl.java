package com.univ.fin.money.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	public int insertRegistPay(RegistPay r) {
		int result1 = registDao.insertRegistPay(sqlSession,r);
		int result2 = 0;
		if(result1>0) {//등록금 입력 성공하면 해당학기 장학금 처리완료로 변경
			result2=registDao.finishScholarShip(sqlSession,r);
		}
		return result1*result2;
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

	@Override
	@Transactional
	public int deleteRegistPay(RegistPay r) {
		int result1 = registDao.deleteRegistPay(sqlSession,r);
		int result2 = 0;
		if(result1>0) {
			result2 = registDao.returnScholarShip(sqlSession,r);
		}
		
		return result1*result2;
	}
}
