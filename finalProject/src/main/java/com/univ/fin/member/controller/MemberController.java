package com.univ.fin.member.controller;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	//로그인 메소드
	@RequestMapping("login.me")
	public ModelAndView loginUser(ModelAndView mv,String userNo,String userPwd
								 ,String saveId,HttpSession session,HttpServletResponse response) {
		
		//userNo
		//userPwd => 비밀번호 암호화 후 진행
		
		//학생 : S
		// S201701
		
		//교수,관리자 : P
		// P201526
		
		if(userNo.charAt(0) == 'S') { //학생 로그인
			
			Student st = Student.builder().studentNo(userNo).studentPwd(userPwd).build();
			
			Student loginUser = memberService.loginStudent(st);
			
			if(loginUser != null) { //로그인 되었을때만 쿠키 생성 및 저장
				
				Cookie cookie = null;
				
				if(saveId != null && saveId.equals("on")) {
					cookie = new Cookie("userNo",userNo);
					cookie.setMaxAge(60*60*24); //1일
					response.addCookie(cookie);
				}else {
					cookie = new Cookie("userNo",null);
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}
			
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
		

		
		//loginUser가 null값이 아니라면 쿠키 저장
		
		return mv;
	}
	
	//ID찾기 뷰 메소드
	@RequestMapping("searchIdForm.me")
	public String searchIdForm() {
		
		return "common/searchIdForm";
	}
	
	//ID조회 (이메일 방식) - 학생
	@ResponseBody
	@RequestMapping(value="checkEmail.me")
	public String checkEmail(Student st,HttpServletRequest request) throws MessagingException {
		
		String setFrom = "jungwoo343@naver.com";
		String toMail = "jungwoo343@naver.com";
		String title = "ㅎㅇ";
		String content = "asdsadas";
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
		messageHelper.setFrom(setFrom);
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		mailSender.send(message);
		
		System.out.println("확인");
		
		int result = memberService.checkEmail(st);
		
		return new Gson().toJson(result);
	}
	
	//비밀번호 재설정 뷰 메소드
	@RequestMapping("resetPwdForm.me")
	public String resetPwdForm() {
		return "common/resetPwdForm";
	}
	
}
