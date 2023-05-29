package com.univ.fin.common.model.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginUserInterceptor extends HandlerInterceptorAdapter {
	
	/*
	 * Interceptor (HandlerInterceptor)
	 * - 해당 Controller가 실행되기 전, 실행된 후에 요청을 가로채서 실행할 내용을 작성할 수 있는 도구
	 * - 주로 권한 체크에 활용한다.
	 * 
	 * - Interceptor 메소드 (간섭시점)
	 * preHandle (전처리): DispatcherServlet에서 컨트롤럴르 호출하기 전 시점
	 * postHandle (후처리): 컨트롤러에서 요청 처리 후 DispatcherServlet으로 뷰 정보가 리턴되는 시점
	 * 
	 * */
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
//		// true가 리턴 - 기존 요청 흐름을 유지해라
//		// false가 리턴 - 기존 요청 흐름이었던 Controller에 요청이 가지 않는다.
//		HttpSession session = request.getSession();
//		Member loginUser = (Member)session.getAttribute("loginUser");
//		
//		if(loginUser != null) {
//			return true;
//		}
//		else {
//			// 현재 요청을 보낸 사용자가 로그인하지 않은 사용자일 경우
//			session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다^^;;");
//			response.sendRedirect(request.getContextPath());
//			return false;
//		}
//	}

}
