package com.project.springboot;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.springboot.dao.MapServiceMongoDB;
import com.project.springboot.dto.EleMap2;
import com.project.springboot.dto.RestMap2;

@Controller
public class MapControllerMongoDB {
	@Autowired
	public MapServiceMongoDB mapService;
	
	@RequestMapping("guest/restMap")
	public String restMap()
	{
		return "guest/restMap";
	}
	
	@RestController
	public class getNearbyRestData2 {
	    @RequestMapping(value = "/guest/restMap1", method = RequestMethod.POST)
	    @ResponseBody
	    public List<RestMap2> getNearbyRestData(
	            @RequestParam(value="centerX", required=false) Double centerX,
	            @RequestParam(value="centerY", required=false) Double centerY,
	            @RequestParam(value="radius", defaultValue = ".03") double radius) {
	       
	        if (centerX == null || centerY == null) {
	            centerX = 127.0016;
	            centerY = 37.5642;
	        }
	        try {
	            List<RestMap2> restDataList = mapService.getNearbyRestData(centerX, centerY, radius);
	            // optime 필드만 URL 인코딩 처리
	            for (RestMap2 item : restDataList) {
	                item.setOptime(encodeString(item.getOptime()));
	            }
	            return restDataList;  // JSON 형식으로 반환
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            return new ArrayList<>();  // 오류 발생 시 빈 배열 반환
	        }
	    }
	}
	
	@RequestMapping("guest/eleMap") 
	 public String eleMap() 
	 {
		 return "guest/eleMap";
	 }
	 
	 @RestController
	 public class getNearbyEleData2 {
		    @RequestMapping(value = "/guest/eleMap1", method = RequestMethod.POST)
		    @ResponseBody
		    public List<EleMap2> getNearbyEleData(
		            @RequestParam(value="centerX", required=false) Double centerX,
		            @RequestParam(value="centerY", required=false) Double centerY,
		            @RequestParam(value="radius", defaultValue = ".03") double radius) {
		       
		        if (centerX == null || centerY == null) {
		            centerX = 127.0016;
		            centerY = 37.5642;
		        }
		        try {
		            List<EleMap2> eleDataList = mapService.getNearbyEleData(centerX, centerY, radius);
		            
		            return eleDataList;  // JSON 형식으로 반환
		        } catch (Exception e) {
		            e.printStackTrace();
		            return new ArrayList<>();  // 오류 발생 시 빈 배열 반환
		        }
		    }
		}
	 
	private String encodeString(String value) {
        try {
            return URLEncoder.encode(value, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return value;
        }
    }
}
