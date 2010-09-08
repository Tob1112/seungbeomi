package com.icontact.android;

public class Contact {
	private CharSequence name;
	private CharSequence phone;
	private CharSequence email;
	private CharSequence address;
	private CharSequence notes;
	private CharSequence status;
	private CharSequence account;

	public Contact() {
		this.name = "name";
		this.phone = "phone";
		this.email = "email";
		this.address = "address";
		this.notes = "notes";
		this.status = "status";
		this.account = "accout";
	}
	public CharSequence getName() {
		return name;
	}
	public void setName(CharSequence name) {
		this.name = name;
	}
	public CharSequence getPhone() {
		return phone;
	}
	public void setPhone(CharSequence phone) {
		this.phone = phone;
	}
	public CharSequence getEmail() {
		return email;
	}
	public void setEmail(CharSequence email) {
		this.email = email;
	}
	public CharSequence getAddress() {
		return address;
	}
	public void setAddress(CharSequence address) {
		this.address = address;
	}
	public CharSequence getNotes() {
		return notes;
	}
	public void setNotes(CharSequence notes) {
		this.notes = notes;
	}
	public CharSequence getStatus() {
		return status;
	}
	public void setStatus(CharSequence status) {
		this.status = status;
	}
	public CharSequence getAccount() {
		return account;
	}
	public void setAccount(CharSequence account) {
		this.account = account;
	}


}
