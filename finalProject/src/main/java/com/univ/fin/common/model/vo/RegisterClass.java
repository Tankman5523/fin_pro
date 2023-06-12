package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RegisterClass {
	private String collegeName;		// 단과대학명
	private int classNo;			// 강의번호
	private String className;
	private String professorName;	// 교수명
	private String departmentName;  // 학과명
	private String creditHour; 		// 시간+학점
	private String preclassNos;		// 수강인원
	private String classInfo;		// 요일+강의시간+강의실
	private String classLevel;		// 수강대상
	private String classYear;		// 학년도
	private String classTerm;		// 학기
	private String studentNo;		// 학번
}