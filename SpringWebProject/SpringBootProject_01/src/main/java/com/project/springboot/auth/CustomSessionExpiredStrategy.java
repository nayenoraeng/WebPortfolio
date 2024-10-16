package com.project.springboot.auth;

import java.io.IOException;

import org.springframework.security.web.session.SessionInformationExpiredEvent;
import org.springframework.security.web.session.SessionInformationExpiredStrategy;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class CustomSessionExpiredStrategy implements SessionInformationExpiredStrategy {
	
	@Override
	public void onExpiredSessionDetected(SessionInformationExpiredEvent event) throws IOException, ServletException
	{
		HttpServletRequest request = event.getRequest();
	    HttpServletResponse response = event.getResponse();
	    
	    // 세션 만료에 대한 알림을 위해 세션 속성 설정
	    HttpSession session = request.getSession();
	    session.setAttribute("DUPLICATE_LOGIN", true);

	    // 사용자에게 로그인 페이지로 리다이렉트
	    response.sendRedirect("/security/loginform");
		
	}

}
