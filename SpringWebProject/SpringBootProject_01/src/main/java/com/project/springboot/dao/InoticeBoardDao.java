package com.project.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.dto.noticeBoardDto;

@Mapper
public interface InoticeBoardDao
{
	public List<noticeBoardDto> listDao(Map<String, Object> map);
	public int totalCountDao(Map<String, Object> map);
	public noticeBoardDto viewDao(String idx);
	public int writeDao(@Param("id") String id, @Param("title") String title, @Param("content") String content , @Param("ofile")String ofile, @Param("sfile") String sfile);
	public int deleteDao(String idx);
	public int editorDao(@Param("idx") String idx, @Param("title") String title, @Param("content") String content , @Param("ofile") String ofile, @Param("sfile") String sfile, @Param("id") String id);
	public int viewCountDao(String idx);
	public int likeCountDao(String idx);
}
