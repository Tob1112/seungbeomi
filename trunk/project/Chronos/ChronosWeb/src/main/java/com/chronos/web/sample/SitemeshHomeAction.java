package com.chronos.web.sample;

import com.opensymphony.xwork2.ActionSupport;

public class SitemeshHomeAction extends ActionSupport{

	private String content;

	public String execute() throws Exception {
		setContent("<br/>" + "Welcome to Chronos");
		return SUCCESS;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}


}
