package com.chronos.appengine.service;

import java.util.logging.Logger;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.chronos.appengine.domain.User;

@Service("ShinseiService")
@RemotingDestination(channels={"my-amf", "my-secure-amf"})
public class ShinseiService {

	private static final Logger log = Logger.getLogger(ShinseiService.class.getName());
	
	@RemotingInclude
	public User login(User user) {
		user.setName("孫承範");
		user.setShainBango("111");

		log.fine(user.toString());
		
		return  user ;
	}
}
