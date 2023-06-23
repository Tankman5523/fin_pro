package com.univ.fin.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.Calendar;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;


@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//학생등록 페이지
	@RequestMapping("enrollStudent.ad")
	public String enrollStudent() {		
		
		return "member/admin/enrollStudent";
	}
	
	//학생등록 페이지 등록
	@RequestMapping(value="insertStudent.ad" ,method=RequestMethod.POST)
	public String insertStudent(Student st,
								Model model,
								HttpSession session) {
	System.out.println(st.toString());
		
	int result = memberService.insertStudent(st);
	
	if(result>0) {
		model.addAttribute("msg", "회원 생성 완료");
	}else {
		model.addAttribute("msg","회원 생성 실패");
	}
	return "member/admin/enrollStudent";
		
	}
		
	//강의개설 승인 페이지 이동
	@RequestMapping("classManagePage.ad")
	public String classManageSelect(Model model) {
		
		ArrayList<Classes> list = memberService.selectClassList();
		
		//ArrayList<Attachment> alist = memberService.selectClassAttachment();
		
		model.addAttribute("list",list);
		//model.addAttribute("alist",alist);
		
		return "member/admin/ad_class_list";
	}
	
	//교수 관리자 등록 페이지 이동
	@RequestMapping("enrollProfessor.ad")
	public String enrollProfessor() {
		
		return "member/admin/enrollProfessor";
	}
	
	@RequestMapping(value="insertProfessor.ad", method=RequestMethod.POST)
	public String insertProfessor(Professor pr,
	                              Model model,
	                              HttpSession session) {
		
	    if (pr.getDepartmentNo().equals("-선택-")) {
	        if (pr.getPosition().equals("관리자")) {
	            pr.setDepartmentNo("");
	            pr.setCollegeNo("");
	        } else {
	            if (pr.getCollegeNo().equals("-선택-") || pr.getCollegeNo() == null) {
	                // 관리자가 아니면서 부서 선택을 하지 않은 경우
	            	model.addAttribute("msg","빈 입력란이 있습니다.");
	            }
	        }
	    }	        

	    int result = memberService.insertProfessor(pr);

	    if (result > 0) {
	        model.addAttribute("msg", "직원 생성 완료");
	    } else {
	        model.addAttribute("msg", "직원 생성 실패");
	    }
	    return "member/admin/enrollProfessor";
	}
	
	//강의 개설 일괄 승인
	@RequestMapping("permitAllClassCreate.ad")
	public String updateClassPermitAll(int cArr[]) {
			
		int result = memberService.updateClassPermitAll(cArr);
			
		if(result>0) {//업데이트(개설승인) 성공
				
		}else {//업데이트(개설승인) 실패
				
		}
			
		return "redirect:classManagePage.ad";
	}
		
	//강의 개설 개별 승인
	@ResponseBody
	@RequestMapping(value="permitClassCreate.ad")
	public int updateClassPermit(int cno) {
		
		int result = memberService.updateClassPermit(cno);
		
		return result;
	}
		
	//강의 개설 반려
	@RequestMapping("rejectClassCreate.ad")
	public String updateClassReject(Classes c) {
			
		int result = memberService.updateClassReject(c);
			
		return "redirect:classManagePage.ad";
	}
	
	//강의 관리 검색
	@ResponseBody
	@RequestMapping(value="classSearchList.ad",produces="application/json; charset = UTF-8")
	public String selectSearchClassList(Classes c,String category,String keyword) {
		
		
		if(!keyword.equals("")) {
			switch(category) {//검색 카테고리에 따라 키워드 담기
			case "professor": c.setProfessorNo(keyword);
			break;
			case "class": c.setClassName(keyword);
			break;
			case "department": c.setDepartmentNo(keyword);
			break;
			}
		}
		
		ArrayList<Classes> list = memberService.selectClassListSearch(c);
		
		
		return new Gson().toJson(list);
	}

	// 강의관리 - 강의시간표
	@RequestMapping("classListView.ad")
	public ModelAndView classListView(ModelAndView mv) {
		ArrayList<String> classTerm = memberService.selectClassTerm();
		
		mv.addObject("classTerm", classTerm).setViewName("member/admin/classListView");
		return mv;
	}
	
	//강의평가조회 페이지
	@RequestMapping("classRatingPage.ad")
	public String classRatingPage() {
		return "member/admin/ad_classRating_list";
	}
	
	//강의평가 조회(검색)
	@ResponseBody
	@GetMapping(value="classRatingList.ad",produces = "application/json;charset=utf-8")
	public String classRatingList(ClassRating cr) {
		ArrayList<ClassRating> list = memberService.classRatingList(cr);
		return new Gson().toJson(list);
	}
	
	//강의평가 기타건의사항 조회
	@ResponseBody
	@GetMapping(value="classRatingEtc.ad",produces = "application/json;charset=utf-8")
	public String classRatingEtcList(ClassRating cr) {
		ArrayList<ClassRating> list = memberService.classRatingEtcList(cr);
		return new Gson().toJson(list);
	}
	
	//강의평가 문항별 평균 점수
	@ResponseBody
	@GetMapping(value="classRatingAverage.ad",produces = "application/json;charset=utf-8")
	public String classRatingAverage(ClassRating cr) {
		ClassRating result = memberService.classRatingAverage(cr);
		System.out.println(result);
		return new Gson().toJson(result);
	}
	
	// 학사관리 - 학사일정 관리
	@GetMapping("calendarView.ad")
	public String calendarView() {
		return "member/admin/calendarView";
	}
	
	// 학사일정 관리 -> 학사일정 조회
	@ResponseBody
	@PostMapping(value="calendarView.ad",produces = "application/json;charset=utf-8")
	public String calendarList() {
		ArrayList<HashMap<String, String>> calList = memberService.calendarList();
		return new Gson().toJson(calList);
	}
	
	// 학사일정 관리 -> 학사일정 추가/수정/삭
	@PostMapping("manageCalendar.ad")
	public String manageCalendar(Calendar c, String check, HttpSession session) {
		System.out.println("*****************" + c);
		System.out.println("*****************" + check);
		
		int result = 0;
		
		if(check.equals("insert")) { // 추가
			result = memberService.insertCalendar(c);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "학사일정이 추가되었습니다.");
			}
			else {
				session.setAttribute("alertMsg", "학사일정 추가에 실패하셨습니다.");
			}
		}
		else if(check.equals("update")) { // 수정
			result = memberService.updateCalendar(c);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "학사일정이 수정되었습니다.");
			}
			else {
				session.setAttribute("alertMsg", "학사일정 수정에 실패하셨습니다.");
			}
		}
		else { // 삭제
			result = memberService.deleteCalendar(c);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "학사일정이 삭제되었습니다.");
			}
			else {
				session.setAttribute("alertMsg", "학사일정 삭제에 실패하셨습니다.");
			}
		}
		
		return "redirect:calendarView.ad";
	}
}

