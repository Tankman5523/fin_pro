package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Objection {
	
	private String studentNo;		// 학번
	private String studentName;		// 학생이름
	private String professorNo;		// 교번
	private String gradeNo; 		// 성적번호
	private String professorName;	// 교수명	
	private String className;		// 강의명
	private String classNo;			// 과목번호
	private String credit;			// 학점	
	private String reason;			// 반려사유 
	private String status;			// 상태
	private String classYear;		// 학년도
	private String classTerm;		// 학기
	private String opinion; 		// 교수의견
	

}
