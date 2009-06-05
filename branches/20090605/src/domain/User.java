package domain;

public class User {
	private String id;
	private String pw;
	private String name;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("User[");
		buffer.append("id = ").append(id);
		buffer.append(" name = ").append(name);
		buffer.append(" pw = ").append(pw);
		buffer.append("]");
		return buffer.toString();
	}
}
