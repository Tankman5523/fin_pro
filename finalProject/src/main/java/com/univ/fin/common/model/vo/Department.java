package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Department {
	private int departmentNo;//DEPARTMENT_NO	NUMBER
	private String collegeNo;//COLLEGE_NO	NUMBER
	private String departmentName;//DEPARTMENT_NAME	VARCHAR2(40 BYTE)
	private int departmentNos;//DEPARTMENT_NOS	NUMBER
	private int graduation;//GRADUATION	NUMBER
}
