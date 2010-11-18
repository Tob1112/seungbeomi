package com.chronos.appengine.sample;

import java.util.logging.Logger;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;


//@Service("MockShinseiService")
@RemotingDestination(channels={"my-amf", "my-secure-amf"})
public class ShinseiService {

	private static final Logger log = Logger.getLogger(ShinseiService.class.getName());
	
	@RemotingInclude
	public Shain login(Shain shain) {
		shain.setShainMei("孫承範");
		shain.setShainBango("111");

		log.fine(shain.toString());
		
		return  shain ;
	}
	
	@RemotingInclude
	public void sendKinmuhyo(Shinsei shinsei) {
		log.fine(shinsei.toString());
	}
}
