package com.univ.fin.common.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.univ.fin.member.model.vo.Student;

public class StudentNoInterceptor implements HandlerInterceptor{
	
	/* 로그인한 학생과 넘어오는 학생번호 값이 다를 경우 처리 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		Student st = (Student)session.getAttribute("loginUser");
		
		//해당 메소드 호출시 넘어온 값들 중 학번 값 추출
		String checkNo = request.getParameter("studentNo");
		
		if(st.getStudentNo().equals(checkNo)) { //로그인한 학생의 학번과 메소드 호출 학번이 같다면
			return true;
		}else {
			session.setAttribute("alertMsg", "경고! 잘못된 접근입니다. 다시 시도할 경우 ip가 차단 됩니다.");
			response.sendRedirect(request.getContextPath() + "/logout.me");
			return false;
		}
	}
}
