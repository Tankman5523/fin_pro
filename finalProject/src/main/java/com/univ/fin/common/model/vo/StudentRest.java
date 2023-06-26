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
public class StudentRest {
	private int restNo;//REST_NO	NUMBER
	private String studentNo;//STUDENT_NO	VARCHAR2(30 BYTE)
	private String category;//CATEGORY	VARCHAR2(20 BYTE)
	private String reason;//REASON	VARCHAR2(100 BYTE)
	private Date requestDate;//REQUEST_DATE	DATE
	private Date startDate;//START_DATE	DATE
	private Date endDate;//END_DATE	DATE
	private String status;//STATUS	VARCHAR2(2 BYTE)
	private String studentName; //학생 이름
}
