package examples.account.dao;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.entity.SecondTitle;

public interface SecondTitleDao {

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	List<SecondTitle> findAll();

}

