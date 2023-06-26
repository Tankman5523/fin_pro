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
public class ProfessorRest {
	private int restNo;//REST_NO	NUMBER
	private String professorNo;//PROFESSOR_NO	VARCHAR2(30 BYTE)
	private int category;//CATEGORY	NUMBER (0:퇴직, 1:안식)
	private Date requestDate;//REQUEST_DATE	DATE
	private Date startDate;//START_DATE	DATE
	private Date endDate;//END_DATE	DATE
	private String reason;//REASON	VARCHAR2(600 BYTE)
	private String status;//STATUS	VARCHAR2(2 BYTE)
}
