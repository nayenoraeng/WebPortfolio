package com.project.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.dto.noticeCommentDto;

@Mapper
public interface InoticeCommentDao 
{
	//댓글 불러오기
	public List<noticeCommentDto> listDao(Map<String, Object> map);
	//댓글 작성
	public int writeDao(String idx, String id, String content);
	//댓글삭제
    public int deleteDao(String coidx) ;
	//댓글수정
	public int editorDao(Map<String, Object> map);
	
}
