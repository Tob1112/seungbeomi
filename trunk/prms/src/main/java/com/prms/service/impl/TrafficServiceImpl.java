package com.prms.service.impl;

import java.util.List;

import com.prms.model.Account;
import com.prms.model.Traffic;
import com.prms.model.TrafficRegular;
import com.prms.service.TrafficService;
import com.prms.dao.TrafficDao;

import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

public class TrafficServiceImpl implements TrafficService {

	private FlexSession session;
	private TrafficDao trafficDao;
	private Traffic traffic;
	private TrafficRegular trafficRegular;

	public void setTrafficDao(TrafficDao trafficDao) {
		this.trafficDao = trafficDao;
	}

	@Override
	public List<TrafficRegular> loadRegTrainList(TrafficRegular bean){

		session = FlexContext.getFlexSession();
		Account account = (Account) session.getAttribute("account");

		bean.setEmpNo(account.getEmpNo());
		bean.setComCode(account.getComCode());

		System.out.println(">>> yyyymm " + bean.getYyyymm() );

		List<TrafficRegular> list = (List<TrafficRegular>) trafficDao.loadRegTrainList(bean);

		return list;
	}

	@Override
	public Traffic loadRegTotals(Traffic bean) {
		session = FlexContext.getFlexSession();
		Account account = (Account) session.getAttribute("account");

		bean.setEmpNo(account.getEmpNo());
		bean.setComCode(account.getComCode());

		Traffic result = trafficDao.loadRegTotals(bean);
		return result;
	}

	public List<Traffic> trafficUserList() {
		session = FlexContext.getFlexSession();
		Account account = (Account) session.getAttribute("account");

		List<Traffic> list = (List<Traffic>) trafficDao.trafficUserList(account);

		return list;

	}

}
