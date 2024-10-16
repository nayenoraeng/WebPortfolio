package com.project.springboot;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.springboot.dao.BoardInfoCommentService;
import com.project.springboot.dto.BoardInfoCommentDto;

import jakarta.servlet.http.HttpServletRequest;
@Controller
public class BoardInfoCommentController {
	
	@Autowired
	private BoardInfoCommentService commentService;
	
	@RequestMapping("/member/writeComment") // 쓰기
	public String addComment(HttpServletRequest req, Model model) {
		String refGroup = req.getParameter("idx");
		String writer = SecurityContextHolder.getContext().getAuthentication().getName();
		String commentText = req.getParameter("commentText");
		BoardInfoCommentDto comment = new BoardInfoCommentDto();
		comment.setWriter(writer);
		comment.setCommentText(commentText);
		comment.setRefGroup(refGroup);
		
		commentService.writeComment(comment);
		return "redirect:/guest/boardInfoView?idx=" + refGroup;
	}
	
	@RequestMapping("/member/getCommentData")//View의 역할
	public String getCommentData(HttpServletRequest req, Model model) {
		String cIdx = req.getParameter("cidx");
		String refGroup = req.getParameter("refGroup");
		BoardInfoCommentDto dto = commentService.getCommentData(cIdx);
		model.addAttribute("cDto", dto);
		return "guest/boardInfoView?idx=" + refGroup;
	}
	
	@RequestMapping("/member/editComment") //수정하기
	public String editComment(HttpServletRequest req, Model model, RedirectAttributes redirectAttributes) {
		String cIdx = req.getParameter("cidx");
		String refGroup = req.getParameter("refGroup");
		String commentText = req.getParameter("commentText");
		BoardInfoCommentDto comment = commentService.getCommentData(cIdx);
		if (comment != null) {
			comment.setCommentText(commentText);
			commentService.editComment(comment);
		}
		model.addAttribute("cDto", comment);
		return "redirect:/guest/boardInfoView?idx=" + refGroup;
	}
	
	@RequestMapping("/member/deleteComment")
	public String deleteComment(HttpServletRequest req) {
		String cIdx = req.getParameter("cidx");
		String refGroup = req.getParameter("refGroup");
		BoardInfoCommentDto comment = commentService.getCommentData(cIdx);
		if (comment!=null) {
			commentService.deleteComment(req.getParameter("cidx"));
		}
		return "redirect:/guest/boardInfoView?idx=" + refGroup;
	}
	
}
