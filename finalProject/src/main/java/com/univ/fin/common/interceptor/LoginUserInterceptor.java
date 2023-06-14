package com.univ.fin.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginUserInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		Object member = session.getAttribute("loginUser");
		
		if(member != null) {
			return true;
		}else {
			session.setAttribute("alertMsg", "경고! 잘못된 접근입니다. 다시 시도할 경우 ip가 차단 됩니다.");
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
		
	}
	
	
	
}
