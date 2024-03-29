package org.chronos.domain;

import org.chronos.domain.ChronosEnum.ShinseiJokyo;
import org.chronos.domain.ChronosEnum.ShinseiKubun;

public class Shinsei {

	private String shinseiBango;
	private String shainId;
	private ShinseiKubun shinseiKubun;
	private ShinseiJokyo shinseiJokyo;
	private String shinseiFile;
	private byte[] shinseiData;
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
	public ShinseiKubun getShinseiKubun() {
		return shinseiKubun;
	}
	public void setShinseiKubun(ShinseiKubun shinseiKubun) {
		this.shinseiKubun = shinseiKubun;
	}
	public ShinseiJokyo getShinseiJokyo() {
		return shinseiJokyo;
	}
	public void setShinseiJokyo(ShinseiJokyo shinseiJokyo) {
		this.shinseiJokyo = shinseiJokyo;
	}
	public String getShinseiFile() {
		return shinseiFile;
	}
	public void setShinseiFile(String shinseiFile) {
		this.shinseiFile = shinseiFile;
	}
	public byte[] getShinseiData() {
		return shinseiData;
	}
	public void setShinseiData(byte[] shinseiData) {
		this.shinseiData = shinseiData;
	}
	public String getShinseiKekka() {
		return shinseiKekka;
	}
	public void setShinseiKekka(String shinseiKekka) {
		this.shinseiKekka = shinseiKekka;
	}
}
