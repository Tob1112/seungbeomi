package org.chronos.domain.sample;

import java.util.List;

public interface PersonService {

	List<Person> list();

	Person get(int id);

	void add(Person person);

	void update(Person person);

	void delete(int id);

}
