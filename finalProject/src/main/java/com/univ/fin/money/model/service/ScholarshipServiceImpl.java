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

	@Override
	public int insertScholarship(Scholarship sc) {
		return scholarshipDao.insertScholarship(sc,sqlSession);
	}

	@Override
	public int deleteScholarship(Scholarship sc) {
		return scholarshipDao.deleteScholarship(sc,sqlSession);
	}

	@Override
	public Scholarship selectOneScholarship(int schNo) {
		return scholarshipDao.selectOneScholarship(schNo,sqlSession);
	}

	@Override
	public int updateScholarship(Scholarship sc) {
		return scholarshipDao.updateScholarship(sc,sqlSession);
	}
	
}
