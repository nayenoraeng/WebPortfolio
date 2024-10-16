package com.project.springboot.auth;


import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.project.springboot.dto.UserDTO;

import lombok.Data;

@Data
public class AccountDetails implements UserDetails, OAuth2User {

	private static final long serialVersionUID = 1L;
	private Map<String, Object> attributes;
	private UserDTO user;
	
	public AccountDetails(UserDTO user) {
		this.user=user;
	}
	
    public AccountDetails(UserDTO user, Map<String, Object> attributes) {
        this.user = user;
        this.attributes = attributes;
    }
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		 ArrayList<GrantedAuthority> authorities = new ArrayList<>();
		 String role = user.getAuthority();
	        authorities.add(new SimpleGrantedAuthority(role)); 
	        return authorities;
	
	}
	
	//소셜로그인용
	@Override
	public String getName() {
	    return user.getName();
	}
	
	@Override
	public Map<String, Object> getAttributes() {
	    return attributes;
	}

	//일반로그인용
	@Override
	public String getPassword() {
		return user.getPass();
	}

	@Override
	public String getUsername() {
		return user.getId();
	}
	
	@Override
    public boolean isAccountNonExpired() {
        return true;
    }
    
	//계정 안 잠김?
    @Override
    public boolean isAccountNonLocked() {
        return user.getIsLock() == 1; // 1은 잠금 해제 상태
    }
    
	//계정 Credential 안 만료됨?
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
	
    //비활성화 되지 않음? (오랫동안 사용하지 않은 경우 등)
    @Override
    public boolean isEnabled() {
        return user.getEnabled() == 1; // 1은 활성화 상태
    }
    
    //중복 로그인방지
    @Override
	public boolean equals(Object obj) {
	    if (obj instanceof AccountDetails) {
	        return this.user.getId().equals(((AccountDetails) obj).user.getId());
	    }
	    return false;
	}
	
	@Override
	public int hashCode() {
	    return this.user.getId().hashCode();
	}
}
