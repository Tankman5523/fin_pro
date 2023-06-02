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

	public int insertScholarship(Scholarship sc, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("moneyMapper.insertScholarship", sc);
	}

	public int deleteScholarship(Scholarship sc, SqlSessionTemplate sqlSession) {
		return sqlSession.delete("moneyMapper.deleteScholarship", sc);
	}

	public Scholarship selectOneScholarship(int schNo, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("moneyMapper.selectOneScholarship", schNo);
	}

	public int updateScholarship(Scholarship sc, SqlSessionTemplate sqlSession) {
		return sqlSession.update("moneyMapper.updateScholarship", sc);
	}
	
}
