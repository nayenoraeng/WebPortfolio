package com.project.springboot.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.springboot.dto.inquiryBoardDto;

@Service
public class inquiryBoardSevice implements IinquiryBoardDao{

	@Autowired
	IinquiryBoardDao dao;
	
	@Override
	public List<inquiryBoardDto> listDao(Map<String, Object> map) {
		
		return dao.listDao(map);
	}

	@Override
	public int listCountDao(Map<String, Object> map) {
		
		return dao.listCountDao(map);
	}

	@Override
	public inquiryBoardDto viewDao(String idx) {
		
		return dao.viewDao(idx);
	}

	@Override
	public int writeDao(String id, String title, String content, String ofile, String sfile, String boardPass) {
		
		int nResult = dao.writeDao(id, title, content, ofile, sfile, boardPass);
		
		return nResult;
	}

	@Override
	public int deleteDao(String id) {
		int nResult = dao.deleteDao(id);
		
		return nResult;
	}

	@Override
	public int viewCountDao(String idx) {
		int nResult = dao.viewCountDao(idx);
		
		return nResult;
	}

	@Override
	public int responsesCountDao(String idx) {
		int nResult = dao.responsesCountDao(idx);
		
		return nResult;
	}

	@Override
	public int editorDao(Map<String, String> map) {
		int nResult = dao.editorDao(map);
		
		return nResult;
	}
	
	@Override
	public int replyWriteDao(Map<String, String> map) {
		int nResult = dao.replyWriteDao(map);
		
		return nResult;		
	}
	
	@Override
	public int changeBoardPass(String idx, String boardPass) {
		int nResult = dao.changeBoardPass(idx, boardPass);
		
		return nResult;
	}
	
}
