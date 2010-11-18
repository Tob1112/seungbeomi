package org.barista.common.mail;

import java.io.Serializable;

public class Mail implements Serializable {

	private static final long serialVersionUID = 1L;

	private String recipinet;
	private String subject;
	private String text;

	public String getRecipinet() {
		return recipinet;
	}
	public void setRecipinet(String recipinet) {
		this.recipinet = recipinet;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}

}
