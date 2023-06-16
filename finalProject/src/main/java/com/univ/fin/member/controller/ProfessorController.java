package com.univ.fin.member.controller;



import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Grade;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;

@Controller
public class ProfessorController {
	
	
	@Autowired
	private MemberService memberService;
	
	//교수 학적정보 조회
	@RequestMapping("infoProfessor.pr")
	public String infoProfessor() {
		
		return "member/professor/infoProfessor";
	}

	//학적 정보수정 - 교수
	@RequestMapping(value="updateProfessor.pr", method = RequestMethod.POST)
	public String updateProfessor(Professor pr,
									Model model,
									HttpSession session) {
		int result = memberService.updateProfessor(pr);
		
		
		if(result>0) {
			//유저 정보갱신
			Professor updateProfessor = memberService.loginProfessor(pr);
			session.setAttribute("loginUser", updateProfessor);
			model.addAttribute("msg", "수정 완료");
		}else { //정보변경실패
			model.addAttribute("msg","수정 실패");
		}
		
	return "member/professor/infoProfessor";
		
	}
	
	// 학사관리 - 개인시간표
	@RequestMapping("personalTimetable.pr")
	public ModelAndView personalTimetable(ModelAndView mv, HttpSession session) {
		Professor st = (Professor)session.getAttribute("loginUser");
		String professorNo = st.getProfessorNo();
		ArrayList<String> classTerm = memberService.selectProfessorClassTerm(professorNo); // 강의한 학년도, 학기
		
		mv.addObject("classTerm", classTerm).setViewName("member/professor/personalTimetableView");
		return mv;
	}
	
	// 개인시간표 -> 학기 선택 후 시간표 조회
	@ResponseBody
	@RequestMapping(value = "selectProfessorTimetable.pr", produces = "application/json; charset=UTF-8;")
	public String selectStudentTimetable(@RequestParam HashMap<String,String> map, HttpSession session) {
		Professor st = (Professor)session.getAttribute("loginUser");
		String professorNo = st.getProfessorNo();
		map.put("professorNo", professorNo);
		
		ArrayList<Classes> cList = memberService.selectProfessorTimetable(map);
		return new Gson().toJson(cList);
	}
	
	// 수업관리 - 성적관리
	@GetMapping("gradeInsert.pr")
	public ModelAndView gradeInsertView(ModelAndView mv, HttpSession session) {
		Professor st = (Professor)session.getAttribute("loginUser");
		String professorNo = st.getProfessorNo();
		ArrayList<String> classTerm = memberService.selectProfessorClassTerm(professorNo); // 강의한 학년도, 학기
		
		mv.addObject("classTerm", classTerm).setViewName("member/professor/gradeInsertView");
		return mv;
	}
	
	// 성적관리 -> 수강중인 학생 조회
	@ResponseBody
	@RequestMapping(value = "selectStudentGradeList.pr", produces = "application/json; charset=UTF-8;")
	public String selectStudentGradeList(String cn) {
		int classNo = Integer.parseInt(cn);
		ArrayList<HashMap<String, String>> sList = memberService.selectStudentGradeList(classNo);
		return new Gson().toJson(sList);
	}
	
	// 성적관리 -> 성적 입력
	@ResponseBody
	@PostMapping("gradeInsert.pr")
	public String gradeInsert(Grade g) {
		int result = memberService.gradeInsert(g);
		return (result>0)? "Y": "N";
	}
	
	// 성적관리 -> 성적 수정
	@ResponseBody
	@PostMapping("gradeUpdate.pr")
	public String gradeUpdate(Grade g) {
		int result = memberService.gradeUpdate(g);
		return (result>0)? "Y": "N";
	}

}
