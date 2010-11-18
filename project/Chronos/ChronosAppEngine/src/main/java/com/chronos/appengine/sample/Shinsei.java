package com.chronos.appengine.sample;

public class Shinsei {

	private Shain shain;
	private Kinmuhyo kinmuhyo; 
	private String shinseiFileName;
	private byte[] shinseiData;
	
	public Shain getShain() {
		return shain;
	}
	public void setShain(Shain shain) {
		this.shain = shain;
	}
	public Kinmuhyo getKinmuhyo() {
		return kinmuhyo;
	}
	public void setKinmuhyo(Kinmuhyo kinmuhyo) {
		this.kinmuhyo = kinmuhyo;
	}
	public String getShinseiFileName() {
		return shinseiFileName;
	}
	public void setShinseiFileName(String shinseiFileName) {
		this.shinseiFileName = shinseiFileName;
	}
	public byte[] getShinseiData() {
		return shinseiData;
	}
	public void setShinseiData(byte[] shinseiData) {
		this.shinseiData = shinseiData;
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("社員：").append(shain);
		sb.append(", 勤務表：").append(kinmuhyo);
		sb.append(", 申請ファイル名：").append(shinseiFileName);
		return sb.toString();
	}
	
}
