package com.chronos.domain.web;

import java.util.List;

import com.chronos.domain.Kinmuhyo;

public interface KinmuhyoDao {

	// 勤務表 --------------------------------

	List<Kinmuhyo> listKinmuhyo();

	Kinmuhyo getKinmuhyo(String email);

	void addKinmuhyo(Kinmuhyo kinmuhyo);

	void updateKinmuhyo(Kinmuhyo kinmuhyo);

	void deleteKinmuhyo(String email);

}
