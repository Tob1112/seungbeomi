package com.chronos.common;

import org.springframework.beans.factory.annotation.Autowired;

import com.chronos.domain.Shain;
import com.chronos.domain.ShainDao;

public class LoginServiceImpl implements LoginService {

	@Autowired
	private ShainDao shainDao;

	/** ログイン */
	@Override
	public Shain login(Shain shain) {
		return shainDao.findShain(shain);
	}

}
