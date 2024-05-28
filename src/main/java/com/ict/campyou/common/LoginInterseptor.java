package com.ict.campyou.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.AsyncHandlerInterceptor;

public class LoginInterseptor implements AsyncHandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(true);
		
		String requestPage = request.getRequestURI();
	    session.setAttribute("requestPage", requestPage);
	    System.out.println(requestPage);
		Object obj = session.getAttribute("memberInfo");
		if(obj == null) {
			response.sendRedirect(request.getContextPath() + "/login_form.do");
			return false;
		}
		return true;
	}
}