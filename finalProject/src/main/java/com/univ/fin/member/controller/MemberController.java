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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.univ.fin.common.template.Sms;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//로그인 폼 메소드
	@GetMapping("login.me")
	public String loginForm() {
		
		return "member/login";
	}
	
	//로그인 메소드
	@PostMapping("login.me")
	public ModelAndView loginUser(ModelAndView mv,String userNo,String userPwd
								 ,String saveId,HttpSession session,HttpServletResponse response) {
		
		if(userNo.charAt(0) == 'S') { //학생 로그인
			
			Student st = Student.builder().studentNo(userNo).build();
			
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
			
		}else if(userNo.charAt(0) == 'P'){ //임직원 로그인
			
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
		}else {
			session.setAttribute("alertMsg", "잘못 입력하셨습니다. 다시 입력해주세요");
			mv.setViewName("member/login");
		}
		
		return mv;
	}
	
	//ID찾기 폼 메소드
	@RequestMapping("searchIdForm.me")
	public String searchIdForm(int num,Model model) {
		
		if(num == 1) { //종합정보시스템에서 ID찾기 들어갔을 경우
			model.addAttribute("backPage", "infoSystem.mp");
		}else { //로그인폼에서 ID찾기 들어갔을 경우
			model.addAttribute("backPage", "login.me");
		}
		
		return "member/searchIdForm";
	}
	
	//ID조회 (이메일 방식)
	@ResponseBody
	@RequestMapping(value="checkEmail.me")
	public String checkEmail(String name,String phone,HttpServletRequest request) throws MessagingException {
		
		//최종 이메일 담을 변수(null 또는 값)
		String resultEmail = null;
		//임직원 변수 생성
		Professor member2 = null;
		//랜덤값 담을 변수 생성
		String ranNum = null;
		//Json객체 변수 생성
		JsonObject obj = null;
		
		Student st = Student.builder().studentName(name).phone(phone).build();
		
		//학생 조회
		Student member = memberService.checkEmail(st);
		
		if(member != null) { //학생 조회결과가 있다면.
			resultEmail = member.getEmail();
		}else { //교수 조회
			Professor pr = Professor.builder().professorName(name).phone(phone).build();
			member2 = memberService.checkEmail2(pr);
			
			if(member2 != null) {
				resultEmail = member2.getEmail();
			}
		}
		
		if(resultEmail != null) { //학생,임직원 둘중 조회된 값이 있다면 
			
			//랜덤값 생성(인증번호)
			ranNum = Integer.toString((int)(Math.random()*900000)+100000);
			
			String setFrom = "jungwoo343@naver.com"; //발송자의 이메일 
			String toMail = "jungwoo343@naver.com"; //받는사용자의 이메일(resultEmail 변수 들어갈 곳)
			String title = "[FEASIBLE UNIVERSITY] 로그인ID조회 - 이메일 인증 번호 ";
			String content = "귀하의 이메일 인증 번호는 다음과 같습니다."
							+"<br>"
							+"<h3>인증번호 : "+ ranNum +"</h3>"
							+"<br>"
							+"해당 인증번호를 인증번호 확인란에 기입하여 주시길 바랍니다."
							+"<br><br>"
							+"인증 번호는 일정 시간 내에서만 유효하며, 그 이후 인증 번호는 무효화 됩니다."
							+"<br><br>"
							+"인증 번호가 무효화 되었을 경우, 새롭게 인증 번호를 요청하십시오.";
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8"); //multipart형식 전달 가능
			messageHelper.setFrom(setFrom);
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content,true); //true설정으로 html형식 전송
			mailSender.send(message);
			
			obj = new JsonObject();
			if(member2 == null) { //학생일 경우
				obj.addProperty("resultNo", member.getStudentNo());
			}else { //임직원일 경우
				obj.addProperty("resultNo", member2.getProfessorNo());
			}
			obj.addProperty("ranNum", ranNum);
		}
		
		return new Gson().toJson(obj);
	}
	
	//ID조회 (SMS 방식)
	@ResponseBody
	@RequestMapping("checkPhone.me")
	public String checkPhone(String name, String phone) {
		//판별값 변수
		Boolean check = false;
		//랜덤값 변수
		String ranNum = null;
		//임직원 변수
		Professor member2 = null;
		//Sms 변수
		Sms message = new Sms();
		//Json객체 변수 생성
		JsonObject obj = null;
		
		//학생먼저 판별
		Student st = Student.builder().studentName(name).phone(phone).build();
		Student member = memberService.checkEmail(st);
		
		//입력한 값과 일치하는 학생존재 판별
		if(member != null) { // 학생 존재함.
			ranNum = Integer.toString((int)(Math.random()*900000)+100000);
			
			//member.getPhone()을 첫 매개변수에 넣어주면 됨;
			message.send_msg("01027552324", ranNum);
			check = true;
		}else { //임직원일 경우
			Professor pr = Professor.builder().professorName(name).phone(phone).build();
			member2 = memberService.checkEmail2(pr);
			
			if(member2 != null) { //임직원 존재함.(학생,임직원 둘다 아닐경우를 위해 판별)
				ranNum = Integer.toString((int)(Math.random()*900000)+100000);
				//member2.getPhone()을 첫번째 매개변수에 넣어주면 됨.
				message.send_msg("01027552324", ranNum);
				check = true;
			}
		}
		
		if(check == true){
			obj = new JsonObject();
			if(member2 == null) { //학생일 경우
				obj.addProperty("resultNo", member.getStudentNo());
			}else { //임직원일 경우
				obj.addProperty("resultNo", member2.getProfessorNo());
			}
			obj.addProperty("ranNum", ranNum);
		}
		return new Gson().toJson(obj);
	}
	
	//비밀번호 초기화 폼 메소드
	@RequestMapping("resetPwdForm.me")
	public String resetPwdForm(int num,Model model) {
		
		if(num == 1) { //종합정보시스템에서 비밀번호초기화 들어갔을 경우
			model.addAttribute("backPage", "infoSystem.mp");
		}else { //로그인폼에서 비밀번호초기화 들어갔을 경우
			model.addAttribute("backPage", "login.me");
		}
		
		return "member/resetPwdForm";
	}
	
	//비밀번호 초기화 (이메일 방식)
	@ResponseBody
	@RequestMapping("checkPwdEmail.me")
	public String checkPwdEmail(String memberNo, String phone) throws MessagingException {
		
		//최종 이메일 담을 변수(null 또는 값)
		String resultEmail = null;
		//임직원 변수 생성
		Professor member2 = null;
		//랜덤값 담을 변수 생성
		String ranNum = null;
		//Json객체 변수 생성
		JsonObject obj = null;
		
		Student st = Student.builder().studentNo(memberNo).phone(phone).build();
		
		//학생 조회
		Student member = memberService.checkPwd(st);
		
		if(member != null) { //학생 조회결과가 있다면.
			resultEmail = member.getEmail();
		}else { //교수 조회
			Professor pr = Professor.builder().professorNo(memberNo).phone(phone).build();
			member2 = memberService.checkPwd2(pr);
			
			if(member2 != null) {
				resultEmail = member2.getEmail();
			}
		}
		
		if(resultEmail != null) { //학생,임직원 둘중 조회된 값이 있다면 
			
			//랜덤값 생성(인증번호)
			ranNum = Integer.toString((int)(Math.random()*900000)+100000);
			
			String setFrom = "jungwoo343@naver.com"; //발송자의 이메일 
			String toMail = "jungwoo343@naver.com"; //받는사용자의 이메일(resultEmail 변수 들어갈 곳)
			String title = "[FEASIBLE UNIVERSITY] 로그인ID조회 - 이메일 인증 번호 ";
			String content = "귀하의 이메일 인증 번호는 다음과 같습니다."
							+"<br>"
							+"<h3>인증번호 : "+ ranNum +"</h3>"
							+"<br>"
							+"해당 인증번호를 인증번호 확인란에 기입하여 주시길 바랍니다."
							+"<br><br>"
							+"인증 번호는 일정 시간 내에서만 유효하며, 그 이후 인증 번호는 무효화 됩니다."
							+"<br><br>"
							+"인증 번호가 무효화 되었을 경우, 새롭게 인증 번호를 요청하십시오.";
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8"); //multipart형식 전달 가능
			messageHelper.setFrom(setFrom);
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content,true); //true설정으로 html형식 전송
			mailSender.send(message);
			
			obj = new JsonObject();
			if(member2 == null) { //학생일 경우
				obj.addProperty("resultNo", member.getStudentNo());
			}else { //임직원일 경우
				obj.addProperty("resultNo", member2.getProfessorNo());
			}
			obj.addProperty("ranNum", ranNum);
		}
		
		return new Gson().toJson(obj);
	}
	
	//비밀번호 초기화 (SMS 방식)
	@ResponseBody
	@RequestMapping("checkPwdPhone.me")
	public String checkPwdPhone(String memberNo, String phone) {
		//판별값 변수
		Boolean check = false;
		//랜덤값 변수
		String ranNum = null;
		//임직원 변수
		Professor member2 = null;
		//Sms 변수
		Sms message = new Sms();
		//Json객체 변수 생성
		JsonObject obj = null;
		
		//학생먼저 판별
		Student st = Student.builder().studentNo(memberNo).phone(phone).build();
		Student member = memberService.checkPwd(st);
		
		//입력한 값과 일치하는 학생존재 판별
		if(member != null) { // 학생 존재함.
			ranNum = Integer.toString((int)(Math.random()*900000)+100000);
			//member.getPhone()을 첫 매개변수에 넣어주면 됨;
			message.send_msg("01027552324", ranNum);
			check = true;
		}else { //임직원일 경우
			Professor pr = Professor.builder().professorNo(memberNo).phone(phone).build();
			member2 = memberService.checkPwd2(pr);
			
			if(member2 != null) { //임직원 존재함.(학생,임직원 둘다 아닐경우를 위해 판별)
				ranNum = Integer.toString((int)(Math.random()*900000)+100000);
				//member2.getPhone()을 첫번째 매개변수에 넣어주면 됨.
				message.send_msg("01027552324", ranNum);
				check = true;
			}
		}
		
		if(check == true){
			obj = new JsonObject();
			if(member2 == null) { //학생일 경우
				obj.addProperty("resultNo", member.getStudentNo());
			}else { //임직원일 경우
				obj.addProperty("resultNo", member2.getProfessorNo());
			}
			obj.addProperty("ranNum", ranNum);
		}
		
		return new Gson().toJson(obj);
	}
	
	//비밀번호 초기화 - 비밀번호 변경 메소드
	@ResponseBody
	@RequestMapping("changePwd.me")
	public String changePwd(String password, String memberNo,HttpSession session) {
		
		int result = 0;
		
		String encPwd = bcryptPasswordEncoder.encode(password);
		
		if(memberNo.charAt(0) == 'S') { //학생일 경우
			Student st = Student.builder().studentNo(memberNo).studentPwd(encPwd).build();
			result = memberService.changePwd(st);
		}else {
			Professor pr = Professor.builder().professorNo(memberNo).professorPwd(encPwd).build();
			result = memberService.changePwd2(pr);
		}
		
		if(result > 0) {
			session.setAttribute("alertMsg", "비밀번호 변경이 완료되었습니다.");
		}
		
		return new Gson().toJson(result);
	}
	
	//교수 학적정보 조회
	@RequestMapping("infoProfessor.me")
	public String infoProfessor() {
		
		return "member/professor/infoProfessor";
	}

	//학적 정보수정 - 교수
	@RequestMapping("updateProfessor.me")
	public ModelAndView updateProfessor(Professor pr,
									ModelAndView mv,
									HttpSession session) {
		int result = memberService.updateProfessor(pr);
		
		
		if(result>0) {
			//유저 정보갱신
			Professor updateStudent = memberService.loginProfessor(pr);
			session.setAttribute("loginUser", updateStudent);
			session.setAttribute("alertMsg", "수정 완료");
			mv.setViewName("redirect:infoProfessor.me");
		}else { //정보변경실패
			mv.addObject("errorMsg","수정 실패함요").setViewName("redirect:infoProfessor.me");
		}
		
	return mv;
		
	}
}
