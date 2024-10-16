package com.project.springboot.oauth2;

public interface OAuth2UserInfo {
	
	String getProviderId();
    String getProvider();
    String getEmail();
    String getName();

}
