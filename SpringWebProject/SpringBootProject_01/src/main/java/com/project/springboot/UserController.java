package com.project.springboot;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.springboot.dto.UserDTO;

import jakarta.servlet.http.HttpServletRequest;



@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/guest/joinform")
	public String joinform(Model model) {
		model.addAttribute("userDTO", new UserDTO());
		return "guest/joinform";
	}
	
	//회원가입
	@PostMapping("/guest/join")
	public String join(HttpServletRequest request, UserDTO user) {
		String sId = request.getParameter("id");
		String sPass = request.getParameter("pass");
		String sName = request.getParameter("name");
		String sPhoneNum = request.getParameter("phoneNum");
		String sEmail = request.getParameter("email");
		String sPostcode = request.getParameter("postcode");
		String sAddress = request.getParameter("address");
		String sDetailaddress = request.getParameter("detailaddress");

		
		user.setId(sId);
		user.setPass(sPass);
		user.setName(sName);
		user.setPhoneNum(sPhoneNum);
		user.setEmail(sEmail);
		user.setPostcode(sPostcode);
		user.setAddress(sAddress);
		user.setDetailaddress(sDetailaddress);
		user.setRegidate(new Date());
	
		int nResult = userService.joinDao(user);
		
		if (nResult > 0) {
			request.setAttribute("msg", "회원가입에 성공하셨습니다!");
			request.setAttribute("url", "/");
			return "guest/alert";// 성공 시
        } else {
        	request.setAttribute("msg", "회원가입에 실패하셨습니다.");
			request.setAttribute("url", "/guest/joinform");
            return "guest/alert"; // 실패 시 다시 폼 페이지로 이동
        }
	}
	
	@PostMapping("/guest/idCheck")
	@ResponseBody
	public boolean isIdCheck(@RequestParam(value ="id") String id) {
		
		boolean result = userService.isUserIdCheck(id);
		return result;
	}
	
    @RequestMapping("/security/loginform")
    public String loginform(Model model,  @RequestParam(value="error", required = false) String error,
            @RequestParam(value = "exception", required = false) String exception, HttpServletRequest request){
    	
    	// 현재페이지 요청하기 전 마지막으로 방문했던 페이지 정보 갖고오기
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.contains("/security/loginform")) {
            request.getSession().setAttribute("prevPage", referer);
        }
    	
        //로그인 오류 예외 처리 보내기
    	model.addAttribute("userDTO", new UserDTO());
    	model.addAttribute("error", error);
        model.addAttribute("exception", exception);
        return "security/loginform";
    }  

        
    //권한요청 실패시 뜨는 화
    @RequestMapping("/denied")
    public String login2() {
    	return "security/denied";
    }
    

}
