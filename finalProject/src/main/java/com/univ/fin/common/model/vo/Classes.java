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
	private int classNo;
	private String professorNo;
	private int departmentNo;
	private int fileNo;
	private String className;
	private String classLevel;
	private String classYear;
	private String classTerm;
	private String classroom;
	private int day;
	private int period;
	private int classHour;
	private int classNos;
	private String explain;
	private int credit;
	private int division;
	private String status;
}
