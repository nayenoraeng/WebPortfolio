package com.project.springboot.dao;

import java.util.List;
import java.util.concurrent.ExecutionException;

import com.project.springboot.dto.EleMap;
import com.project.springboot.dto.RestMap;

public interface IFirebaseMapService {
	public List<RestMap> getNearbyRestrooms(double centerX, double centerY, double radius) throws InterruptedException, ExecutionException;
	public List<EleMap> getNearbyElevators(double centerX, double centerY, double radius) throws InterruptedException, ExecutionException;
	
//	public String insertRestMap(RestMap restMap) throws InterruptedException, ExecutionException;
//	public String updateRestMap(RestMap restMap) throws InterruptedException, ExecutionException;
//	public String deleteRestMap(String pname);
//	
//	public String insertEleMap(EleMap eleMap) throws InterruptedException, ExecutionException;
//	public String updateEleMap(EleMap eleMap) throws InterruptedException, ExecutionException;
//	public String deleteEleMap(String fname);
	
}
