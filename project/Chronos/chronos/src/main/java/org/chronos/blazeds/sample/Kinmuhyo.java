package org.chronos.blazeds.sample;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Kinmuhyo {
	
	private String nengetsu;			// 年月
	private String shinseiBango;		// 申請番号
	private String shinseiKubun;		// 申請区分
	private String shinseiJokyo;		// 申請状況
	private double syoteiNissu;			// 所定日数
	private double sagyoNissu;			// 作業日数
	private double kekkinNissu;			// 欠勤日数
	private double jitsudoJikanGokei;	// 実働時間合計
	private String sagyoGenba;			// 作業現場
	
	public String getNengetsu() {
		return nengetsu;
	}
	public void setNengetsu(String nengetsu) {
		this.nengetsu = nengetsu;
	}
	public String getShinseiBango() {
		return shinseiBango;
	}
	public void setShinseiBango(String shinseiBango) {
		this.shinseiBango = shinseiBango;
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
	public double getSyoteiNissu() {
		return syoteiNissu;
	}
	public void setSyoteiNissu(double syoteiNissu) {
		this.syoteiNissu = syoteiNissu;
	}
	public double getSagyoNissu() {
		return sagyoNissu;
	}
	public void setSagyoNissu(double sagyoNissu) {
		this.sagyoNissu = sagyoNissu;
	}
	public double getKekkinNissu() {
		return kekkinNissu;
	}
	public void setKekkinNissu(double kekkinNissu) {
		this.kekkinNissu = kekkinNissu;
	}
	public double getJitsudoJikanGokei() {
		return jitsudoJikanGokei;
	}
	public void setJitsudoJikanGokei(double jitsudoJikanGokei) {
		this.jitsudoJikanGokei = jitsudoJikanGokei;
	}
	public String getSagyoGenba() {
		return sagyoGenba;
	}
	public void setSagyoGenba(String sagyoGenba) {
		this.sagyoGenba = sagyoGenba;
	}
}
