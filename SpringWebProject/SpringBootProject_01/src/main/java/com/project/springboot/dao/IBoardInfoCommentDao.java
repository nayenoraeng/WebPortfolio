package com.project.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.dto.BoardInfoCommentDto;

@Mapper
public interface IBoardInfoCommentDao {
	public List<BoardInfoCommentDto> listComment(String refGroup);
	public int writeComment(BoardInfoCommentDto comment);
	public int editComment(BoardInfoCommentDto comment);
	public int deleteComment(String idx);
	public BoardInfoCommentDto getCommentData(String idx);
	
}
