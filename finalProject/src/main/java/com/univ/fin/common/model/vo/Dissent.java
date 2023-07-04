package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Dissent {
	private String dissentNo;
	private String gradeNo;
	private String fileNo;
	private String studentNo;
	private String classNo;
	private String className;
	private String professorName;
	private String reason;
	private String option;
	private String status;
	private String professorNo;
	}

