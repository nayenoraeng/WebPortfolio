package com.project.springboot.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.project.springboot.dto.BoardInfoCommentDto;

@Service
public class BoardInfoCommentService {
 
	@Autowired private IBoardInfoCommentDao commentDao;
 
 	public List<BoardInfoCommentDto> listComment(String refGroup) { 
 		return commentDao.listComment(refGroup); 
	}

 	public void writeComment(BoardInfoCommentDto comment) { 
 		commentDao.writeComment(comment); 
 	}
 
 	public void editComment(BoardInfoCommentDto comment) {
 		commentDao.editComment(comment);
 	}

	public void deleteComment(String cIdx) {
		commentDao.deleteComment(cIdx);
	}
	
	public BoardInfoCommentDto getCommentData(String cIdx) {
		return commentDao.getCommentData(cIdx);
	}
}

