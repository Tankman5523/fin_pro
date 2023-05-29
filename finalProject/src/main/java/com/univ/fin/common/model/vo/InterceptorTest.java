package com.univ.fin.common.model.vo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class InterceptorTest implements HandlerInterceptor {

	// 인터셉터 간섭시점1: 처리 전
	// - 404는 인터셉터가 실행되지 않는다 (요청이 들어와야만 실행되기 때문)
	// - request: 사용자는 어떤 것을 요청했는가?
	// - response: 사용자에게 첨부할 정보가 있는가?
	// - handler: 이 요청은 누가 처리하기로 했는가?
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("테스트 인터셉터 처리 전");
		System.out.println(handler);
		
		return true;
	}
	
	// 인터셉터 간섭시점2: 처리 후
	// 컨트롤러의 처리 직후 시점을 간섭하는 메소드
	// - request: 사용자는 무엇을 요청했는가?
	// - response: 사용자에게 첨부할 정보가 있는가?
	// - handler: 요청은 누가 처리하기로 했는가?
	// - modelAndView: model(전달데이터), view(출력페이지) 정보

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("테스트 인터셉터 처리 후");
		System.out.println(handler);
		System.out.println(modelAndView);
	}
	
	// 인터셉터 간섭시점3: 사용자에게 출력되기 직전
	// - request: 사용자는 무엇을 요청했는가?
	// - response: 사용자에게 첨부할 정보가 있는가?
	// - handler: 요청은 누가 처리하기로 했는가?
	// - exception: 진행 과정에서 예외가 발생했는가?

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		System.out.println("afterCompletion");
		System.out.println(ex);
	}

}
