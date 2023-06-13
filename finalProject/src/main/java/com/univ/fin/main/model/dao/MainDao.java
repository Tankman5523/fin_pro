package com.univ.fin.main.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.univ.fin.common.model.vo.PageInfo;
import com.univ.fin.main.model.vo.Notice;

@Repository
public class MainDao {

	//총 게시글 수 조회
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("mainMapper.selectListCount");
	}

	//게시글 목록 조회
	public ArrayList<Notice> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*(pi.getBoardLimit());
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("mainMapper.selectNoticeList", null, rowBounds);
	}

	//총 FAQ 수 조회
	public int selectFaqCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("mainMapper.selectFaqCount");
	}
	
	//FAQ 조회
	public ArrayList<Notice> selectFaqList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectFaqList");
	}


	
}
