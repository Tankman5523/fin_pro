package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Grade {
	private int classNo; // 강의번호
	private String departmentName; // 학과
	private String studentNo; // 학번
	private int classLevel; // 학년
	private String studentName; // 이름
	private int score; // 성적
	private String gradeLevel; // 등급
}
