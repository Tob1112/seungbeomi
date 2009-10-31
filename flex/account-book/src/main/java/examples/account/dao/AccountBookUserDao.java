package examples.account.dao;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.entity.AccountBookUser;

public interface AccountBookUserDao {

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	List<AccountBookUser> findAll();

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	Integer getCount();
}
