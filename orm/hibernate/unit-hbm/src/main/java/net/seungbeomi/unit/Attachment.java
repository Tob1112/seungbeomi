package net.seungbeomi.unit;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Attachment {

	private Long id;
	private String filename;
	private Article article;

	public Attachment() {}

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

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
