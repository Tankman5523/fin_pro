package com.univ.fin.main.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.CalendarVo;
import com.univ.fin.common.model.vo.PageInfo;
import com.univ.fin.common.template.Pagination;
import com.univ.fin.main.model.service.MainService;
import com.univ.fin.main.model.vo.Notice;
import com.univ.fin.main.model.vo.NoticeAttachment;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Controller
public class MainPageController {

	@Autowired
	private MainService mainService;
	
	//@Autowired
	//private BusTime busTime;
	
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
	
	@ResponseBody
	@PostMapping(value="haksaSchedule.mp", produces = "application/json; charset=UTF-8")
	public String selectHaksaCalendar() {
		
		ArrayList<CalendarVo> list = mainService.selectHaksaCalendar();
		System.out.println(list);
		return new Gson().toJson(list);
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

	@GetMapping("detail.mp")
	public ModelAndView boardDetailView(int noticeNo, Model mvmodel, ModelAndView mv, HttpServletRequest request) {
		
		int result = mainService.increaseCount(noticeNo);		
		
		if(result > 0) {
			Notice n = mainService.selectNotice(noticeNo);
			ArrayList<NoticeAttachment> na = mainService.detailNoticeFile(noticeNo);
			mv.addObject("n", n);
			mv.addObject("na", na);
			mv.setViewName("main/noticeDetailView");
		}else {
			mv.addObject("alertMsg", "해당 게시물을 조회할 수 없습니다.");
			mv.addObject("url", "notice.mp");
			mv.setViewName("main/alert");
		}
		
		return mv;
	}
	
	@GetMapping("faqDetail.mp")
	public ModelAndView faqDetailView(int faqNo, Model mvmodel, ModelAndView mv, HttpServletRequest request) {
		
		int result = mainService.increaseFaqCount(faqNo);
		
		if(result > 0) {
			Notice faq = mainService.selectFaq(faqNo);
			mv.addObject("f", faq);
			mv.setViewName("main/faqDetailView");
		}else {
			mv.addObject("alertMsg", "해당 게시물을 조회할 수 없습니다.");
			mv.addObject("url", "notice.mp");
			mv.setViewName("main/alert");
		}
		
		return mv;
	}
	
	
	@GetMapping("search.mp")
	public String searchBoardList(@RequestParam(value="currentPage", defaultValue="1") int currentPage
								, @RequestParam(value = "selectBox", required = false) String selectBox
								, @RequestParam(value = "keyword", required = false) String keyword
								, Model model) {
		
		HashMap<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("selectBox", selectBox);
		searchMap.put("keyword", keyword);
		
		//게시글 목록 조회
		int listCount = mainService.searchListCount(searchMap);
		int pageLimit = 10;
		int boardLimit = 15;

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Notice> list = mainService.searchNotice(searchMap, pi);
		
		model.addAttribute("slist", list);
		model.addAttribute("searchPi", pi);
		model.addAttribute("selectBox", selectBox);
		model.addAttribute("keyword", keyword);
		
		return "main/searchNoticeList";
	}
	
	@GetMapping("infoSystem.mp")
	public String infoSystemMain(Model model, HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) { //세션값 판별
		
			ArrayList<Notice> list = mainService.infoNoticeList();
			ArrayList<Notice> faq = mainService.infoFaqList();
			
			model.addAttribute("infoList", list);
			model.addAttribute("infoFaq", faq);
			
			return "main/infoSystemMain";
		}else {
			
			String chk = session.getAttribute("loginUser").toString();
			
			if(chk.charAt(0) == 'S') { //학생일 경우
				return "redirect:main.st";
			}else { //임직원일 경우
				Professor loginUser2 = (Professor)session.getAttribute("loginUser");
				if(loginUser2.getAdmin() == 1) {
					return "redirect:main.pr";
				}else {
					return "redirect:main.ad";
				}
			}
		}
	}
}

