package com.univ.fin.money.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.money.model.dao.ScholarshipDao;
import com.univ.fin.money.model.vo.Scholarship;

@Service
public class ScholarshipServiceImpl implements ScholarshipService{
	
	@Autowired
	private ScholarshipDao scholarshipDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Scholarship> selectMyScholarshipList(Scholarship sc) {
		return scholarshipDao.selectMyScholarshipList(sc,sqlSession);
	}
	
}
