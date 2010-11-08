package com.chronos.appengine.domain;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Shain {

	private String id;
	private String password;
	private String name;
	private String shainBango;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getShainBango() {
		return shainBango;
	}
	public void setShainBango(String shainBango) {
		this.shainBango = shainBango;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
}
