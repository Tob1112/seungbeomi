package org.chronos.management.sample;

import com.opensymphony.xwork2.ActionSupport;

public class PersonAction extends ActionSupport {

	private String name;

	public String execute() throws Exception {
		setName("seungbeomi");
		return SUCCESS;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
