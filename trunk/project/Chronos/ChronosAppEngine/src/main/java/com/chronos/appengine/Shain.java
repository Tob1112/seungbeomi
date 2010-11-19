package com.chronos.appengine;

import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import org.apache.commons.lang.builder.ToStringBuilder;

@PersistenceCapable(identityType=IdentityType.APPLICATION)
public class Shain {

	@PrimaryKey
	@Persistent
	private String id;
	@Persistent
	private String password;
	@Persistent
	private String shainMei;
	@Persistent
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

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
