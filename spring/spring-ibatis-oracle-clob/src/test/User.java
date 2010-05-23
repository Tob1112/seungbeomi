package test;

public class User {

	private String userId;
	private String name;
	private String contents;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("User[");
		buffer.append(" userId = ").append(userId);
		buffer.append(" name = ").append(name);
		buffer.append(" contents = ").append(contents);
		buffer.append("]");
		return buffer.toString();
	}
	
}
