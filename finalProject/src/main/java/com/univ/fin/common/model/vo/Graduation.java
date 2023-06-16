package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Graduation {
	private String studentNo;		// 학번
	private String studentName;		// 학생명
	private String entranceDate;	// 입학년도
	private String collegeName;		// 단과대학명
	private String departmentName;	// 전공명
	private String status;			// 학적상태
	private int classLevel;			// 학년
	private String classTerm;		// 이수학기
	private int sumCredit;			// 총 취득학점
	private int commonClass;		// 교양공통
	private int nomalClass;			// 교양일반
	private int majorClass;			// 전공심화
}
