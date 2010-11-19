package com.chronos.appengine;

import java.util.List;

import com.chronos.appengine.Kinmuhyo;

public interface KinmuhyoDao {

	// 勤務表 --------------------------------

	List<Kinmuhyo> listKinmuhyo();

	Kinmuhyo getKinmuhyo(String email);

	void addKinmuhyo(Kinmuhyo kinmuhyo);

	void updateKinmuhyo(Kinmuhyo kinmuhyo);

	void deleteKinmuhyo(String email);

}
