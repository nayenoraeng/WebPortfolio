package com.project.springboot.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ParameterDTO {
	private String searchField;
	private String searchWord;
	private int start;
	private int end;
}
