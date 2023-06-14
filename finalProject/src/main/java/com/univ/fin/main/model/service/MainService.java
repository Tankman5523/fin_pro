package com.univ.fin.main.model.service;

import java.util.ArrayList;

import com.univ.fin.common.model.vo.PageInfo;
import com.univ.fin.main.model.vo.Notice;

public interface MainService {

	//총 게시글 수 조회
	int selectListCount();
	
	//게시글 목록 조회
	ArrayList<Notice> selectNoticeList(PageInfo pi);

	//FAQ 조회
	ArrayList<Notice> selectFaqList();

	int selectFaqCount();
}
