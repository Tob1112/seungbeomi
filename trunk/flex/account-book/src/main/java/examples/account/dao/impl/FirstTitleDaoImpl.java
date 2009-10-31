package examples.account.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.dao.FirstTitleDao;
import examples.account.entity.FirstTitle;

@Repository
@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
public class FirstTitleDaoImpl extends SqlMapClientDaoSupport implements FirstTitleDao{

	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public List<FirstTitle> findAll() {
		return getSqlMapClientTemplate().queryForList("FirstTitle.findAll");
	}
}

