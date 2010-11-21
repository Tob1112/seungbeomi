package com.chronos.blazeds;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;

import com.chronos.common.LoginService;
import com.chronos.domain.Shain;
import com.chronos.domain.Shinsei;

@RemotingDestination(channels={"my-amf", "my-secure-amf"})
public class ShinseiServiceFacade {

	private static final Logger log = Logger.getLogger(ShinseiServiceFacade.class);

	//@Autowired
	//private ShainService shainService;
	@Autowired
	private KinmuhyoService kinmuhyoService;
	@Autowired
	private LoginService loginSerivce;

	/** ログイン */
	@RemotingInclude
	public Shain login(Shain shain) {
		return loginSerivce.login(shain);
	}

	/** 申請勤務表保存 */
	@RemotingInclude
	public Shinsei sendKinmuhyo(Shinsei shinsei) {
		return kinmuhyoService.saveKinmuhyo(shinsei);
	}
}
