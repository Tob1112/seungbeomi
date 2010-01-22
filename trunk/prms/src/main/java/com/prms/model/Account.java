package com.prms.model;

import java.sql.Date;
import java.util.Arrays;

/**
 * アカウントドメイン
 * @author
 */
public class Account {

	private String comCode;
	private String empNo;					// 社員番号
	private String regDay;
	private String delDay;
	private String latestFlag;
	private String deptCode;
	private String email;					// メール
	private String passwd;
	private String hireDay;
	private Date retireDay;
	private String lastName;				// 名前（姓
	private String firstName;				// 名前（名
	private String roles[];					// 権限
	private String deptName;				// 部署名
	private String accountAdminCompanyFlg;	// 会社コード(パラメータ)
	private String accountUserPassword;		// ユーザーパスワード
	private String accountUserNewPassword;	// ユーザー新パスワード
	private String accountUserId;			// ユーザーid

	// default constructor
	public Account() {}

	public Account(String email, String[] roles) {
		this.email = email;
		this.roles = roles;
	}

	public String getComCode() {
		return comCode;
	}

	public void setComCode(String comCode) {
		this.comCode = comCode;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getRegDay() {
		return regDay;
	}

	public void setRegDay(String regDay) {
		this.regDay = regDay;
	}

	public String getDelDay() {
		return delDay;
	}

	public void setDelDay(String delDay) {
		this.delDay = delDay;
	}

	public String getLatestFlag() {
		return latestFlag;
	}

	public void setLatestFlag(String latestFlag) {
		this.latestFlag = latestFlag;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getHireDay() {
		return hireDay;
	}

	public void setHireDay(String hireDay) {
		this.hireDay = hireDay;
	}

	public Date getRetireDay() {
		return retireDay;
	}

	public void setRetireDay(Date retireDay) {
		this.retireDay = retireDay;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String[] getRoles() {
		return roles;
	}

	public void setRoles(String[] roles) {
		this.roles = roles;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getAccountAdminCompanyFlg() {
		return accountAdminCompanyFlg;
	}

	public void setAccountAdminCompanyFlg(String accountAdminCompanyFlg) {
		this.accountAdminCompanyFlg = accountAdminCompanyFlg;
	}

	public String getAccountUserPassword() {
		return accountUserPassword;
	}

	public void setAccountUserPassword(String accountUserPassword) {
		this.accountUserPassword = accountUserPassword;
	}

	public String getAccountUserNewPassword() {
		return accountUserNewPassword;
	}

	public void setAccountUserNewPassword(String accountUserNewPassword) {
		this.accountUserNewPassword = accountUserNewPassword;
	}

	public String getAccountUserId() {
		return accountUserId;
	}

	public void setAccountUserId(String accountUserId) {
		this.accountUserId = accountUserId;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Account[");
		buffer.append("accountAdminCompanyFlg = ").append(
				accountAdminCompanyFlg);
		buffer.append(", accountUserId = ").append(accountUserId);
		if (roles == null) {
			buffer.append(", roles = ").append("null");
		} else {
			buffer.append(", roles = ").append(Arrays.asList(roles).toString());
		}
		buffer.append(", comCode = ").append(comCode);
		buffer.append(", delDay = ").append(delDay);
		buffer.append(", deptCode = ").append(deptCode);
		buffer.append(", deptName = ").append(deptName);
		buffer.append(", email = ").append(email);
		buffer.append(", passwd = ").append("[PROTECTED]");
		buffer.append(", empNo = ").append(empNo);
		buffer.append(", firstName = ").append(firstName);
		buffer.append(", hireDay = ").append(hireDay);
		buffer.append(", lastName = ").append(lastName);
		buffer.append(", latestFlag = ").append(latestFlag);
		buffer.append(", regDay = ").append(regDay);
		buffer.append(", retireDay = ").append(retireDay);
		buffer.append("]");
		return buffer.toString();
	}
}