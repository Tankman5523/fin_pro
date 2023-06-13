package com.univ.fin.main.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		//총 FAQ 수 조회
		int faqCount = mainService.selectFaqCount();
		
		//FAQ 조회
		ArrayList<Notice> faq = mainService.selectFaqList();
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("faq", faq);
		model.addAttribute("fc", faqCount);
		
		return "main/notice";
	}
	
	@GetMapping("infoSystem.mp")
	public String infoSystemMain() {
		return "main/infoSystemMain";
	}
}

