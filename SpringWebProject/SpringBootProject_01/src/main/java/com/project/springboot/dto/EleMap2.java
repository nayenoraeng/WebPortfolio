package com.project.springboot.dto;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;

@Data
@Document(collection="elemap")
public class EleMap2 {
	@Id
	private ObjectId id;
	private String sbwy_stn_nm;//sbwy_stn_name 지하철명
	private String sbwy_stn_cd;//sbwy_stn_cd 지하철 코드
	private String sgg_cd;//sgg_cd 시군구 코드
	private String emd_nm;//emd_nm 읍면동 이름
	private String node_wkt;//node_wkt 위도 경도 코드
	private String node_type_cd;//node_cd 노드 코드 0- 일반, 1-지하철 출입구, 2- 버스정류장, 3- 지하보도 출입구
	private String sgg_nm;//sgg_nm 시군구이름
	private Double x_wgs84; //좌표
	private Double y_wgs84; //좌표
	private double distance;
	
	public EleMap2() {};
}
