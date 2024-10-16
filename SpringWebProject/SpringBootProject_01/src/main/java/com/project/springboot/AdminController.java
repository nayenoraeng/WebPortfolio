package com.project.springboot;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.springboot.dao.BoardPage;
import com.project.springboot.dao.IMemberDao;
import com.project.springboot.dao.PagingUtil;
import com.project.springboot.dto.AdminMemberDTO;
import com.project.springboot.dto.AdminService;
import com.project.springboot.dto.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminController {
	@Autowired
	AdminService admindao;
	@Autowired
	UserService userService;
	@Autowired
	IMemberDao dao;
	
	
	//회원 전체목록 보기
	@RequestMapping("/admin/list")
	public String userListPage(HttpServletRequest req, Model model, ParameterDTO pDto)
	{		
		PagingUtil.pagingAndSearch(req, model, pDto, dao);
		
		List<AdminMemberDTO> lists = admindao.userListPage(pDto);
		model.addAttribute("lists", lists);
		
		return "admin/userlist";
	}
	
	//일반회원 목록 보기
	@RequestMapping("/admin/localList")
	public String localuserListPage(HttpServletRequest req, Model model, ParameterDTO pDto)
	{		
			
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchField", searchField);
		map.put("searchWord", searchWord);
		
		int totalCount = admindao.getTotalCountLocal(pDto);
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
		
	    String pagingImgs = BoardPage.pagingStr(totalCount, pageSize,
	              blockPage, pageNum, "../admin/localList", searchField, searchWord);
	    
	    
	    model.addAttribute("pagingImgs" , pagingImgs);
	    
	    List<AdminMemberDTO> list1 = admindao.localMemList(pDto);
	    model.addAttribute("list1", list1);
		
		return "admin/LocalList";
	}
	
	//소셜회원 목록 보기
	@RequestMapping("/admin/socialList")
	public String socialUserListPage(HttpServletRequest req, Model model, ParameterDTO pDto)
	{		
			
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchField", searchField);
		map.put("searchWord", searchWord);
		
		int totalCount = admindao.getTotalCountSocial(pDto);
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
		
	    String pagingImg1 = BoardPage.pagingStr(totalCount, pageSize,
	           blockPage, pageNum, "../admin/socialList", searchField, searchWord);
		    
		    
	    model.addAttribute("pagingImg1" , pagingImg1);
		    
	    List<AdminMemberDTO> list2 = admindao.SocialMemList(pDto);
	    model.addAttribute("list2", list2);
			
		return "admin/SocialList";
	}
		
	//잠금회원 목록 보기
	@RequestMapping("/admin/LockList")
	public String lockUserListPage(HttpServletRequest req, Model model, ParameterDTO pDto)
	{		
					
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchField", searchField);
		map.put("searchWord", searchWord);
			
		int totalCount = admindao.getTotalCountLock(pDto);
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
					
		String pagingImg2 = BoardPage.pagingStr(totalCount, pageSize,
			blockPage, pageNum, "../admin/LockList", searchField, searchWord);
				    
			    
		model.addAttribute("pagingImg2" , pagingImg2);
				    
		List<AdminMemberDTO> list3 = admindao.LockMemList(pDto);
		model.addAttribute("list3", list3);
					
		return "admin/LockList";
	}

	//비활성화회원 목록 보기
	@RequestMapping("/admin/enabledList")
	public String EnabledUserListPage(HttpServletRequest req, Model model, ParameterDTO pDto)
	{		
					
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchField", searchField);
		map.put("searchWord", searchWord);
			
		int totalCount = admindao.getTotalCountEnabled(pDto);
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
					
		String pagingImg3 = BoardPage.pagingStr(totalCount, pageSize,
			blockPage, pageNum, "../admin/enabledList", searchField, searchWord);
				    
			    
		model.addAttribute("pagingImg3" , pagingImg3);
				    
		List<AdminMemberDTO> list4 = admindao.EnabledMemList(pDto);
		model.addAttribute("list4", list4);
					
		return "admin/EnabledList";
	}
	
	
	
	//회원 개인정보 상세 보기
	@RequestMapping(value="admin/userEdit", method=RequestMethod.GET)
	public String memberView(HttpServletRequest req, AdminMemberDTO adminMemberDTO, Model model) 
	{
		adminMemberDTO = admindao.selectOne(req.getParameter("id"));
		model.addAttribute("dto", adminMemberDTO);
		return "admin/userEdit";
	}
	//소셜 개인정보 상세 보기
	@RequestMapping(value="admin/socialUserEdit", method=RequestMethod.GET)
	public String socialView(HttpServletRequest req, AdminMemberDTO adminMemberDTO, Model model) 
	{
	    adminMemberDTO = admindao.selectOneSocial(req.getParameter("providerId"));
	    model.addAttribute("dto", adminMemberDTO);
		return "admin/socialUserEdit";
	}
	
	//권한 수정
	@PostMapping("/admin/updateAuth")
    public ModelAndView updateUserAuthority(@RequestParam(value="id") String id,
                                            @RequestParam(value="authority") String authority) {
        try {
            userService.updateUserAuth(id, authority);
        } catch (RuntimeException e) {
            // 예외 처리 및 사용자에게 오류 메시지 전달
        	 return new ModelAndView("security/AdminUpdateError");
        }
        return new ModelAndView("redirect:/admin/list");
    }
	
	//회원 활성화 비활성화 수정
	@PostMapping("/admin/updateEnabled")
    public ModelAndView updateUseEnabled(@RequestParam(value="id") String id,
                                            @RequestParam(value="enabled") int enabled) {
        try {
            userService.updateEnabled(id, enabled);
        } catch (RuntimeException e) {
            // 예외 처리 및 사용자에게 오류 메시지 전달
            return new ModelAndView("security/AdminUpdateError");
        }
        return new ModelAndView("redirect:/admin/list");
    }
	
	//잠금 수정
	@PostMapping("/admin/updateLock")
    public ModelAndView updateUserlock(@RequestParam(value= "id") String id,
                                            @RequestParam(value= "isLock") int isLock) {
        try {
            userService.updateLock(id, isLock);
        } catch (RuntimeException e) {
            // 예외 처리 및 사용자에게 오류 메시지 전달
        	 return new ModelAndView("security/AdminUpdateError");
        }
        return new ModelAndView("redirect:/admin/list");
    }
}
