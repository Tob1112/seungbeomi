package examples.account.entity;

import java.util.Date;

public class Account {

	protected long accountId;
	protected Date txdate;
	protected int firstTitle;
	protected int secondTitle;
	protected String thirdTitle;
	protected long price;
	protected int userId;
	protected long version;
	protected String firstTitleName;
	protected String secondTitleName;

	public long getAccountId() {
		return accountId;
	}

	public void setAccountId(long accountId) {
		this.accountId = accountId;
	}

	public Date getTxdate() {
		return txdate;
	}

	public void setTxdate(Date txdate) {
		this.txdate = txdate;
	}

	public int getFirstTitle() {
		return firstTitle;
	}

	public void setFirstTitle(int firstTitle) {
		this.firstTitle = firstTitle;
	}

	public int getSecondTitle() {
		return secondTitle;
	}

	public void setSecondTitle(int secondTitle) {
		this.secondTitle = secondTitle;
	}

	public String getThirdTitle() {
		return thirdTitle;
	}

	public void setThirdTitle(String thirdTitle) {
		this.thirdTitle = thirdTitle;
	}

	public long getPrice() {
		return price;
	}

	public void setPrice(long price) {
		this.price = price;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public long getVersion() {
		return version;
	}

	public void setVersion(long version) {
		this.version = version;
	}

	public String getFirstTitleName() {
		return firstTitleName;
	}

	public void setFirstTitleName(String firstTitleName) {
		this.firstTitleName = firstTitleName;
	}

	public String getSecondTitleName() {
		return secondTitleName;
	}

	public void setSecondTitleName(String secondTitleName) {
		this.secondTitleName = secondTitleName;
	}


	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Account[");
		buffer.append("accountId = ").append(accountId);
		buffer.append(" firstTitle = ").append(firstTitle);
		buffer.append(" firstTitleName = ").append(firstTitleName);
		buffer.append(" price = ").append(price);
		buffer.append(" secondTitle = ").append(secondTitle);
		buffer.append(" secondTitleName = ").append(secondTitleName);
		buffer.append(" thirdTitle = ").append(thirdTitle);
		buffer.append(" txdate = ").append(txdate);
		buffer.append(" userId = ").append(userId);
		buffer.append(" version = ").append(version);
		buffer.append("]");
		return buffer.toString();
	}
}
