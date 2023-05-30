package com.univ.fin.registPay.controller;

import org.springframework.stereotype.Controller;

@Controller
public class RegistController {
	
	
	public String insertRegistPay() {//학생이 내야할 등록금정보 등록
		
		
		return "redirect:/";
	}
	
	public String updateRegistPay() {//등록금정보 수정
		
		return "";
	}
	
	public String updateInputPay() {//학생이 등록금을 냈을때 정보수정
		
		
		return "";
	}
	
	public String selectRegistList() {//등록금납부정보(날짜,학기)
		//학기와 날짜정보 추출 후 대조
		
		return "";
	}
	
	public String selectNowRegistInfo() {//이번학기 등록금납부정보
		
		return "";
	}
	
	public String searchRegistList() {//이름,상태값으로 검색
		
		return "";
	}
	
	
	public String selectRegistNonPaidList() {//미납등록금정보
		
		return "";
	}
	
	public String dunningToNonPaid() {//독촉문자,이메일 발송
		
		return "";
	}
	
	
	public String refundOverPaid() { //초과금 환급
		
		return "";
	}
}
