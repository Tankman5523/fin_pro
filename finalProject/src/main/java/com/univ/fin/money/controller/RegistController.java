package com.univ.fin.money.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.common.template.Sms;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.service.RegistService;
import com.univ.fin.money.model.vo.RegistPay;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@EnableAsync
public class RegistController {
	
	@Autowired
	private RegistService registService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	//학생
	
	@PostMapping("input.rg")
	public String updateInputPay(RegistPay r) {//학생이 등록금을 냈을때 정보수정
		//금액 , 입금학생계좌 , 입금시각/날짜, 입금학교계좌
		int result = registService.updateInputPay(r);
		if(result>0) {
			log.info("inputPay Success) SchoolAccount : "+r.getRegAccountNo()+" ,amount : "+r.getInputPay());
		}
		else {
			log.info("inputPay failed) SchoolAccount : "+r.getRegAccountNo());
		}
		
		return "redirect:/onelist.rg";
	}
	
	@GetMapping("listPage.rg")
	public String registListPage() {
		return "money/registPay/student/student_registPay_myList";
	}
	
	
	@ResponseBody
	@GetMapping(value="list.rg",produces = "application/json;charset=utf-8")
	public String selectMyRegistList(RegistPay r) {//등록금납부정보(날짜,학기) 조회
		//학기와 날짜정보 추출 후 대조
		ArrayList<RegistPay> list = registService.selectMyRegistList(r);
		return new Gson().toJson(list);
	}
	
	@GetMapping("onelist.rg")
	public ModelAndView selectNewRegistInfo(ModelAndView mv,HttpSession session) {//이번학기 등록금납부정보 조회
		Student st = (Student)session.getAttribute("loginUser");
		
		//현재 날짜정보로 다음학기 , 년도 찾기
		LocalDate now = LocalDate.now();
		int classYear = now.getYear();
		int month = now.getMonthValue();
		String classTerm = "";//int classTerm = 0;
		
		if(month>1 && month<8) {
			classTerm = "2";//2
		}else{
			classYear +=1;
			classTerm = "1";//1
		}
		
		String classYear2 = Integer.toString(classYear);
		
		
		ClassRating cr = ClassRating.builder()
									.studentNo(st.getStudentNo())
									.classTerm(classTerm)
									.classYear(classYear2)
									.build();
		RegistPay r = registService.selectNewRegistInfo(cr);
		mv.addObject("RegistPay", r).setViewName("money/registPay/student/student_registPay_nowList");
		return mv;
	}
	
	
	
	//관리자
	@ResponseBody
	@PostMapping(value = "allList.rg" , produces = "application/json;charset=utf-8")
	public String searchRegistList(String keyword , String filter) {//이름,상태값으로 검색
		HashMap<String,String> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("filter",filter);
		ArrayList<RegistPay> list = registService.searchRegistList(map);;
		return new Gson().toJson(list);
	}
	
	@GetMapping("insert.rg")
	public String insertRegistPayForm() {//학생이 내야할 등록금정보 등록 페이지
		return "money/registPay/admin/admin_registPay_insertForm";
	}
	@ResponseBody
	@PostMapping("insert.rg")
	public String insertRegistPay(RegistPay r,HttpSession session) {//학생이 내야할 등록금정보 등록
		//가상계좌 생성
		r.setRegAccountNo(randomAccount(r.getStudentNo()));
		//등록금 정보 입력 , 해당학기 장학금 처리
		int result = registService.insertRegistPay(r);
		if(result>0) {
			return "Y";
		}else {
			return "N";
		}
	}
	
	@GetMapping("update.rg")
	public ModelAndView updateRegistPayForm(ModelAndView mv,int regNo) {//등록금정보 수정 페이지
		RegistPay r = registService.selectOneRegistPay(regNo);
		mv.addObject("r", r).setViewName("money/registPay/admin/admin_registPay_updateForm");
		return mv;
	}
	@PostMapping("update.rg")
	public String updateRegistPay(RegistPay r,HttpSession session) {//등록금정보 수정
		int result = registService.updateRegistPay(r);
		if(result>0) {
			session.setAttribute("alertMsg", "등록금 수정 성공");
		}else {
			session.setAttribute("alertMsg", "등록금 수정 실패 ! 수정 실패한 학번 : "+r.getStudentNo());
		}
		return "redirct:allList.rg";
	}
	
	@GetMapping("nonPaidList.rg")
	public ModelAndView selectRegistNonPaidList(ModelAndView mv) {//미납등록금정보 조회
		ArrayList<RegistPay> list = registService.selectRegistNonPaidList();
		System.out.println(list);
		mv.addObject("list", list).setViewName("money/registPay/admin/admin_nonPaid_list");
		return mv;
	}
	@ResponseBody
	@GetMapping(value="nonPaidListSearch.rg",produces = "application/json;charset=utf-8")
	public String selectRegistNonPaidListSearch(String keyword,String filter) {//미납등록금정보 조회
		HashMap<String,String> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("filter",filter);
		ArrayList<RegistPay> list = registService.selectRegistNonPaidListSearch(map);
		return new Gson().toJson(list);
	}
	
