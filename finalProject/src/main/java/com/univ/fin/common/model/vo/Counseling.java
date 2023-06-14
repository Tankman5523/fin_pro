package com.univ.fin.common.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Counseling {
	private int counselNo;//COUNSEL_NO	NUMBER
	private String studentNo;//STUDENT_NO	VARCHAR2(30 BYTE)
	private String professorNo;//PROFESSOR_NO	VARCHAR2(30 BYTE)
	private Date applicationDate;//APPLICATION_DATE	DATE
	private Date requestDate;//REQUEST_DATE	DATE
	private String counselArea;//COUNSEL_AREA	VARCHAR2(30 BYTE)
	private String counselContent;//COUNSEL_CONTENT	VARCHAR2(500 BYTE)
	private String counselResult;//COUNSEL_RESULT	VARCHAR2(500 BYTE)
	private String status;//STATUS	VARCHAR2(2 BYTE)
	private String professorName;
}
