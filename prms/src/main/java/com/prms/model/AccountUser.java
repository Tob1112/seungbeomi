package com.prms.model;

import java.util.Date;

/**
 * アカウントドメイン
 *
 * @author
 */
public class AccountUser {

	private String empNo;					// 社員番号
	private String latestFlag;
	private String deptCode;				// 部署コード
	private String email;					// メール
	private String hireDay;					// 入社日
	private String lastName;				// 名前（姓
	private String firstName;				// 名前（名
	private String deptName;				// 部署名
	private String accountAdminCompanyFlg;	// 会社コード(パラメータ)
	private String accountUserPassword;		// ユーザーパスワード
	private String accountUserNewPassword;	// ユーザー新パスワード
	private String accountUserName;			// ユーザー名前
	private String role;					// 権限
	private String validateName;			// 妥当性エラー名
	private Date currentDate;				// 現在日付

	public AccountUser() {}

	public Date getCurrentDate() {
		return currentDate;
	}

	public void setCurrentDate(Date currentDate) {
		this.currentDate = currentDate;
	}

	public String getAccountUserName() {
		return accountUserName;
	}

	public void setAccountUserName(String accountUserName) {
		this.accountUserName = accountUserName;
	}

	public String getValidateName() {
		return validateName;
	}

	public void setValidateName(String validateName) {
		this.validateName = validateName;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
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

	public String getHireDay() {
		return hireDay;
	}

	public void setHireDay(String hireDay) {
		this.hireDay = hireDay;
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

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Account[");
		buffer.append("accountAdminCompanyFlg = ").append(
				accountAdminCompanyFlg);
		buffer.append(", accountUserName = ").append(accountUserName);
		buffer.append(", deptCode = ").append(deptCode);
		buffer.append(", deptName = ").append(deptName);
		buffer.append(", email = ").append(email);
		buffer.append(", empNo = ").append(empNo);
		buffer.append(", firstName = ").append(firstName);
		buffer.append(", hireDay = ").append(hireDay);
		buffer.append(", lastName = ").append(lastName);
		buffer.append(", latestFlag = ").append(latestFlag);
		buffer.append(", role = ").append(role);
		buffer.append("]");
		return buffer.toString();
	}
}