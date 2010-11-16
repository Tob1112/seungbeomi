package com.chronos.domain.saple;

import java.util.List;

public interface PersonDao {

	List<Person> list();

	Person get(String pk);

	void add(Person person);

	void update(Person person);

	void delete(String id);

}
