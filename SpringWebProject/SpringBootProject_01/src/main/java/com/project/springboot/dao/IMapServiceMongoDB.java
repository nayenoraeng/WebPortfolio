package com.project.springboot.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.project.springboot.dto.EleMap2;
import com.project.springboot.dto.RestMap2;

@Repository
public interface IMapServiceMongoDB {
	List<RestMap2> getNearbyRestData(double lowerX, double upperX, double radius);
	List<EleMap2> getNearbyEleData(double lowerX, double upperX, double radius);
}
