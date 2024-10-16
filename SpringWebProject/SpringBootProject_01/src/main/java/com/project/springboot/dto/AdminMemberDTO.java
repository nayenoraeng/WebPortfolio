package com.project.springboot.dto;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AdminMemberDTO {
	
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
	
	private List<String> searchField;
	private String searchKeyword;

}
