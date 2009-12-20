package org.flora.dao.ibatis.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.security.GrantedAuthority;
import org.springframework.security.userdetails.UserDetails;

public class User implements Serializable, UserDetails{

	private String id;
	private String username;
	private String password;
	private Set roles = new HashSet();
	private Integer version;
	private boolean enabled;
	private boolean accountExpired;
	private boolean accountLocked;
	private boolean credentialExpired;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Set getRoles() {
		return roles;
	}

	public void addRole(Role role) {
		getRoles().add(role);
	}

	public void setRoles(Set roles) {
		this.roles = roles;
	}
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	@Override
	public GrantedAuthority[] getAuthorities() {
		return (GrantedAuthority[]) roles.toArray(new GrantedAuthority[0]);
	}
	@Override
	public boolean isAccountNonExpired() {
		return !isAccountExpired();
	}
	public boolean isAccountExpired() {
		return accountExpired;
	}
	@Override
	public boolean isAccountNonLocked() {
		return accountLocked;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return !credentialExpired;
	}
	@Override
	public boolean isEnabled() {
		return enabled;
	}

	public List getRoleList() {
		List userRoles = new ArrayList();

		if (this.roles != null) {
			for (Iterator iter = roles.iterator(); iter.hasNext();) {
				Role role = (Role) iter.next();
				userRoles.add(new LabelValue(role.getName(), role.getName()));
			}
		}
		return userRoles;
	}
}