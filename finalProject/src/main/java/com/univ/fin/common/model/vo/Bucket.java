package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Bucket {
/*
	CLASS_NO		NUMBER
	STUDENT_NO		VARCHAR2(30 BYTE)
 */
	private int classNo;
	private String studentNo;
}
