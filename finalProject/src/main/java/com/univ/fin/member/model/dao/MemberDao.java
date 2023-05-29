package com.univ.fin.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Repository
public class MemberDao {

	//학생 로그인
	public Student loginStudent(SqlSessionTemplate sqlSession, Student st) {
		return sqlSession.selectOne("memberMapper.loginStudent", st);
	}

	//임직원 로그인
	public Professor loginProfessor(SqlSessionTemplate sqlSession, Professor pr) {
		return sqlSession.selectOne("memberMapper.loginProfessor", pr);
	}

}
