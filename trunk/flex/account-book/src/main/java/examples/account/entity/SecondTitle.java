package examples.account.entity;

public class SecondTitle {

	private Integer secondTitleId;
	private String secondTitleName;
	private Integer firstTitleId;

	public Integer getFirstTitleId() {
		return firstTitleId;
	}

	public void setFirstTitleId(Integer firstTitleId) {
		this.firstTitleId = firstTitleId;
	}

	public Integer getSecondTitleId() {
		return secondTitleId;
	}

	public void setSecondTitleId(Integer secondTitleId) {
		this.secondTitleId = secondTitleId;
	}

	public String getSecondTitleName() {
		return secondTitleName;
	}

	public void setSecondTitleName(String secondTitleName) {
		this.secondTitleName = secondTitleName;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("SecondTitle[");
		buffer.append("firstTitleId = ").append(firstTitleId);
		buffer.append(" secondTitleId = ").append(secondTitleId);
		buffer.append(" secondTitleName = ").append(secondTitleName);
		buffer.append("]");
		return buffer.toString();
	}
}
