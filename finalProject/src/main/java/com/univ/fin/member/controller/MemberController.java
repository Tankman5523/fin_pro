package com.univ.fin.member.controller;

import javax.mail.MessagingException;
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
			
		}else { //임직원 로그인
			
			Professor pr = Professor.builder().professorNo(userNo).professorPwd(userPwd).build();
			
			Professor loginUser = memberService.loginProfessor(pr);
			
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
	
	//ID찾기 뷰 메소드
	@RequestMapping("searchIdForm.me")
	public String searchIdForm() {
		
		return "common/searchIdForm";
	}
	
	//ID조회 (이메일 방식) - 학생
	@ResponseBody
	@RequestMapping(value="checkEmail.st")
	public String checkEmail(Student st,HttpServletRequest request) throws MessagingException {
		
		int result = memberService.checkEmail(st);
		
		if(result > 0) { //해당하는 학생이 존재한다면 메일 발송
			String setFrom = "jungwoo343@naver.com"; //발송자의 이메일 
			String toMail = "jungwoo343@naver.com"; //받는사용자의 이메일
			String title = "제목";
			String content = "<h1>그럴싸한 대학교 </h1>"
							+"<br>"
							+"회원님의 인증번호는 : 000000 입니다."
							+"<br>"
							+"해당 인증번호를 인증번호 확인란에 기입하여 주시길 바랍니다.";
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8"); //multipart형식 전달 가능
			messageHelper.setFrom(setFrom);
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content,true); //true설정으로 html형식 전송
			mailSender.send(message);
		}
		
		return new Gson().toJson(result);
	}
	
	//비밀번호 재설정 뷰 메소드
	@RequestMapping("resetPwdForm.me")
	public String resetPwdForm() {
		return "common/resetPwdForm";
	}
	
}
