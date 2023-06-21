package com.univ.fin.member.controller;

import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.member.model.service.MemberService;
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
		
		ArrayList<Attachment> alist = memberService.selectClassAttachment();
		
		model.addAttribute("list",list);
		model.addAttribute("alist",alist);
		
		return "member/admin/ad_class_list";
	}
	
	//강의 개설 일괄 승인
	@RequestMapping("permitAllClassCreate.ad")
	public String updateClassPermitAll(int cArr[]) {
			
			
		String cnoArr = Arrays.toString(cArr);//강의 번호 배열 스트링으로 바꿈
			
		String cno = cnoArr.replaceAll("\\[", "").replaceAll("\\]", "");// 중괄호 뺌
			
		int result = memberService.updateClassPermitAll(cno);
			
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
}

