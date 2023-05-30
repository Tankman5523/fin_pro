package com.univ.fin.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("login.me")
	public ModelAndView loginUser(ModelAndView mv,String userNo,String userPwd,HttpSession session) {
		
		//userNo
		//userPwd => 비밀번호 암호화 후 진행
		
		//학생 : S
		// S201701
		
		//교수,관리자 : P
		// P201526
		
		
		if(userNo.charAt(0) == 'S') { //학생 로그인
			
			Student st = Student.builder().studentNo(userNo).studentPwd(userPwd).build();
			
			Student loginUser = memberService.loginStudent(st);
			
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("common/student_category");
			
		}else {
			
			Professor pr = Professor.builder().professorNo(userNo).professorPwd(userPwd).build();
			
			Professor loginUser = memberService.loginProfessor(pr);
			
			if(loginUser.getAdmin() == 1) { // 교수 로그인
				
				session.setAttribute("loginUser", loginUser);
				mv.setViewName("common/professor_category");
				
			}else { // 관리자 로그인
				
				session.setAttribute("loginUser", loginUser);
				mv.setViewName("common/admin_category");
			}
		}
	
		return mv;
	}
	
}
