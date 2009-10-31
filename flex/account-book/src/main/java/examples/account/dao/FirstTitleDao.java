package examples.account.dao;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.entity.FirstTitle;

public interface FirstTitleDao {

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	List<FirstTitle> findAll();

}

