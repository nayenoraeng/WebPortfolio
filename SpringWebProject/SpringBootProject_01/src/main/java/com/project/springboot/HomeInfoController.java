package com.project.springboot;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeInfoController {
	
	@RequestMapping("/guest/homeInfo")
	public String homeInfo(Model model) {
		return "guest/homeInfo";
	}
	
	 @GetMapping("/{filename}")
	    @ResponseBody
	    public ResponseEntity<Resource> getImage(@PathVariable String filename) {
	        try {
	            Resource resource = new ClassPathResource("static/images/" + filename);

	            if (resource.exists() || resource.isReadable()) {
	                return ResponseEntity.ok()
	                        .header(HttpHeaders.CONTENT_TYPE, "image/jpeg") // 파일 타입에 따라 조정
	                        .body(resource);
	            } else {
	                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
	            }
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	        }
	    }

}
