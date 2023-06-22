package com.univ.fin.member.controller;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.univ.fin.common.model.vo.Attachment;
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
		
		ArrayList<Attachment> alist = memberService.selectClassAttachment();
		
		model.addAttribute("list",list);
		model.addAttribute("alist",alist);
		
		return "member/admin/ad_class_list";
	}
	
	//교수 관리자 등록 페이지 이동
	@RequestMapping("enrollProfessor.ad")
	public String enrollProfessor() {
		
		return "member/admin/enrollProfessor";
	}
	
	//교수 관리자 등록 
	@RequestMapping(value="insertProfessor.ad", method=RequestMethod.POST)
	public String insertProfessor(Professor pr,
								Model model,
								HttpSession session) {
	
		int result = memberService.insertProfessor(pr);
		
		if(result>0) {
			model.addAttribute("msg","직원 생성 완료");
		}else {
			model.addAttribute("msg","직원 생성 실패");
		}
		return "member/admin/enrollProfessor";
	}
		

}
