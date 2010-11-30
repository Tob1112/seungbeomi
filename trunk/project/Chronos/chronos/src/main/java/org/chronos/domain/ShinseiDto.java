package org.chronos.domain;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ShinseiDto {

	private String shinseiBango;
	private String shainId;
	private String shinseiKubun;
	private String shinseiJokyo;
	private String shinseiFile;
	private String shinseiKekka;

	public String getShinseiBango() {
		return shinseiBango;
	}
	public void setShinseiBango(String shinseiBango) {
		this.shinseiBango = shinseiBango;
	}
	public String getShainId() {
		return shainId;
	}
	public void setShainId(String shainId) {
		this.shainId = shainId;
	}
	public String getShinseiKubun() {
		return shinseiKubun;
	}
	public void setShinseiKubun(String shinseiKubun) {
		this.shinseiKubun = shinseiKubun;
	}
	public String getShinseiJokyo() {
		return shinseiJokyo;
	}
	public void setShinseiJokyo(String shinseiJokyo) {
		this.shinseiJokyo = shinseiJokyo;
	}
	public String getShinseiFile() {
		return shinseiFile;
	}
	public void setShinseiFile(String shinseiFile) {
		this.shinseiFile = shinseiFile;
	}
	public String getShinseiKekka() {
		return shinseiKekka;
	}
	public void setShinseiKekka(String shinseiKekka) {
		this.shinseiKekka = shinseiKekka;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
