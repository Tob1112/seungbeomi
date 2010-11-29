package org.chronos.blazeds;

import org.chronos.domain.Shinsei;

public interface KinmuhyoService {

	/** 勤務表保存 */
	void addKinmuhyo();

	Shinsei saveKinmuhyo(Shinsei shinsei);

}
