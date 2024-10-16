package com.project.springboot.oauth2;

import java.util.Map;

import com.project.springboot.dto.UserDTO;

import lombok.Builder;
import lombok.Getter;

@Getter
public class OAuthAttributes {
	
	private Map<String,Object> attributes;
    private String nameAttributeKey, name, email;
    private String provider;
    private String providerId;
    private String id;

    @Builder
    public OAuthAttributes(Map<String,Object> attributes,
                           String nameAttributeKey,
                           String name,String email, 
                           String provider,
                           String providerId, String id){
        this.attributes=attributes;
        this.nameAttributeKey=nameAttributeKey;
        this.id=provider + "_" + providerId;
        this.name=name;
        this.email=email;
        this.provider = provider;
        this.providerId = providerId;
    }
    public static OAuthAttributes of(String registrationId,
                                     String userNameAttributeName,
                                     Map<String, Object> attributes) {
    	if (registrationId.equals("google")) {
			return ofGoogle(userNameAttributeName, attributes,registrationId);
		} else if  (registrationId.equals("facebook")) {
			return ofFacebook(userNameAttributeName, attributes, registrationId);
		} else if  (registrationId.equals("kakao")) {
			return ofKakao(userNameAttributeName, attributes, registrationId);
		} else if  (registrationId.equals("naver")) {
			return ofNaver(userNameAttributeName, attributes, registrationId);
		}
    	
		return ofGoogle(userNameAttributeName, attributes, registrationId);
    	

    }
    public static OAuthAttributes ofGoogle(String userNameAttributeName,
                                           Map<String, Object> attributes,
                                           String registrationId) {
        return OAuthAttributes.builder()
                .name((String) attributes.get("name"))
                .email((String) attributes.get("email"))
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)
                .provider(registrationId) // Set provider
                .providerId((String) attributes.get("sub")) // Set provider ID
                .build();
    }
    
    private static OAuthAttributes ofFacebook(String userNameAttributeName,
    										Map<String, Object> attributes,
    										String registrationId) 
	{
//		System.out.println(attributes);
		String sName = (String) attributes.get("name");
		String sEmail = (String) attributes.get("email");
		
		return OAuthAttributes.builder()
				.name(sName)
				.email(sEmail)
				.attributes(attributes)
				.nameAttributeKey(userNameAttributeName)
				.provider(registrationId) // Set provider
	            .providerId((String) attributes.get("id")) // Set provider ID
				.build();
	}

	private static OAuthAttributes ofKakao(String userNameAttributeName,
											Map<String, Object> attributes,
											String registrationId) 
	{
//		System.out.println(attributes);
		Map<String, Object> obj1 = (Map<String, Object>) attributes.get("kakao_account");
		String sName = (String) obj1.get("name");
		String sEmail = (String) obj1.get("email");
		String sId = String.valueOf(attributes.get("id"));
		
		return OAuthAttributes.builder()
				.name(sName)
				.email(sEmail)
				.attributes(attributes)
				.nameAttributeKey(userNameAttributeName)
				.provider(registrationId) // Set provider
	            .providerId(sId) // Set provider ID
				.build();
	}

	private static OAuthAttributes ofNaver(String userNameAttributeName,
											Map<String, Object> attributes,
											String registrationId) 
	{
//		System.out.println(attributes);
		Map<String, Object> obj1 = (Map<String, Object>) attributes.get("response");
		String sName = (String) obj1.get("name");
		String sEmail = (String) obj1.get("email");
		String sId = (String) obj1.get("id");

		return OAuthAttributes.builder()
				.name(sName)
				.email(sEmail)
				.attributes(attributes)
				.nameAttributeKey(userNameAttributeName)
				.provider(registrationId) // Set provider
	            .providerId(sId) // Set provider ID
				.build();
	}


    public UserDTO toDTO() {
        return UserDTO.builder()
        		.id(provider + "_" + providerId)
                .name(name)
                .email(email)
                .authority("ROLE_USER") // Set default authority
                .enabled(1) // Account is enabled by default
                .provider(provider) // 소셜 로그인 제공자 추가
                .providerId(providerId) // 소셜 로그인 제공자의 ID 추가
                .build();
    }
}
