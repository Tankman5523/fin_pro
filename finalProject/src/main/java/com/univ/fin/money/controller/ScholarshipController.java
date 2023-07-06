package com.univ.fin.money.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.service.RegistService;
import com.univ.fin.money.model.service.ScholarshipService;
import com.univ.fin.money.model.vo.RegistPay;
import com.univ.fin.money.model.vo.Scholarship;

@Controller
public class ScholarshipController {
	
	@Autowired
	private ScholarshipService scholarshipService;
	
	@Autowired
	private RegistService registService;
	
	//학생
	@GetMapping("listPage.sc")
	public ModelAndView selectMyScholarshipListPage(ModelAndView mv,HttpSession session) {
		
		//세션에 있는 로그인 유저 가져와서 판별
		Student st = (Student)session.getAttribute("loginUser");
		Scholarship sc = Scholarship.builder().studentNo(st.getStudentNo()).classYear("0").build();
		ArrayList<Scholarship> list = scholarshipService.selectMyScholarshipList(sc);
		
		mv.addObject("list", list).setViewName("money/scholarship/student/student_scholar_list");
		
		return mv;
	}
	
	@ResponseBody
	@GetMapping(value = "list.sc",produces = "application/json; charset=UTF-8" ) //ajax처리
	public String selectMyScholarshipList(Scholarship sc) { //학년도로 조회(본인)
		//sc => 유저 학번, 선택한 학년도 
		ArrayList<Scholarship> list = scholarshipService.selectMyScholarshipList(sc);
		return new Gson().toJson(list);
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
		
		return "redirect:allList.sc";
	}
	
	/*장학금 수정,삭제는 상태값이 지급 예정인 데이터에 한해서 적용가능 (STATUS IN 'W','N') */
	@ResponseBody
	@GetMapping(value = "delete.sc")
	public String deleteScholarship(Scholarship sc, HttpSession session) { //장학금 삭제
		System.out.println("sc : "+ sc);
		int result = 0;
		result = scholarshipService.deleteScholarship(sc);
		
		if(result>0) {//성공시
			return "Y";
		}else {
			return "N";
		}
		
	}
	
	@GetMapping("update.sc")
	public ModelAndView updateScholarForm(int schNo, ModelAndView mv) {//장학금 수정페이지
		Scholarship sc = scholarshipService.selectOneScholarship(schNo);
		mv.addObject("sc", sc).setViewName("money/scholarship/admin/admin_scholar_updateForm");
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
		return "redirect:allList.sc";
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
		map.put("keyword", keyword);
		map.put("filter",filter);
		
		ArrayList<Scholarship> list = scholarshipService.selectScholarshipListAll(map);
		
		return new Gson().toJson(list);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "selectForSc.st",produces="text/html;charset=UTF-8") //"text/html;charset=UTF-8";
	public String selectStudentForSc(String studentNo,String classYear,String classTerm) {//학생1명 정보 ajax로 출력
		ClassRating rp = ClassRating .builder()
									 .studentNo(studentNo)
									 .classYear(classYear)
									 .classTerm(classTerm)
									 .build();
		RegistPay r = registService.selectNewRegistInfo(rp); 
		if(r==null) {//해당학기 등록금이 이미 입력되어있지 않을 때.
			String studentName = scholarshipService.selectStudentForSc(studentNo); //
			return studentName; //
		}else {//이미 해당학기 등록금이 있을때
			return "N";
		}
	}
}
