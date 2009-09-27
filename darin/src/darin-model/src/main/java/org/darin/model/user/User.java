package org.darin.model.user;

public class User {
	private String userId;
	private String password;
	private String name;
	private String email;
	private String roleId;
	private String[] roles;

	public User(){}

	public User(String[] roles, String userId) {
		this.roles = roles;
		this.userId = userId;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String[] getRoles() {
		return roles;
	}
	public void setRole(String[] roles) {
		this.roles = roles;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("User[");
		buffer.append(" userId = ").append(userId);
		buffer.append(" password = ").append(password);
		buffer.append(" name = ").append(name);
		buffer.append(" email = ").append(email);
		buffer.append(" roleId = ").append(roleId);
		buffer.append("]");
		return buffer.toString();
	}

}
