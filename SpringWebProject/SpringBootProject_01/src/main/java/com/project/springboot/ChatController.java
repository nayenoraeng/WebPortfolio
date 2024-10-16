package com.project.springboot;

import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.dao.ChatService;
import com.project.springboot.dto.MessageDto;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ChatController {
	
	@Autowired
    private ChatService chatService;
	
	// 채팅방 전 확인 팝업
	@RequestMapping("member/chatPopup")
	public String chatPopup(Model model) {
		String sId = SecurityContextHolder.getContext().getAuthentication().getName();
		
		model.addAttribute("Id", sId);
		return "member/chatPopup";
	}
	
	// 채팅방
	@RequestMapping("member/chatRoom")
	public CompletableFuture<Object> chatRoom(HttpServletRequest request, Model model)
	{
		String sId = SecurityContextHolder.getContext().getAuthentication().getName();
		String chatRoomId = request.getParameter("chatRoomId");
	    model.addAttribute("Id", sId); // 로그인된 아이디
	    model.addAttribute("chatRoomId", chatRoomId);
	    
	    return chatService.getMessagesByChatRoomId(chatRoomId)
	            .thenApply(messages -> {
	                model.addAttribute("messages", messages);
	                return "member/chatRoom";
	            });
	}
	
	// 메세지 보내는 기능
	@PostMapping("member/chatRoom/send")
	public ResponseEntity<MessageDto> sendMessage(@RequestBody MessageDto message) {
		chatService.sendMessage(message);
	    return ResponseEntity.ok(message);
	}
	
	// 관리자 전용 채팅방리스트
	@GetMapping("admin/chatRoomList")
	public CompletableFuture<String> chatRoomList(Model model) {
	    return chatService.getChatRoomList()
	        .thenApply(chatRooms -> {
	            model.addAttribute("chatRooms", chatRooms);
	            return "admin/chatRoomList"; // chatRoomList.jsp 페이지로 이동
	        });
	}
	
	 @DeleteMapping("member/chatRoom/deleteChatRoom")
	    public ResponseEntity<String> deleteChatRoom(HttpServletRequest request) {
	        try {
		    		String chatRoomId = request.getParameter("chatRoomId");
		            chatService.deleteChatRoom(chatRoomId);
		            
	            return ResponseEntity.ok("채팅방이 성공적으로 삭제되었습니다.");
	        } catch (Exception e) {
	            return ResponseEntity.status(500).body("채팅방 삭제에 실패했습니다: " + e.getMessage());
	        }
	    }
}
