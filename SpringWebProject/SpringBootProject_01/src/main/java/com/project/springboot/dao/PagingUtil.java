package com.project.springboot.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.ui.Model;
import com.project.springboot.dto.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;

public class PagingUtil {
	
	public static void pagingAndSearch(HttpServletRequest req, Model model, ParameterDTO pDto, IMemberDao dao) {
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchField", searchField);
		map.put("searchWord", searchWord);
		
		int totalCount = dao.getTotalCount(pDto);
		int pageSize = 10;
		int blockPage = 5;
		
		int pageNum = (req.getParameter("pageNum")) == null || req.getParameter("pageNum").equals("")
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		
		pDto.setStart(start);
		pDto.setEnd(end);
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("totalCount", totalCount);
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps" , maps);
		
	    String pagingImg = BoardPage.pagingStr(totalCount, pageSize,
	              blockPage, pageNum, "../admin/list", searchField, searchWord);
	      
	    model.addAttribute("pagingImg" , pagingImg);
		
	}

}
