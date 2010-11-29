package org.chronos.common;

import org.chronos.domain.Shain;
import org.chronos.domain.ShainDao;
import org.springframework.beans.factory.annotation.Autowired;


public class LoginServiceImpl implements LoginService {

	@Autowired
	private ShainDao shainDao;

	/** ログイン */
	@Override
	public Shain login(Shain shain) {
		return shainDao.findShain(shain);
	}

}
