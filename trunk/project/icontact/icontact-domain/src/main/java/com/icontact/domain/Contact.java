package com.icontact.domain;

public class Contact {

	private String name;
	private String phone;
	private String email;
	private String address;
	private String notes;
	private String status;
	private String account;

	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Contact[");
		buffer.append(" account = ").append(account);
		buffer.append(" name = ").append(name);
		buffer.append(" phone = ").append(phone);
		buffer.append(" email = ").append(email);
		buffer.append(" address = ").append(address);
		buffer.append(" status = ").append(status);
		buffer.append("]");
		return buffer.toString();
	}
}
