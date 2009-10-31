package examples.account.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.dao.SecondTitleDao;
import examples.account.entity.SecondTitle;

@Repository
public class SecondTitleDaoImpl extends SqlMapClientDaoSupport implements SecondTitleDao {

	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public List<SecondTitle> findAll() {
		return getSqlMapClientTemplate().queryForList("SecondTitle.findAll");
	}

}

