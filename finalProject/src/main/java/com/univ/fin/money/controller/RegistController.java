package com.univ.fin.money.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RegistController {
	
	
	public String insertRegistPay() {//학생이 내야할 등록금정보 등록
		
		
		return "";
	}
	
	public String updateRegistPay() {//등록금정보 수정
		
		return "";
	}
	
	public String updateInputPay() {//학생이 등록금을 냈을때 정보수정
		
		
		return "";
	}
	
	@GetMapping("list.rg")
	public String selectRegistList() {//등록금납부정보(날짜,학기) 조회
		//학기와 날짜정보 추출 후 대조
		
		return "";
	}
	
	public String selectNowRegistInfo() {//이번학기 등록금납부정보 조회
		
		return "";
	}
	@GetMapping("search.rg")
	public String searchRegistList() {//이름,상태값으로 검색
		
		return "";
	}
	
	
	public String selectRegistNonPaidList() {//미납등록금정보 조회
		
		return "";
	}
	
	public String dunningToNonPaid() {//독촉문자,이메일 발송
		
		return "";
	}
	
	
	public String refundOverPaid() { //초과금 환급
		
		return "";
	}
}
