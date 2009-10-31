package examples.account.entity;

public class TotalAccount {

	protected Long totalprice;
	protected Integer txyear;
	protected Integer txmonth;

	public Integer getTxyear() {
		return txyear;
	}

	public void setTxyear(Integer txyear) {
		this.txyear = txyear;
	}

	public Integer getTxmonth() {
		return txmonth;
	}

	public void setTxmonth(Integer txmonth) {
		this.txmonth = txmonth;
	}

	public Long getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(Long totalprice) {
		this.totalprice = totalprice;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("TotalAccount[");
		buffer.append("totalprice = ").append(totalprice);
		buffer.append(" txmonth = ").append(txmonth);
		buffer.append(" txyear = ").append(txyear);
		buffer.append("]");
		return buffer.toString();
	}

}
