package model;

import java.sql.Timestamp;

public class Guestbook {
	private int no;
	private String userId;
	private String title;
	private Timestamp postdate;
	private String category;
	private String comment;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getPostdate() {
		return postdate;
	}
	public void setPostdate(Timestamp postdate) {
		this.postdate = postdate;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Guestbook[");
		buffer.append(" no = ").append(no);
		buffer.append(" userId = ").append(userId);
		buffer.append(" title = ").append(title);
		buffer.append(" postdate = ").append(postdate);
		buffer.append(" category = ").append(category);
		buffer.append(" comment = ").append(comment);
		buffer.append("]");
		return buffer.toString();
	}

}
