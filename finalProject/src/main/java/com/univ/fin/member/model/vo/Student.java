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
public class Student {
	
	/*
	STUDENT_NO		VARCHAR2(30 BYTE)
	DEPARTMENT_NO	NUMBER
	COLLEGE_NO		NUMBER
	FILE_NO			NUMBER
	STUDENT_NAME	VARCHAR2(15 BYTE)
	STUDENT_PWD		VARCHAR2(30 BYTE)
	ENTRANCE_DATE	DATE
	GRADUATION_DATE	DATE
	CLASS_LEVEL		NUMBER
	PHONE			VARCHAR2(15 BYTE)
	EMAIL			VARCHAR2(30 BYTE)
	POST			NUMBER
	ADDRESS			VARCHAR2(100 BYTE)
	STATUS			VARCHAR2(10 BYTE)
	*/
	
	private String studentNo;
	private int departmentNo;
	private int collegeNo;
	private int fileNo;
	private String studentName;
	private String studentPwd;
	private Date entranceDate;
	private Date graduationDate;
	private int classLevel;
	private String phone;
	private String email;
	private int post;
	private String address;
	private String status;
	
}
