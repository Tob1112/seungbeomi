package examples.account.dao;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.entity.ThirdTitle;

public interface ThirdTitleDao {

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	List<ThirdTitle> findAll();

}

