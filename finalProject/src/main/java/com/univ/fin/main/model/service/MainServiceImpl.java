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
	
	//총 FAQ 수 조회
	@Override
	public int selectFaqCount() {
		int faqCount = mainDao.selectFaqCount(sqlSession);
		
		return faqCount;
	}
	
	//FAQ 조회
	@Override
	public ArrayList<Notice> selectFaqList() {
		
		ArrayList<Notice> faq = mainDao.selectFaqList(sqlSession);
		
		return faq;
	}

	
	
	
}
