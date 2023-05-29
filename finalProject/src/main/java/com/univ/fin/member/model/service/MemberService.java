package com.univ.fin.member.model.service;

import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

public interface MemberService {

	//학생 로그인
	Student loginStudent(Student st);
	
	//임직원 로그인
	Professor loginProfessor(Professor pr);

}
