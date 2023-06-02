package com.univ.fin.money.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.univ.fin.money.model.vo.Scholarship;

@Repository
public class ScholarshipDao {

	public ArrayList<Scholarship> selectMyScholarshipList(Scholarship sc, SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("moneyMapper.selectMyScholarshipList", sc);
	}
	
}
