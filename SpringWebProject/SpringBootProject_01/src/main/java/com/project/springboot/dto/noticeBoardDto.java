package com.project.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class noticeBoardDto
{
	private String idx;
	private String id;
	private String title;
	private String content;
	private Date postdate;
	private int viewCount;
	private int likeCount;
	private String ofile;
	private String sfile;
}
