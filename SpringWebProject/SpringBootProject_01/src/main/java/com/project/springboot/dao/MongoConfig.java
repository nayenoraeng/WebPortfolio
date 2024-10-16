package com.project.springboot.dao;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoClientDatabaseFactory;

import com.mongodb.client.MongoClients;

@Configuration
public class MongoConfig {
	@Value("mongodb+srv://project:qwer1234!@sprringbootproject.qgapg.mongodb.net/mapdata?retryWrites=true&w=majority&appName=sprringbootProject")
	private String mongoUri;
	@Bean
	public MongoTemplate mongoTemplate() {
		return new MongoTemplate(
				new SimpleMongoClientDatabaseFactory(MongoClients.create(mongoUri), "mapdata")
				);
	}
}
