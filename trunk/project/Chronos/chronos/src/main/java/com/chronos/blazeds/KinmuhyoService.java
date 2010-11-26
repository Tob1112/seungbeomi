package com.chronos.blazeds;

import com.chronos.domain.Shinsei;

public interface KinmuhyoService {

	/** 勤務表保存 */
	void addKinmuhyo();

	Shinsei saveKinmuhyo(Shinsei shinsei, String sessionId);

}
