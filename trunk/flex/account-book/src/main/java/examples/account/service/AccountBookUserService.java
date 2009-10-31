package examples.account.service;

import java.util.List;

import examples.account.entity.AccountBookUser;


public interface AccountBookUserService {

	void beginWatch();
	
	void endWatch();
	
	List<AccountBookUser> findAll();
	
}
