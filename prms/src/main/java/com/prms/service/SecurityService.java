package com.prms.service;

import com.prms.model.Account;
import com.prms.model.Message;

public interface SecurityService {

	public Account authenticateUser(Account account);

	public Message logout(String empNo);

}
