package com.project.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.dto.BoardInfoDto;
import com.project.springboot.dto.ParameterDTO;

@Mapper
public interface IBoardInfoDao {
	public List<BoardInfoDto> listDao(Map<String, Object> maps);
	public BoardInfoDto viewDao(String idx);
	public int writeDao(@Param("id") String id, @Param("title") String title, @Param("content") String content,
						 @Param("ofile") String ofile, @Param("sfile")String sfile);
	public int editDao(@Param("idx") String idx, @Param("id") String id, @Param("title") String title, 
						@Param("content") String content, @Param("ofile") String ofile, @Param("sfile")String sfile);
	public int deleteDao(String idx);
	public int updateViewCount(String idx);
	public int addLike(@Param("idx")String idx);	
	public int getTotalCount(Map<String, Object> maps);
}
