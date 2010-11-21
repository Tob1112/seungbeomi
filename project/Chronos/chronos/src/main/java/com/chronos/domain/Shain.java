package com.chronos.domain;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Shain {

	private String id;
	private String password;
	private String shainMei;
	private String shainBango;
	private boolean enable;
	private String[] role;

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
	public String getShainMei() {
		return shainMei;
	}
	public void setShainMei(String shainMei) {
		this.shainMei = shainMei;
	}
	public String getShainBango() {
		return shainBango;
	}
	public void setShainBango(String shainBango) {
		this.shainBango = shainBango;
	}
	public boolean isEnable() {
		return enable;
	}
	public void setEnable(boolean enable) {
		this.enable = enable;
	}
	public String[] getRole() {
		return role;
	}
	public void setRole(String[] role) {
		this.role = role;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
