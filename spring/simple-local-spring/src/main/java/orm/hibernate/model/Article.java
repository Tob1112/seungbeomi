package orm.hibernate.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Article {

	private Long id;
	private String title;
	private String content;
	private Date createDate = new Date();

	private Set<Attachment> attachments = new HashSet<Attachment>();

	// default constructor
	public Article(){}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Set<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(Set<Attachment> attachments) {
		this.attachments = attachments;
	}

	public void addAttachment(Attachment attachment) {
		this.attachments.add(attachment);
		attachment.setArticle(this);
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Article[");
		buffer.append(" id = ").append(id);
		buffer.append(" title = ").append(title);
		buffer.append(" content = ").append(content);
		buffer.append(" createDate = ").append(createDate);
		buffer.append("]");
		return buffer.toString();
	}
}
