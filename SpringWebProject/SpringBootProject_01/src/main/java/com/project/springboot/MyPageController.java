package com.project.springboot;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.springboot.dao.IMemberDao;
import com.project.springboot.dto.UserDTO;
import com.project.springboot.oauth2.SessionUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageController {
	
	@Autowired
	IMemberDao member;
	@Autowired
	UserService sev;
	
		
	@RequestMapping("/member/myPageView")
	public String myPageView(
			Principal principal, Model model, HttpSession session)
	{
		String loginId = principal.getName();
		SessionUser user = (SessionUser) session.getAttribute("user");
		    
		UserDTO dto = null;
		boolean isNormalUser = false;

		if(user !=null && user.getProviderId() != null) {
		        // 소셜 로그인 처리
		    dto = member.findBySocailrname(null, user.getProviderId());
		} 
		else {
		    // 일반 로그인 처리
		    dto = member.findBySocailrname(loginId, null);
		    isNormalUser = true;
		}
		   
		    
		model.addAttribute("dto", dto);
		model.addAttribute("isNormalUser", isNormalUser);
		    
		return "member/myPageView";
	}
	
	
	
	@RequestMapping("/member/myPageEdit")
	public String myPageEdit(Principal principal, Model model,  HttpSession session)
	{
		String loginId = principal.getName();
		SessionUser user = (SessionUser) session.getAttribute("user");
		    
		    UserDTO dto = null;

		    if(user !=null && user.getProviderId() != null) {
		        // 소셜 로그인 처리
		        dto = member.findBySocailrname(null, user.getProviderId());
		    } 
		    else {
		        // 일반 로그인 처리
		        dto = member.findBySocailrname(loginId, null);
		    }
		   
		    
		model.addAttribute("dto", dto);
		return "member/myPageEdit";
	}
	
	
	@PostMapping("/member/myPageUpdate")
	public String editMemberInfo(Principal principal, HttpServletRequest req, Model model,
			HttpSession session) {
		String loginId = principal.getName();
		SessionUser user = (SessionUser) session.getAttribute("user");
		    
		    UserDTO updatedto = null;

		    if(user !=null && user.getProviderId() != null) {
		        // 소셜 로그인 처리
		    	updatedto = member.findBySocailrname(null, user.getProviderId());
		        model.addAttribute("dto", member.socialeditDao(req.getParameter("name"),
						req.getParameter("phoneNum"),
						req.getParameter("email"),
						req.getParameter("postcode"),
						req.getParameter("address"),
						req.getParameter("detailaddress"),
						user.getProviderId())
		        		);
		    } 
		    else {
		        // 일반 로그인 처리
		    	updatedto = member.findBySocailrname(loginId, null);
		        model.addAttribute("dto", member.editDao(req.getParameter("name"),
						req.getParameter("phoneNum"),
						req.getParameter("email"),
						req.getParameter("postcode"),
						req.getParameter("address"),
						req.getParameter("detailaddress"),
						loginId)
		        		);
		    }
		    

		    model.addAttribute("msg", "회원님의 정보 수정이 완료되었습니다.");
            model.addAttribute("url", "/member/myPageView");
		
		return "guest/alert";
	}
	
	@PostMapping("/member/memberDelete")
    public String deactivateMember(@RequestParam("id") String id, Model model, HttpServletRequest request) {
        try {
            sev.deactivateMember(id);
            model.addAttribute("msg", "회원 탈퇴가 완료되었습니다.");
            model.addAttribute("url", "/");
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // 세션 무효화
            }
        } catch (Exception e) {
        	model.addAttribute("msg", "회원 탈퇴 중 오류가 발생했습니다.");
        	model.addAttribute("url", "/member/myPageView");
        }
        return "guest/alert";
    }
	
	@GetMapping("/member/pwUpdateView")
	public String pwUpdateView(Model model, Principal principal) {
		
		String id = principal.getName();
		
		 model.addAttribute("id", id);
		return "member/myPagePass";
	}
	
	@PostMapping("/member/changePassword")
    public String changePassword(
            @RequestParam("id") String id,
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpServletRequest request, Model model, Principal principal) {
		
		String loginid = principal.getName();
		model.addAttribute("id", loginid);

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
            return "member/myPagePass"; // 비밀번호 변경 폼 JSP 페이지
        }

        int rowsAffected = sev.changePassword(id, currentPassword, newPassword);

        if (rowsAffected > 0) {
        	
        	HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // 세션 무효화
            }
            model.addAttribute("msg", "비밀번호가 성공적으로 변경되었습니다. 다시 로그인해 주세요.");
            model.addAttribute("url", "/");  // 메인 페이지로 리디렉션
            return "guest/alert";
        } else {
            // 비밀번호 변경 실패 시 에러 메시지 추가
            model.addAttribute("error", "현재 비밀번호가 올바르지 않습니다.");
            return "member/myPagePass";
        }
    }

	
	
	
	
}