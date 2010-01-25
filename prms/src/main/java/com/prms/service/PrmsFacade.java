package com.prms.service;

import java.util.List;

import com.prms.model.Account;
import com.prms.model.AccountUser;
import com.prms.model.CodeDetail;
import com.prms.model.FixTime;
import com.prms.model.Message;
import com.prms.model.Timesheet;
import com.prms.model.Traffic;
import com.prms.model.TrafficRegular;
import com.prms.model.Traffic;

/**
 * PRMS FACADE SERVICE INTERFACE
 * @author seungbeomi
 */
public interface PrmsFacade {

	// TODO より単純なインタフェイスを提供するように!!!

	// -------------------------------------- Security Service
	public Account authenticateUser(Account account);

	public Message logout(String empNo);

	// -------------------------------------- Timesheet Service
	public Timesheet getTimesheetAndChildByPk(Timesheet bean);

	public List<Timesheet> getTimesheetList();

	public List<Timesheet> getTimesheetListByComCode(String comCode);

	public List<FixTime> getFixTimeList(FixTime bean);

	public boolean existTimesheetByYYYYMM(Timesheet bean);

	public Message saveTimesheet(Timesheet bean);

	public Timesheet getEmpNameBySession();

	public Timesheet getCurrentTime();

	public List<CodeDetail> getWorkPattern();

	public List<Timesheet> getTimesheetListByComCodeAndYYYYMM(Timesheet bean);

	public Timesheet getTimesheetDetail(Timesheet bean);

	public Timesheet getTimesheetSummary(Timesheet bean);

	public List<Timesheet> compareTimesheet(List<Timesheet> list);

	// -------------------------------------- Account Service
	public boolean updateAccount(AccountUser account);

	public List<AccountUser> accountAdminList(AccountUser account);

	public Message saveAccountAdminUser(AccountUser account);

	public AccountUser accountUserInfo();


	// -------------------------------------- Traffic Service
	public List<TrafficRegular> loadRegTrainList(TrafficRegular bean);

	public Traffic loadRegTotals(Traffic traffic);

	public List<Traffic> trafficUserList();
}
