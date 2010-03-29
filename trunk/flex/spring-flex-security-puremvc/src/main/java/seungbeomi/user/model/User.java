package seungbeomi.user.model;

public class User {
	private String userId;
	private String password;
	private String name;
	private String email;
	private String groupId;
	private String[] groups;

	public User(){}

	public User(String[] groups, String userId) {
		this.groups = groups;
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
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String[] getGroups() {
		return groups;
	}
	public void setGroups(String[] groups) {
		this.groups = groups;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("User[");
		buffer.append(" userId = ").append(userId);
		buffer.append(" password = ").append(password);
		buffer.append(" name = ").append(name);
		buffer.append(" email = ").append(email);
		buffer.append("]");
		return buffer.toString();
	}


}
