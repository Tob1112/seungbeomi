package seungbeomi;

import java.util.Date;

public class DefaultShinseishoYoshiki {

	private String yoshikiId;
	private String yoshikiFileData;
	private Date tetsuzukiYukoKaishibi;
	private int version;

	public Date getTetsuzukiYukoKaishibi() {
		return tetsuzukiYukoKaishibi;
	}
	public void setTetsuzukiYukoKaishibi(Date tetsuzukiYukoKaishibi) {
		this.tetsuzukiYukoKaishibi = tetsuzukiYukoKaishibi;
	}
	public String getYoshikiId() {
		return yoshikiId;
	}
	public void setYoshikiId(String yoshikiId) {
		this.yoshikiId = yoshikiId;
	}
	public String getYoshikiFileData() {
		return yoshikiFileData;
	}
	public void setYoshikiFileData(String yoshikiFileData) {
		this.yoshikiFileData = yoshikiFileData;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}

}
