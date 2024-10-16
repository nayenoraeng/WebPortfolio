package com.project.springboot.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.concurrent.ExecutionException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;

@Configuration
public class FirebaseConfig {
	@Bean
	public Firestore firestore() throws InterruptedException, ExecutionException, IOException {
		FileInputStream serviceAccount = new FileInputStream("src/main/resources/serviceAccountKey.json");
	
		FirestoreOptions firestoreOptions = FirestoreOptions.getDefaultInstance().toBuilder()
	                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
	                .setProjectId("springbootstudy-57416")
	                .build();
		
		return firestoreOptions.getService();

	}
}
