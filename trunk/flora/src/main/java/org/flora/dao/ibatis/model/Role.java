package org.flora.dao.ibatis.model;

import java.io.Serializable;

import org.springframework.security.GrantedAuthority;

public class Role implements Serializable, GrantedAuthority{

	private Long id;
	private String name;
	private String description;

	public Role() {}

	public Role (String name) {
		this.name = name;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String getAuthority() {
		return getName();
	}

	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		return 0;
	}

}
