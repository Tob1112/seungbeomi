package com.prms.service.impl;

import java.util.List;

import com.prms.model.Account;
import com.prms.model.AccountUser;
import com.prms.model.CodeDetail;
import com.prms.model.FixTime;
import com.prms.model.Message;
import com.prms.model.Timesheet;
import com.prms.model.Traffic;
import com.prms.model.TrafficRegular;
import com.prms.service.AccountService;
import com.prms.service.PrmsFacade;
import com.prms.service.SecurityService;
import com.prms.service.TimesheetService;
import com.prms.service.TrafficService;

/**
 * PRMS FACADE SERVICE Implement
 * @author seungbeomi
 */
public class PrmsFacadeImpl implements PrmsFacade{

	private SecurityService securityService;
	private TimesheetService timesheetService;
	private AccountService accountService;
	private TrafficService trafficService;

	//-------------------------------------------------------------------------
	// Setter methods for dependency injection
	//-------------------------------------------------------------------------
	public void setSecurityService(SecurityService securityService) {
		this.securityService = securityService;
	}
	public void setTimesheetService(TimesheetService timesheetService) {
		this.timesheetService = timesheetService;
	}
	public void setAccountService(AccountService accountService) {
		this.accountService = accountService;
	}
	public void setTrafficService(TrafficService trafficService){
		this.trafficService = trafficService;
	}

	//-------------------------------------------------------------------------
	// Operation methods, implementing the PrmsFacade interface
	//-------------------------------------------------------------------------

	//-------------------------------------------------------- Security Service
	@Override
	public Account authenticateUser(Account account) {
		return this.securityService.authenticateUser(account);
	}

	@Override
	public Message logout(String empNo) {
		return this.securityService.logout(empNo);
	}

	//-------------------------------------------------------- Account Service
	@Override
	public boolean updateAccount(AccountUser account) {
		return this.accountService.updateAccount(account);
	}
	@Override
	public List<AccountUser> accountAdminList(AccountUser account) {
		return this.accountService.accountAdminList(account);
	}
	@Override
	public Message saveAccountAdminUser(AccountUser account) {
		return this.accountService.saveAccountAdminUser(account);
	}
	@Override
	public AccountUser accountUserInfo() {
		return this.accountService.accountUserInfo();
	}

	//-------------------------------------------------------- Timesheet Service
	@Override
	public Timesheet getTimesheetAndChildByPk(Timesheet bean) {
		return this.timesheetService.getTimesheetAndChildByPk(bean);
	}

	@Override
	public List<Timesheet> getTimesheetList() {
		return this.timesheetService.getTimesheetList();
	}

	@Override
	public List<Timesheet> getTimesheetListByComCode(String comCode) {
		return this.timesheetService.getTimesheetListByComCode(comCode);
	}

	@Override
	public List<FixTime> getFixTimeList(FixTime bean) {
		return this.timesheetService.getFixTimeList(bean);
	}

	@Override
	public boolean existTimesheetByYYYYMM(Timesheet bean) {
		return this.timesheetService.existTimesheetByYYYYMM(bean);
	}

	@Override
	public Message saveTimesheet(Timesheet bean) {
		// TODO session処理

		Message message = null;

		// 妥当性検証呼出
		message = timesheetService.validateTimesheet(bean);
		if (message != null) {
			return message;
		}

		// 計算ロジック
		timesheetService.calculateTimesheet(bean);

		// 保存処理
		return this.timesheetService.saveTimesheet(bean);
	}

	@Override
	public Timesheet getEmpNameBySession() {
		return this.timesheetService.getEmpNameBySession();
	}

	@Override
	public Timesheet getCurrentTime() {
		return this.timesheetService.getCurrentTime();
	}

	@Override
	public List<CodeDetail> getWorkPattern() {
		return this.timesheetService.getWorkPattern();
	}

	@Override
	public List<Timesheet> getTimesheetListByComCodeAndYYYYMM(Timesheet  bean) {
		return this.timesheetService.getTimesheetListByComCodeAndYYYYMM(bean);
	}
	@Override
	public Timesheet getTimesheetDetail(Timesheet bean) {
		return this.timesheetService.getTimesheetDetail(bean);
	}
	@Override
	public Timesheet getTimesheetSummary(Timesheet bean) {
		return this.timesheetService.getTimesheetSummary(bean);
	}

	//-------------------------------------------------------- Traffic Service
	@Override
	public List<TrafficRegular> loadRegTrainList(TrafficRegular bean) {
		return this.trafficService.loadRegTrainList(bean);
	}
	@Override
	public Traffic loadRegTotals(Traffic bean) {
		return this.trafficService.loadRegTotals(bean);
	}

	@Override
	public List<Traffic> trafficUserList() {
		return this.trafficService.trafficUserList();
	}
}
