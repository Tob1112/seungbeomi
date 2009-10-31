package examples.account.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.dao.AccountBookUserDao;
import examples.account.entity.AccountBookUser;

@Repository
@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
public class AccountBookUserDaoImpl extends SqlMapClientDaoSupport implements AccountBookUserDao {

	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public List<AccountBookUser> findAll() {
		return getSqlMapClientTemplate().queryForList("AccountBookUser.findAll");
	}

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public Integer getCount() {
		return (Integer) getSqlMapClientTemplate().queryForObject("AccountBookUser.getCount");
	}

}
