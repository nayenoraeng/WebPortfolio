package com.project.springboot.dto;

import lombok.Data;

@Data
public class RoomDto {
    private String id;          // 방의 고유 ID
    private String name;        // 방 이름
    private String creator;     // 방을 만든 사용자
    private long timestamp;     // 방이 만들어진 시간
}
