package com.project.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class noticeCommentDto 
{
	private String coidx;
	private String idx;
	private String id;
	private String content;
	private Date postdate;
	private Date modifydate;
}
