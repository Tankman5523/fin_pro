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
public class RegistPay { //등록금
	private String studentNo;
	private String regAccountNo;//입금계좌(학교계좌)
	private int mustPay;
	private int inputPay;
	private String classYear;
	private int classTerm;
	private String payAccountNo;//학생계좌
	private	Date payDate; //리스트 조회시 날짜대조
	private Date startDate;
	private Date endDate;
	private String payStatus;
	private String status;
	
	//미납관련
	private int NonPaidAmount;// = mustPay-inputPay; //미납금
	//해당학생정보
	private String studentName;
	private String studentPhone;
	private String studentEmail;

}
