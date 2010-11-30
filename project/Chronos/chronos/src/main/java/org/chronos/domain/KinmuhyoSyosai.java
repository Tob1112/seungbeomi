package org.chronos.domain;

import org.apache.commons.lang.builder.ToStringBuilder;

public class KinmuhyoSyosai {

	private String nengetsu;		// 年月
	private String hizuke;			// 日付
	private String yasumiKubun;		// 休み区分
	private String shigyoJikan;		// 始業時間
	private double shigyoJikanchi;	// 始業時間値
	private String syuryoJikan;		// 終了時間
	private double syuryoJikanchi;	// 終了時間値
	private double kyukeiJikan;		// 休憩時間
	private double jitsudoJikan;	// 実働時間
	private String sagyoNaiyo;		// 作業内容

	public String getNengetsu() {
		return nengetsu;
	}
	public void setNengetsu(String nengetsu) {
		this.nengetsu = nengetsu;
	}
	public String getHizuke() {
		return hizuke;
	}
	public void setHizuke(String hizuke) {
		this.hizuke = hizuke;
	}
	public String getYasumiKubun() {
		return yasumiKubun;
	}
	public void setYasumiKubun(String yasumiKubun) {
		this.yasumiKubun = yasumiKubun;
	}
	public String getShigyoJikan() {
		return shigyoJikan;
	}
	public void setShigyoJikan(String shigyoJikan) {
		this.shigyoJikan = shigyoJikan;
	}
	public double getShigyoJikanchi() {
		return shigyoJikanchi;
	}
	public void setShigyoJikanchi(double shigyoJikanchi) {
		this.shigyoJikanchi = shigyoJikanchi;
	}
	public String getSyuryoJikan() {
		return syuryoJikan;
	}
	public void setSyuryoJikan(String syuryoJikan) {
		this.syuryoJikan = syuryoJikan;
	}
	public double getSyuryoJikanchi() {
		return syuryoJikanchi;
	}
	public void setSyuryoJikanchi(double syuryoJikanchi) {
		this.syuryoJikanchi = syuryoJikanchi;
	}
	public double getKyukeiJikan() {
		return kyukeiJikan;
	}
	public void setKyukeiJikan(double kyukeiJikan) {
		this.kyukeiJikan = kyukeiJikan;
	}
	public double getJitsudoJikan() {
		return jitsudoJikan;
	}
	public void setJitsudoJikan(double jitsudoJikan) {
		this.jitsudoJikan = jitsudoJikan;
	}
	public String getSagyoNaiyo() {
		return sagyoNaiyo;
	}
	public void setSagyoNaiyo(String sagyoNaiyo) {
		this.sagyoNaiyo = sagyoNaiyo;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
