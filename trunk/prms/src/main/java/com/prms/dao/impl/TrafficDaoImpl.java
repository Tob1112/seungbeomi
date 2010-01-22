package com.prms.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.prms.Constants;
import com.prms.dao.TrafficDao;
import com.prms.model.Account;
import com.prms.model.Traffic;
import com.prms.model.TrafficRegular;

public class TrafficDaoImpl extends SqlMapClientDaoSupport implements TrafficDao{

	public List<TrafficRegular> loadRegTrainList(TrafficRegular bean){
		return (List<TrafficRegular>) getSqlMapClientTemplate().queryForList("trafficRegular.loadRegTrainList", bean);
	}

	public Traffic loadRegTotals(Traffic bean){

		Traffic traffic = (Traffic) getSqlMapClientTemplate().queryForObject("traffic.loadRegTotals", bean);
		return traffic;
	}

	// 交通費ユーザーリストを取得
	public List<Traffic> trafficUserList(Account account) {

		account.setCodeType(Constants.CODE_TYPE_STATUS);
		account.setLatestFlag(Constants.LATEST_FLG_Y);

		return (List<Traffic>) getSqlMapClientTemplate().queryForList("traffic.userTrafficList", account);
	}
}