package examples.account.entity;

public class GroupedAccount {

	protected int firstTitle;
    protected String firstTitleName;
    protected int secondTitle;
    protected String secondTitleName;
    protected long groupPrice;

	public int getFirstTitle() {
		return firstTitle;
	}

	public void setFirstTitle(int firstTitle) {
		this.firstTitle = firstTitle;
	}

	public String getFirstTitleName() {
		return firstTitleName;
	}

	public void setFirstTitleName(String firstTitleName) {
		this.firstTitleName = firstTitleName;
	}

	public int getSecondTitle() {
		return secondTitle;
	}

	public void setSecondTitle(int secondTitle) {
		this.secondTitle = secondTitle;
	}

	public String getSecondTitleName() {
		return secondTitleName;
	}

	public void setSecondTitleName(String secondTitleName) {
		this.secondTitleName = secondTitleName;
	}

	public long getGroupPrice() {
		return groupPrice;
	}

	public void setGroupPrice(long groupPrice) {
		this.groupPrice = groupPrice;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("GroupedAccount[");
		buffer.append("firstTitle = ").append(firstTitle);
		buffer.append(" firstTitleName = ").append(firstTitleName);
		buffer.append(" groupPrice = ").append(groupPrice);
		buffer.append(" secondTitle = ").append(secondTitle);
		buffer.append(" secondTitleName = ").append(secondTitleName);
		buffer.append("]");
		return buffer.toString();
	}
}
