package com.chronos.appengine;

import java.util.logging.Logger;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;


@RemotingDestination(channels={"my-amf", "my-secure-amf"})
public class ShinseiServiceAdapter {

	private static final Logger log = Logger.getLogger(ShinseiServiceAdapter.class.getName());

	@RemotingInclude
	public Shain login(Shain shain) {
		shain.setShainMei("孫承範");
		shain.setShainBango("111");

		log.fine(shain.toString());

		return  shain ;
	}

}
