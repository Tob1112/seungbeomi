package examples.account.entity;

public class AccountBookUser {

	public int userId;
	public String password;
	public String userName;
	public long version;

	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public long getVersion() {
		return version;
	}
	public void setVersion(long version) {
		this.version = version;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("AccountBookUser[");
		buffer.append("password = ").append(password);
		buffer.append(" userId = ").append(userId);
		buffer.append(" userName = ").append(userName);
		buffer.append(" version = ").append(version);
		buffer.append("]");
		return buffer.toString();
	}
}
