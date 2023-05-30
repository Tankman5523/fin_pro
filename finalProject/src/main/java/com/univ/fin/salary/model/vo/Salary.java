package com.univ.fin.salary.model.vo;

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
	private Date paymentDate;
	
	private int basePay; //기본급
	private int positionPay; //직책수당
	private int extensionPay; //연장근로수당
	private int holidayPay; //휴일근로수당
	private int researchPay; //연구비
	private int paymentTotal; //지급액계
	
	private int nationalTax; //국민연금
	private int healthTax; //건강보험
	private int employTax; //고용보험
	private int incomeTax; //소득세
	private int deductTotal; //공제액계
	
	private int realPay; //실수령액
	private String status;
}
