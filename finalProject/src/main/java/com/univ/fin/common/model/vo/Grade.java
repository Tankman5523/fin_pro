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
	private int gradeNo;
	private String classNo; // 강의번호
	private int classYear; // 학년도
	private int classTerm; // 학기
	private String studentNo; // 학번
	private int score; // 성적
	private String gradeLevel; // 등급
}
