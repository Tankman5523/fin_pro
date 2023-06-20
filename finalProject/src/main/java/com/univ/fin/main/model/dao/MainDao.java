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

	//학사 FAQ 조회
	public ArrayList<Notice> selectHaksaList(SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("mainMapper.selectHaksaList");
	}

	//장학 FAQ 조회
	public ArrayList<Notice> selectJangHakList(SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("mainMapper.selectJangHakList");
	}

	//입학 FAQ 조회
	public ArrayList<Notice> selectIpHakList(SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("mainMapper.selectIpHakList");
	}

	//채용 FAQ 조회
	public ArrayList<Notice> selectChaeYongList(SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("mainMapper.selectChaeYongList");
	}

	//기타 FAQ 조회
	public ArrayList<Notice> selectGitaList(SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("mainMapper.selectGitaList");
	}

	//조회수 증가
	public int increaseCount(SqlSessionTemplate sqlSession, int noticeNo) {

		return sqlSession.update("mainMapper.increaseCount", noticeNo);
	}

	//게시글 상세 조회
	public Notice selectNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		
		return sqlSession.selectOne("mainMapper.selectNotice", noticeNo);
	}

	//공지사항 상세 조회 첨부파일
	public ArrayList<Notice> selectFiles(SqlSessionTemplate sqlSession, int noticeNo) {
		
		return (ArrayList)sqlSession.selectList("mainMapper.selectFiles", noticeNo);
	}

	//FAQ 조회수 증가
	public int increaseFaqCount(SqlSessionTemplate sqlSession, int faqNo) {
		
		return sqlSession.update("mainMapper.increaseFaqCount", faqNo);
	}

	//FAQ 상세 조회
	public Notice selectFaq(SqlSessionTemplate sqlSession, int faqNo) {
		
		return sqlSession.selectOne("mainMapper.selectFaq", faqNo);
	}

	


	
}
