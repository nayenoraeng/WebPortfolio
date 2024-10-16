package com.project.springboot.oauth2;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.project.springboot.dao.IMemberDao;
import com.project.springboot.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
	
	@Autowired
	 private IMemberDao dao;
	@Autowired
     private HttpSession httpSession;
	
	    @Override
	    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
	        OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
	        OAuth2User oAuth2User = delegate.loadUser(userRequest);
	        // 현재 로그인 진행 중인 서비스를 구분하는 코드
	        String registrationId = userRequest
	                .getClientRegistration()
	                .getRegistrationId();
	        // oauth2 로그인 진행 시 키가 되는 필드값
	        String userNameAttributeName = userRequest.getClientRegistration()
	                .getProviderDetails()
	                .getUserInfoEndpoint()
	                .getUserNameAttributeName();
	        // OAuthAttributes: attribute를 담을 클래스 (개발자가 생성)
	        OAuthAttributes attributes = OAuthAttributes
	                .of(registrationId, userNameAttributeName, oAuth2User.getAttributes());
	        
	        UserDTO user = saveOrUpdate(attributes);
	        
	        SessionUser sessionUser = new SessionUser(user);
	        httpSession.setAttribute("user", sessionUser);
	        
	        
	        return new DefaultOAuth2User(
	                Collections.singleton(new SimpleGrantedAuthority(user.getAuthority())),
	                attributes.getAttributes(),
	                attributes.getNameAttributeKey()
	        );
	    }
	    
	    private UserDTO saveOrUpdate(OAuthAttributes attributes) {
	        UserDTO user = dao.findByUsername(attributes.getId());
	        if (user == null) {
	            user = attributes.toDTO(); // Convert OAuthAttributes to UserDTO
	            dao.joinSocial(user); // 저장할 메서드 호출
	        }
	        return user;
	    }
	
}
