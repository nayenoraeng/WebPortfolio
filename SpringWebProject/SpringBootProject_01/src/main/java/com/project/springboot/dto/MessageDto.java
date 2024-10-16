package com.project.springboot.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MessageDto {
    private String sender;
    private String message;
    private long timestamp;
    private String chatRoomId;
    private Map<String, Boolean> unreadStatus;
    
  
}
