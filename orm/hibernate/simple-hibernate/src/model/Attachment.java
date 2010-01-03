package model;

public class Attachment {

	private Long id;
	private String filename;

	private Article article;

	// default constructor
	public Attachment(){}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Attachment[");
		buffer.append(" id = ").append(id);
		buffer.append(" filename = ").append(filename);
		buffer.append("]");
		return buffer.toString();
	}
}
