package com.univ.fin.money.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Salary {
	private int payNo;
	private String professorNo;
	private String paymentDate;
	
	private int basePay; //기본급
	private int positionPay; //직책수당
	private int extensionPay; //연장근로수당
	private int holidayPay; //휴일근로수당
	private int researchPay; //연구비
	private int paymentTotal; // = basePay+positionPay+holidayPay+researchPay; //지급액계
	
	private int nationalTax; // = (int)(paymentTotal * (double)(45/1000)); //국민연금
	private int healthTax; // = (int)(paymentTotal * (double)(35/1000)); //건강보험
	private int employTax; // = (int)(paymentTotal * (double)(9/1000)); //고용보험
	
	private int incomeTax;
	private int deductTotal; // = nationalTax + healthTax + employTax + incomeTax; //공제액계
	
	private int realPay; //실수령액
	private String status;
	
	//정보조회용
	private String professorName; //이름
	private String position; //직책
	private String accountNo; //급여계좌
	
	
}
