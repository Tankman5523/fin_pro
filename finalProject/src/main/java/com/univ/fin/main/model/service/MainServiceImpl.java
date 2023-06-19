package com.univ.fin.main.model.service;

import java.util.ArrayList;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.common.model.vo.PageInfo;
import com.univ.fin.main.model.dao.MainDao;
import com.univ.fin.main.model.vo.Notice;

@Service
public class MainServiceImpl implements MainService{

	@Autowired
	private MainDao mainDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//총 게시글 수 조회
	@Override
	public int selectListCount() {
		int listCount = mainDao.selectListCount(sqlSession);
		
		return listCount;
	}

	//게시글 목록 조회
	@Override
	public ArrayList<Notice> selectNoticeList(PageInfo pi) {
		
		ArrayList<Notice> list = mainDao.selectNoticeList(sqlSession, pi);
		
		return list; 
	}
	
	//학사 FAQ 조회
	@Override
	public ArrayList<Notice> selectHaksaList() {
		
		ArrayList<Notice> haksa = mainDao.selectHaksaList(sqlSession);
		
		return haksa;
	}

	//장학 FAQ 조회
	@Override
	public ArrayList<Notice> selectJangHakList() {

		ArrayList<Notice> jangHak = mainDao.selectJangHakList(sqlSession);
		
		return jangHak;
	}

	//입학 FAQ 조회
	@Override
	public ArrayList<Notice> selectIpHakList() {

		ArrayList<Notice> ipHak = mainDao.selectIpHakList(sqlSession);
		
		return ipHak;
	}

	//채용 FAQ 조회
	@Override
	public ArrayList<Notice> selectChaeYongList() {

		ArrayList<Notice> chaeYong = mainDao.selectChaeYongList(sqlSession);
		
		return chaeYong;
	}

	//기타 FAQ 조회
	@Override
	public ArrayList<Notice> selectGitaList() {

		ArrayList<Notice> gita = mainDao.selectGitaList(sqlSession);
		
		return gita;
	}

	//조회수 증가
	@Override
	public int increaseCount(int noticeNo) {

		int result = mainDao.increaseCount(sqlSession, noticeNo);
		
		return result;
	}

	//게시글 상세 조회
	@Override
	public Notice selectNotice(int noticeNo) {
		
		Notice n = mainDao.selectNotice(sqlSession, noticeNo);
		
		return n;
	}

	//첨부파일 조회
	@Override
	public ArrayList<Notice> selectFiles(int noticeNo) {
		 
		ArrayList<Notice> files = mainDao.selectFiles(sqlSession, noticeNo);
		
		return files;
	}
	
	

	


	
	
	
}
