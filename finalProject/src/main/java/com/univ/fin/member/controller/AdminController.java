	package com.univ.fin.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
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
		
		//ArrayList<Attachment> alist = memberService.selectClassAttachment();
		
		model.addAttribute("list",list);
		//model.addAttribute("alist",alist);
		
		return "member/admin/ad_class_list";
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
		
		System.out.println("검색정보"+c);
		System.out.println("카테고리"+category);
		System.out.println("검색키워드"+keyword);
		
		if(!keyword.equals("")) {
			System.out.println("들어옴");
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

}

