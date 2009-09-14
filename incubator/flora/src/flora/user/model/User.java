package flora.user.model;

import java.io.Serializable;

public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	private String userId;
	private String password;
	private String name;
	private String email;

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

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("User[");
		buffer.append("userId = ").append(userId);
		buffer.append(", password = ").append(password);
		buffer.append(", name = ").append(name);
		buffer.append(", email = ").append(email);
		buffer.append("]");
		return buffer.toString();
	}
}