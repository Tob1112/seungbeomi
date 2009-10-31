package examples.account.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.dao.ThirdTitleDao;
import examples.account.entity.ThirdTitle;

@Repository
public class ThirdTitleDaoImpl extends SqlMapClientDaoSupport implements ThirdTitleDao {

	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public List<ThirdTitle> findAll() {
		return getSqlMapClientTemplate().queryForList("ThirdTitle.findAll");
	}

}

