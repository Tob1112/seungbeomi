package com.prms.service;

import java.util.List;

import com.prms.model.Traffic;
import com.prms.model.TrafficRegular;

public interface TrafficService {

	public List<TrafficRegular> loadRegTrainList(TrafficRegular bean);

	public Traffic loadRegTotals(Traffic bean);

	public List<Traffic> trafficUserList();

}
