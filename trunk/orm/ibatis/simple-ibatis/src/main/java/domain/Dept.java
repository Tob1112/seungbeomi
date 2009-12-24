package domain;

import java.util.List;

public class Dept {
	private String deptNo;
	private String deptName;
	private List<Emp> empList;

	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public List<Emp> getEmpList() {
		return empList;
	}
	public void setEmpList(List<Emp> empList) {
		this.empList = empList;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Dept[");
		buffer.append(" deptNo = ").append(deptNo);
		buffer.append(" deptName = ").append(deptName);
		buffer.append("]");
		return buffer.toString();
	}
}
