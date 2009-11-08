package flora.model;

import java.io.Serializable;
import java.util.Arrays;

public class User extends BaseObject implements Serializable {

	private static final long serialVersionUID = -3147069054252170760L;
	private String userId;
	private String password;
	private String[] roles;

	public User() {}

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
	public String[] getRoles() {
		return roles;
	}
	public void setRoles(String[] roles) {
		this.roles = roles;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("User[");
		buffer.append(" userId = ").append(userId);
		buffer.append(" password = ").append(password);
		if (roles == null) {
			buffer.append(" roles = ").append("null");
		} else {
			buffer.append(" roles = ").append(Arrays.asList(roles).toString());
		}
		buffer.append("]");
		return buffer.toString();
	}
}
