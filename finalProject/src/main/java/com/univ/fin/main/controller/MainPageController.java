package com.univ.fin.main.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.PageInfo;
import com.univ.fin.common.template.Pagination;
import com.univ.fin.main.model.service.MainService;
import com.univ.fin.main.model.vo.Notice;

@Controller
public class MainPageController {

	@Autowired
	private MainService mainService;
	
	@GetMapping("mainPage.mp")
	public String mainPage() {
		return "main/mainPage";
	}
	
	@GetMapping("universityIntro.mp")
	public String universityIntro() {
		return "main/universityIntoroduction";
	}
	
	@GetMapping("haksaInfo.mp")
	public String haksaInfo() {
		return "main/haksaInfo";
	}
	
	@GetMapping("haksaSchedule.mp")
	public String haksaSchedule() {
		return "main/haksaSchedule";
	}
	
	@GetMapping("notice.mp")
	public String noticeBoard(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
							   Model model) {
		
		//게시글 목록 조회
		int listCount = mainService.selectListCount();
		int pageLimit = 10;
		int boardLimit = 15;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		//공지사항 조회
		ArrayList<Notice> list = mainService.selectNoticeList(pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "main/notice";
	}
	
	@ResponseBody
	@RequestMapping(value="loadFaq.mp",produces = "application/json; charset=UTF-8")
	public String selectHaksaList(String active) {
		
		ArrayList<Notice> haksa = new ArrayList<>();
		
		if(active.equals("학사")) {
			 haksa = mainService.selectHaksaList();
		}
		
		return new Gson().toJson(haksa);
	}
	
	@ResponseBody
	@RequestMapping(value="clickFaq.mp",produces = "application/json; charset=UTF-8")
	public String selectFaqList(String active) {
		
		ArrayList<Notice> faq = new ArrayList<>();
		
		switch (active) {
		case "학사":
			faq = mainService.selectHaksaList();
			break;
		case "장학":
			faq = mainService.selectJangHakList();
			break;
		case "입학":
			faq = mainService.selectIpHakList();
			break;
		case "채용":
			faq = mainService.selectChaeYongList();
			break;
		case "기타":
			faq = mainService.selectGitaList();
			break;
		}
		
		return new Gson().toJson(faq);
	}
	
	@GetMapping("search.mp")
	public String searchBoardList(String keyword) {
		
		System.out.println(keyword);
		
		return null;
	}
	
	@GetMapping("infoSystem.mp")
	public String infoSystemMain() {
		return "main/infoSystemMain";
	}
}

