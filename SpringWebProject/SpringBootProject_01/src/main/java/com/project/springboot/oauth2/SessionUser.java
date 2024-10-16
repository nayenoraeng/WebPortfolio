package com.project.springboot.oauth2;

import java.io.Serializable;

import com.project.springboot.dto.UserDTO;

import lombok.Getter;

@Getter
public class SessionUser implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String authority;
	private int enabled;
	private String providerId;

	public SessionUser(UserDTO userDTO) {
		this.id = userDTO.getId();
        this.authority = userDTO.getAuthority();
        this.enabled = userDTO.getEnabled();
        this.providerId = userDTO.getProviderId();
	}
	
	@Override
    public String toString() {
        return "SessionUser{" +
                "id='" + id + '\'' +
                ", authority='" + authority + '\'' +
                ", enabled=" + enabled +
                ", providerId='" + providerId + '\'' +
                '}';
    }
}
