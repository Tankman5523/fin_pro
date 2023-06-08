package com.univ.fin.money.controller;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.money.model.service.ScholarshipService;
import com.univ.fin.money.model.vo.Scholarship;

@Controller
public class ScholarshipController {
	
	@Autowired
	private ScholarshipService scholarshipService;
	
	
	//학생
	@GetMapping("listPage.sc")
	public String selectMyScholarshipListPage() {
		return "money/scholarship/student/student_scholar_list";
	}
	
	@ResponseBody
	@GetMapping(value = "list.sc") //ajax처리
	public String selectMyScholarshipList(Scholarship sc) { //학년도로 조회(본인)
		//sc => 유저 학번, 선택한 학년도 
		ArrayList<Scholarship> slist = scholarshipService.selectMyScholarshipList(sc);
		
		return new Gson().toJson(slist);
	}
	
	
	//관리자
	@GetMapping("insert.sc")
	public String insertScholarForm(){ //장학금 수여 페이지로
		
		return "money/scholarship/admin/admin_scholar_insertForm";
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
	public String selectScholarshipListAllPage() {//관리자-장학금리스트 페이지로
		
		return "money/scholarship/admin/admin_scholar_list";
	}
	
	@ResponseBody
	@PostMapping(value = "allList.sc",produces = "application/json; charset=UTF-8" )
	public String selectScholarshipListAll(String filter,String keyword) { //필터에 해당하는 키워드로 검색결과
		
		//필터 ,검색키워드 보내기
		HashMap<String,String> map = new HashMap<>();
		map.put("keyowrd", keyword);
		map.put("filter",filter);
		
		ArrayList<Scholarship> list = scholarshipService.selectScholarshipListAll(map);
		
		return new Gson().toJson(list);
	}
	
//	@ResponseBody
//	@RequestMapping(value = "allList.sc")
//	public ResponseEntity<ArrayList<Scholarship>> selectScholarshipListAll(String filter,String keyword) { //필터에 해당하는 키워드로 검색결과
//		
//		HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(new MediaType("application", "json", StandardCharsets.UTF_8));
//			
//		HashMap<String,String> map = new HashMap<>();
//		map.put("keyowrd", keyword);
//		map.put("filter",filter);
//		
//		ArrayList<Scholarship> list = scholarshipService.selectScholarshipListAll(map);
//		
//		return ResponseEntity.ok().headers(headers).body(list);
//	}
}
