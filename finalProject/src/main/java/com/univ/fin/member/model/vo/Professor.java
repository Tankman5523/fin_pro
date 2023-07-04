package com.univ.fin.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Professor {

/*
	PROFESSOR_NO		VARCHAR2(30 BYTE)
	FILE_NO				NUMBER
	DEPARTMENT_NO		NUMBER
	COLLEGE_NO			NUMBER
	PROFESSOR_NAME		VARCHAR2(15 BYTE)
	PROFESSOR_PWD		VARCHAR2(30 BYTE)
	POSITION			VARCHAR2(10 BYTE)
	ENTRANCE_DATE		DATE
	PHONE				VARCHAR2(15 BYTE)
	EMAIL				VARCHAR2(30 BYTE)
	POST				NUMBER
	ADDRESS				VARCHAR2(50 BYTE)
	ACCOUNT_NO			VARCHAR2(20 BYTE)
	ADMIN				NUMBER
	STATUS				VARCHAR2(2 BYTE) 
*/
	private String professorNo;
	private int fileNo;
	private String departmentNo;
	private String collegeNo;
	private String professorName;
	private String professorPwd;
	private String position;
	private Date entranceDate;
	private String phone;
	private String email;
	private int post;
	private String address;
	private String accountNo;
	private int admin;
	private String status;
	private String dissentNo;
	
}
