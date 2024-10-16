package com.project.springboot.auth;

import java.io.IOException;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.project.springboot.dao.IMemberDao;
import com.project.springboot.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class MyAuthSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	
	
    private final RequestCache requestCache = new HttpSessionRequestCache();
    private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    @Autowired
    private IMemberDao idao;
    
    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {
    	clearSession(request);
    	
        if (authentication == null) {
            throw new IllegalStateException("Authentication object is null.");
        }
        
    	String id = authentication.getName();
    	UserDTO user = idao.findByUsername(id);
    	
    	//계정 잠금 전 로그인 성공시 실패 카운트 리셋
        if(user.getIsLock() == 1 && user.getFailCount() < 5 && user.getFailCount() >= 1) {
          
            idao.updateFailCount(0, id);
        }
    	 
        //인증되지 ㅇ낳은 상태에서 접근하려 했던 url 저장
        SavedRequest savedRequest = requestCache.getRequest(request, response);

        /**
         * prevPage가 존재하는 경우 = 사용자가 직접 /security/loginform 경로로 로그인 요청
         * 기존 Session의 prevPage attribute 제거
         */
        String prevPage = (String) request.getSession().getAttribute("prevPage");
//        System.out.println("Previous Page: " + prevPage);

        /**
         * savedRequest 존재하는 경우 = 인증 권한이 없는 페이지 접근
         * Security Filter가 인터셉트하여 savedRequest에 세션 저장
         */
        String uri;

        // SavedRequest가 있을 경우, savedRequest의 URL로 리다이렉트
        if (savedRequest != null) {
            uri = savedRequest.getRedirectUrl();
        } 
        // prevPage가 null이 아니고 비어있지 않을 경우
        else if (prevPage != null && !prevPage.isEmpty()) {
            // prevPage가 특정 페이지를 포함하는지 확인
            if (prevPage.contains("/security/findId") || prevPage.contains("/security/findPwd")
            		|| prevPage.contains("/guest/joinform")) {
                uri = "/";
            } else {
                uri = prevPage; // prevPage가 지정된 경우, 해당 페이지로 리다이렉트
            }
        } 
        // prevPage가 null이거나 비어있을 경우 기본 페이지로 리다이렉트
        else {
            uri = "/";
        }
        
//        System.out.println("Redirecting to: " + uri);
        
        if (prevPage != null) {
            request.getSession().removeAttribute("prevPage");
        }

        redirectStrategy.sendRedirect(request, response, uri);
        
//        System.out.println("Redirecting to: " + uri);
        
    }
    
    // 로그인 실패한 후 성공 했을 시 남아있는 에러 세션을 제거함.
    protected void clearSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        }
    }
   
  

}
