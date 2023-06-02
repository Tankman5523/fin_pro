package com.univ.fin.money.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RegistController {
	
	//학생
	
	@PostMapping("input.rg")
	public String updateInputPay() {//학생이 등록금을 냈을때 정보수정
		
		
		return "";
	}
	
	@GetMapping("list.rg")
	public ModelAndView selectRegistList(ModelAndView mv) {//등록금납부정보(날짜,학기) 조회
		//학기와 날짜정보 추출 후 대조
		
		return mv;
	}
	
	@GetMapping("onelist.rg")
	public ModelAndView selectNowRegistInfo(ModelAndView mv) {//이번학기 등록금납부정보 조회
		
		return mv;
	}
	
	
	
	//관리자
	@GetMapping("search.rg")
	public ModelAndView searchRegistList(ModelAndView mv) {//이름,상태값으로 검색
		
		return mv;
	}
	
	@GetMapping("insert.rg")
	public String insertRegistPayForm() {//학생이 내야할 등록금정보 등록 페이지
		
		
		return "";
	}
	@PostMapping("insert.rg")
	public String insertRegistPay() {//학생이 내야할 등록금정보 등록
		
		
		return "";
	}
	
	@GetMapping("update.rg")
	public String updateRegistPayForm() {//등록금정보 수정 페이지
		
		return "";
	}
	@PostMapping("update.rg")
	public String updateRegistPay() {//등록금정보 수정
		
		return "";
	}
	
	@GetMapping("nonPaidList.rg")
	public ModelAndView selectRegistNonPaidList(ModelAndView mv) {//미납등록금정보 조회
		
		return mv;
	}
	
	@PostMapping("dunning.rg")
	public String dunningToNonPaid() {//독촉문자,이메일 발송
		
		return "";
	}
	
	@PostMapping("refund.rg")
	public String refundOverPaid() { //초과금 환급
		
		return "";
	}
}
