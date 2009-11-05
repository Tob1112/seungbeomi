package seungbeomi.user.model;

public class Groups {

	private String id;
	private String groupName;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Groups[");
		buffer.append(" id = ").append(id);
		buffer.append(" groupName = ").append(groupName);
		buffer.append("]");
		return buffer.toString();
	}
}
