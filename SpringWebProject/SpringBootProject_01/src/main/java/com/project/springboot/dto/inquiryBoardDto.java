package com.project.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class inquiryBoardDto {
	private String idx;
	private String parentIdx;
	private String id;
	private String parentId;
	private String title;
	private String content;
	private Date postDate;
	private int viewCount;
	private int responses;
	private String ofile;
	private String sfile;
	private String isAnnouncementAu;
	private String boardPass;
}
