package org.chronos.blazeds;

import org.apache.log4j.Logger;
import org.chronos.common.LoginService;
import org.chronos.domain.Shain;
import org.chronos.domain.Shinsei;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;

@RemotingDestination(channels={"my-amf", "my-secure-amf"})
public class UketsukeService {

	private static final Logger log = Logger.getLogger(UketsukeService.class);

	//@Autowired
	//private ShainService shainService;
	@Autowired
	private KinmuhyoService kinmuhyoService;
	@Autowired
	private ShinseiService shinseiService;
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
		return shinseiService.saveShinsei(shinsei);
	}
}
