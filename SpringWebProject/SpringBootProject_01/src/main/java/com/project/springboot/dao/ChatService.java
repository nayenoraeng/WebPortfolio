package com.project.springboot.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.api.core.ApiFuture;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.ValueEventListener;
import com.project.springboot.dto.MessageDto;

@Service
public class ChatService {
	
	@Autowired
	private final DatabaseReference databaseReference;
	
	@Autowired 
    public ChatService(DatabaseReference databaseReference) {
        this.databaseReference = databaseReference;
    }
	
    public CompletableFuture<List<String>> getChatRoomList() {
    	System.out.println(11111);
        CompletableFuture<List<String>> futureChatRooms = new CompletableFuture<>();
        System.out.println(222);
        List<String> chatRooms = new ArrayList<>();
        DatabaseReference chatRoomsRef = databaseReference.child("chatRooms");

        chatRoomsRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot snapshot : dataSnapshot.getChildren()) {
                    chatRooms.add(snapshot.getKey());
                }
                futureChatRooms.complete(chatRooms);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
            	System.err.println("Firebase error: " + databaseError.getMessage()); // 로그 추가
                System.err.println("채팅방 리스트를 읽어오던 중 오류 발생 : " + databaseError.getMessage());
                futureChatRooms.completeExceptionally(new RuntimeException("채팅방 리스트를 읽어오던 중 오류 발생"));
            }
        });

        return futureChatRooms;
    }
    
    public void sendMessage(MessageDto message) {
        String chatRoomId = message.getChatRoomId();
        DatabaseReference chatRoomRef = databaseReference.child("chatRooms").child(chatRoomId); // Firebase 경로 설정
        
        Map<String, Object> messageMap = new HashMap<>();
        messageMap.put("sender", message.getSender());
        messageMap.put("message", message.getMessage());
        messageMap.put("timestamp", message.getTimestamp());
        messageMap.put("chatRoomId", message.getChatRoomId());
        
        Map<String, Boolean> unreadStatus = new HashMap<>();
        unreadStatus.put("admin", true); // admin이 메세지를 보기 전
        
        messageMap.put("unreadStatus", unreadStatus);
        
        chatRoomRef.push().setValueAsync(messageMap);
    }

    public CompletableFuture<List<MessageDto>> getMessagesByChatRoomId(String chatRoomId) {
        CompletableFuture<List<MessageDto>> futureMessages = new CompletableFuture<>();
        List<MessageDto> messages = new ArrayList<>();
        DatabaseReference chatRoomRef = databaseReference.child("chatRooms").child(chatRoomId);

        chatRoomRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot snapshot : dataSnapshot.getChildren()) {
                    MessageDto message = snapshot.getValue(MessageDto.class);
                    messages.add(message);
                }
                futureMessages.complete(messages);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                System.err.println("채팅방 메세지를 읽어오던 중 오류 발생 : " + databaseError.getMessage());
                futureMessages.completeExceptionally(new RuntimeException("채팅방 메세지를 읽어오던 중 오류 발생"));
            }
        });

        return futureMessages;
    }

    public void deleteChatRoom(String chatRoomId) {
        DatabaseReference chatRoomRef = databaseReference.child("chatRooms").child(chatRoomId);

        // 비동기 작업 수행
        ApiFuture<Void> future = chatRoomRef.removeValueAsync();

        // 비동기 작업 완료 대기
        try {
            future.get(); // 성공적으로 완료되면 아무것도 하지 않음
            System.out.println("Chat room deleted successfully.");
        } catch (Exception e) {
            System.err.println("Failed to delete chat room: " + e.getMessage());
        }
    }
	
}
