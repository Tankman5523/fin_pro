package com.univ.fin.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.fin.member.model.dao.MemberDao;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//학생 로그인
	@Override
	public Student loginStudent(Student st) {
		
		Student loginUser = memberDao.loginStudent(sqlSession,st);
		
		return loginUser;
	}

	//임직원 로그인
	@Override
	public Professor loginProfessor(Professor pr) {
		
		Professor loginUser = memberDao.loginProfessor(sqlSession,pr);
		
		return loginUser;
	}

	//ID조회 (이메일 방식) - 학생
	@Override
	public int checkEmail(Student st) {
		
		int result = memberDao.checkEmail(sqlSession,st);
		
		return result;
	}

}
