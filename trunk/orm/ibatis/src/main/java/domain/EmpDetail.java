package domain;

public class EmpDetail {
	private String empNo;
	private String email;

	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("EmpDetail[");
		buffer.append("email = ").append(email);
		buffer.append(" empNo = ").append(empNo);
		buffer.append("]");
		return buffer.toString();
	}
}
