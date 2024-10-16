package com.project.springboot.dto;

import lombok.Data;

@Data
public class BoardInfoDto {
	private int idx;
	private String id;
	private String title;
	private String content;
	private java.sql.Date postdate;
	private int viewCount;
	private int likeCount;
	private String ofile;
	private String sfile;
	private String isAnnouncement;
}
