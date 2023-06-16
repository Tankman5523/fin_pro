 package com.univ.fin.member.controller;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	


}
