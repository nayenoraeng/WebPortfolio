package com.project.springboot.dto;

import lombok.Data;

@Data
public class RestMap {
	
	private String id;//문서 id
	private String pname;// 장소이름
	private String addr1;//주소1 - 구 
	private String addr2; //주소2 - 도로명주소
	private Double x_wgs84;//x 축 좌표
	private Double y_wgs84; //y 축 좌표
	private String phonenum;//전화번호
	private String ptype;// 장소 유형 - 공공기관, 공중화장실, 개방 화장실, 기타등등
	private String optime; // 운영시간
	private String btype;// 건물유형 - 지하철, 공원, 주유소, 빌딩, 기타
	private String detail1; //상세정보 -변기 수, 장애인 용 화장실 유무 등
	private String detail2; //상세정보2 - 시설정보 -손건조기, 아이용 기저귀 갈이, 비상벨 etc
	private double distance; // 목적지와의 거리 비교를 위한 변수
}
