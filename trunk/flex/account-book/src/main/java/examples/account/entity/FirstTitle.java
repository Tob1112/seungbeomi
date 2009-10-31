package examples.account.entity;

public class FirstTitle {

	private Integer firstTitleId;
	private String firstTitleName;

	public Integer getFirstTitleId() {
		return firstTitleId;
	}

	public void setFirstTitleId(Integer firstTitleId) {
		this.firstTitleId = firstTitleId;
	}

	public String getFirstTitleName() {
		return firstTitleName;
	}

	public void setFirstTitleName(String firstTitleName) {
		this.firstTitleName = firstTitleName;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("FirstTitle[");
		buffer.append("firstTitleId = ").append(firstTitleId);
		buffer.append(" firstTitleName = ").append(firstTitleName);
		buffer.append("]");
		return buffer.toString();
	}
}
