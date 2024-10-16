package com.project.springboot.dao;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.project.springboot.dto.EleMap2;
import com.project.springboot.dto.RestMap2;

@Service
public class MapServiceMongoDB implements IMapServiceMongoDB {
	@Autowired
	private MongoTemplate mongoTemplate;
	
    public List<RestMap2> getNearbyRestData(double centerX, double centerY, double radius) {
        double lowerX = centerX - radius;
        double lowerY = centerY - radius;
        double upperX = centerX + radius;
        double upperY = centerY + radius;
        System.out.println("centerX and Y in service: " + centerX + " " + centerY );
        Query query = new Query();
        query.addCriteria(Criteria.where("x_wgs84").gte(lowerX).lte(upperX));
        query.addCriteria(Criteria.where("y_wgs84").gte(lowerY).lte(upperY));
   
        List<RestMap2> restrooms = mongoTemplate.find(query, RestMap2.class, "restmap");
   
        for (RestMap2 restroom : restrooms) {
            double x = restroom.getX_wgs84();
            double y = restroom.getY_wgs84();
            double distance = haversine(centerX, centerY, x, y);
            restroom.setDistance(distance);
        }

        restrooms.sort(Comparator.comparingDouble(RestMap2::getDistance));
        
        Set<RestMap2> uniqueRestrooms = new HashSet<>(restrooms);
        restrooms = new ArrayList<>(uniqueRestrooms);

        return restrooms.subList(0, Math.min(50, restrooms.size()));
    }

    public List<EleMap2> getNearbyEleData(double centerX, double centerY, double radius) {
        List<EleMap2> elevators = new ArrayList<>();

        double lowerX = centerX - radius;
        double lowerY = centerY - radius;
        double upperX = centerX + radius;
        double upperY = centerY + radius;

        Query query = new Query();
        query.addCriteria(Criteria.where("x_wgs84").gte(lowerX).lte(upperX));
        query.addCriteria(Criteria.where("y_wgs84").gte(lowerY).lte(upperY));

        elevators = mongoTemplate.find(query, EleMap2.class, "elemap");

        for (EleMap2 elevator : elevators) {
            double x = elevator.getX_wgs84();
            double y = elevator.getY_wgs84();
            double distance = haversine(centerX, centerY, x, y);
            elevator.setDistance(distance);
        }

        elevators.sort(Comparator.comparingDouble(EleMap2::getDistance));

        return elevators.subList(0, Math.min(50, elevators.size()));
    }
	
    private double haversine(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // 지구 반지름 (km)
        double latDistance = Math.toRadians(lat2 - lat1);
        double lonDistance = Math.toRadians(lon2 - lon1);
        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                + Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;
    }

}
