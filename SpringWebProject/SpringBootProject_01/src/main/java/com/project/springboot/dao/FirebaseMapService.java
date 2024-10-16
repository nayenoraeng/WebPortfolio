package com.project.springboot.dao;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.SetOptions;
import com.project.springboot.dto.EleMap;
import com.project.springboot.dto.RestMap;

@Service
public class FirebaseMapService implements IFirebaseMapService {

	private Firestore firestore;
	
	public static final String COL_REST = "restmap";
	public static final String COL_ELE = "elemap";
	
	@Autowired
    public FirebaseMapService(Firestore firestore) {
        this.firestore = firestore;
    }

	
	public List<RestMap> getNearbyRestrooms(double centerX, double centerY, double radius) throws InterruptedException, ExecutionException {
		List<RestMap> restrooms = new ArrayList<>();
	    
		double lowerX = centerX - radius;
	    double lowerY = centerY - radius;
	    double upperX = centerX + radius;
	    double upperY = centerY + radius;
		//범위 안의 결과를 보여줌
		ApiFuture<QuerySnapshot> query = firestore.collection(COL_REST)
				.whereGreaterThanOrEqualTo("x_wgs84", lowerX)
				.whereGreaterThanOrEqualTo("y_wgs84", lowerY)
				.whereLessThanOrEqualTo("x_wgs84", upperX)
				.whereLessThanOrEqualTo("y_wgs84", upperY)
				.get();
//		System.out.println("query1: " + query);
		List<QueryDocumentSnapshot> info = query.get().getDocuments();
//		System.out.println("info1: " + info);
		for (QueryDocumentSnapshot document : info) {
			RestMap restroom = document.toObject(RestMap.class);
	        double x = restroom.getX_wgs84();
	        double y = restroom.getY_wgs84();

	        double distance = haversine(centerX, centerY, x, y);
	        
	        restroom.setDistance(distance);
	        restrooms.add(restroom);
		}
		
	    restrooms.sort(Comparator.comparingDouble(RestMap::getDistance));
		
		return restrooms.subList(0, Math.min(30, restrooms.size()));
		
	}
	
	public List<EleMap> getNearbyElevators(double centerX, double centerY, double radius) throws InterruptedException, ExecutionException {
		List<EleMap> elevators = new ArrayList<>();
	    
		double lowerX = centerX - radius;
	    double lowerY = centerY - radius;
	    double upperX = centerX + radius;
	    double upperY = centerY + radius;
		//범위 안의 결과를 보여줌
		ApiFuture<QuerySnapshot> query = firestore.collection(COL_ELE)
				.whereGreaterThanOrEqualTo("x_wgs84", lowerX)
				.whereGreaterThanOrEqualTo("y_wgs84", lowerY)
				.whereLessThanOrEqualTo("x_wgs84", upperX)
				.whereLessThanOrEqualTo("y_wgs84", upperY)
				.get();
//		System.out.println("query1: " + query);
		List<QueryDocumentSnapshot> info = query.get().getDocuments();
//		System.out.println("info1: " + info);
		for (QueryDocumentSnapshot document : info) {
			EleMap elevator = document.toObject(EleMap.class);
	        double x = elevator.getX_wgs84();
	        double y = elevator.getY_wgs84();

	        double distance = haversine(centerX, centerY, x, y);
	        
	        elevator.setDistance(distance);
	        elevators.add(elevator);
		}
		
		elevators.sort(Comparator.comparingDouble(EleMap::getDistance));
		
		return elevators.subList(0, Math.min(30, elevators.size()));
		
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
//	
//	public void addRestrooms(RestMap restmap) throws InterruptedException, ExecutionException {
//		ApiFuture<com.google.cloud.firestore.WriteResult> future = firestore.collection(COL_REST)
//																			.document()
//																			.set(restmap);
//		System.out.println("addMethod called");
//		future.get();
//	}
//	
//	public void updateRestrooms(String docuId, RestMap updateRestMap) throws InterruptedException, ExecutionException {
//		ApiFuture<com.google.cloud.firestore.WriteResult> future = firestore.collection(COL_REST)
//																			.document(docuId)
//																			.set(updateRestMap, SetOptions.merge());
//		future.get();
//	}
//	public void deleteRestrooms(String docuId) throws InterruptedException, ExecutionException {
//		ApiFuture<com.google.cloud.firestore.WriteResult> future = firestore.collection(COL_REST)
//																			.document("docuId")
//																			.delete();
//		future.get();
//	}
//	
//	public RestMap getRestroomById(String id) throws InterruptedException, ExecutionException {
//		return firestore.collection(COL_REST).document(id).get().get().toObject(RestMap.class);
//	}
//
//	public List<RestMap> getAllRestrooms() throws InterruptedException, ExecutionException {
//		List<RestMap> restrooms = new ArrayList<>();
//		ApiFuture<QuerySnapshot> query = firestore.collection(COL_REST).limit(5).get();
//		List<QueryDocumentSnapshot> documents = query.get().getDocuments();
//		
//		for (QueryDocumentSnapshot document : documents) {
//			RestMap restroom = document.toObject(RestMap.class);
//			restrooms.add(restroom);
//		}
//		
//		return restrooms;
//		
//	}

}
