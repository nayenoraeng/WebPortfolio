package com.project.springboot.dto;

import java.sql.Timestamp;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
	

	private String id;
	private String pass;
	private String name;
	private String phoneNum;
	private String email;
	private String postcode;
	private String address;
	private String detailaddress;
	private Date regidate;
	private String authority;
	private int enabled;
	private String provider;
	private String providerId;
	private int isLock;
	private int failCount;
	private Timestamp lockTime;


}
