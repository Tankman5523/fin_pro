package com.univ.fin.main.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.univ.fin.common.model.vo.CalendarVo;
import com.univ.fin.common.model.vo.PageInfo;
import com.univ.fin.main.model.vo.Notice;
import com.univ.fin.main.model.vo.NoticeAttachment;

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

	//검색 결과 수
	public int searchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> searchMap) {
		
		return sqlSession.selectOne("mainMapper.searchListCount", searchMap);
	}
	
	//공지게시판 검색
	public ArrayList<Notice> searchNotice(SqlSessionTemplate sqlSession, HashMap<String, String> searchMap, PageInfo pi) {
	
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*(pi.getBoardLimit());
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("mainMapper.searchNotice", searchMap, rowBounds);
	}

	//종합정보시스템 공지사항
	public ArrayList<Notice> infoNoticeList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("mainMapper.infoNoticeList");
	}

	//종합정보시스템 FAQ
	public ArrayList<Notice> infoFaqList(SqlSessionTemplate sqlSession) {
		 
		return (ArrayList)sqlSession.selectList("mainMapper.infoFaqList");
	}

	//학사일정 캘린더 조회
	public ArrayList<CalendarVo> selectHaksaCalendar(SqlSessionTemplate sqlSession) {
		 
		return (ArrayList)sqlSession.selectList("mainMapper.selectHaksaCalendar");
	}

	//공지사항 파일 조회
	public ArrayList<NoticeAttachment> detailNoticeFile(SqlSessionTemplate sqlSession, int noticeNo) {
		return (ArrayList)sqlSession.selectList("mainMapper.detailNoticeFile", noticeNo);
	}

	//FAQ 파일 조회
	public ArrayList<NoticeAttachment> detailFaqFile(SqlSessionTemplate sqlSession, int faqNo) {
		return (ArrayList)sqlSession.selectList("mainMapper.detailFaqFile", faqNo);
	}

	

	


	
}
