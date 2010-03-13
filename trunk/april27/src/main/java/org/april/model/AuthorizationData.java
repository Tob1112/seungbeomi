package org.april.model;

import java.util.Arrays;

public class AuthorizationData {

	private String username;
	private String password;
	private String roles[];

	// default constructor
	public AuthorizationData() {}

	public AuthorizationData(String username, String[] roles) {
		this.username = username;
		this.roles = roles;
	}

	public boolean isAdmin() {
		return hasAuthority(this.roles);
	}

	private boolean hasAuthority(String[] roles) {
		for (String authority : roles) {
			String[] temp = authority.split("_");
			if (temp[1] == "ADMIN" || temp[1].equals("ADMIN")) return true;
		}
		return false;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String[] getRoles() {
		return roles;
	}
	public void setRoles(String[] roles) {
		this.roles = roles;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("AuthorizationData[");
		buffer.append(" username = ").append(username);
		if (roles == null) {
			buffer.append(" roles = ").append("null");
		} else {
			buffer.append("roles = ").append(
					Arrays.asList(roles).toString());
		}
		buffer.append("]");
		return buffer.toString();
	}
}
