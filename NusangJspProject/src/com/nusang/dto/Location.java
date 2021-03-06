package com.nusang.dto;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(Include.NON_NULL)
public class Location {

	private int locationno;
	private double latitude;
	private double longtitude;
	private String name1;
	private String name2;
	private String name3;
	private String tabletype;

	public String getAddress() {
		return getName1() + " " + getName2() + " " + getName3();
	}

	public String getAddress2() {
		return getName2() + " " + getName3();
	}
}
