package com.project.springboot;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.springboot.dao.BoardPage;
import com.project.springboot.dao.InoticeBoardDao;
import com.project.springboot.dao.InoticeCommentDao;
import com.project.springboot.dto.noticeBoardDto;
import com.project.springboot.dto.noticeCommentDto;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class noticeController {
	@Autowired
	ServletContext context;

	@Autowired
	InoticeBoardDao dao;

	@Autowired
	InoticeCommentDao cdao;

	@RequestMapping("/guest/noticeBoard") // 공지사항 list
	public String noticeBoard(HttpServletRequest request, Model model) {

		String searchField = request.getParameter("searchField");
		String searchWord = request.getParameter("searchWord");

		model.addAttribute("searchField", searchField);
		model.addAttribute("searchWord", searchWord);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchField", searchField);
		map.put("searchWord", searchWord);

		int totalCount = dao.totalCountDao(map);
		int pageSize = 10;
		int pageNum = 1;
		int blockPage = 5;
		String pageTemp = request.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;

		map.put("start", start);
		map.put("end", end);

		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../guest/noticeBoard",
				searchField, searchWord);

		List<noticeBoardDto> list = dao.listDao(map);

		model.addAttribute("list", list);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("blockPage", blockPage);
		model.addAttribute("pagingImg", pagingImg);

		return "guest/noticeBoard";
	}

	@RequestMapping("/admin/noticeWriteForm") // 공지사항 글쓰기 양식
	public String noticeWriteForm(Model model) {
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		model.addAttribute("userId", userId);

		return "admin/noticeWriteForm";
	}

	@RequestMapping("/admin/noticeWrite")
	public String noticeWrite(HttpServletRequest request, @RequestParam("file") MultipartFile file) throws Exception {
		String ofileName = file.getOriginalFilename();
		String uploadDir = context.getRealPath("/static/files");
		String sfileName = "";
		
		File dir = new File(uploadDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		sfileName = UUID.randomUUID().toString() + "_" + ofileName;

		File destination = new File(dir, sfileName);
		try {
			file.transferTo(destination);

		} catch (IOException e) {
			e.printStackTrace();
			return "redirect:/member/noticeWriteForm?status=fail";
		}

		String sId = SecurityContextHolder.getContext().getAuthentication().getName();

		dao.writeDao(sId, request.getParameter("title"), request.getParameter("content"), ofileName, sfileName);
		System.out.println(ofileName);
		System.out.println(sfileName);
		
		return "redirect:../guest/noticeBoard";
	}

	@RequestMapping("/guest/noticeView")
	public String noticeView(HttpServletRequest request, Model model) {
		String sIdx = request.getParameter("idx");
		noticeBoardDto dto = dao.viewDao(sIdx);
		model.addAttribute("dto", dto);
		dao.viewCountDao(sIdx);

		String ext = null, fileName = dto.getSfile();
		if (fileName != null) {
			ext = fileName.substring(fileName.lastIndexOf(".") + 1);
		}
		String[] mimeStr = { "png", "jpg", "gif", "PNG", "jpeg", "bmp" };
		List<String> mimeList = Arrays.asList(mimeStr);
		boolean isImage = false;
		if (mimeList.contains(ext)) {
			isImage = true;
		}
		model.addAttribute("isImage", isImage);

		// 댓글
		Map<String, Object> map = new HashMap<String, Object>();
		// 로그인 된 아이디 들고 옴
		String id = SecurityContextHolder.getContext().getAuthentication().getName();
		String content = request.getParameter("content");
		model.addAttribute("loginId", id);
		

		map.put("idx", sIdx);
		map.put("id", id);

		List<noticeCommentDto> list = cdao.listDao(map);
		model.addAttribute("list", list);

		return "guest/noticeView";
	}

	@RequestMapping("/member/noticeComment")
	public String noticeComment(HttpServletRequest request, Model model) {
		String idx = request.getParameter("idx");
		// 로그인 된 아이디 들고 옴
		String id = SecurityContextHolder.getContext().getAuthentication().getName();
		String content = request.getParameter("content1");

		cdao.writeDao(idx, id, content);

		String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
		return "redirect:" + referer; // 이전 페이지로 리다이렉트
	}

	
	  @RequestMapping("/member/noticeCommentDelete") 
	  public String noticeCommentDelete(HttpServletRequest request, Model model) { 
		  String coidx = request.getParameter("coidx"); 
		  cdao.deleteDao(coidx);
		  
		  String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다. 
		  return "redirect:"+ referer; // 이전 페이지로 리다이렉트 
	  }
	  	
	  @PostMapping("/guest/noticeCommentEditor")
	  public @ResponseBody String noticeCommentEditor(@RequestParam("coidx") String coidx, @RequestParam("content") String content) {
		Map<String, Object> map = new HashMap<>();
		map.put("coidx", coidx);
		map.put("content", content);
		cdao.editorDao(map);

		return "success"; // 이전 페이지로 리다이렉트
	}

	@RequestMapping("/admin/noticeEditorForm")
	public String noticeEditorForm(HttpServletRequest request, Model model) {
		String sIdx = request.getParameter("idx");
		noticeBoardDto dto = dao.viewDao(sIdx);

		model.addAttribute("dto", dto);
		model.addAttribute("existingOfile", dto.getOfile());
		model.addAttribute("existingSfile", dto.getSfile());

		return "admin/noticeEditorForm";
	}

	@RequestMapping("/admin/noticeEditor")
	public String noticeEditor(HttpServletRequest request, @RequestParam("file") MultipartFile file, Model model) {
		String sIdx = request.getParameter("idx");

		noticeBoardDto dto = dao.viewDao(sIdx);
		String ofileName = dto.getOfile();
		String sfileName = dto.getSfile();

		if (!file.isEmpty()) {
			ofileName = file.getOriginalFilename();
			sfileName = UUID.randomUUID().toString() + "_" + ofileName;
			String uploadDir = context.getRealPath("/static/files");

			File dir = new File(uploadDir);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			File destination = new File(dir, sfileName);
			try {
				file.transferTo(destination);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		model.addAttribute("dto", dao.editorDao(request.getParameter("idx"), request.getParameter("title"),
				request.getParameter("content"), ofileName, sfileName, request.getParameter("id")));
		System.out.println(ofileName);
		System.out.println(sfileName);

		return "redirect:../guest/noticeView?idx=" + sIdx;
	}

	@RequestMapping("/admin/noticeDelete")
	public String noticeDelete(HttpServletRequest request) {
		dao.deleteDao(request.getParameter("idx"));

		return "redirect:../guest/noticeBoard";
	}

	@RequestMapping("/guest/noticeLike")
	public String noticeLike(HttpServletRequest request, Model model) {
		String sIdx = request.getParameter("idx");
		dao.likeCountDao(sIdx);

		return "redirect:../guest/noticeBoard";
	}
}