package com.project.springboot;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.dao.FirebaseMapService;
import com.project.springboot.dto.EleMap;
import com.project.springboot.dto.EleMap2;
import com.project.springboot.dto.RestMap;
import com.project.springboot.dto.RestMap2;

@Controller
public class FirebaseMapController {
	
	 @Autowired private FirebaseMapService firebaseMapService;
	 

	/*@RequestMapping("/guest/restMap")
	public String getNearbyRestData(@RequestParam(value="centerX", required=false) Double centerX,
			@RequestParam(value="centerY", required=false) Double centerY,
			@RequestParam(value="radius", defaultValue = ".03") double radius, Model model) {
		if (centerX == null||centerY==null) {

			centerX = 127.0016;
			centerY = 37.5642;
		}
		try {
			List<RestMap> restDataList = firebaseMapService.getNearbyRestrooms(centerX, centerY, radius);
			// optime 필드만 URL 인코딩 처리
			for (RestMap item : restDataList) {
				item.setOptime(encodeString(item.getOptime())); 
			}
			model.addAttribute("restDataList", restDataList);
		} catch (Exception e) {
			e.printStackTrace();		
		}
		
		return "guest/restMap";
	} */

	/*@RequestMapping("/guest/eleMap")
	public String getNearbyEleData(@RequestParam(value="centerX", required=false) Double centerX,
								@RequestParam(value="centerY", required=false) Double centerY,
								@RequestParam(value="radius", defaultValue = ".03") double radius, Model model) {
		if (centerX == null||centerY==null) {
			centerX = 127.0016;
			centerY = 37.5642;
		}
		try {
			 List<EleMap> eleDataList = firebaseMapService.getNearbyElevators(centerX, centerY, radius);
			 System.out.println("eleDataList: " + eleDataList);
			 model.addAttribute("eleDataList", eleDataList);
		} catch (Exception e) {
			e.printStackTrace();		
		}
		
		return "guest/eleMap";
	}*/

	private String encodeString(String value) {
		try {
			return URLEncoder.encode(value, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return value;
		}
	}

//	@GetMapping("/admin/insertRestInfo")
//	public String insertRestInfo(@RequestParam RestMap restMap) throws InterruptedException, ExecutionException {
//		return firebaseMapService.insertRestMap(restMap);
//	}
//	
//	@GetMapping("/admin/updateRestInfo")
//	public String updateRestInfo(@RequestParam RestMap restMap) throws InterruptedException, ExecutionException {
//		return firebaseMapService.updateRestMap(restMap);
//	}
//	
//	@GetMapping("/admin/deleteRestInfo")
//	public String deleteRestInfo(@RequestParam String pname) throws InterruptedException, ExecutionException {
//		return firebaseMapService.deleteRestMap(pname);
//	}
//
//	@GetMapping("/admin/insertRestInfo")
//	public String insertEleInfo(@RequestParam EleMap eleMap) throws InterruptedException, ExecutionException {
//		return firebaseMapService.insertEleMap(eleMap);
//	}
//	
//	@GetMapping("/admin/updateRestInfo")
//	public String updateEleInfo(@RequestParam EleMap eleMap) throws InterruptedException, ExecutionException {
//		return firebaseMapService.updateEleMap(eleMap);
//	}
//	
//	@GetMapping("/admin/deleteRestInfo")
//	public String deleteEleInfo(@RequestParam String sbwy_stn_nm) throws InterruptedException, ExecutionException {
//		return firebaseMapService.deleteEleMap(sbwy_stn_nm);
//	}
//	

}
