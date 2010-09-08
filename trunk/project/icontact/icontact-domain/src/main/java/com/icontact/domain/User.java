package com.icontact.domain;

public class User {

	private String account;
	private String password;
	private String username;

	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("User[");
		buffer.append(" account = ").append(account);
		buffer.append(" password = ").append(password);
		buffer.append(" username = ").append(username);
		buffer.append("]");
		return buffer.toString();
	}
}