	@ResponseBody
	@PostMapping("dunning.rg")
	public String dunningToNonPaid(String studentName,int nonPaidAmount ,String phone,String email) throws MessagingException {//독촉문자,이메일 발송
		
		//등록금 독촉 이메일
		String setFrom = ""; //보내는 계정
		String toMail = "ksh940813@naver.com"; //받는계정  /* email */
		String title = "[FEASIBLE UNIVERSITY]미납 등록금 납부 부탁드립니다.";
		String content = "귀하의 등록금이 미납 혹은 미달되어 연락 드립니다."
					   + "<br>"
					   + "미납된 금액은 "+nonPaidAmount+"(원) 입니다."
					   + "<br>"
					   + "해 사항에 대한 문의는 입학처 이메일인 ksh940813@naver.com "
					   + "<br>"
					   + "혹은 010-0000-0000 으로 연락바랍니다.";
					   
		
	    MimeMessage message = mailSender.createMimeMessage(); MimeMessageHelper
	    messageHelper = new MimeMessageHelper(message,true,"UTF-8");
	    messageHelper.setFrom(setFrom); messageHelper.setTo(toMail);
	    messageHelper.setSubject(title); messageHelper.setText(content,true);
	    mailSender.send(message);
		 
		//메일 완료
		
		//SMS 문자전송
		Sms smsMessage = new Sms();
		int result = smsMessage.dunningMsg("01000000000", nonPaidAmount, studentName);
		//문자 완료
		
		if(result>0) {
			return "Y";
		}else { //문자발송 실패시, 실패한 학생 이름,번호 반환
			return studentName+" ("+phone+")";
		}
		
		
	}
	
	@ResponseBody
	@PostMapping(value="refund.rg" , produces = "text/html;charset=UTF-8")
	public String refundOverPaid(RegistPay r) { //초과금 환급
		//payAccountNo로 (inputPay - mustPay) 만큼을 반환했다고 가정. 
		//int returnPay = r.getInputPay() - r.getMustPay();
		
		System.out.println(r);
		int result = registService.refundOverPaid(r);
		if(result>0) {
			return "Y";
		}else {
			return "N";
		}
		
	}
	
	
	//@GetMapping("activate.rg") //나중에 스케줄러 고장나면 버튼으로 처리
	//@Scheduled(cron = "0 0 10 * * *")//매일 아침 10시마다 실행
	//@Scheduled(cron = "9/60 * * * * *")//테스트용. 10초마다 실행
	@Async
	public void activateRegistPay() { //스케쥴러에 의해 등록금 활성화 개시 
		int result = 0;
		LocalDate now = LocalDate.now(); //현재시간
		Date date = java.sql.Date.valueOf(now);
		result = registService.activateRegistPay(date);
		if(result>0) {
			log.info("등록금 활성화 성공 / 테스트중입니다.");
		}else {
			log.info("등록금 활성화 실패 / 테스트중입니다.");
		}
	}
	
	@GetMapping("deactivate.rg") //나중에 스케줄러 고장나면 버튼으로 처리
	//@Scheduled(cron = "10/60 * * * * *")//매일 새벽 1시마다 실행
	@Async
	public void deactivateRegistPay() {//스케쥴러에 의해 등록금 비활성화 개시 
		int result = 0;
		LocalDate now = LocalDate.now(); //현재시간
		Date date = java.sql.Date.valueOf(now);
		result = registService.deactivateRegistPay(date);
		if(result>0) {
			log.info("등록금 비활성화 성공 / 테스트중입니다.");
		}else {
			log.info("등록금 비활성화 실패 / 테스트중입니다.");
		}
	}
	
	@GetMapping("allList.rg")
	public String selectRegistPayAllPage() { //등록금 전부조회 페이지로
		return "money/registPay/admin/admin_registPay_allList";
	}
	
	@ResponseBody
	@GetMapping(value="listForInsert.rg",produces = "application/json;charset=utf-8")
	public String studentListToInsert(int classYear,int classTerm) {//insert하기 전 학생정보 및 장학금 , 등록금 조회구문
		HashMap<String,Integer> map = new HashMap<>();
		map.put("classYear", classYear);
		map.put("classTerm", classTerm);
		ArrayList<RegistPay> list = registService.studentListToInsert(map);
		return new Gson().toJson(list);
	}
	
	//가상계좌번호 생성기 (사용하지 않을 실제 가상계좌를 만들 수 없기에 기능점검용)
	public String randomAccount(String studentNo) {
		
		String regAccountNo = null; //XXX-XXX-XXXXXX
		int flag = 1;
		
		regAccountNo = registService.selectAccountNo(studentNo);
			
		if(regAccountNo==null){
			while(flag>0) { //겹치는 계좌번호 없을때까지 반복
				int first = (int)(Math.random()*900) +99;
				int second = (int)(Math.random()*900) +99;
				int third = (int)(Math.random()*900000) +99999;
				regAccountNo = first+"-"+second+"-"+third;
				
				flag = registService.accountCheck(regAccountNo);
			}
		}
		
		return regAccountNo;
	}  
	
	//등록금 삭제
	@ResponseBody
	@GetMapping("delete.rg")
	public String deleteRegistPay(RegistPay r) {
		
		int result = registService.deleteRegistPay(r);
				
		if(result>0) {
			return "Y";
		}else {
			return "N";
		}
	}
	
}
