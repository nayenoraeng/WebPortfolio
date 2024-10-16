package com.project.springboot.auth;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.project.springboot.dao.IMemberDao;
import com.project.springboot.dto.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class MyAuthFailureHandler 
extends SimpleUrlAuthenticationFailureHandler {
	
	@Autowired
	IMemberDao idao;
	
	private static final int MAX_FAILED_ATTEMPTS = 5;
	
	@Override
	public void onAuthenticationFailure(
	   HttpServletRequest request, 
	   HttpServletResponse response,
	   AuthenticationException exception) 
	         throws IOException, ServletException {
	
		String errorMessage = "";
		String id= request.getParameter("id");           
			          
            if (exception instanceof BadCredentialsException || exception instanceof InternalAuthenticationServiceException) {
            	loginFailureCnt(id);
                errorMessage = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요."
                			+ "5번 실패 시 계정이 잠김 처리 됩니다.";
            } else if (exception instanceof UsernameNotFoundException) {
                errorMessage = "존재하지 않는 사용자 아이디입니다. 아이디 찾기로 아이디를 확인해주시거나 회원가입 해주세요.";
            } else if (exception instanceof LockedException) {
                errorMessage = "계정이 잠겨있습니다. 15분 뒤에 다시 로그인해주세요.";
            } else if (exception instanceof DisabledException) {
                errorMessage = "계정이 비활성화되었습니다. 관리자에게 문의하세요.";
            } else {
                errorMessage = "알 수 없는 오류로 로그인 요청을 처리할 수 없습니다. 관리자에게 문의하세요.";
            }

            // URL encode the error message and set the default failure URL
            errorMessage = URLEncoder.encode(errorMessage, "UTF-8");
            setDefaultFailureUrl("/security/loginform?error=true&exception=" + errorMessage);
        
	
	    super.onAuthenticationFailure(request, response, exception);
	}
	
	public void loginFailureCnt(String id) {
		UserDTO user = idao.findByUsername(id);
		

	    if (user != null) {
	        int failCount = user.getFailCount(); // 현재 실패 횟수
	        long currentTime = System.currentTimeMillis(); // 현재 시간

	        // 로그인 실패 횟수 증가
	        failCount++;

	        // 최대 실패 횟수에 도달했는지 확인
	        if (failCount >= MAX_FAILED_ATTEMPTS) {
	            // 실패 횟수가 최대값에 도달하면 계정 잠금 및 잠금 시간 설정
	            idao.updateUserLockStatus(0, failCount, new Timestamp(currentTime), id);
	        } else {
	            // 그렇지 않으면 실패 횟수만 업데이트
	            idao.updateFailCount(failCount, id);
	        }
	    }
	}
	
 
}
