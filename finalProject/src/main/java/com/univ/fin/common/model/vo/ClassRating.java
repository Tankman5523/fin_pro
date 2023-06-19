package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ClassRating {
	private int ratingNo;//	RATING_NO	NUMBER
	private int classNo;//	CLASS_NO	NUMBER
	private String studentNo;//	STUDENT_NO	VARCHAR2(30 BYTE)
	private int q1;//	Q1	NUMBER
	private int q2;//	Q2	NUMBER
	private int q3;//	Q3	NUMBER
	private int q4;//	Q4	NUMBER
	private int q5;//	Q5	NUMBER
	private int q6;//	Q6	NUMBER
	private int q7;//	Q7	NUMBER
	private int q8;//	Q8	NUMBER
	private String etc;//	ETC	VARCHAR2(300 BYTE)
	private String status;//	STATUS	VARCHAR2(2 BYTE)
	
	private String className;
	private String professorName;
	private int classYear;
	private int classTerm;
	
	
}
