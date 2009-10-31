package domain;

public class Emp {
	private String empNo;
	private String empName;
	private String deptNo;
	private EmpDetail empDetail;

	public EmpDetail getEmpDetail() {
		return empDetail;
	}
	public void setEmpDetail(EmpDetail empDetail) {
		this.empDetail = empDetail;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	/**
		 *
		 * @return
		 * @author
		 */
		public String toString() {
			StringBuffer buffer = new StringBuffer();
			buffer.append("Emp[");
			buffer.append(" empNo = ").append(empNo);
			buffer.append(" deptNo = ").append(deptNo);
			buffer.append(" empName = ").append(empName);
			buffer.append(" empDetail = ").append(empDetail);
			buffer.append("]");
			return buffer.toString();
		}


}
