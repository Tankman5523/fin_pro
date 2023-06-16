package com.univ.fin.money.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.vo.RegistPay;

public interface RegistService {

	ArrayList<RegistPay> selectMyRegistList(RegistPay r);

	RegistPay selectNewRegistInfo(Student st);

	int updateInputPay(RegistPay r);

	ArrayList<RegistPay> searchRegistList(HashMap<String, String> map);
	
	int insertRegistPay(RegistPay r);
	
	RegistPay selectOneRegistPay(int regNo);
	
	int updateRegistPay(RegistPay r);
	
	ArrayList<RegistPay> selectRegistNonPaidList();
	
	ArrayList<RegistPay> selectRegistNonPaidListSearch(HashMap<String, String> map);
	
	int refundOverPaid(RegistPay r);
	
	int activateRegistPay(Date time);

	int deactivateRegistPay(Date date);

	ArrayList<RegistPay> studentListToInsert(HashMap<String, Integer> map);

	String selectAccountNo(String studentNo);

	int accountCheck(String regAccountNo);
	
}
