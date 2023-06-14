package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Classes {
	private String classNo;
	private String professorNo;
	private String departmentNo;
	private String fileNo;
	private String className;
	private String classLevel;
	private String classYear;
	private String classTerm;
	private String classroom;
	private String day;
	private String period;
	private int classHour;
	private int classNos;
	private int spareNos; // 여석
	private String explain;
	private int credit;
	private int division;
	private String status;
}
