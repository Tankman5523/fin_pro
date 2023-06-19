package com.univ.fin.main.model.service;

import java.util.ArrayList;

import com.univ.fin.common.model.vo.PageInfo;
import com.univ.fin.main.model.vo.Notice;

public interface MainService {

	//총 게시글 수 조회
	int selectListCount();
	
	//게시글 목록 조회
	ArrayList<Notice> selectNoticeList(PageInfo pi);

	//학사 FAQ 조회
	ArrayList<Notice> selectHaksaList();
	
	//장학 FAQ 조회
	ArrayList<Notice> selectJangHakList();

	//입학 FAQ 조회
	ArrayList<Notice> selectIpHakList();

	//채용 FAQ 조회
	ArrayList<Notice> selectChaeYongList();

	//기타 FAQ 조회
	ArrayList<Notice> selectGitaList();

	//조회수 증가
	int increaseCount(int noticeNo);

	//게시글 목록 조회
	Notice selectNotice(int noticeNo);

	//첨부파일 조회
	ArrayList<Notice> selectFiles(int noticeNo);
	

}
