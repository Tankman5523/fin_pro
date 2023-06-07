package com.univ.fin.money.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

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
	public String insertScholarship(Scholarship sc, HttpSession session){ //장학금 수여
		
		int result = 0;
		result = scholarshipService.insertScholarship(sc);
		
		if(result>0) {//성공시
			session.setAttribute("alertMsg", "해당학생의 장학금이 성공적으로 추가되었습니다.");
		}else {
			session.setAttribute("alertMsg", "장학금 입력 오류!");
		}
		
		return "redirct:/allList.sc";
	}
	
	/*장학금 수정,삭제는 상태값이 지급 예정인 데이터에 한해서 적용가능 (STATUS IN 'W','N') */
	@GetMapping("delete.sc")
	public String deleteScholarship(Scholarship sc, HttpSession session) { //장학금 삭제
		
		int result = 0;
		result = scholarshipService.deleteScholarship(sc);
		
		if(result>0) {//성공시
			session.setAttribute("alertMsg", "장학금이 성공적으로 삭제되었습니다.");
		}else {
			session.setAttribute("alertMsg", "장학금 삭제 오류!");
		}
		
		return "redirct:/allList.sc";
	}
	
	@GetMapping("update.sc")
	public ModelAndView updateScholarForm(int schNo, ModelAndView mv) {//장학금 수정페이지
		
		Scholarship sc = scholarshipService.selectOneScholarship(schNo);
		
		mv.addObject("sc", sc).setViewName("money/scholarship/admin/admin_scholar_insertForm");
		
		return mv;
	}
	@PostMapping("update.sc")
	public String updateScholarship(Scholarship sc, HttpSession session) {//장학금 수정
		
		int result = 0;
		result = scholarshipService.updateScholarship(sc);
		if(result>0) {//성공시
			session.setAttribute("alertMsg", "장학금이 성공적으로 수정되었습니다.");
		}else {
			session.setAttribute("alertMsg", "장학금 수정 오류!");
		}
		
		return "redirct:/allList.sc";
	}
	
	@GetMapping("allList.sc")
	public ModelAndView selectScholarshipListAll(ModelAndView mv) { //필터에 해당하는 키워드로 검색결과
		
//		ArrayList<Scholarship> list = scholarshipService.selectScholarshipListAll();
		
		return mv;
	}
	
	
	
}
