package com.prms.dao;

import java.util.List;

import com.prms.model.Account;
import com.prms.model.Traffic;
import com.prms.model.TrafficRegular;


public interface TrafficDao {

	List<TrafficRegular> loadRegTrainList(TrafficRegular bean);

	Traffic loadRegTotals(Traffic bean);

	List<Traffic> trafficUserList(Account account);
}
