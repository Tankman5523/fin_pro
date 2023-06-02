package com.univ.fin.money.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.univ.fin.money.model.service.ScholarshipService;
import com.univ.fin.money.model.vo.Scholarship;

@Controller
public class ScholarshipController {
	
	@Autowired
	private ScholarshipService scholarshipService;
	
	//학생
	@GetMapping("list.sc")
	public ModelAndView selectMyScholarshipList(Scholarship sc,ModelAndView mv) { //학년도로 조회(본인)
		//sc => 유저 학번, 선택한 학년도 
		ArrayList<Scholarship> slist = scholarshipService.selectMyScholarshipList(sc);
		
		
		mv.addObject("list", slist);
		mv.setViewName("money/scholarship/student_scholar_list");
		return mv;
	}
	
	
	//관리자
	@GetMapping("insert.sc")
	public String insertScholarForm(){ //장학금 수여 페이지로
		
		return "money/scholarship/manager_scholar_insertForm";
	}
	@PostMapping("insert.sc")
	public String insertScholar(){ //장학금 수여
		
		return "redirct:/allList.sc";
	}
	
	/*장학금 수정,삭제는 상태값이 지급 예정인 데이터에 한해서 적용가능 */
	@GetMapping("delete.sc")
	public String deleteScholar() { //장학금 삭제
		
		return "redirct:/allList.sc";
	}
	
	@GetMapping("update.sc")
	public String updateScholarForm() {//장학금 수정페이지
		
		return "";
	}
	@PostMapping("update.sc")
	public String updateScholar() {//장학금 수정
		
		return "";
	}
	
	@GetMapping("allList.sc")
	public ModelAndView selectScholarListAll(ModelAndView mv) { //필터에 해당하는 키워드로 검색결과
		
		return mv;
	}
	
	
}
