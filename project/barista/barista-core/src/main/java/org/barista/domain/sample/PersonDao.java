package org.barista.domain.sample;

import java.util.Collection;

public interface PersonDao {

	Person findPerson(long id);
	
	Collection<DefaultPerson> findPersons();
	
	void insert(Person person);
	
	void save(Person person);
	
	void update(long id);
	
	void delete(long id);

}
