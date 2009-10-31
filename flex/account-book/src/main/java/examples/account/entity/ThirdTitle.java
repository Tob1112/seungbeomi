package examples.account.entity;

public class ThirdTitle {

	private String thirdTitleId;
	private String thirdTitleName;
	private Integer secondTitleId;

	public String getThirdTitleId() {
		return thirdTitleId;
	}

	public void setThirdTitleId(String thirdTitleId) {
		this.thirdTitleId = thirdTitleId;
	}

	public String getThirdTitleName() {
		return thirdTitleName;
	}

	public void setThirdTitleName(String thirdTitleName) {
		this.thirdTitleName = thirdTitleName;
	}

	public Integer getSecondTitleId() {
		return secondTitleId;
	}

	public void setSecondTitleId(Integer secondTitleId) {
		this.secondTitleId = secondTitleId;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("ThirdTitle[");
		buffer.append("secondTitleId = ").append(secondTitleId);
		buffer.append(" thirdTitleId = ").append(thirdTitleId);
		buffer.append(" thirdTitleName = ").append(thirdTitleName);
		buffer.append("]");
		return buffer.toString();
	}
}
